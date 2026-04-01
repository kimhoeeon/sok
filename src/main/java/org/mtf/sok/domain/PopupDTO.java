package org.mtf.sok.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;

@Data
public class PopupDTO {
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

    private MultipartFile uploadFile;
    private FileDTO popupImage; // TB_FILE 연동 정보

    // 관리자 고도화를 위한 상태 값 (가상 필드)
    public String getDisplayStatus() {
        Date now = new Date();
        if ("N".equals(this.useYn)) return "사용안함";
        if (now.before(this.startDt)) return "게시예정";
        if (now.after(this.endDt)) return "게시종료";
        return "게시중";
    }
}