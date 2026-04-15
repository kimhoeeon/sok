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

    MemberDTO selectMemberById(String mbrId);

    void insertKakaoMember(MemberDTO memberDTO);

    // [프론트엔드용 추가] 비밀번호 찾기를 위한 회원 검증 (이메일 또는 연락처)
    MemberDTO selectMemberForFindPw(MemberDTO memberDTO);

    // [프론트엔드용 추가] 임시 비밀번호로 DB 업데이트
    void updatePassword(MemberDTO memberDTO);

}