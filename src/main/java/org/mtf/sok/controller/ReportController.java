package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.service.NaverStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/report")
public class ReportController {

    @Autowired
    private BoardMapper boardMapper;

    // 네이버 클라우드 스토리지 서비스 주입
    @Autowired
    private NaverStorageService naverStorageService;

    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        params.setBrdType("REPORT"); // 활동보고서 전용 타입

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "admin/report/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long brdSeq,
                       @ModelAttribute("params") BoardDTO params,
                       Model model) {
        BoardDTO report = new BoardDTO();

        if (brdSeq != null) {
            report = boardMapper.selectBoard(brdSeq);

            // 기존 첨부파일(PDF 책자 등) 조회
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(brdSeq);
            List<FileDTO> files = boardMapper.selectFiles(fileParams);
            report.setFileList(files);
        }

        model.addAttribute("report", report);
        return "admin/report/form";
    }

    @PostMapping("/save")
    public String save(BoardDTO board, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        boolean isUpdate = (board.getBrdSeq() != null); // 신규/수정 판별

        board.setBrdType("REPORT");
        if(board.getIsNotice() == null) board.setIsNotice("N");

        // 1. 활동보고서 기본 정보 저장
        if (isUpdate) {
            board.setModId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.insertBoard(board);
        }

        // 2. 활동보고서 첨부파일 처리 (네이버 클라우드 연동)
        if (board.getUploadFiles() != null && !board.getUploadFiles().isEmpty()) {
            for (MultipartFile file : board.getUploadFiles()) {
                if (!file.isEmpty()) {
                    try {
                        String originalFileName = file.getOriginalFilename();
                        String ext = originalFileName != null && originalFileName.contains(".")
                                ? originalFileName.substring(originalFileName.lastIndexOf(".")) : "";

                        // 서버 로컬이 아닌 네이버 클라우드에 업로드하고 외부 접근 URL 반환받음
                        String cloudUrl = naverStorageService.uploadFile(file, "report");

                        FileDTO fileDTO = new FileDTO();
                        fileDTO.setRefTable("TB_BOARD");
                        fileDTO.setRefSeq(board.getBrdSeq());
                        fileDTO.setOrgFileNm(originalFileName);
                        // 클라우드 URL의 마지막 파일명 부분 추출하여 저장
                        fileDTO.setSaveFileNm(cloudUrl.substring(cloudUrl.lastIndexOf("/") + 1));
                        // DB filePath에는 /upload/report/.. 가 아닌 클라우드 절대 URL(https://...) 이 들어갑니다.
                        fileDTO.setFilePath(cloudUrl);
                        fileDTO.setFileSize(file.getSize());
                        fileDTO.setFileExt(ext);

                        boardMapper.insertFile(fileDTO);
                    } catch (Exception e) {
                        e.printStackTrace();
                        rttr.addFlashAttribute("errorMessage", "클라우드 파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
                    }
                }
            }
        }

        if (isUpdate) {
            rttr.addAttribute("pageNum", board.getPageNum());
            rttr.addAttribute("amount", board.getAmount());
            rttr.addAttribute("category", board.getCategory());
            rttr.addAttribute("searchKeyword", board.getSearchKeyword());
        } else {
            rttr.addAttribute("pageNum", 1);
            rttr.addAttribute("amount", board.getAmount());
        }

        return "redirect:/admin/report/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq, @ModelAttribute BoardDTO params, RedirectAttributes rttr) {
        boardMapper.deleteBoard(brdSeq);

        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("category", params.getCategory());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/admin/report/list";
    }
}