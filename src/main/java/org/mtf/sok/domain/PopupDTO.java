package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
public class PopupDTO extends Criteria {

    private Long popSeq;
    private String title;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date startDt;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date endDt;

    private String useYn;
    private String regId;
    private Date regDt;
    private String modId;
    private Date modDt;
    private String delYn;

    private MultipartFile uploadFile; // 팝업은 단일 파일 처리
    private FileDTO popupImage; // TB_FILE 연동 정보

    // 검색어 파라미터 추가
    private String searchKeyword;

    // 사용 팝업만 보기 체크박스 상태
    private String searchUseYnOnly;

    // 관리자 고도화를 위한 상태 값 (가상 필드)
    public String getDisplayStatus() {
        Date now = new Date();
        if ("N".equals(this.useYn)) return "사용안함";
        if (now.before(this.startDt)) return "게시예정";
        if (now.after(this.endDt)) return "게시종료";
        return "게시중";
    }
}