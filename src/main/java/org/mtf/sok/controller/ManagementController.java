package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BoardMapper;
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
@RequestMapping("/admin/management")
public class ManagementController {

    @Autowired
    private BoardMapper boardMapper;

    @Autowired
    private FileController fileController;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        params.setBrdType("MANAGEMENT");

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "admin/management/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long brdSeq,
                       @ModelAttribute("params") BoardDTO params,
                       Model model) {
        BoardDTO board = new BoardDTO();

        if (brdSeq != null) {
            board = boardMapper.selectBoard(brdSeq);
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(brdSeq);
            board.setFileList(boardMapper.selectFiles(fileParams));
        }

        model.addAttribute("management", board);
        return "admin/management/form";
    }

    @PostMapping("/save")
    public String save(BoardDTO board, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        boolean isUpdate = (board.getBrdSeq() != null);

        board.setBrdType("MANAGEMENT");

        if (isUpdate) {
            board.setModId(admin != null ? admin.getAdmId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getAdmId() : "SYSTEM");
            boardMapper.insertBoard(board);
        }

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

        if (isUpdate) {
            rttr.addAttribute("pageNum", board.getPageNum());
            rttr.addAttribute("amount", board.getAmount());
            rttr.addAttribute("category", board.getCategory());
            rttr.addAttribute("searchKeyword", board.getSearchKeyword());
        } else {
            rttr.addAttribute("pageNum", 1);
            rttr.addAttribute("amount", board.getAmount());
        }

        return "redirect:/admin/management/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq, @ModelAttribute BoardDTO params, RedirectAttributes rttr) {

        // ★ 1. 삭제할 게시글의 첨부파일 목록 먼저 조회
        FileDTO fileParams = new FileDTO();
        fileParams.setRefTable("TB_BOARD");
        fileParams.setRefSeq(brdSeq);
        List<FileDTO> fileList = boardMapper.selectFiles(fileParams);

        // ★ 2. 서버 로컬(webapps/upload/management)에서 실제 물리 파일 삭제
        if (fileList != null && !fileList.isEmpty()) {
            for (FileDTO file : fileList) {
                fileController.deleteLocalFile(file.getFilePath());
            }
        }

        // 3. 기존 글 삭제 로직
        boardMapper.deleteBoard(brdSeq);

        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchType", params.getSearchType());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/admin/management/list";
    }
}