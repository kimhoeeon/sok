package org.mtf.sok.controller;

import org.mtf.sok.domain.VolunteerDTO;
import org.mtf.sok.mapper.VolunteerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/volunteer")
public class VolunteerController {

    @Autowired
    private VolunteerMapper volunteerMapper;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String searchSupportArea,
                       @RequestParam(required = false) String searchKeyword, Model model) {
        VolunteerDTO params = new VolunteerDTO();
        params.setSearchSupportArea(searchSupportArea);
        params.setSearchKeyword(searchKeyword);

        List<VolunteerDTO> list = volunteerMapper.selectVolunteerList(params);
        model.addAttribute("list", list);
        model.addAttribute("searchSupportArea", searchSupportArea);
        model.addAttribute("searchKeyword", searchKeyword);

        return "admin/volunteer/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long volSeq, Model model) {
        model.addAttribute("volunteer", volunteerMapper.selectVolunteer(volSeq));
        return "admin/volunteer/detail";
    }

    @PostMapping("/update")
    public String update(VolunteerDTO volunteer) {
        volunteerMapper.updateVolunteer(volunteer);
        return "redirect:/admin/volunteer/detail?volSeq=" + volunteer.getVolSeq();
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long volSeq) {
        volunteerMapper.deleteVolunteer(volSeq);
        return "redirect:/admin/volunteer/list";
    }
}