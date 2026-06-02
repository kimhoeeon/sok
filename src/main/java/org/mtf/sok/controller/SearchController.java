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
import java.util.stream.Collectors;

@Controller
public class SearchController {

    @Autowired
    private BoardMapper boardMapper;

    // =========================================================================
    // [1] 정적 메뉴 데이터 (실제 홈페이지 메뉴 구조에 맞게 이름과 URL을 추가해주세요)
    // =========================================================================
    private static final List<Map<String, String>> SITE_MENUS = new ArrayList<>();

    static {
        addMenu("스페셜올림픽코리아 소개", "/intro/about");
        addMenu("인사말", "/intro/greeting");
        addMenu("연혁", "/intro/history");
        addMenu("조직도", "/intro/org");
        addMenu("공지사항", "/notice/list");
        addMenu("SOK 소식", "/news/list");
        addMenu("채용공고", "/careers/list");
        addMenu("입찰공고", "/bidding/list");
        addMenu("자료실", "/press/list");
        addMenu("활동보고서", "/report/list");
        addMenu("운영자료", "/management/list");
        addMenu("후원하기", "/sponsor/donate");
        addMenu("자원봉사 신청", "/volunteer/apply");
        addMenu("증명서 신청", "/certificate/apply");
        // 필요에 따라 홈페이지의 모든 메뉴를 여기에 등록해 두시면 됩니다.
    }

    private static void addMenu(String name, String url) {
        Map<String, String> menu = new HashMap<>();
        menu.put("name", name);
        menu.put("url", url);
        SITE_MENUS.add(menu);
    }

    // =========================================================================
    // [2] 통합 검색 결과 페이지 라우팅
    // =========================================================================
    @GetMapping("/search")
    public String integratedSearch(@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
        model.addAttribute("keyword", keyword);
        int totalSum = 0;

        // 검색어가 있을 때만 조회 로직 실행
        if (!keyword.trim().isEmpty()) {

            // 1. 메뉴 검색 (대소문자 구분 없이 필터링)
            List<Map<String, String>> menuResults = SITE_MENUS.stream()
                    .filter(m -> m.get("name").toLowerCase().contains(keyword.toLowerCase()))
                    .collect(Collectors.toList());

            model.addAttribute("menuList", menuResults);
            model.addAttribute("menuTotal", menuResults.size());
            totalSum += menuResults.size();

            // 2. 공지사항 (NOTICE)
            totalSum += searchBoard(keyword, "NOTICE", "notice", model);

            // 3. 입찰공고 (BIDDING)
            totalSum += searchBoard(keyword, "BIDDING", "bid", model);

            // 4. 채용공고 (CAREERS)
            totalSum += searchBoard(keyword, "CAREERS", "recruit", model);

            // 5. 자료실 (PRESS)
            totalSum += searchBoard(keyword, "PRESS", "press", model);

            // 6. 활동보고서 (REPORT)
            totalSum += searchBoard(keyword, "REPORT", "report", model);

            // 7. SOK 소식 (NEWS)
            totalSum += searchBoard(keyword, "NEWS", "news", model);
        }

        // 전체 합산 건수를 Model에 담아 화면으로 전달
        model.addAttribute("totalSum", totalSum);

        return "search/index";
    }

    // =========================================================================
    // [3] 중복되는 게시판 검색 로직을 처리하는 헬퍼 메서드
    // =========================================================================
    private int searchBoard(String keyword, String brdType, String modelPrefix, Model model) {
        BoardDTO param = new BoardDTO();
        param.setBrdType(brdType);
        param.setSearchKeyword(keyword);
        param.setPageNum(1);
        param.setAmount(5); // 통합 검색 화면이므로 각 게시판별 최신 5건만 가져옴

        List<BoardDTO> list = boardMapper.selectBoardList(param);
        int total = boardMapper.selectBoardTotalCount(param);

        // JSP에서 사용할 수 있도록 접두사(Prefix)를 붙여 동적으로 Model에 세팅
        // 예: noticeList, noticeTotal
        model.addAttribute(modelPrefix + "List", list);
        model.addAttribute(modelPrefix + "Total", total);

        return total; // 총계 합산을 위해 해당 게시판의 검색 건수 반환
    }
}