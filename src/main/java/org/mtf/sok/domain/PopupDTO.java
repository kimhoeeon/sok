package org.mtf.sok.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;

@Data
public class PopupDTO {
    private Long popSeq;
    private String title;

    // HTML5 datetime-local 타입과 매핑하기 위한 포맷 설정
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

    // 폼에서 업로드되는 팝업 이미지 파일 (DB 매핑 X)
    private MultipartFile uploadFile;

    // DB에서 조회된 팝업 이미지 정보 (TB_FILE 매핑)
    private FileDTO popupImage;
}