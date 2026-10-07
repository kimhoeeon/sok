package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.DonationDTO;

import java.util.List;

@Mapper
public interface DonationMapper {
    // 1. 개인 기부 내역 리스트 조회
    List<DonationDTO> selectDonationList(DonationDTO params);

    // 특정 회원의 정기기부 중 가장 높은 회차 번호 조회
    int selectMaxRegularRound(Long mbrSeq);

    // 2. 개인 누적 기부 총액 및 횟수 조회
    DonationDTO selectDonationSummary(Long mbrSeq);

    void insertDonation(DonationDTO donationDTO); // 결제 시작 전 대기 정보 저장

    DonationDTO selectDonationByOrderId(String orderId); // 검증용 주문번호 조회

    void updateDonationStatus(DonationDTO donationDTO); // 최종 승인/실패 처리

    // 매일 오전 결제일이 도래한(정확히 1달 전 결제) 정기기부 대상자 목록 조회
    List<DonationDTO> selectBillingTargets();

    // 스케줄러를 통해 자동 결제가 일어난 후 새로운 회차의 결제 내역(이력) 추가
    void insertRegularDonationHistory(DonationDTO donation);

}