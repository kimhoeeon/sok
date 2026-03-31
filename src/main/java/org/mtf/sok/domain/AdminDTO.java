package org.mtf.sok.domain;

import lombok.Data;
import java.util.List;

@Data
public class AdminDTO {
    private Long mbrSeq;
    private String mbrId;
    private String mbrPw;
    private String mbrNm;
    private String mbrRole;

    // 허용된 IP 목록을 문자열 리스트로 단순화
    private List<String> allowedIpList;
}