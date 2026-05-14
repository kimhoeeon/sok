package org.mtf.sok.controller;

import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.domain.VolunteerDTO;
import org.mtf.sok.mapper.VolunteerMapper;
import org.mtf.sok.util.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/mng/volunteer")
public class VolunteerController {

    @Autowired
    private VolunteerMapper volunteerMapper;

    @GetMapping("/list")
    public String list(@ModelAttribute VolunteerDTO params, Model model) {

        List<VolunteerDTO> list = volunteerMapper.selectVolunteerList(params);
        int total = volunteerMapper.selectVolunteerTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "mng/volunteer/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long volSeq,
                         @ModelAttribute("params") VolunteerDTO params,
                         Model model) {
        model.addAttribute("volunteer", volunteerMapper.selectVolunteer(volSeq));
        return "mng/volunteer/detail";
    }

    @PostMapping("/update")
    public String update(VolunteerDTO volunteer, RedirectAttributes rttr) {
        volunteerMapper.updateVolunteer(volunteer);

        rttr.addAttribute("volSeq", volunteer.getVolSeq());
        rttr.addAttribute("pageNum", volunteer.getPageNum());
        rttr.addAttribute("amount", volunteer.getAmount());
        rttr.addAttribute("searchSupportArea", volunteer.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", volunteer.getSearchKeyword());

        return "redirect:/mng/volunteer/detail";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long volSeq, @ModelAttribute VolunteerDTO params, RedirectAttributes rttr) {
        volunteerMapper.deleteVolunteer(volSeq);

        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchSupportArea", params.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/mng/volunteer/list";
    }

    @GetMapping("/excel")
    public void downloadExcel(@ModelAttribute VolunteerDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1);
        params.setAmount(1000000); // 대용량 추출

        List<VolunteerDTO> list = volunteerMapper.selectVolunteerList(params);
        List<String> headers = Arrays.asList("연번", "지원분야", "신청 행사명", "신청자(단체)명", "연락처", "참여인원", "참여빈도", "개인정보동의", "신청일시");
        List<List<Object>> data = new ArrayList<>();

        for (VolunteerDTO vol : list) {
            List<Object> row = new ArrayList<>();
            row.add(vol.getVolSeq());
            row.add(vol.getSupportArea());
            row.add(vol.getEventNm());
            row.add(vol.getApplyNm());
            row.add(vol.getPhone());
            row.add(vol.getApplyCnt() + "명");
            row.add("ONCE".equals(vol.getFreqType()) ? "1회성" : "정기/수시");
            row.add(vol.getAgreeYn());
            row.add(vol.getRegDt()); // Date 객체 그대로 전달
            data.add(row);
        }
        ExcelUtils.download(response, "자원봉사_신청_내역", headers, data);
    }
}