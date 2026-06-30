package org.mtf.sok.controller;

import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/business")
public class FrontBusinessController {

    @Autowired
    private BoardMapper boardMapper;

    // ==========================================
    // 1. 스포츠(Sports) 영역
    // ==========================================

    // [사업소식] 목록 - sports.html
    @GetMapping("/sports")
    public String sportsList(@ModelAttribute BoardDTO params, Model model) {
        params.setBrdType("BUSINESS");
        params.setCategory("SPORTS");

        List<BoardDTO> list = boardMapper.selectBoardList(params);
        int total = boardMapper.selectBoardTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "business/sports/list";
    }

    // 35개 종목 데이터를 메모리에 캐싱 (향후 DB의 TB_SPORTS 테이블로 전환하기 용이한 구조)
    private static final Map<String, Map<String, String>> SPORTS_DATA = new HashMap<>();

    static {
        // ==========================================
        // [1] 구기 스포츠 (10개)
        // ==========================================
        addSport("tennis", "테니스", "[Special Olympic] 하계스포츠 [INAS] 하계스포츠", "");
        addSport("softball", "소프트볼", "[Special Olympic] 하계스포츠", "");
        addSport("netball", "넷볼", "[Special Olympic] 하계스포츠", "");
        addSport("handball", "핸드볼", "[Special Olympic] 하계스포츠", "");
        addSport("volleyball", "배구", "[Special Olympic] 동계스포츠 [Unified Sports] 통합스포츠", "/file/volleyball.pdf");
        addSport("tabletennis", "탁구", "[Special Olympic] 하계스포츠 [Unified Sports] 하계스포츠 [INAS] 하계스포츠", "");
        addSport("football", "축구", "[Special Olympic] 하계스포츠 [Unified Sports] 하계스포츠", "");
        addSport("futsal", "풋살", "[INAS] 하계스포츠", "");
        addSport("basketball", "농구", "[Special Olympic] 하계스포츠 [Unified Sports] 하계스포츠 [INAS] 하계스포츠", "/file/basketball.pdf");
        addSport("badminton", "배드민턴", "[Special Olympic] 하계스포츠 [Unified Sports] 하계스포츠", "/file/badminton.hwp");

        // ==========================================
        // [2] 수상·해양 스포츠 (5개)
        // ==========================================
        addSport("yacht", "요트", "[Special Olympic] 하계스포츠 [INAS] 하계스포츠", "");
        addSport("kayak", "카약", "[Special Olympic] 하계스포츠", "");
        addSport("outdoorswim", "실외수영", "[Special Olympic] 하계스포츠", "");
        addSport("swim", "수영", "[Special Olympic] 하계스포츠 [INAS] 하계스포츠", "");
        addSport("rowing", "조정", "[INAS] 하계스포츠", "");

        // ==========================================
        // [3] 개인기록 스포츠 (4개)
        // ==========================================
        addSport("athletics", "육상", "[Special Olympic] 하계스포츠 [INAS] 하계스포츠", "");
        addSport("cycling", "사이클", "[Special Olympic] 하계스포츠 [INAS] 하계스포츠", "");
        addSport("weightlifting", "역도", "[Special Olympic] 하계스포츠", "/file/weightlifting.hwp");
        addSport("rollerskate", "롤러스케이트", "[Special Olympic] 하계스포츠", "/file/rollerskate.pdf");

        // ==========================================
        // [4] 기타 스포츠 (8개)
        // ==========================================
        addSport("judo", "유도", "[Special Olympic] 하계스포츠", "");
        addSport("rhythmic", "리듬체조", "[Special Olympic] 하계스포츠", "");
        addSport("gymnastics", "기계체조", "[Special Olympic] 하계스포츠", "");
        addSport("horseback", "승마", "[Special Olympic] 하계스포츠", "");
        addSport("cricket", "크리켓", "[Special Olympic] 하계스포츠", "");
        addSport("bowling", "볼링", "[Special Olympic] 하계스포츠", "");
        addSport("golf", "골프", "[Special Olympic] 하계스포츠", "/file/golf.pdf");
        addSport("bocce", "보체", "[Special Olympic] 하계스포츠", "/file/bocce.pdf");

        // ==========================================
        // [5] 동계 스포츠 (8개)
        // ==========================================
        addSport("floorhockey", "플로어하키", "[Special Olympic] 동계스포츠 [Unified Sports] 통합스포츠", "/file/floorhockey.hwp");
        addSport("figureskate", "피겨스케이트", "[Special Olympic] 동계스포츠", "/file/figureskate.hwp");
        addSport("speedskate", "스피드스케이트", "[Special Olympic] 동계스포츠", "/file/speedskate.hwp");
        addSport("snowboard", "스노보드", "[Special Olympic] 동계스포츠", "/file/snowboard.hwp");
        addSport("snowshoe", "스노슈잉", "[Special Olympic] 동계스포츠", "/file/snowshoe.hwp");
        addSport("crosscountry", "크로스컨트리", "[Special Olympic] 동계스포츠", "/file/crosscountry.hwp");
        addSport("nordicski", "노르딕스키", "[INAS] 동계스포츠", "");
        addSport("alpineski", "알파인스키", "[INAS] 동계스포츠", "/file/alpineski.hwp");
    }

    // 맵 데이터 초기화를 위한 헬퍼 메서드
    private static void addSport(String id, String name, String desc, String fileUrl) {
        Map<String, String> data = new HashMap<>();
        data.put("name", name);
        data.put("description", desc);
        data.put("fileUrl", fileUrl);
        SPORTS_DATA.put(id, data);
    }

    // [사업소식] 상세
    @GetMapping("/sports/{sportId}")
    public String sportDetail(@PathVariable String sportId, Model model) {

        // 1. 유효하지 않은 종목 URL 방어 로직
        if (!SPORTS_DATA.containsKey(sportId)) {
            return "redirect:/business/sports/list";
        }

        // 2. 공통 view.jsp에 데이터 전달
        model.addAttribute("sportId", sportId);
        model.addAttribute("sport", SPORTS_DATA.get(sportId));

        return "business/sports/view";
    }

    // [국제대회] 메인 및 하위 페이지
    @GetMapping("/sports/intl")
    public String sportsIntl() { return "business/sports/intl"; }

    @GetMapping("/sports/intl-global")
    public String sportsIntlGlobal() { return "business/sports/intl_global"; }

    @GetMapping("/sports/intl-category")
    public String sportsIntlCategory() { return "business/sports/intl_category"; }

    // [국내대회] 메인 및 하위 페이지
    @GetMapping("/sports/domestic")
    public String sportsDomestic() { return "business/sports/domestic"; }

    @GetMapping("/sports/domestic-winter")
    public String sportsDomesticWinter() { return "business/sports/domestic_winter"; }

    // [통합스포츠] 메인 및 하위 페이지
    @GetMapping("/sports/unif")
    public String sportsUnif() { return "business/sports/unif"; }

    @GetMapping("/sports/unif-sport")
    public String sportsUnifSport() { return "business/sports/unif_sport"; }

    @GetMapping("/sports/unif-k-league")
    public String sportsUnifKLeague() { return "business/sports/unif_k-league"; }

    // [기타사업] 메인 및 하위 페이지
    @GetMapping("/sports/other")
    public String sportsOther() { return "business/sports/other"; }

    @GetMapping("/sports/other-one")
    public String sportsOtherOne() { return "business/sports/other_one"; }

    @GetMapping("/sports/other-hap")
    public String sportsOtherHap() { return "business/sports/other_hap"; }

    // ==========================================
    // 2. 문화예술(Culture) 영역
    // ==========================================

    // [국제 스페셜 뮤직&아트 페스티벌]
    @GetMapping("/culture")
    public String cultureMain() { return "business/culture/culture"; }

    // [SOK 앙상블]
    @GetMapping("/culture-ensemble")
    public String cultureEnsemble() { return "business/culture/culture_ensemble"; }

    // [SOK 연말음악회]
    @GetMapping("/culture-concert")
    public String cultureConcert() { return "business/culture/culture_concert"; }

    // [두드림 페스티벌]
    @GetMapping("/culture-dodream")
    public String cultureDodream() { return "business/culture/culture_dodream"; }

    // [국내외 공연 참가 지원]
    @GetMapping("/culture-support")
    public String cultureSupport() { return "business/culture/culture_support"; }

    // [국내외 문화예술 활동 지원]
    @GetMapping("/culture-support-act")
    public String cultureSupportAct() { return "business/culture/culture_support_act"; }

    // [스페셜올림픽 미술대회]
    @GetMapping("/culture-art")
    public String cultureArt() { return "business/culture/culture_art"; }

    // ==========================================
    // 3. 커뮤니티(Community) 영역
    // ==========================================

    // [유아체육프로그램]
    @GetMapping("/commu")
    public String commuMain() { return "business/commu/commu"; }

    // [선수아카데미]
    @GetMapping("/commu-academy")
    public String commuAcademy() { return "business/commu/commu_academy"; }

    // [가족/자원봉사 위원회]
    @GetMapping("/commu-volunteer")
    public String commuVolunteer() { return "business/commu/commu_volunteer"; }

    // ==========================================
    // 4. 인식개선(Awareness) 영역
    // ==========================================

    // [인식개선 캠페인]
    @GetMapping("/awareness")
    public String awarenessMain() { return "business/awareness/awareness"; }

    // [슈퍼블루 마라톤]
    @GetMapping("/awareness-marathon")
    public String awarenessMarathon() { return "business/awareness/awareness_marathon"; }

}