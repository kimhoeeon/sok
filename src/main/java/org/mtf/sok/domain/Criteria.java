package org.mtf.sok.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class Criteria {
    private int pageNum; // 현재 페이지 번호
    private int amount;  // 한 페이지당 보여줄 데이터 개수

    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    // [개선] 악의적인 페이지 번호(-1, 0 등) 요청 시 1페이지로 강제 고정
    public void setPageNum(int pageNum) {
        this.pageNum = pageNum <= 0 ? 1 : pageNum;
    }

    // [개선] 1페이지당 개수를 비정상적으로 크게 요청하여 DB/서버를 다운시키는 공격 방어 (최대 100개)
    public void setAmount(int amount) {
        this.amount = (amount <= 0 || amount > 100) ? 10 : amount;
    }

    public int getSkip() {
        // MyBatis가 #{skip}을 찾을 때 이 메서드를 호출하여 시작 위치를 계산합니다.
        return (this.pageNum - 1) * this.amount;
    }

    public int getOffset() {
        return (this.pageNum - 1) * this.amount;
    }
}