package org.mtf.sok.domain;

import lombok.Data;
import java.util.Date;

@Data
public class AdminIpDTO {
    private Long ipSeq;       // IP 일련번호
    private Long admSeq;      // 관리자 일련번호
    private String allowIp;   // 허용된 IP 주소
    private String description; //비고(설명)
    private Date regDt;       // 등록일시

    // 조인을 위한 관리자 정보 (목록 출력용)
    private String admId;
    private String admNm;
}