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

    public void setAmount(int amount) {
        // [추가된 로직] 엑셀 다운로드 등 전체 데이터 조회를 위한 특수 값(1,000,000)은 방어 로직을 예외로 통과시킵니다.
        if (amount == 1000000) {
            this.amount = amount;
            return;
        }

        // [기존 방어 로직] 악의적인 파라미터 조작으로 인한 DB(Memory) 과부하 방지
        // 0 이하의 값이 들어오거나, 100 이상의 무리한 값이 들어오면 기본값 10으로 강제 고정
        if (amount <= 0 || amount > 100) {
            this.amount = 10;
        } else {
            this.amount = amount;
        }
    }

    public int getSkip() {
        // MyBatis가 #{skip}을 찾을 때 이 메서드를 호출하여 시작 위치를 계산합니다.
        return (this.pageNum - 1) * this.amount;
    }

    public int getOffset() {
        return (this.pageNum - 1) * this.amount;
    }
}