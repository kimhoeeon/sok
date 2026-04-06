package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
public class MemberDTO extends Criteria {
    private Long mbrSeq;
    private String mbrId;
    private String mbrPw;
    private String mbrNm;
    private String mbrRole;
    private String mbrType;      // INDIVIDUAL(개인), CORP(단체/기업)
    private String loginType;    // GENERAL, KAKAO
    private String bizNo;        // 사업자번호
    private String managerNm;    // 담당자명
    private String managerPos;   // 담당자 직함
    private String phone;
    private String email;
    private String isDonor;      // 후원 이력 여부 (Y/N)
    private Date joinDt;
    private String withdrawYn;
    private Date withdrawDt;
    private String snsType; // 연동 플랫폼 (예: "KAKAO")
    private String snsId;   // 카카오에서 부여받은 고유 회원 번호

    // --- 스토리보드 항목 반영 추가 ---
    private Integer totalDonateCnt; // 누적 후원 건수
    private Long totalDonateAmt;    // 누적 후원 금액

    // 상세 조회 시 매핑될 해당 회원의 기부 내역 리스트
    private List<DonationDTO> donationList;

    // 검색용 파라미터
    private String searchKeyword;
}