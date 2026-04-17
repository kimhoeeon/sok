package org.mtf.sok.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageDTO {
    private int startPage;
    private int endPage;
    private boolean prev, next;
    private int total;
    private Object cri;
    private int pageNum;
    private int amount;

    public PageDTO(Object cri, int total) {
        this.cri = cri;
        this.total = total;

        // [개선] BoardDTO, MemberDTO 등 모든 DTO가 Criteria를 상속받으므로
        // 부모 타입인 Criteria 하나로 형변환하여 단번에 처리 (유지보수성 극대화)
        if (cri instanceof Criteria) {
            this.pageNum = ((Criteria) cri).getPageNum();
            this.amount = ((Criteria) cri).getAmount();
        } else {
            this.pageNum = 1;
            this.amount = 10;
        }

        this.endPage = (int) (Math.ceil(this.pageNum / 10.0)) * 10;
        this.startPage = this.endPage - 9;
        int realEnd = (int) (Math.ceil((total * 1.0) / this.amount));

        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}