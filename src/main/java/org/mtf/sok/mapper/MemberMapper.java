package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.MemberDTO;

@Mapper
public interface MemberMapper {

    // 일반 로그인 (아이디, 비밀번호 매칭 조회)
    MemberDTO selectMemberForLogin(MemberDTO memberDTO);

    int checkDuplicateId(String mbrId);

    void insertMember(MemberDTO memberDTO);

    void updateMemberProfile(MemberDTO memberDTO);

    MemberDTO selectMemberBySeq(Long mbrSeq); // 세션 갱신용

    void updateWithdrawal(Long mbrSeq);

    void updateOptionalAgreement(MemberDTO memberDTO);

    void updateMarketingAgreement(MemberDTO memberDTO);
}