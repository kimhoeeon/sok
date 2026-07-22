package org.mtf.sok.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class InstaTokenDTO {
    private String seq;
    private String token;
    private LocalDateTime initRegiDttm;
    private LocalDateTime finalRegiDttm;
}