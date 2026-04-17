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
@RequestMapping("/admin/bidding")
public class BiddingController {

    @Autowired
    private BoardMapper boardMapper;

    @Autowired
    private FileController fileController;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        params.setBrdType("BIDDING");

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "admin/bidding/list";
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
        } else {
            board.setIsNotice("N");
        }

        model.addAttribute("bidding", board);
        return "admin/bidding/form";
    }

    @PostMapping("/save")
    public String save(BoardDTO board, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        boolean isUpdate = (board.getBrdSeq() != null);

        board.setBrdType("BIDDING");

        if (isUpdate) {
            board.setModId(admin != null ? admin.getAdmId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getAdmId() : "SYSTEM");
            boardMapper.insertBoard(board);
        }

        if (board.getUploadFiles() != null && !board.getUploadFiles().isEmpty()) {
            String savePath = uploadDir + "bidding/";
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
                        fileDTO.setFilePath("/upload/bidding/" + savedFileName);
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

        return "redirect:/admin/bidding/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq, @ModelAttribute BoardDTO params, RedirectAttributes rttr) {

        // ★ 1. 삭제할 게시글의 첨부파일 목록 먼저 조회
        FileDTO fileParams = new FileDTO();
        fileParams.setRefTable("TB_BOARD");
        fileParams.setRefSeq(brdSeq);
        List<FileDTO> fileList = boardMapper.selectFiles(fileParams);

        // ★ 2. 서버 로컬에서 실제 물리 파일 삭제
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

        return "redirect:/admin/bidding/list";
    }

    @GetMapping("/excel")
    public void downloadExcel(@ModelAttribute BoardDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1);
        params.setAmount(1000000);
        params.setBrdType("BIDDING");

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
            row.add(board.getRegDt());
            data.add(row);
        }
        ExcelUtils.download(response, "입찰정보_내역", headers, data);
    }
}