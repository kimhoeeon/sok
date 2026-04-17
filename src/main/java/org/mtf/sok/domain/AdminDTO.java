package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false) // 부모 클래스(Criteria)의 필드는 equals/hashCode 검사에서 제외
public class AdminDTO extends Criteria {

    private Long admSeq;       // MBR_SEQ -> ADM_SEQ
    private String admId;      // MBR_ID -> ADM_ID
    private String admPw;      // MBR_PW -> ADM_PW
    private String admNm;      // MBR_NM -> ADM_NM
    private String admRole;    // MBR_ROLE -> ADM_ROLE

    private Date regDt;        // 등록일시
    private Date lastLoginDt;  // 최종 로그인 일시

    // 허용된 IP 목록
    private List<String> allowedIpList;
}