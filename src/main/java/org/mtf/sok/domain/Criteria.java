package org.mtf.sok.domain;

import lombok.Data;

@Data
public class Criteria {
    private int pageNum; // 현재 페이지 번호
    private int amount;  // 한 페이지당 보여줄 데이터 개수

    public Criteria() {
        this(1, 10); // 기본값: 1페이지, 10개씩
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    // MyBatis에서 LIMIT 구문의 시작 위치(Offset)를 계산하기 위한 메서드
    public int getOffset() {
        return (this.pageNum - 1) * this.amount;
    }
}