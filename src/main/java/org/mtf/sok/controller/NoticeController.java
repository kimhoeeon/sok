package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin/notice")
public class NoticeController {

    @Autowired
    private BoardMapper boardMapper;

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
        if (board.getIsNotice() == null) board.setIsNotice("N");

        if (board.getBrdSeq() != null) {
            board.setModId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.updateBoard(board);
        } else {
            board.setRegId(admin != null ? admin.getMbrId() : "SYSTEM");
            boardMapper.insertBoard(board);
        }
        return "redirect:/admin/notice/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long brdSeq) {
        boardMapper.deleteBoard(brdSeq);
        return "redirect:/admin/notice/list";
    }
}