package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;

import java.util.List;

@Mapper
public interface SponsorMapper {
    // 가입자(회원) 관리
    List<MemberDTO> selectMemberList(MemberDTO params);

    MemberDTO selectMember(Long mbrSeq);

    void updateMember(MemberDTO member);

    // 기부금(후원) 관리
    List<DonationDTO> selectDonationList(DonationDTO params);

    DonationDTO selectDonation(Long paySeq);

    List<DonationDTO> selectDonationByMember(Long mbrSeq); // 특정 회원의 결제 내역

    void updateDonationStatus(DonationDTO donation);       // 취소/환불 상태 변경
}