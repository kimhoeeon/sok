package org.mtf.sok.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;
import java.util.List;

@Data
public class DevRequestDTO {
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

    // 조인/서브쿼리 필드
    private Integer commentCnt;

    // 첨부파일 처리
    private List<MultipartFile> uploadFiles;
    private List<FileDTO> fileList;

    // 검색 파라미터
    private String searchType;
    private String searchStatus;
    private String searchKeyword;
}