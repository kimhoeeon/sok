package org.mtf.sok.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.time.LocalDateTime;

@Data
public class PromoterDTO {
    // 테이블 컬럼
    private Integer seq;
    private String promoterName;
    private Integer displayOrder;
    private String fileName;
    private String originalFileName;
    private LocalDateTime regDt;
    private LocalDateTime modDt;

    // 검색 및 페이징 파라미터
    private String keyword;
    private int pageNum = 1;
    private int amount = 10;
    private int offset;

    // LIMIT 연산을 위한 offset 계산
    public void calcOffset() {
        this.offset = (this.pageNum - 1) * this.amount;
    }

    // 파일 업로드 객체
    private MultipartFile uploadFile;
}