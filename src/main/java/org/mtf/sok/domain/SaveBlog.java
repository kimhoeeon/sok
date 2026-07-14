package org.mtf.sok.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class SaveBlog {
    private int seq;
    private String imageSrc;
    private String title;
    private String linkUrl;
    private String fileName;
    private LocalDateTime regDt;
}