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
}