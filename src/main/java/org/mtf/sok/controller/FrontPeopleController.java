package org.mtf.sok.controller;

import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/people")
public class FrontPeopleController {

    @Autowired
    private BoardMapper boardMapper;

    // 1. 함께하는 사람들 목록 화면
    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        // 함께하는 사람들 게시판 코드 세팅
        params.setBrdType("PEOPLE");

        // 목록 및 전체 개수 조회
        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);

        // 썸네일 노출을 위해 각 게시글별 첨부파일 조회
        for (BoardDTO board : list) {
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(board.getBrdSeq());
            board.setFileList(boardMapper.selectFiles(fileParams));
        }

        // 페이징 객체 생성
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "people/list";
    }

    // 2. 함께하는 사람들 전용 상세 페이지 이동 메서드
    @GetMapping("/detail")
    public String detail(@RequestParam Long brdSeq, @ModelAttribute("params") BoardDTO params, Model model) {
        // 조회수 1 증가
        boardMapper.updateViewCnt(brdSeq);

        // 게시글 상세 조회
        BoardDTO board = boardMapper.selectBoard(brdSeq);

        model.addAttribute("board", board);

        // 함께하는 사람들 전용 상세 뷰 페이지로 연결
        return "people/detail";
    }
}