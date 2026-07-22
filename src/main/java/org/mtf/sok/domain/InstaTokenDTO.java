package org.mtf.sok.domain;

import lombok.Data;
import java.util.Date;

@Data
public class InstaTokenDTO {
    private String seq;
    private String token;
    private Date initRegiDttm;
    private Date finalRegiDttm;
}