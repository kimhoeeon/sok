package org.mtf.sok.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

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

    // 폼에서 전송받을 실제 파일 데이터 (DB에는 안 들어감)
    private List<MultipartFile> uploadFiles;

    // DB에서 조회된 첨부파일 목록 정보
    private List<FileDTO> fileList;
}