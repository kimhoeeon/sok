package org.mtf.sok.domain;

import lombok.Data;
import java.util.Date;

@Data
public class FileDTO {
    private Long fileSeq;
    private String refTable;    // 참조 테이블명 (TB_BOARD 등)
    private Long refSeq;        // 참조 테이블의 일련번호 (brdSeq 등)
    private String orgFileNm;   // 원본 파일명
    private String saveFileNm;  // 저장된 파일명
    private String filePath;    // 파일 저장 경로
    private Long fileSize;      // 파일 크기
    private String fileExt;     // 파일 확장자
    private Date regDt;
    private String delYn;
}