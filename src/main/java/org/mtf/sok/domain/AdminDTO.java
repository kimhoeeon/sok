package org.mtf.sok.domain;

import lombok.Data;

@Data
public class AdminIpDTO {
    private Long ipSeq;
    private Long mbrSeq;
    private String allowIp;
}