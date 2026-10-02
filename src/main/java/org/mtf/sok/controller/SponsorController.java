package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.CampaignMapper;
import org.mtf.sok.mapper.MemberMapper;
import org.mtf.sok.mapper.SponsorMapper;
import org.mtf.sok.security.PrincipalDetails;
import org.mtf.sok.service.TossPaymentService;
import org.mtf.sok.util.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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

    @Autowired
    private CampaignMapper campaignMapper;

    // ==========================================
    // 1. 가입자(회원) 관리 목록 및 상세
    // ==========================================
    @GetMapping("/member/list")
    public String memberList(@ModelAttribute MemberDTO params, Model model) {

        List<MemberDTO> list = sponsorMapper.selectMemberList(params);
        int total = sponsorMapper.selectMemberTotalCount(params);
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
    public String updateDonateStatus(DonationDTO donation, @AuthenticationPrincipal PrincipalDetails principalDetails, RedirectAttributes rttr) {

        AdminDTO admin = (principalDetails != null) ? principalDetails.getAdminDTO() : null;

        // 환불(REFUND) 요청일 때 권한 검증 수행
        if ("REFUND".equals(donation.getPayStatus())) {
            donation.setRefundRsn(donation.getCancelRsn());

            if (admin == null || !"meetingfan".equals(admin.getAdmId())) {
                rttr.addFlashAttribute("errorMessage", "환불 처리는 마스터(meetingfan) 계정만 가능합니다.");
                return "redirect:/mng/sponsor/donate/detail?paySeq=" + donation.getPaySeq();
            }
        }

        try {
            DonationDTO originData = sponsorMapper.selectDonation(donation.getPaySeq());

            // 1. 관리자가 취소나 환불 처리를 요청한 경우 PG사 연동
            if (("CANCEL".equals(donation.getPayStatus()) || "REFUND".equals(donation.getPayStatus()))) {

                // [1-A] 이미 결제가 완료된 건(DONE)에 대해 결제 금액 자체를 취소(환불) 처리
                if ("DONE".equals(originData.getPayStatus()) && originData.getPaymentKey() != null) {
                    tossPaymentService.cancelPayment(originData.getPaymentKey(), donation.getCancelRsn());

                    // 환불이 승인되면 캠페인 누적 모금액 차감
                    if (originData.getCampSeq() != null) {
                        campaignMapper.addCurrentAmount(originData.getCampSeq(), originData.getPayAmt().negate());
                    }
                }

                // [1-B] 신규 로직: 정기결제(REGULAR)인 경우, 빌링키를 토스 서버에서 만료시켜 다음 달 결제를 원천 차단
                if ("REGULAR".equals(originData.getPayType()) && originData.getBillingKey() != null) {
                    tossPaymentService.expireBillingKey(originData.getBillingKey());
                }
            }

            // 2. 취소/환불 완료 및 빌링키 해지 성공 시 우리 DB 업데이트
            sponsorMapper.updateDonationStatus(donation);
            rttr.addFlashAttribute("successMessage", "상태가 정상적으로 변경 및 해지되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("errorMessage", "PG사(토스) 결제 취소 또는 해지 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/mng/sponsor/donate/detail?paySeq=" + donation.getPaySeq();
        }

        rttr.addAttribute("paySeq", donation.getPaySeq());
        rttr.addAttribute("pageNum", donation.getPageNum());
        rttr.addAttribute("amount", donation.getAmount());
        rttr.addAttribute("payType", donation.getPayType());
        rttr.addAttribute("searchStatus", donation.getSearchStatus());

        return "redirect:/mng/sponsor/donate/detail";
    }

    // ==========================================
    // [1] 후원자(회원) 목록 엑셀 다운로드
    // ==========================================
    @GetMapping("/member/excel")
    public void downloadMemberExcel(@ModelAttribute MemberDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1);
        params.setAmount(1000000);
        List<MemberDTO> list = sponsorMapper.selectMemberList(params);

        // DDL 기준: 관리 및 연락에 필요한 필수 인적 정보와 동의 내역, 기부 요약만 포함
        List<String> headers = Arrays.asList(
                "회원번호", "가입상태", "회원구분", "후원여부",
                "회원명(또는 기관명)", "로그인ID", "연락처", "이메일",
                "담당자명(기관)", "직함(기관)", "성별", "출생년도", "거주지역",
                "마케팅동의", "제3자동의",
                "총 기부횟수", "총 기부금액", "가입일", "탈퇴일"
        );
        List<List<Object>> data = new ArrayList<>();

        for (MemberDTO mbr : list) {
            List<Object> row = new ArrayList<>();

            // 1. 기본 식별 및 상태 정보
            row.add(mbr.getMbrSeq());
            row.add("Y".equals(mbr.getWithdrawYn()) ? "탈퇴" : "정상");
            row.add("CORP".equals(mbr.getMbrType()) ? "기관/단체" : "개인");
            row.add("Y".equals(mbr.getIsDonor()) ? "후원자" : "일반회원");

            // 2. 인적 및 연락처 정보
            row.add(mbr.getMbrNm());
            row.add(mbr.getMbrId());
            row.add(mbr.getPhone() != null ? mbr.getPhone() : "-");
            row.add(mbr.getEmail() != null ? mbr.getEmail() : "-");

            // 3. 기관 담당자 정보
            row.add(mbr.getManagerNm() != null ? mbr.getManagerNm() : "-");
            row.add(mbr.getManagerPos() != null ? mbr.getManagerPos() : "-");

            // 4. 부가 정보 (성별, 출생년도, 지역)
            String gender = "-";
            if ("M".equalsIgnoreCase(mbr.getGender()) || "male".equalsIgnoreCase(mbr.getGender())) gender = "남성";
            else if ("F".equalsIgnoreCase(mbr.getGender()) || "female".equalsIgnoreCase(mbr.getGender())) gender = "여성";
            row.add(gender);

            row.add(mbr.getBirthYear() != null ? mbr.getBirthYear() + "년" : "-");

            String region = "-";
            if (mbr.getRegion1() != null) {
                region = mbr.getRegion1() + (mbr.getRegion2() != null ? " " + mbr.getRegion2() : "");
            }
            row.add(region);

            // 5. 선택 약관 동의 내역
            row.add("Y".equals(mbr.getMarketingYn()) ? "동의" : "미동의");
            row.add("Y".equals(mbr.getAgreeOptionalYn()) ? "동의" : "미동의");

            // 6. 기부 통계
            row.add(mbr.getTotalDonateCnt() != null ? mbr.getTotalDonateCnt() : 0);
            row.add(mbr.getTotalDonateAmt() != null ? mbr.getTotalDonateAmt() : 0);

            // 7. 일시
            row.add(mbr.getJoinDt());
            row.add("Y".equals(mbr.getWithdrawYn()) ? mbr.getWithdrawDt() : "-");

            data.add(row);
        }
        ExcelUtils.download(response, "SOK_회원_및_후원자_목록", headers, data);
    }

    // ==========================================
    // [2] 기부금(결제) 내역 엑셀 다운로드
    // ==========================================
    @GetMapping("/donate/excel")
    public void downloadDonateExcel(@ModelAttribute DonationDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1);
        params.setAmount(1000000);
        List<DonationDTO> list = sponsorMapper.selectDonationList(params);

        // 결제 및 정산 관리에 필요한 항목으로 구성
        List<String> headers = Arrays.asList(
                "결제번호", "주문번호", "후원유형", "기부회차", "후원자명", "아이디", "연락처",
                "결제수단", "결제금액", "결제상태", "응원메시지", "결제완료일", "취소/환불일", "취소/환불사유"
        );
        List<List<Object>> data = new ArrayList<>();

        for (DonationDTO d : list) {
            List<Object> row = new ArrayList<>();
            row.add(d.getPaySeq());
            row.add(d.getOrderId());

            // 후원 유형 및 회차 분리 표시
            row.add("REGULAR".equals(d.getPayType()) ? "정기후원" : "일시후원");
            row.add("REGULAR".equals(d.getPayType()) && d.getRegularRound() != null ? d.getRegularRound() + "회차" : "-");

            row.add(d.getMbrNm());
            row.add(d.getMbrId());
            row.add(d.getPhone() != null ? d.getPhone() : "-");

            row.add(d.getPayMethod() != null ? d.getPayMethod() : "-");
            row.add(d.getPayAmt());

            // 상태 매핑
            String status = d.getPayStatus();
            if ("DONE".equals(status)) status = "결제완료";
            else if ("WAIT".equals(status)) status = "입금대기";
            else if ("CANCEL".equals(status)) status = "결제취소";
            else if ("FAIL".equals(status)) status = "결제실패";
            else if ("REFUND".equals(status)) status = "환불완료";
            row.add(status);

            row.add(d.getCheerMsg() != null ? d.getCheerMsg() : "");

            // 일시
            row.add(d.getPayDt() != null ? d.getPayDt() : "-");

            // 취소/환불 일시 및 사유
            if ("CANCEL".equals(d.getPayStatus()) || "FAIL".equals(d.getPayStatus())) {
                row.add(d.getCancelDt() != null ? d.getCancelDt() : "-");
                row.add(d.getCancelRsn() != null ? d.getCancelRsn() : "-");
            } else if ("REFUND".equals(d.getPayStatus())) {
                row.add(d.getRefundDt() != null ? d.getRefundDt() : "-");
                row.add(d.getRefundRsn() != null ? d.getRefundRsn() : "-");
            } else {
                row.add("-");
                row.add("-");
            }

            data.add(row);
        }
        ExcelUtils.download(response, "SOK_기부결제_내역", headers, data);
    }

}