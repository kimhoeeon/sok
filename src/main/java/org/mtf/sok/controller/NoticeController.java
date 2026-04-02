package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.util.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/notice")
public class NoticeController {

    @Autowired
    private BoardMapper boardMapper;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        params.setBrdType("NOTICE"); // 통합 게시판 중 공지사항만 조회

        // 페이징 처리 및 목록 조회
        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params); // 검색/페이징 상태 유지용
        return "admin/notice/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long brdSeq,
                       @ModelAttribute("params") BoardDTO params,
                       Model model) {
        BoardDTO board = new BoardDTO();

        // 글 수정/상세 보기일 경우 데이터 조회
        if (brdSeq != null) {
            board = boardMapper.selectBoard(brdSeq);
            // 첨부파일 조회
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(brdSeq);
            board.setFileList(boardMapper.selectFiles(fileParams));
        } else {
            board.setIsNotice("N"); // 기본값 세팅
        }

        model.addAttribute("board", board);
        return "admin/notice/form";
    }

    @PostMapping("/save")
    public String save(BoardDTO board, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        // ★ [UX 고도화] 수정인지 신규 등록인지 판별하는 플래그
        boolean isUpdate = (board.getBrdSeq() != null);

        board.setBrdType("NOTICE");
        if(board.getIsNotice() == null) board.setIsNotice("N");

        if (isUpdate) {
            board.setModId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.insertBoard(board);
        }

        if (board.getUploadFiles() != null && !board.getUploadFiles().isEmpty()) {
            String savePath = uploadDir + "notice/";
            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            for (MultipartFile file : board.getUploadFiles()) {
                if (!file.isEmpty()) {
                    try {
                        String originalFileName = file.getOriginalFilename();
                        String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String savedFileName = UUID.randomUUID().toString() + ext;

                        File targetFile = new File(savePath + savedFileName);
                        file.transferTo(targetFile);

                        FileDTO fileDTO = new FileDTO();
                        fileDTO.setRefTable("TB_BOARD");
                        fileDTO.setRefSeq(board.getBrdSeq());
                        fileDTO.setOrgFileNm(originalFileName);
                        fileDTO.setSaveFileNm(savedFileName);
                        fileDTO.setFilePath("/upload/notice/" + savedFileName);
                        fileDTO.setFileSize(file.getSize());
                        fileDTO.setFileExt(ext);

                        boardMapper.insertFile(fileDTO);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        // ★ [UX 고도화] 상황에 맞는 지능형 Redirect 처리
        if (isUpdate) {
            // 글 수정 시: 내가 작업하던 원래 페이지 번호와 검색어 상태를 그대로 유지
            rttr.addAttribute("pageNum", board.getPageNum());
            rttr.addAttribute("amount", board.getAmount());
            rttr.addAttribute("searchType", board.getSearchType());
            rttr.addAttribute("searchKeyword", board.getSearchKeyword());
        } else {
            // 신규 등록 시: 방금 쓴 글을 확인할 수 있도록 무조건 1페이지로 이동 (검색어 초기화)
            rttr.addAttribute("pageNum", 1);
            // 단, 사용자가 보기 개수를 50개로 설정해 두었다면 그 설정(amount)은 유지해 주는 센스!
            rttr.addAttribute("amount", board.getAmount());
        }

        return "redirect:/admin/notice/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq, @ModelAttribute BoardDTO params, RedirectAttributes rttr) {
        boardMapper.deleteBoard(brdSeq);

        // ★ [수정됨] 삭제 후 다시 원래 페이지 목록으로 돌아가도록 파라미터 세팅
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchType", params.getSearchType());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/admin/notice/list";
    }

    // ★ [추가] 공지사항 엑셀 다운로드
    @GetMapping("/excel")
    public void downloadExcel(@ModelAttribute BoardDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1);
        params.setAmount(1000000); // 대용량 엑셀 추출
        params.setBrdType("NOTICE"); // 공지사항 게시판만

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        List<String> headers = Arrays.asList("연번", "카테고리", "중요여부", "제목", "조회수", "등록일시");
        List<List<Object>> data = new ArrayList<>();

        for (BoardDTO board : list) {
            List<Object> row = new ArrayList<>();
            row.add(board.getBrdSeq());
            row.add(board.getCategory());
            row.add("Y".equals(board.getIsNotice()) ? "중요" : "일반");
            row.add(board.getTitle());
            row.add(board.getViewCnt());
            row.add(board.getRegDt()); // Date 객체 그대로 넘김
            data.add(row);
        }
        ExcelUtils.download(response, "공지사항_내역", headers, data);
    }
}