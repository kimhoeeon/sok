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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/people")
public class FrontPeopleController {

    @Autowired
    private BoardMapper boardMapper;

    // 1. SOK 스토리 목록 화면
    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        // SOK 스토리 게시판 코드 세팅
        params.setBrdType("PEOPLE");

        // 목록 및 전체 개수 조회
        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);

        // 2. 첨부파일 아이콘 노출을 위해 각 게시글별 첨부파일 존재 여부 확인
        // N+1 쿼리 성능 최적화: 목록에 있는 모든 게시글의 파일을 단 1번의 쿼리로 가져옴
        if (list != null && !list.isEmpty()) {
            List<Long> brdSeqs = list.stream().map(BoardDTO::getBrdSeq).collect(Collectors.toList());
            List<FileDTO> allFiles = boardMapper.selectFilesByRefSeqs("TB_BOARD", brdSeqs);

            if (allFiles != null && !allFiles.isEmpty()) {
                // 게시글 번호(refSeq)를 기준으로 파일들을 그룹화하여 매핑
                Map<Long, List<FileDTO>> fileMap = allFiles.stream()
                        .collect(Collectors.groupingBy(FileDTO::getRefSeq));

                for (BoardDTO board : list) {
                    board.setFileList(fileMap.getOrDefault(board.getBrdSeq(), new ArrayList<>()));
                }
            }
        }

        // 페이징 객체 생성
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "people/list";
    }

    // 2. SOK 스토리 전용 상세 페이지 이동 메서드
    @GetMapping("/detail")
    public String detail(@RequestParam Long brdSeq, @ModelAttribute("params") BoardDTO params, Model model) {
        // 조회수 1 증가
        boardMapper.updateViewCnt(brdSeq);

        // 게시글 상세 조회
        BoardDTO board = boardMapper.selectBoard(brdSeq);

        if (board == null) {
            // 목록 페이지로 강제 리다이렉트 (또는 공통 에러 페이지 안내)
            return "redirect:/people/list";
        }

        // 상세 페이지에서 노출할 다중 프로필 이미지(첨부파일) 목록 조회 로직
        FileDTO fileParam = new FileDTO();
        fileParam.setRefTable("TB_BOARD");
        fileParam.setRefSeq(brdSeq);
        List<FileDTO> fileList = boardMapper.selectFiles(fileParam);

        // 조회된 파일 리스트를 board 객체에 담아 JSP로 전달
        board.setFileList(fileList);

        model.addAttribute("board", board);

        // SOK 스토리 전용 상세 뷰 페이지로 연결
        return "people/detail";
    }
}