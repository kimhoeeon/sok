package org.mtf.sok.controller;

import org.mtf.sok.domain.*;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.mapper.SnsMapper;
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

    @Autowired
    private SnsMapper snsMapper;

    // 1. SOK 스토리 목록 화면
    @GetMapping("/list")
    public String list(@ModelAttribute BoardDTO params, Model model) {
        // SOK 스토리 목록은 한 줄에 3개씩 노출되므로, 디자인을 위해 한 페이지당 9개씩 호출되도록 강제 설정
        params.setAmount(9);

        List<BoardDTO> list = new ArrayList<>();
        int total = 0;

        String category = params.getCategory();

        // [A] 인스타그램 탭을 클릭했을 경우
        if ("인스타그램".equals(category)) {
            // SnsMapper.xml에 작성된 selectInstagramList 쿼리 호출 (LIMIT 9 내장됨)
            List<InstagramDTO> instaList = snsMapper.selectInstagramList();

            // 기존 list.jsp 화면 구조를 100% 재사용하기 위해 InstagramDTO를 BoardDTO 형태로 변환
            for (InstagramDTO insta : instaList) {
                BoardDTO board = new BoardDTO();
                board.setBrdSeq(0L); // 외부 링크이므로 내부 시퀀스 불필요
                board.setCategory(category);

                // 인스타그램 게시글 내용 매핑
                String title = insta.getTitle();
                if (title == null || title.trim().isEmpty()) {
                    title = insta.getDescription(); // 제목이 없을 경우 내용(description)으로 대체
                }
                board.setTitle(title);

                // 외부 링크 (BoardDTO의 youtubeUrl 변수를 외부 링크 속성으로 재활용)
                board.setYoutubeUrl(insta.getLinkUrl());

                // 썸네일 파일 매핑 (저장된 실제 이미지 경로 지정)
                FileDTO thumb = new FileDTO();
                thumb.setFilePath("/upload/instagram/" + insta.getFileName());
                List<FileDTO> files = new ArrayList<>();
                files.add(thumb);
                board.setFileList(files);

                list.add(board);
            }
            total = instaList.size(); // SnsMapper 쿼리에 LIMIT 9 가 설정되어 있으므로 사이즈를 토탈로 사용
        }
        // [B] 블로그 탭을 클릭했을 경우
        else if ("블로그".equals(category)) {
            // SnsMapper.xml에 작성된 selectBlogList 쿼리 호출 (LIMIT 9 내장됨)
            List<BlogDTO> blogList = snsMapper.selectBlogList();

            // 기존 list.jsp 화면 구조를 100% 재사용하기 위해 BlogDTO를 BoardDTO 형태로 변환
            for (BlogDTO blog : blogList) {
                BoardDTO board = new BoardDTO();
                board.setBrdSeq(0L); // 외부 링크이므로 내부 시퀀스 불필요
                board.setCategory(category);
                board.setTitle(blog.getTitle());
                board.setYoutubeUrl(blog.getLinkUrl());

                // 썸네일 파일 매핑 (저장된 실제 이미지 경로 지정)
                FileDTO thumb = new FileDTO();
                thumb.setFilePath("/upload/blog/" + blog.getFileName());
                List<FileDTO> files = new ArrayList<>();
                files.add(thumb);
                board.setFileList(files);

                list.add(board);
            }
            total = blogList.size(); // SnsMapper 쿼리에 LIMIT 9 가 설정되어 있으므로 사이즈를 토탈로 사용
        }
        // [C] 전체 및 기존 SOK 스토리 카테고리일 경우 (TB_BOARD 테이블 연동)
        else {
            params.setBrdType("PEOPLE");
            list = boardMapper.selectBoardList(params);
            total = boardMapper.selectBoardTotalCount(params);

            // N+1 쿼리 성능 최적화: 첨부파일 일괄 조회 매핑 로직
            if (list != null && !list.isEmpty()) {
                List<Long> brdSeqs = list.stream().map(BoardDTO::getBrdSeq).collect(Collectors.toList());
                List<FileDTO> allFiles = boardMapper.selectFilesByRefSeqs("TB_BOARD", brdSeqs);

                if (allFiles != null && !allFiles.isEmpty()) {
                    Map<Long, List<FileDTO>> fileMap = allFiles.stream()
                            .collect(Collectors.groupingBy(FileDTO::getRefSeq));

                    for (BoardDTO board : list) {
                        board.setFileList(fileMap.getOrDefault(board.getBrdSeq(), new ArrayList<>()));
                    }
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