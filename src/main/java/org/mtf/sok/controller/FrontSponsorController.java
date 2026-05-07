package org.mtf.sok.controller;

import com.fasterxml.jackson.databind.JsonNode;
import org.mtf.sok.domain.CampaignDTO;
import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.CampaignMapper;
import org.mtf.sok.mapper.DonationMapper;
import org.mtf.sok.mapper.StatsMapper;
import org.mtf.sok.service.TossPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/sponsor")
public class FrontSponsorController {

    @Autowired
    private StatsMapper statsMapper;

    @Autowired
    private DonationMapper donationMapper;

    @Autowired
    private TossPaymentService tossPaymentService;

    @Autowired
    private CampaignMapper campaignMapper;

    // 1. 후원하기 메인 화면
    @GetMapping("/donate")
    public String donateForm(Model model) {
        // 관리자 대시보드에서 사용하던 전체 누적 기부 통계를 가져와 프론트에 노출합니다.
        Map<String, Object> summary = statsMapper.selectSummaryStats();
        model.addAttribute("summary", summary);

        CampaignDTO campaign = campaignMapper.selectActiveCampaign();
        model.addAttribute("campaign", campaign);

        return "sponsor/donate";
    }

    // 1. 기부 결제 초기화 (결제창 띄우기 직전, DB에 'WAIT' 상태로 주문번호를 미리 저장)
    @PostMapping("/donate/init")
    @ResponseBody
    public ResponseEntity<?> donateInit(DonationDTO donation, HttpSession session) {
        try {
            // 로그인 유저 맵핑
            MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
            if (loginUser != null) {
                donation.setMbrSeq(loginUser.getMbrSeq());
                donation.setMbrNm(loginUser.getMbrNm());
            }

            // 고유 주문번호 생성 (토스페이먼츠 요구사항)
            String orderId = UUID.randomUUID().toString().replace("-", "") + System.currentTimeMillis();
            donation.setOrderId(orderId);

            // 대기 상태로 DB 인서트 (campSeq도 폼에서 넘어왔다면 함께 저장됨)
            donationMapper.insertDonation(donation);

            // 프론트엔드로 주문번호 응답
            return ResponseEntity.ok(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("결제 초기화에 실패했습니다.");
        }
    }

    // 2. 토스페이먼츠 결제 성공 리다이렉트 (검증 및 승인)
    @GetMapping("/donate/success")
    public String donateSuccess(@RequestParam String paymentKey,
                                @RequestParam String orderId,
                                @RequestParam Long amount,
                                Model model) {
        try {
            // DB에 저장된 주문 정보 조회 (위변조 방지를 위해 금액 대조)
            DonationDTO donation = donationMapper.selectDonationByOrderId(orderId);
            if (donation == null || donation.getPayAmt().longValue() != amount) {
                throw new Exception("결제 금액이 일치하지 않거나 유효하지 않은 주문입니다.");
            }

            // 토스페이먼츠 최종 승인 API 호출
            JsonNode result = tossPaymentService.confirmPayment(paymentKey, orderId, amount);

            // 승인 완료 시 DB 상태 'DONE'으로 업데이트
            donation.setPayStatus("DONE");
            donation.setPaymentKey(paymentKey); // 환불 시 필요하므로 키 저장
            donation.setPayMethod(result.get("method").asText()); // 카드, 계좌이체 등
            donationMapper.updateDonationStatus(donation);

            // [추가] 결제가 최종 승인되면, 해당 기부 캠페인의 현재 모금액(CURRENT_AMT)을 증가시킴
            if (donation.getCampSeq() != null) {
                campaignMapper.addCurrentAmount(donation.getCampSeq(), new BigDecimal(amount));
            }

            return "redirect:/mypage/donate?success=true"; // 결제 완료 후 마이페이지 기부내역으로 이동

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "결제 승인 중 오류가 발생했습니다: " + e.getMessage());
            return "sponsor/donate_fail"; // 실패 페이지로 이동
        }
    }

    // 3. 토스페이먼츠 결제 실패 리다이렉트
    @GetMapping("/donate/fail")
    public String donateFail(@RequestParam String code,
                             @RequestParam String message,
                             @RequestParam String orderId,
                             Model model) {

        // 결제 취소/실패 시 DB 상태 'CANCEL'로 업데이트
        DonationDTO donation = new DonationDTO();
        donation.setOrderId(orderId);
        donation.setPayStatus("CANCEL");
        donation.setCheerMsg(message); // 실패 사유 저장
        donationMapper.updateDonationStatus(donation);

        model.addAttribute("errorMessage", message);
        return "sponsor/donate_fail";
    }
}