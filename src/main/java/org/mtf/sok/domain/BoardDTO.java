package org.mtf.sok.domain;

import lombok.Data;
import java.util.Date;

@Data
public class BoardDTO {
    private Long brdSeq;
    private String brdType;
    private String category;
    private String isNotice;
    private String title;
    private String content;
    private String youtubeUrl;
    private Integer viewCnt;
    private String regId;
    private Date regDt;
    private String modId;
    private Date modDt;
    private String delYn;
}