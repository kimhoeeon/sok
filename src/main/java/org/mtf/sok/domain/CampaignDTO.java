package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
public class CampaignDTO extends Criteria {

    private Long campSeq;          // 캠페인 일련번호
    private String title;          // 캠페인 제목
    private String content;        // 본문 내용 (Summernote 에디터)

    // 썸네일 이미지 처리
    private MultipartFile thumbFile;
    private String thumbPath;      // DB 저장용 썸네일 경로

    private BigDecimal goalAmt;    // 목표 모금액
    private BigDecimal currentAmt; // 현재 모금액

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDt;          // 모금 시작일

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDt;            // 모금 종료일

    private String useYn;          // 노출 여부 (Y/N)

    private String regId;          // 등록자
    private Date regDt;            // 등록일시
    private String modId;          // 수정자
    private Date modDt;            // 수정일시
    private String delYn;          // 삭제여부 (Y/N)

    // 일반 파일 다중 첨부용 (필요 시)
    private List<MultipartFile> uploadFiles;
    private List<FileDTO> fileList;

    // 프론트엔드 노출을 위한 추가 연산 필드
    private Integer achievementRate; // 달성률 (%)
    private Integer dDay;            // 남은 기간 (일)

    // 검색 조건 추가 (관리자용)
    private String searchKeyword;
    private String searchUseYn;
}