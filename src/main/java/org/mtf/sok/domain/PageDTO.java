package org.mtf.sok.domain;

import lombok.Getter;

@Getter
public class PageDTO {
    private int startPage;
    private int endPage;
    private boolean prev, next;
    private int total;
    private Criteria cri;

    public PageDTO(Criteria cri, int total) {
        this.cri = cri;
        this.total = total;

        // 페이징 끝 번호 계산 (예: 10, 20, 30...)
        this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
        // 페이징 시작 번호 계산
        this.startPage = this.endPage - 9;

        // 실제 데이터 개수에 따른 진짜 끝 페이지 계산
        int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}