package org.mtf.sok.controller;

import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.domain.PageDTO; // ★ [페이징 추가/수정]
import org.mtf.sok.mapper.SponsorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // ★ [페이징 추가/수정]

import java.util.List;

@Controller
@RequestMapping("/admin/sponsor")
public class SponsorController {

    @Autowired
    private SponsorMapper sponsorMapper;

    // ==========================================
    // 1. 가입자(회원) 관리 목록 및 상세
    // ==========================================
    // ★ [페이징 추가/수정] DTO 파라미터 매핑 적용
    @GetMapping("/member/list")
    public String memberList(@ModelAttribute MemberDTO params, Model model) {

        List<MemberDTO> list = sponsorMapper.selectMemberList(params);
        int total = sponsorMapper.selectMemberTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params); // 필터 유지

        return "admin/sponsor/member_list";
    }

    // ★ [페이징 추가/수정] @ModelAttribute 추가
    @GetMapping("/member/detail")
    public String memberDetail(@RequestParam Long mbrSeq,
                               @ModelAttribute("params") MemberDTO params,
                               Model model) {
        MemberDTO member = sponsorMapper.selectMember(mbrSeq);
        List<DonationDTO> donations = sponsorMapper.selectDonationByMember(mbrSeq);
        member.setDonationList(donations);

        model.addAttribute("member", member);
        return "admin/sponsor/member_detail";
    }

    // ★ [페이징 추가/수정] Redirect 파라미터 릴레이
    @PostMapping("/member/update")
    public String memberUpdate(MemberDTO member, RedirectAttributes rttr) {
        sponsorMapper.updateMember(member);

        rttr.addAttribute("mbrSeq", member.getMbrSeq());
        rttr.addAttribute("pageNum", member.getPageNum());
        rttr.addAttribute("amount", member.getAmount());
        rttr.addAttribute("mbrType", member.getMbrType());
        rttr.addAttribute("isDonor", member.getIsDonor());
        rttr.addAttribute("searchKeyword", member.getSearchKeyword());

        return "redirect:/admin/sponsor/member/detail";
    }

    // ==========================================
    // 2. 기부금(결제) 관리 목록 및 상세/상태변경
    // ==========================================
    // ★ [페이징 추가/수정] DTO 파라미터 매핑 적용
    @GetMapping("/donate/list")
    public String donateList(@ModelAttribute DonationDTO params, Model model) {

        List<DonationDTO> list = sponsorMapper.selectDonationList(params);
        int total = sponsorMapper.selectDonationTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "admin/sponsor/donate_list";
    }

    // ★ [페이징 추가/수정] @ModelAttribute 추가
    @GetMapping("/donate/detail")
    public String donateDetail(@RequestParam Long paySeq,
                               @ModelAttribute("params") DonationDTO params,
                               Model model) {
        model.addAttribute("donation", sponsorMapper.selectDonation(paySeq));
        return "admin/sponsor/donate_detail";
    }

    // ★ [페이징 추가/수정] Redirect 파라미터 릴레이
    @PostMapping("/donate/updateStatus")
    public String updateDonateStatus(DonationDTO donation, RedirectAttributes rttr) {
        sponsorMapper.updateDonationStatus(donation);

        rttr.addAttribute("paySeq", donation.getPaySeq());
        rttr.addAttribute("pageNum", donation.getPageNum());
        rttr.addAttribute("amount", donation.getAmount());
        rttr.addAttribute("payType", donation.getPayType());
        rttr.addAttribute("searchStatus", donation.getSearchStatus());

        return "redirect:/admin/sponsor/donate/detail";
    }
}