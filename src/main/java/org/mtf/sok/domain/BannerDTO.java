package org.mtf.sok.domain;

import lombok.Data;
import java.util.Date;

@Data
public class BannerDTO {
    // TB_BANNER 테이블 컬럼 매핑
    private Integer seq;
    private String title;
    private String linkUrl;
    private String targetType;
    private String fileName;
    private String originalFileName;
    private Integer displayOrder;
    private String isActive;
    private Date regDt;
    private Date modDt;

    // 관리자 목록 페이징 및 검색용 파라미터
    private int pageNum = 1;
    private int amount = 10;
    private int offset = 0;
    private String keyword;

    // 페이징 처리를 위한 오프셋 계산 메서드
    public void calcOffset() {
        this.offset = (this.pageNum - 1) * this.amount;
    }
}