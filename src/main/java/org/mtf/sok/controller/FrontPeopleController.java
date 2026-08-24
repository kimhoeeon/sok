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

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
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
        int pageSize = 9;
        int currentPage = params.getPageNum() > 0 ? params.getPageNum() : 1;

        params.setAmount(pageSize);
        params.setPageNum(currentPage);

        List<BoardDTO> list = new ArrayList<>();
        int total = 0;

        String category = params.getCategory();

        // [A] 인스타그램 탭을 클릭했을 경우
        if ("인스타그램".equals(category)) {
            List<InstagramDTO> instaList = snsMapper.selectInstagramList();
            for (InstagramDTO insta : instaList) {
                BoardDTO board = new BoardDTO();
                board.setBrdSeq(0L);
                board.setCategory(category);

                String title = insta.getTitle();
                board.setTitle(title != null && !title.trim().isEmpty() ? title : insta.getDescription());
                board.setYoutubeUrl(insta.getLinkUrl());
                board.setRegDt(parseStringToDate(insta.getRegDt()));

                FileDTO thumb = new FileDTO();
                thumb.setFilePath("/upload/instagram/" + insta.getFileName());
                List<FileDTO> files = new ArrayList<>();
                files.add(thumb);
                board.setFileList(files);

                list.add(board);
            }
            total = instaList.size();
        }
        // [B] 블로그 탭을 클릭했을 경우
        else if ("블로그".equals(category)) {
            List<BlogDTO> blogList = snsMapper.selectBlogList();
            for (BlogDTO blog : blogList) {
                BoardDTO board = new BoardDTO();
                board.setBrdSeq(0L);
                board.setCategory(category);
                board.setTitle(blog.getTitle());
                board.setYoutubeUrl(blog.getLinkUrl());
                board.setRegDt(convertLdtToDate(blog.getRegDt()));

                FileDTO thumb = new FileDTO();
                thumb.setFilePath("/upload/blog/" + blog.getFileName());
                List<FileDTO> files = new ArrayList<>();
                files.add(thumb);
                board.setFileList(files);

                list.add(board);
            }
            total = blogList.size();
        }
        // [C] 선수, 아티스트 등 단일 카테고리일 경우
        else if (category != null && !category.trim().isEmpty() && !"전체".equals(category)) {
            params.setBrdType("PEOPLE");
            list = boardMapper.selectBoardList(params);
            total = boardMapper.selectBoardTotalCount(params);

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
        // [D] "전체" (카테고리가 없거나 '전체'일 경우) - 모든 데이터 병합 및 최신순 정렬 처리
        else {
            List<BoardDTO> allList = new ArrayList<>();

            // 1. 게시판(TB_BOARD) 전체 데이터 조회 (페이징을 무시하기 위해 limit 수치를 임시로 크게 설정)
            params.setBrdType("PEOPLE");
            params.setAmount(100000);
            params.setPageNum(1);
            List<BoardDTO> boardList = boardMapper.selectBoardList(params);

            if (boardList != null && !boardList.isEmpty()) {
                List<Long> brdSeqs = boardList.stream().map(BoardDTO::getBrdSeq).collect(Collectors.toList());
                List<FileDTO> allFiles = boardMapper.selectFilesByRefSeqs("TB_BOARD", brdSeqs);

                if (allFiles != null && !allFiles.isEmpty()) {
                    Map<Long, List<FileDTO>> fileMap = allFiles.stream()
                            .collect(Collectors.groupingBy(FileDTO::getRefSeq));

                    for (BoardDTO board : boardList) {
                        board.setFileList(fileMap.getOrDefault(board.getBrdSeq(), new ArrayList<>()));
                    }
                }
                allList.addAll(boardList);
            }

            // 2. 인스타그램 전체 조회 및 변환 병합
            List<InstagramDTO> instaList = snsMapper.selectInstagramList();
            if (instaList != null) {
                for (InstagramDTO insta : instaList) {
                    BoardDTO board = new BoardDTO();
                    board.setBrdSeq(0L);
                    board.setCategory("인스타그램");
                    String title = insta.getTitle();
                    board.setTitle(title != null && !title.trim().isEmpty() ? title : insta.getDescription());
                    board.setYoutubeUrl(insta.getLinkUrl());
                    board.setRegDt(parseStringToDate(insta.getRegDt()));

                    FileDTO thumb = new FileDTO();
                    thumb.setFilePath("/upload/instagram/" + insta.getFileName());
                    List<FileDTO> files = new ArrayList<>();
                    files.add(thumb);
                    board.setFileList(files);
                    allList.add(board);
                }
            }

            // 3. 블로그 전체 조회 및 변환 병합
            List<BlogDTO> blogList = snsMapper.selectBlogList();
            if (blogList != null) {
                for (BlogDTO blog : blogList) {
                    BoardDTO board = new BoardDTO();
                    board.setBrdSeq(0L);
                    board.setCategory("블로그");
                    board.setTitle(blog.getTitle());
                    board.setYoutubeUrl(blog.getLinkUrl());
                    board.setRegDt(convertLdtToDate(blog.getRegDt()));

                    FileDTO thumb = new FileDTO();
                    thumb.setFilePath("/upload/blog/" + blog.getFileName());
                    List<FileDTO> files = new ArrayList<>();
                    files.add(thumb);
                    board.setFileList(files);
                    allList.add(board);
                }
            }

            // 4. 최신순(regDt 내림차순) 정렬
            allList.sort((a, b) -> {
                if (a.getRegDt() == null && b.getRegDt() == null) return 0;
                if (a.getRegDt() == null) return 1;
                if (b.getRegDt() == null) return -1;
                return b.getRegDt().compareTo(a.getRegDt());
            });

            // 5. 자바 메모리상에서 서브리스트를 활용한 수동 페이징 처리
            total = allList.size();
            int fromIndex = (currentPage - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, total);

            if (fromIndex < total) {
                list = new ArrayList<>(allList.subList(fromIndex, toIndex));
            }

            // 6. 하단 PageDTO(페이징 버튼) 생성을 위해 원래 페이징 파라미터 복구
            params.setAmount(pageSize);
            params.setPageNum(currentPage);
            // category 값이 없더라도 빈값 유지 (전체 탭 활성화 위함)
            params.setCategory(category);
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

    // ==========================================
    // 날짜 타입 변환 헬퍼(Helper) 메서드
    // ==========================================

    // String 형식을 java.util.Date 로 변환 (InstagramDTO 용)
    private Date parseStringToDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        try {
            // YYYY-MM-DD 인지 YYYY-MM-DD HH:mm:ss 인지 길이에 따라 분기 처리
            if (dateStr.length() <= 10) {
                return new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            } else {
                return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(dateStr);
            }
        } catch (Exception e) {
            // 파싱 실패 시 예외를 던지지 않고 null 반환 (정렬 시 맨 뒤로 밀림)
            return null;
        }
    }

    // LocalDateTime 형식을 java.util.Date 로 변환 (BlogDTO 용)
    private Date convertLdtToDate(LocalDateTime ldt) {
        if (ldt == null) {
            return null;
        }
        return Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
    }
}