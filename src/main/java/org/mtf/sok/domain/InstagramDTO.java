package org.mtf.sok.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InstagramDTO {
    String regDt;
    Integer seq;
    String linkUrl;
    String title;
    String description;
    String imageSrc;
    String fileName;
}