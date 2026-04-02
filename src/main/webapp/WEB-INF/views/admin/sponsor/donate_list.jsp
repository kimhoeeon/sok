<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="donate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">기부금(결제) 내역 관리</h3>
    <button type="button" class="btn btn-success px-4 fw-bold" onclick="downloadExcel()">
        <i class="bi bi-file-earmark-excel me-1"></i> 엑셀 다운로드
    </button>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/sponsor/donate/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 500px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="payType" class="form-select dark-search-bar border-start-0" style="max-width: 140px;">
                <option value="">후원 유형</option>
                <option value="ONCE" ${params.payType eq 'ONCE' ? 'selected' : ''}>일시후원</option>
                <option value="REGULAR" ${params.payType eq 'REGULAR' ? 'selected' : ''}>정기후원</option>
            </select>

            <select name="searchStatus" class="form-select dark-search-bar border-start-0" style="max-width: 140px;">
                <option value="">결제 상태</option>
                <option value="DONE" ${params.searchStatus eq 'DONE' ? 'selected' : ''}>결제완료</option>
                <option value="WAIT" ${params.searchStatus eq 'WAIT' ? 'selected' : ''}>입금대기</option>
                <option value="CANCEL" ${params.searchStatus eq 'CANCEL' ? 'selected' : ''}>결제취소</option>
                <option value="REFUND" ${params.searchStatus eq 'REFUND' ? 'selected' : ''}>환불완료</option>
            </select>

            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="15%">주문번호</th>
                    <th width="15%">후원자명 (아이디)</th>
                    <th width="10%">후원유형</th>
                    <th width="12%">결제수단</th>
                    <th width="15%">결제금액</th>
                    <th width="10%">결제상태</th>
                    <th width="15%">결제일시</th>
                    <th width="8%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr><td colspan="8" class="py-5 text-muted">결제 내역이 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="text-start">
                                    <a href="/admin/sponsor/donate/detail?paySeq=${item.paySeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&payType=${params.payType}&searchStatus=${params.searchStatus}" class="text-info text-decoration-none fw-bold hover-glow">
                                        ${item.orderId}
                                    </a>
                                </td>
                                <td class="text-start text-white">${item.mbrNm} <span class="text-muted" style="font-size: 12px;">(${item.mbrId})</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.payType eq 'REGULAR'}"><span class="badge bg-primary">정기 (${item.regularRound}회)</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary">일시</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><span class="badge bg-dark border border-secondary">${item.payMethod}</span></td>
                                <td class="text-success fw-bold"><fmt:formatNumber value="${item.payAmt}" pattern="#,###" />원</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.payStatus eq 'DONE'}"><span class="text-success fw-bold">결제완료</span></c:when>
                                        <c:when test="${item.payStatus eq 'WAIT'}"><span class="text-warning">입금대기</span></c:when>
                                        <c:when test="${item.payStatus eq 'CANCEL'}"><span class="text-danger">결제취소</span></c:when>
                                        <c:when test="${item.payStatus eq 'REFUND'}"><span class="text-danger">환불완료</span></c:when>
                                        <c:otherwise><span class="text-muted">${item.payStatus}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-muted"><fmt:formatDate value="${item.payDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
                                    <a href="/admin/sponsor/donate/detail?paySeq=${item.paySeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&payType=${params.payType}&searchStatus=${params.searchStatus}" class="btn btn-sm btn-outline-light">확인</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <c:if test="${pageMaker.total > 0}">
        <div class="d-flex justify-content-center mt-5">
            <ul class="pagination pagination-dark m-0">
                <c:if test="${pageMaker.prev}"><li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.startPage - 1})"><i class="bi bi-chevron-left"></i></a></li></c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="javascript:goPage(${num})">${num}</a></li>
                </c:forEach>
                <c:if test="${pageMaker.next}"><li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.endPage + 1})"><i class="bi bi-chevron-right"></i></a></li></c:if>
            </ul>
        </div>
    </c:if>
</div>

<script>
    function goPage(pageNum) {
        document.getElementById('searchForm').pageNum.value = pageNum;
        document.getElementById('searchForm').submit();
    }
    function searchData() {
        document.getElementById('searchForm').pageNum.value = 1;
        document.getElementById('searchForm').submit();
    }

    // [엑셀 다운로드 함수 추가]
    function downloadExcel() {
        var form = document.getElementById('searchForm');
        var originalAction = form.action;
        form.action = '/admin/sponsor/donate/excel';
        form.submit();
        form.action = originalAction;
    }
</script>
<%@ include file="../layout/footer.jsp" %>