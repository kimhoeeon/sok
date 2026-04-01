package org.mtf.sok.controller;

import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.SponsorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/sponsor")
public class SponsorController {

    @Autowired
    private SponsorMapper sponsorMapper;

    // ==========================================
    // 1. 가입자(회원) 관리 목록 및 상세
    // ==========================================
    @GetMapping("/member/list")
    public String memberList(@RequestParam(required = false) String mbrType,
                             @RequestParam(required = false) String isDonor,
                             @RequestParam(required = false) String searchKeyword, Model model) {
        MemberDTO params = new MemberDTO();
        params.setMbrType(mbrType);
        params.setIsDonor(isDonor);
        params.setSearchKeyword(searchKeyword);

        model.addAttribute("list", sponsorMapper.selectMemberList(params));
        model.addAttribute("mbrType", mbrType);
        model.addAttribute("isDonor", isDonor);
        model.addAttribute("searchKeyword", searchKeyword);
        return "admin/sponsor/member_list";
    }

    @GetMapping("/member/detail")
    public String memberDetail(@RequestParam Long mbrSeq, Model model) {
        MemberDTO member = sponsorMapper.selectMember(mbrSeq);
        // 회원의 기부 내역을 조회하여 DTO에 담음
        List<DonationDTO> donations = sponsorMapper.selectDonationByMember(mbrSeq);
        member.setDonationList(donations);

        model.addAttribute("member", member);
        return "admin/sponsor/member_detail";
    }

    @PostMapping("/member/update")
    public String memberUpdate(MemberDTO member) {
        sponsorMapper.updateMember(member);
        return "redirect:/admin/sponsor/member/detail?mbrSeq=" + member.getMbrSeq();
    }

    // ==========================================
    // 2. 기부금(결제) 관리 목록 및 상세/상태변경
    // ==========================================
    @GetMapping("/donate/list")
    public String donateList(@RequestParam(required = false) String payType,
                             @RequestParam(required = false) String searchStatus, Model model) {
        DonationDTO params = new DonationDTO();
        params.setPayType(payType);
        params.setSearchStatus(searchStatus);

        model.addAttribute("list", sponsorMapper.selectDonationList(params));
        model.addAttribute("payType", payType);
        model.addAttribute("searchStatus", searchStatus);
        return "admin/sponsor/donate_list";
    }

    @GetMapping("/donate/detail")
    public String donateDetail(@RequestParam Long paySeq, Model model) {
        model.addAttribute("donation", sponsorMapper.selectDonation(paySeq));
        return "admin/sponsor/donate_detail";
    }

    @PostMapping("/donate/updateStatus")
    public String updateDonateStatus(DonationDTO donation) {
        // 실제 운영 환경에서는 여기서 토스페이먼츠 환불/취소 API 통신 로직이 들어가야 합니다.
        // 현재는 DB 상태값만 변경합니다.
        sponsorMapper.updateDonationStatus(donation);
        return "redirect:/admin/sponsor/donate/detail?paySeq=" + donation.getPaySeq();
    }
}