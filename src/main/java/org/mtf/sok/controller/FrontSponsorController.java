package org.mtf.sok.controller;

import org.mtf.sok.mapper.StatsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/sponsor")
public class FrontSponsorController {

    @Autowired
    private StatsMapper statsMapper;

    // 1. 후원하기 메인 화면
    @GetMapping("/donate")
    public String donateForm(Model model) {
        // 관리자 대시보드에서 사용하던 전체 누적 기부 통계를 가져와 프론트에 노출합니다.
        Map<String, Object> summary = statsMapper.selectSummaryStats();
        model.addAttribute("summary", summary);

        return "sponsor/donate";
    }
}