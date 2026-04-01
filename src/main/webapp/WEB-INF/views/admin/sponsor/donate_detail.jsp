<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="donate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">결제(기부) 상세 내역</h3>
    <a href="/admin/sponsor/donate/list?pageNum=${params.pageNum}&amount=${params.amount}&payType=${params.payType}&searchStatus=${params.searchStatus}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row g-4">
    <div class="col-xl-8">
        <div class="premium-dark-card p-5 h-100">
            <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4"><i class="bi bi-receipt text-info me-2"></i> 주문 및 결제 상세 정보</h5>

            <div class="row mb-3">
                <div class="col-md-3 text-muted">주문번호</div>
                <div class="col-md-9 text-info fw-bold">${donation.orderId}</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">후원자명 (아이디)</div>
                <div class="col-md-9 text-white">${donation.mbrNm} (${donation.mbrId})</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">후원 유형 / 수단</div>
                <div class="col-md-9 text-white">
                    <span class="badge bg-secondary me-2">${donation.payType eq 'REGULAR' ? '정기후원' : '일시후원'}</span>
                    ${donation.payMethod}
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">결제금액</div>
                <div class="col-md-9 text-success fw-bold fs-5"><fmt:formatNumber value="${donation.payAmt}" pattern="#,###" /> 원</div>
            </div>
            <div class="row mb-4">
                <div class="col-md-3 text-muted">결제 일시</div>
                <div class="col-md-9 text-muted"><fmt:formatDate value="${donation.payDt}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
            </div>

            <c:if test="${not empty donation.cheerMsg}">
                <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4 mt-5"><i class="bi bi-chat-heart text-danger me-2"></i> 후원자 응원 메시지</h5>
                <div class="p-4 rounded text-white" style="background: rgba(255,255,255,0.03); border: 1px solid #474761; white-space: pre-wrap;">${donation.cheerMsg}</div>
            </c:if>
        </div>
    </div>

    <div class="col-xl-4">
        <div class="premium-dark-card p-4 h-100 glassmorphism-box border-0">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-gear-fill me-2 text-primary"></i> 결제 상태 관리</h5>

            <div class="p-4 rounded text-center mb-4 border border-secondary" style="background-color: #151521;">
                <span class="d-block text-muted mb-2">현재 상태</span>
                <c:choose>
                    <c:when test="${donation.payStatus eq 'DONE'}"><h2 class="text-success fw-bold m-0">결제 완료</h2></c:when>
                    <c:when test="${donation.payStatus eq 'WAIT'}"><h2 class="text-warning fw-bold m-0">입금 대기</h2></c:when>
                    <c:when test="${donation.payStatus eq 'CANCEL'}">
                        <h2 class="text-danger fw-bold m-0 mb-2">결제 취소</h2>
                        <span class="text-muted d-block" style="font-size: 12px;">취소일: <fmt:formatDate value="${donation.cancelDt}" pattern="yyyy-MM-dd HH:mm" /></span>
                        <span class="text-muted d-block" style="font-size: 12px;">사유: ${donation.cancelRsn}</span>
                    </c:when>
                    <c:when test="${donation.payStatus eq 'REFUND'}">
                        <h2 class="text-danger fw-bold m-0 mb-2">환불 완료</h2>
                        <span class="text-muted d-block" style="font-size: 12px;">환불일: <fmt:formatDate value="${donation.refundDt}" pattern="yyyy-MM-dd HH:mm" /></span>
                        <span class="text-muted d-block" style="font-size: 12px;">사유: ${donation.refundRsn}</span>
                    </c:when>
                </c:choose>
            </div>

            <hr class="border-secondary my-4">

            <form action="/admin/sponsor/donate/updateStatus" method="post">
                <input type="hidden" name="paySeq" value="${donation.paySeq}">
                <input type="hidden" name="pageNum" value="${params.pageNum}">
                <input type="hidden" name="amount" value="${params.amount}">
                <input type="hidden" name="payType" value="${params.payType}">
                <input type="hidden" name="searchStatus" value="${params.searchStatus}">

                <label class="form-label text-muted mb-2" style="font-size: 13px;">상태 변경 (PG사 API 연동 필요)</label>
                <select name="payStatus" id="payStatusSelect" class="form-select dark-search-bar mb-3 border-danger" onchange="toggleCancelReason()">
                    <option value="WAIT" ${donation.payStatus eq 'WAIT' ? 'selected' : ''}>입금 대기 (무통장)</option>
                    <option value="DONE" ${donation.payStatus eq 'DONE' ? 'selected' : ''}>결제 완료 처리</option>
                    <option value="CANCEL" ${donation.payStatus eq 'CANCEL' ? 'selected' : ''}>결제 취소 처리</option>
                    <option value="REFUND" ${donation.payStatus eq 'REFUND' ? 'selected' : ''}>환불 완료 처리</option>
                </select>

                <div id="cancelReasonDiv" style="display: ${donation.payStatus eq 'CANCEL' or donation.payStatus eq 'REFUND' ? 'block' : 'none'};">
                    <label class="form-label text-danger mb-2" style="font-size: 13px;">취소/환불 사유 입력</label>
                    <input type="text" name="cancelRsn" id="cancelRsn" class="form-control dark-search-bar border-danger mb-3" placeholder="예: 고객 단순 변심" value="${not empty donation.cancelRsn ? donation.cancelRsn : donation.refundRsn}">
                </div>

                <button type="submit" class="btn btn-outline-danger w-100 py-2" onclick="return confirm('결제 상태를 강제로 변경하시겠습니까?');">상태 강제 저장</button>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleCancelReason() {
        var status = document.getElementById('payStatusSelect').value;
        var reasonDiv = document.getElementById('cancelReasonDiv');

        if (status === 'CANCEL' || status === 'REFUND') {
            reasonDiv.style.display = 'block';
        } else {
            reasonDiv.style.display = 'none';
        }
    }
</script>
<%@ include file="../layout/footer.jsp" %>