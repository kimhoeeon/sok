package org.mtf.sok.controller;

import lombok.RequiredArgsConstructor;
import org.mtf.sok.domain.PromoterDTO;
import org.mtf.sok.service.PromoterService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/mng/promoter")
@RequiredArgsConstructor
public class PromoterController {

    private final PromoterService promoterService;

    // 목록 페이지 렌더링
    @GetMapping("/list")
    public String promoterList(@ModelAttribute("params") PromoterDTO params, Model model) {
        Map<String, Object> result = promoterService.getPromoterList(params);
        model.addAttribute("promoterList", result.get("list"));
        model.addAttribute("totalCount", result.get("totalCount"));
        return "mng/promoter/list";
    }

    // 수정 팝업용 단건 데이터 반환
    @ResponseBody
    @GetMapping("/detail")
    public PromoterDTO getPromoterDetail(@RequestParam("seq") Integer seq) {
        return promoterService.getPromoter(seq);
    }

    // 신규 등록 및 수정 처리 (Ajax)
    @ResponseBody
    @PostMapping("/save")
    public Map<String, Object> savePromoter(PromoterDTO params) {
        return promoterService.savePromoter(params);
    }

    // 삭제 처리 (Ajax)
    @ResponseBody
    @PostMapping("/delete")
    public Map<String, Object> deletePromoter(@RequestParam("seq") Integer seq) {
        return promoterService.deletePromoter(seq);
    }
}