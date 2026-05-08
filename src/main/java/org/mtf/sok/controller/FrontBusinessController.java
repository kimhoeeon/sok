package org.mtf.sok.controller;

import org.mtf.sok.domain.BoardDTO;
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

    // [사업소식] 상세 - sports_view.html
    @GetMapping("/sports/view")
    public String sportsView(@RequestParam("brdSeq") Long brdSeq, @ModelAttribute("params") BoardDTO params, Model model) {
        boardMapper.updateViewCnt(brdSeq);
        BoardDTO board = boardMapper.selectBoard(brdSeq);
        model.addAttribute("board", board);
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

    @GetMapping("/sports/unif-k-league")
    public String sportsUnifKLeague() { return "business/sports/unif_k-league"; }

    @GetMapping("/sports/unif-sport")
    public String sportsUnifSport() { return "business/sports/unif_sport"; }

    // [기타사업] 메인 및 하위 페이지
    @GetMapping("/sports/other")
    public String sportsOther() { return "business/sports/other"; }

    @GetMapping("/sports/other-hap")
    public String sportsOtherHap() { return "business/sports/other_hap"; }

    @GetMapping("/sports/other-one")
    public String sportsOtherOne() { return "business/sports/other_one"; }


    // ==========================================
    // 2. 문화예술(Arts) 영역 (추후 파일 전달 시 확장)
    // ==========================================
    @GetMapping("/arts")
    public String artsList() {
        // 문화예술 관련 로직 구현 예정
        return "business/arts/list";
    }
}