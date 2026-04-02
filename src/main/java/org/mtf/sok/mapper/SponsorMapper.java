package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;

import java.util.List;

@Mapper
public interface SponsorMapper {
    // 1. 회원(후원자) 관련
    List<MemberDTO> selectMemberList(MemberDTO params);

    int selectMemberTotalCount(MemberDTO params);

    MemberDTO selectMember(Long mbrSeq);

    void updateMember(MemberDTO member);

    // 2. 기부금(결제) 관련
    List<DonationDTO> selectDonationList(DonationDTO params);

    int selectDonationTotalCount(DonationDTO params);

    DonationDTO selectDonation(Long paySeq);

    List<DonationDTO> selectDonationByMember(Long mbrSeq);

    void updateDonationStatus(DonationDTO donation);
}