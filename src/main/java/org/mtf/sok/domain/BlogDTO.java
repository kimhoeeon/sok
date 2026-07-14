package org.mtf.sok.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class BlogDTO {
    LocalDateTime regDt;
    Integer seq;
    String linkUrl;
    String title;
    String imageSrc;
    String fileName;
}