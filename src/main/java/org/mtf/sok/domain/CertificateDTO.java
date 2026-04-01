package org.mtf.sok.domain;

import lombok.Data;
import java.util.Date;

@Data
public class CertificateDTO {
    private Long certSeq;
    private String certType;    // 선수등록, 봉사활동, 경기실적, 대회참가
    private String issueStatus; // WAIT(대기), ING(발급중), DONE(발급완료), REJECT(거절)
    private String applyNm;
    private String phone;
    private String email;
    private String usePurpose;
    private String belongTo;
    private String remark;
    private String rejectRsn;
    private Date regDt;
    private Date issueDt;
    private String delYn;

    // 검색 파라미터
    private String searchType;
    private String searchStatus;
    private String searchKeyword;
}