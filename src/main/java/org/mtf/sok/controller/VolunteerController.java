package org.mtf.sok.controller;

import org.mtf.sok.domain.PageDTO; // ★ [페이징 추가]
import org.mtf.sok.domain.VolunteerDTO;
import org.mtf.sok.mapper.VolunteerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // ★ [페이징 추가]

import java.util.List;

@Controller
@RequestMapping("/admin/volunteer")
public class VolunteerController {

    @Autowired
    private VolunteerMapper volunteerMapper;

    // ★ [페이징 추가/수정] DTO 바인딩 적용
    @GetMapping("/list")
    public String list(@ModelAttribute VolunteerDTO params, Model model) {

        List<VolunteerDTO> list = volunteerMapper.selectVolunteerList(params);
        int total = volunteerMapper.selectVolunteerTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "admin/volunteer/list";
    }

    // ★ [페이징 추가/수정] @ModelAttribute 추가 (상태 유지용)
    @GetMapping("/detail")
    public String detail(@RequestParam Long volSeq,
                         @ModelAttribute("params") VolunteerDTO params,
                         Model model) {
        model.addAttribute("volunteer", volunteerMapper.selectVolunteer(volSeq));
        return "admin/volunteer/detail";
    }

    // ★ [페이징 추가/수정] Redirect 파라미터 릴레이 추가
    @PostMapping("/update")
    public String update(VolunteerDTO volunteer, RedirectAttributes rttr) {
        volunteerMapper.updateVolunteer(volunteer);

        rttr.addAttribute("volSeq", volunteer.getVolSeq());
        rttr.addAttribute("pageNum", volunteer.getPageNum());
        rttr.addAttribute("amount", volunteer.getAmount());
        rttr.addAttribute("searchSupportArea", volunteer.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", volunteer.getSearchKeyword());

        return "redirect:/admin/volunteer/detail";
    }

    // ★ [페이징 추가/수정] 삭제 후 목록 복귀 파라미터 릴레이
    @PostMapping("/delete")
    public String delete(@RequestParam Long volSeq, @ModelAttribute VolunteerDTO params, RedirectAttributes rttr) {
        volunteerMapper.deleteVolunteer(volSeq);

        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchSupportArea", params.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/admin/volunteer/list";
    }
}