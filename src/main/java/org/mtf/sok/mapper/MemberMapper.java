package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.MemberDTO;
import java.util.List;

@Mapper
public interface MemberMapper {

    // ==========================================
    // 1. 사용자 (Front) - 인증 및 가입
    // ==========================================

    // 로그인 검증
    MemberDTO selectMemberForLogin(MemberDTO memberDTO);

    // 아이디로 회원 단건 조회 (Spring Security 및 소셜 로그인용)
    MemberDTO selectMemberById(String mbrId);

    // 아이디 중복 체크 (AJAX)
    int checkDuplicateId(String mbrId);

    // 신규 회원 등록 (개인/단체/소셜 공용)
    void insertMember(MemberDTO memberDTO);


    // ==========================================
    // 2. 사용자 (Front) - 마이페이지 및 비밀번호 찾기
    // ==========================================

    // PK(mbrSeq)로 회원 조회
    MemberDTO selectMemberBySeq(Long mbrSeq);

    // 회원 정보 수정
    void updateMemberProfile(MemberDTO memberDTO);

    // 회원 탈퇴 처리 (상태값 변경)
    void updateWithdrawal(Long mbrSeq);

    // 선택 약관 동의 여부 업데이트
    void updateOptionalAgreement(MemberDTO memberDTO);

    // 마케팅 수신 동의 여부 업데이트
    void updateMarketingAgreement(MemberDTO memberDTO);

    // 비밀번호 찾기용 회원 정보 검증
    MemberDTO selectMemberForFindPw(MemberDTO memberDTO);

    // 임시 비밀번호 발급 및 비밀번호 변경
    void updatePassword(MemberDTO memberDTO);


    // ==========================================
    // 3. 관리자 (Admin) - 회원 관리 (SponsorController 연동)
    // ==========================================

    // 관리자용 회원 목록 조회 (페이징, 검색, 일반/카카오 필터링)
    List<MemberDTO> selectMemberList(MemberDTO params);

    // 관리자용 회원 총 데이터 개수 (페이징 연동용)
    int selectMemberListCount(MemberDTO params);

    // 관리자용 회원 상세 정보 조회
    MemberDTO selectMemberDetail(Long mbrSeq);

}