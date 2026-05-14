package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.mtf.sok.mapper.SponsorMapper;
import org.mtf.sok.service.TossPaymentService;
import org.mtf.sok.util.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/mng/sponsor")
public class SponsorController {

    @Autowired
    private SponsorMapper sponsorMapper;

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private TossPaymentService tossPaymentService;

    // ==========================================
    // 1. 가입자(회원) 관리 목록 및 상세
    // ==========================================
    @GetMapping("/member/list")
    public String memberList(@ModelAttribute MemberDTO params, Model model) {

        List<MemberDTO> list = memberMapper.selectMemberList(params);
        int total = memberMapper.selectMemberListCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "mng/sponsor/member_list";
    }

    @GetMapping("/member/detail")
    public String memberDetail(@RequestParam Long mbrSeq,
                               @ModelAttribute("params") MemberDTO params,
                               Model model) {
        MemberDTO member = memberMapper.selectMemberDetail(mbrSeq);
        List<DonationDTO> donations = sponsorMapper.selectDonationByMember(mbrSeq);
        member.setDonationList(donations);

        model.addAttribute("member", member);
        return "mng/sponsor/member_detail";
    }

    @PostMapping("/member/update")
    public String memberUpdate(MemberDTO member, RedirectAttributes rttr) {
        sponsorMapper.updateMember(member);

        rttr.addAttribute("mbrSeq", member.getMbrSeq());
        rttr.addAttribute("pageNum", member.getPageNum());
        rttr.addAttribute("amount", member.getAmount());
        rttr.addAttribute("mbrType", member.getMbrType());
        rttr.addAttribute("isDonor", member.getIsDonor());
        rttr.addAttribute("searchKeyword", member.getSearchKeyword());

        return "redirect:/mng/sponsor/member/detail";
    }

    // ==========================================
    // 2. 기부금(결제) 관리 목록 및 상세/상태변경
    // ==========================================
    @GetMapping("/donate/list")
    public String donateList(@ModelAttribute DonationDTO params, Model model) {

        List<DonationDTO> list = sponsorMapper.selectDonationList(params);
        int total = sponsorMapper.selectDonationTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "mng/sponsor/donate_list";
    }

    @GetMapping("/donate/detail")
    public String donateDetail(@RequestParam Long paySeq,
                               @ModelAttribute("params") DonationDTO params,
                               Model model) {
        model.addAttribute("donation", sponsorMapper.selectDonation(paySeq));
        return "mng/sponsor/donate_detail";
    }

    @PostMapping("/donate/updateStatus")
    public String updateDonateStatus(DonationDTO donation, HttpSession session, RedirectAttributes rttr) {

        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        // 환불(REFUND) 요청일 때 권한 검증 수행
        if ("REFUND".equals(donation.getPayStatus())) {
            donation.setRefundRsn(donation.getCancelRsn());

            if (admin == null || !"meetingfan".equals(admin.getAdmId())) {
                rttr.addFlashAttribute("errorMessage", "환불 처리는 마스터(meetingfan) 계정만 가능합니다.");
                return "redirect:/mng/sponsor/donate/detail?paySeq=" + donation.getPaySeq();
            }
        }

        // 2. [추가된 로직] 토스페이먼츠 실제 취소/환불 API 호출
        if (("CANCEL".equals(donation.getPayStatus()) || "REFUND".equals(donation.getPayStatus()))) {
            try {
                // 기존 결제 내역을 조회하여 PaymentKey를 가져옴
                DonationDTO originData = sponsorMapper.selectDonation(donation.getPaySeq());

                // 이미 결제가 완료된 건(DONE)에 대해서만 토스 취소 호출
                if ("DONE".equals(originData.getPayStatus()) && originData.getPaymentKey() != null) {
                    tossPaymentService.cancelPayment(originData.getPaymentKey(), donation.getCancelRsn());
                }
            } catch (Exception e) {
                e.printStackTrace();
                rttr.addFlashAttribute("errorMessage", "PG사(토스) 결제 취소 중 오류가 발생했습니다: " + e.getMessage());
                return "redirect:/mng/sponsor/donate/detail?paySeq=" + donation.getPaySeq();
            }
        }

        // 3. 토스 취소 성공 시 우리 DB 상태 업데이트
        sponsorMapper.updateDonationStatus(donation);

        rttr.addAttribute("paySeq", donation.getPaySeq());
        rttr.addAttribute("pageNum", donation.getPageNum());
        rttr.addAttribute("amount", donation.getAmount());
        rttr.addAttribute("payType", donation.getPayType());
        rttr.addAttribute("searchStatus", donation.getSearchStatus());

        return "redirect:/mng/sponsor/donate/detail";
    }

    // [1] 후원자(회원) 목록 엑셀 다운로드
    @GetMapping("/member/excel")
    public void downloadMemberExcel(@ModelAttribute MemberDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1); params.setAmount(1000000);
        List<MemberDTO> list = sponsorMapper.selectMemberList(params);

        // 헤더에 '가입상태', '탈퇴일시' 추가
        List<String> headers = Arrays.asList("회원번호", "가입상태", "회원구분", "후원이력", "회원명", "아이디", "연락처", "이메일", "누적기부횟수", "누적기부금액", "가입일", "탈퇴일시");
        List<List<Object>> data = new ArrayList<>();

        for (MemberDTO mbr : list) {
            List<Object> row = new ArrayList<>();
            row.add(mbr.getMbrSeq());
            // 상태값 추가
            row.add("Y".equals(mbr.getWithdrawYn()) ? "탈퇴" : "정상");
            row.add("CORP".equals(mbr.getMbrType()) ? "기업/단체" : "개인");
            row.add("Y".equals(mbr.getIsDonor()) ? "Y" : "N");
            row.add(mbr.getMbrNm());
            row.add(mbr.getMbrId());
            row.add(mbr.getPhone() != null ? mbr.getPhone() : "-");
            row.add(mbr.getEmail() != null ? mbr.getEmail() : "-");
            row.add(mbr.getTotalDonateCnt() != null ? mbr.getTotalDonateCnt() : 0);
            row.add(mbr.getTotalDonateAmt() != null ? mbr.getTotalDonateAmt() : 0);
            row.add(mbr.getJoinDt());
            // 탈퇴일시 추가
            row.add("Y".equals(mbr.getWithdrawYn()) ? mbr.getWithdrawDt() : "-");
            data.add(row);
        }
        ExcelUtils.download(response, "후원자_회원_목록", headers, data);
    }

    // [2] 기부금(결제) 내역 엑셀 다운로드
    @GetMapping("/donate/excel")
    public void downloadDonateExcel(@ModelAttribute DonationDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1); params.setAmount(1000000);
        List<DonationDTO> list = sponsorMapper.selectDonationList(params);

        List<String> headers = Arrays.asList("주문번호", "후원유형", "후원자명", "아이디", "결제수단", "결제금액", "결제상태", "응원메시지", "결제/변경일시");
        List<List<Object>> data = new ArrayList<>();

        for (DonationDTO d : list) {
            List<Object> row = new ArrayList<>();
            row.add(d.getOrderId());
            row.add("REGULAR".equals(d.getPayType()) ? "정기(" + d.getRegularRound() + "회)" : "일시");
            row.add(d.getMbrNm());
            row.add(d.getMbrId());
            row.add(d.getPayMethod());
            row.add(d.getPayAmt());

            String status = d.getPayStatus();
            if ("DONE".equals(status)) status = "결제완료";
            else if ("WAIT".equals(status)) status = "입금대기";
            else if ("CANCEL".equals(status)) status = "결제취소";
            else if ("REFUND".equals(status)) status = "환불완료";
            row.add(status);

            row.add(d.getCheerMsg() != null ? d.getCheerMsg() : "");
            row.add(d.getPayDt() != null ? d.getPayDt() : d.getRegDt());
            data.add(row);
        }
        ExcelUtils.download(response, "기부금_결제_내역", headers, data);
    }
}