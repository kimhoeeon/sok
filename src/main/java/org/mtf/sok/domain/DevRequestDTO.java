package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
public class DevRequestDTO extends Criteria {
    private Long reqSeq;
    private String reqType;
    private String title;
    private String content;
    private String urgency;
    private String status;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dueDt;

    private String regId;
    private Date regDt;
    private String modId;
    private Date modDt;
    private String delYn;

    private Integer commentCnt;
    private List<MultipartFile> uploadFiles;
    private List<FileDTO> fileList;

    private String searchType;
    private String searchStatus;
    private String searchKeyword;

    private List<Long> reqSeqs;
}