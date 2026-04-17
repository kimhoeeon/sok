package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.DonationDTO;

import java.util.List;

@Mapper
public interface DonationMapper {
    // 1. 개인 기부 내역 리스트 조회
    List<DonationDTO> selectDonationList(Long mbrSeq);

    // 2. 개인 누적 기부 총액 및 횟수 조회
    DonationDTO selectDonationSummary(Long mbrSeq);

    void insertDonation(DonationDTO donationDTO); // 결제 시작 전 대기 정보 저장

    DonationDTO selectDonationByOrderId(String orderId); // 검증용 주문번호 조회

    void updateDonationStatus(DonationDTO donationDTO); // 최종 승인/실패 처리

}