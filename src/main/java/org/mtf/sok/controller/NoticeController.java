package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
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
    public String list(@RequestParam(required = false) String title, Model model) {
        BoardDTO params = new BoardDTO();
        params.setBrdType("NOTICE");
        params.setTitle(title);

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        model.addAttribute("list", list);
        model.addAttribute("searchTitle", title);

        return "admin/notice/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long brdSeq, Model model) {
        BoardDTO notice = new BoardDTO();
        if (brdSeq != null) {
            notice = boardMapper.selectBoard(brdSeq);
        } else {
            notice.setIsNotice("N"); // 기본값 세팅
        }
        model.addAttribute("notice", notice);
        return "admin/notice/form";
    }

    @PostMapping("/save")
    public String save(BoardDTO board, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        board.setBrdType("NOTICE");
        if(board.getIsNotice() == null) board.setIsNotice("N");

        // 1. 게시글 정보 먼저 Insert 또는 Update (brdSeq 확보)
        if (board.getBrdSeq() != null) {
            board.setModId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.insertBoard(board); // 이 때 useGeneratedKeys 설정으로 board 객체에 brdSeq가 담김
        }

        // 2. 다중 첨부파일 물리적 저장 및 DB 기록 (TB_FILE 활용)
        if (board.getUploadFiles() != null && !board.getUploadFiles().isEmpty()) {
            String savePath = uploadDir + "notice/"; // 게시판별 폴더 분리
            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            for (MultipartFile file : board.getUploadFiles()) {
                if (!file.isEmpty()) {
                    try {
                        String originalFileName = file.getOriginalFilename();
                        String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String savedFileName = UUID.randomUUID().toString() + ext;

                        // 물리적 파일 저장
                        File targetFile = new File(savePath + savedFileName);
                        file.transferTo(targetFile);

                        // 통합 첨부파일 DB 정보 저장
                        FileDTO fileDTO = new FileDTO();
                        fileDTO.setRefTable("TB_BOARD");           // 참조 테이블명 고정
                        fileDTO.setRefSeq(board.getBrdSeq());      // 방금 저장된 게시글 일련번호
                        fileDTO.setOrgFileNm(originalFileName);
                        fileDTO.setSaveFileNm(savedFileName);
                        fileDTO.setFilePath("/upload/notice/" + savedFileName);
                        fileDTO.setFileSize(file.getSize());
                        fileDTO.setFileExt(ext);

                        boardMapper.insertFile(fileDTO); // TB_FILE 에 저장
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return "redirect:/admin/notice/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq) {
        boardMapper.deleteBoard(brdSeq);
        return "redirect:/admin/notice/list";
    }
}