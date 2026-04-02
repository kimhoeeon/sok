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
    private Date regDt;         // 신청일시
    private String delYn;       // 삭제여부

    // 검색용 파라미터 (유지)
    private String searchSupportArea;
    private String searchKeyword;
}