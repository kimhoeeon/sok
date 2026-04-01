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
@RequestMapping("/admin/management")
public class ManagementController {

    @Autowired
    private BoardMapper boardMapper;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String title,
                       @RequestParam(required = false) String category, Model model) {
        BoardDTO params = new BoardDTO();
        params.setBrdType("MANAGEMENT"); // 경영공시 전용 타입
        params.setTitle(title);
        params.setCategory(category);

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        model.addAttribute("list", list);
        model.addAttribute("searchTitle", title);
        model.addAttribute("searchCategory", category);

        return "admin/management/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long brdSeq, Model model) {
        BoardDTO management = new BoardDTO();

        if (brdSeq != null) {
            management = boardMapper.selectBoard(brdSeq);

            // 기존 첨부파일 조회
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(brdSeq);
            List<FileDTO> files = boardMapper.selectFiles(fileParams);
            management.setFileList(files);
        }

        model.addAttribute("management", management);
        return "admin/management/form";
    }

    @PostMapping("/save")
    public String save(BoardDTO board, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        board.setBrdType("MANAGEMENT");
        if(board.getIsNotice() == null) board.setIsNotice("N");

        // 1. 게시글 정보 저장
        if (board.getBrdSeq() != null) {
            board.setModId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.insertBoard(board);
        }

        // 2. 경영공시 첨부파일 처리 (TB_FILE 연동)
        if (board.getUploadFiles() != null && !board.getUploadFiles().isEmpty()) {
            String savePath = uploadDir + "management/";
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
                        fileDTO.setFilePath("/upload/management/" + savedFileName);
                        fileDTO.setFileSize(file.getSize());
                        fileDTO.setFileExt(ext);

                        boardMapper.insertFile(fileDTO);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return "redirect:/admin/management/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq) {
        boardMapper.deleteBoard(brdSeq);
        return "redirect:/admin/management/list";
    }
}