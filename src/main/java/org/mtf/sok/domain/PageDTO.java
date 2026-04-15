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

        // 전달받은 객체의 타입에 따라 pageNum과 amount를 안전하게 추출합니다.
        if (cri instanceof BoardDTO) {
            this.pageNum = ((BoardDTO) cri).getPageNum();
            this.amount = ((BoardDTO) cri).getAmount();
        } else if (cri instanceof MemberDTO) {
            this.pageNum = ((MemberDTO) cri).getPageNum();
            this.amount = ((MemberDTO) cri).getAmount();
        } else if (cri instanceof AdminDTO) {
            this.pageNum = ((AdminDTO) cri).getPageNum();
            this.amount = ((AdminDTO) cri).getAmount();
        } else if (cri instanceof CertificateDTO) {
            this.pageNum = ((CertificateDTO) cri).getPageNum();
            this.amount = ((CertificateDTO) cri).getAmount();
        } else if (cri instanceof DevRequestDTO) {
            this.pageNum = ((DevRequestDTO) cri).getPageNum();
            this.amount = ((DevRequestDTO) cri).getAmount();
        } else if (cri instanceof DonationDTO) {
            this.pageNum = ((DonationDTO) cri).getPageNum();
            this.amount = ((DonationDTO) cri).getAmount();
        } else if (cri instanceof VolunteerDTO) {
            this.pageNum = ((VolunteerDTO) cri).getPageNum();
            this.amount = ((VolunteerDTO) cri).getAmount();
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