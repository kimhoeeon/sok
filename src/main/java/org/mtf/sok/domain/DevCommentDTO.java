package org.mtf.sok.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;
import java.util.List;

@Data
public class DevCommentDTO {
    private Long cmtSeq;
    private Long reqSeq;
    private String content;
    private String regId;
    private Date regDt;
    private String delYn;

    // 첨부파일 처리
    private List<MultipartFile> uploadFiles;
    private List<FileDTO> fileList;
}