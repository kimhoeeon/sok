package org.mtf.sok.controller;

import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.util.CookieUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/news")
public class FrontNewsController {

    @Autowired
    private BoardMapper boardMapper;

    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        // 보도자료 게시판 코드 세팅
        params.setBrdType("NEWS");

        // 1. 목록 및 전체 개수 조회
        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);

        // 2. 썸네일 노출을 위해 각 게시글별 첨부파일 조회
        for (BoardDTO board : list) {
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(board.getBrdSeq());
            board.setFileList(boardMapper.selectFiles(fileParams));
        }

        // 3. 페이징 객체 생성
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "news/list";
    }

    // 공통 상세 페이지 이동 메서드 (Controller 내부에 복사)
    @GetMapping("/detail")
    public String detail(@RequestParam("brdSeq") Long brdSeq, @ModelAttribute("params") BoardDTO params, Model model,
                         HttpServletRequest request, HttpServletResponse response) {

        // 1. 조회수 중복 방지 (쿠키)
        if (!CookieUtils.checkAndViewCookie(request, response, "board_news", brdSeq)) {
            boardMapper.updateViewCnt(brdSeq);
        }

        // 2. 게시글 상세 조회
        BoardDTO board = boardMapper.selectBoard(brdSeq);

        if (board != null) {
            // 3. 첨부파일 조회
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_BOARD");
            fileParams.setRefSeq(brdSeq);
            board.setFileList(boardMapper.selectFiles(fileParams));

            // 4. 이전글/다음글 조회 (조회를 위해 현재 타입과 시퀀스 세팅)
            params.setBrdType(board.getBrdType());
            params.setBrdSeq(brdSeq);

            BoardDTO prevBoard = boardMapper.selectPrevBoard(params);
            BoardDTO nextBoard = boardMapper.selectNextBoard(params);

            model.addAttribute("board", board);
            model.addAttribute("prevBoard", prevBoard);
            model.addAttribute("nextBoard", nextBoard);
        }

        // 5. 공통 상세 뷰 페이지로 연결
        return "board/detail";
    }
}