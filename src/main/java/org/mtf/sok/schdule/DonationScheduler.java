package org.mtf.sok.scheduler;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.extern.slf4j.Slf4j;
import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.mapper.CampaignMapper;
import org.mtf.sok.mapper.DonationMapper;
import org.mtf.sok.service.TossPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Slf4j
@Component
public class DonationScheduler {

    @Autowired
    private DonationMapper donationMapper;

    @Autowired
    private TossPaymentService tossPaymentService;

    @Autowired
    private CampaignMapper campaignMapper;

    // 매일 오전 10시 정각에 실행 (초 분 시 일 월 요일)
    @Scheduled(cron = "0 0 10 * * *")
    public void processRegularDonations() {
        log.info("▶ [정기기부 스케줄러] 매월 정기결제 배치 작업을 시작합니다.");

        // 1. 오늘 결제해야 할 정기기부 대상자 목록 조회 (한 달 전 결제자)
        List<DonationDTO> targetList = donationMapper.selectBillingTargets();

        if (targetList == null || targetList.isEmpty()) {
            log.info("▶ [정기기부 스케줄러] 오늘 결제 대상자가 없습니다.");
            return;
        }

        for (DonationDTO target : targetList) {
            // 이번 회차를 위한 새로운 고유 주문번호 생성
            String newOrderId = UUID.randomUUID().toString().replace("-", "") + System.currentTimeMillis();

            try {
                log.info("결제 시도: 회원번호 [{}], 금액 [{}], 빌링키 [{}]", target.getMbrSeq(), target.getPayAmt(), target.getBillingKey());

                // 2. 토스페이먼츠 빌링키 결제 승인 API 호출
                // 주의: customerKey는 최초 등록 시 사용한 값(주로 mbrId)과 동일해야 함
                JsonNode paymentResult = tossPaymentService.confirmBilling(
                        target.getBillingKey(),
                        target.getMbrId(),
                        newOrderId,
                        target.getPayAmt().longValue()
                );

                // 3. 결제 성공 시 DB에 새로운 회차 데이터(INSERT) 기록
                target.setOrderId(newOrderId);
                target.setPayStatus("DONE");
                target.setPaymentKey(paymentResult.get("paymentKey").asText());
                target.setPayMethod(paymentResult.get("method").asText());
                target.setRegularRound(target.getRegularRound() + 1); // 다음 회차 증가

                donationMapper.insertRegularDonationHistory(target);

                // 4. 캠페인 누적 모금액 업데이트
                if (target.getCampSeq() != null) {
                    campaignMapper.addCurrentAmount(target.getCampSeq(), target.getPayAmt());
                }

            } catch (Exception e) {
                log.error("❌ 정기결제 실패 - 대상자 MbrSeq: {}, 원인: {}", target.getMbrSeq(), e.getMessage());

                // 실패 이력 저장 (고객 잔액 부족 등)
                target.setOrderId(newOrderId);
                target.setPayStatus("FAIL");
                target.setCancelRsn("정기결제 승인 실패: " + e.getMessage());
                target.setRegularRound(target.getRegularRound() + 1);

                donationMapper.insertRegularDonationHistory(target);
            }
        }
        log.info("▶ [정기기부 스케줄러] 배치 작업이 종료되었습니다.");
    }
}