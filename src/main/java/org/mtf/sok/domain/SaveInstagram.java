package org.mtf.sok.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SaveInstagram {
    private LocalDateTime regDt;   // reg_dtm
    private Integer seq;            // seq (1..maxCnt, tinyint)
    private String linkUrl;         // link_url
    private String title;           // title
    private String description;     // description
    private String imageSrc;        // image_src (원격 이미지 URL)
    private String fileName;        // file_name (저장된 파일명, 없으면 "")
}