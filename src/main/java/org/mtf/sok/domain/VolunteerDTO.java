package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
public class VolunteerDTO extends Criteria {
    private Long volSeq;
    private String supportArea; // 지원분야 (스포츠, 문화예술, 기타)
    private String eventNm;     // 행사명
    private String applyNm;     // 신청자명/단체명
    private String phone;       // 휴대전화
    private Integer applyCnt;   // 참여 인원 수
    private String freqType;    // 봉사희망횟수 (ONCE, OFTEN)
    private String agreeYn;     // 개인정보동의여부

    private Date agreeDt;       // 동의 일시

    // [신규 추가] 상태 관리 및 알림 발송을 위한 핵심 필드
    private String email;       // 이메일 (결과 알림 발송용)
    private String status;      // 처리상태 (WAIT: 대기, APPR: 승인, DONE: 완료, REJECT: 반려)
    private String searchStatus;
    private String rejectRsn;   // 반려(거절) 사유

    private Date regDt;         // 신청일시
    private String delYn;       // 삭제여부

    // 검색용 파라미터 (유지)
    private String searchSupportArea;
    private String searchKeyword;
}