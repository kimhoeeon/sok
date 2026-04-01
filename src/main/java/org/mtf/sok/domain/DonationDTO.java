package org.mtf.sok.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false) // ★ [페이징 추가/수정]
public class DonationDTO extends Criteria { // ★ [페이징 추가/수정] Criteria 상속
    private Long paySeq;
    private Long mbrSeq;
    private String orderId;
    private String payType;       // REGULAR(정기), ONCE(일시)
    private Integer regularRound; // 정기결제 회차
    private BigDecimal payAmt;    // 결제금액
    private String payStatus;     // WAIT(대기), DONE(완료), FAIL(실패), CANCEL(취소), REFUND(환불)
    private String payMethod;     // 카드, 계좌이체 등
    private Date payDt;
    private Date cancelDt;
    private String cancelRsn;
    private Date refundDt;
    private String refundRsn;
    private String cheerMsg;      // 응원 메시지
    private Date regDt;

    // 조인(Join) 시 가져올 회원 정보
    private String mbrNm;
    private String mbrId;
    private String phone;

    // 검색용 파라미터
    private String searchStatus;
}