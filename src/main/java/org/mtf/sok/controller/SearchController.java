package org.mtf.sok.controller;

import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Controller
public class SearchController {

    @Autowired
    private BoardMapper boardMapper;

    // =========================================================================
    // [1] 정적 메뉴 데이터 (실제 홈페이지 메뉴 구조에 맞게 이름과 URL을 추가)
    // =========================================================================
    private static final List<Map<String, String>> SITE_MENUS = new ArrayList<>();

    static {
        // 1. SOK 소개
        addMenu("SOK 소개", "인사말", "/intro/greeting");
        addMenu("SOK 소개", "단체소개", "/intro/about");
        addMenu("SOK 소개", "조직구성", "/intro/org");
        addMenu("SOK 소개", "위원회", "javascript:alert('준비중입니다.');");
        addMenu("SOK 소개", "운영자료", "/management/list");
        addMenu("SOK 소개", "오시는 길", "/intro/way");

        // 2. SOK 스토리
        addMenu("SOK 스토리", "", "/people/list");

        // 3. 사업소개
        addMenu("사업소개", "스포츠", "/business/sports");
        addMenu("사업소개", "문화예술", "/business/culture");
        addMenu("사업소개", "커뮤니티", "/business/commu");
        addMenu("사업소개", "인식개선", "/business/awareness");

        // 4. 알림공간
        addMenu("알림공간", "공지사항", "/notice/list");
        addMenu("알림공간", "입찰정보", "/bidding/list");
        addMenu("알림공간", "채용정보", "/careers/list");
        addMenu("알림공간", "자료실", "/press/list");
        addMenu("알림공간", "활동보고서", "/report/list");
        addMenu("알림공간", "스페셜올림픽코리아 소식", "/news/list");

        // 5. 참여공간
        addMenu("참여공간", "후원하기", "/sponsor/donate");
        addMenu("참여공간", "자원봉사 신청", "/volunteer/apply");
        addMenu("참여공간", "선수등록", "http://110.45.238.25/login.do");
        addMenu("참여공간", "증명서 신청", "/certificate/apply");
    }

    private static void addMenu(String depth1, String depth2, String url) {
        Map<String, String> menu = new HashMap<>();
        menu.put("depth1", depth1);
        menu.put("depth2", depth2);
        menu.put("url", url);
        // 검색을 위해 1뎁스와 2뎁스 텍스트를 합침
        menu.put("searchText", depth1 + " " + depth2);
        SITE_MENUS.add(menu);
    }

    // =========================================================================
    // [2] 통합 검색 결과 페이지 라우팅
    // =========================================================================
    @GetMapping("/search")
    public String integratedSearch(@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
        model.addAttribute("keyword", keyword);
        int totalSum = 0;

        // 검색어가 있을 때만 전체 조회 로직 실행
        if (!keyword.trim().isEmpty()) {

            // 1. 메뉴 검색 (대소문자 구분 없이 필터링 및 뎁스별 <span> 구성)
            List<Map<String, String>> menuResults = SITE_MENUS.stream()
                    .filter(m -> m.get("searchText").toLowerCase().contains(keyword.toLowerCase()))
                    .map(m -> {
                        Map<String, String> processedMenu = new HashMap<>();
                        processedMenu.put("url", m.get("url"));

                        String regex = "(?i)(" + Pattern.quote(keyword) + ")";
                        String replacement = "<span class='on'>$1</span>";

                        // 1뎁스, 2뎁스 각각 하이라이트 처리
                        String d1 = m.get("depth1").replaceAll(regex, replacement);
                        StringBuilder htmlBuilder = new StringBuilder();
                        htmlBuilder.append("<span>홈</span><span>").append(d1).append("</span>");

                        // 2뎁스가 존재할 경우에만 추가
                        if (m.get("depth2") != null && !m.get("depth2").isEmpty()) {
                            String d2 = m.get("depth2").replaceAll(regex, replacement);
                            htmlBuilder.append("<span>").append(d2).append("</span>");
                        }

                        // JSP에서 바로 출력할 수 있도록 완전한 HTML 묶음으로 세팅
                        processedMenu.put("html", htmlBuilder.toString());
                        return processedMenu;
                    })
                    .collect(Collectors.toList());

            model.addAttribute("menuList", menuResults);
            model.addAttribute("menuTotal", menuResults.size());
            totalSum += menuResults.size();

            // 2. 공지사항 (NOTICE)
            totalSum += searchBoard(keyword, "NOTICE", "notice", model);

            // 3. 입찰공고 (BIDDING)
            totalSum += searchBoard(keyword, "BIDDING", "bid", model);

            // 4. 채용공고 (CAREERS)
            totalSum += searchBoard(keyword, "CAREERS", "careers", model);

            // 5. 자료실 (PRESS)
            totalSum += searchBoard(keyword, "PRESS", "press", model);

            // 6. 활동보고서 (REPORT)
            totalSum += searchBoard(keyword, "REPORT", "report", model);

            // 7. SOK 소식 (NEWS)
            totalSum += searchBoard(keyword, "NEWS", "news", model);
        }

        model.addAttribute("totalSum", totalSum);

        return "search/index";
    }

    // =========================================================================
    // [3] 중복되는 게시판 검색 로직 및 UI 데이터 가공 헬퍼 메서드
    // =========================================================================
    private int searchBoard(String keyword, String brdType, String modelPrefix, Model model) {
        BoardDTO param = new BoardDTO();
        param.setBrdType(brdType);
        param.setSearchKeyword(keyword);
        param.setPageNum(1);
        param.setAmount(5);

        List<BoardDTO> list = boardMapper.selectBoardList(param);
        int total = boardMapper.selectBoardTotalCount(param);

        // 검색 데이터 UI 가공 로직 (HTML 태그 제거 및 하이라이트)
        if (list != null && !list.isEmpty()) {
            String regex = "(?i)(" + Pattern.quote(keyword) + ")";
            String replacement = "<span class='on'>$1</span>";

            for (BoardDTO board : list) {
                if (board.getTitle() != null) {
                    board.setTitle(board.getTitle().replaceAll(regex, replacement));
                }

                if (board.getContent() != null) {
                    String plainText = board.getContent()
                            .replaceAll("<[^>]*>", "")
                            .replaceAll("&nbsp;", " ")
                            .replaceAll("&lt;", "<")
                            .replaceAll("&gt;", ">");

                    board.setContent(plainText.replaceAll(regex, replacement));
                }
            }
        }

        model.addAttribute(modelPrefix + "List", list);
        model.addAttribute(modelPrefix + "Total", total);

        return total;
    }
}