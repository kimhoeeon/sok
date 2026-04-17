<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="certificate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">증명서 신청 상세 확인</h3>
    <a href="/admin/certificate/list?pageNum=${params.pageNum}&amount=${params.amount}&searchType=${params.searchType}&searchStatus=${params.searchStatus}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row g-4">
    <div class="col-xl-8">
        <div class="premium-dark-card p-5 h-100">
            <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4"><i class="bi bi-person-vcard me-2 text-info"></i> 신청자 및 증명서 정보</h5>

            <div class="row mb-3">
                <div class="col-md-3 text-muted">증명서 종류</div>
                <div class="col-md-9 text-white fw-bold"><span class="badge bg-secondary">${certificate.certType}</span></div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">신청자명</div>
                <div class="col-md-9 text-white">${certificate.applyNm}</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">연락처</div>
                <div class="col-md-9 text-white">${certificate.phone}</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">이메일</div>
                <div class="col-md-9 text-white">${certificate.email}</div>
            </div>
            <div class="row mb-3">
                <div class="col-md-3 text-muted">소속</div>
                <div class="col-md-9 text-white">${not empty certificate.belongTo ? certificate.belongTo : '-'}</div>
            </div>
            <div class="row mb-4">
                <div class="col-md-3 text-muted">신청일시</div>
                <div class="col-md-9 text-muted"><fmt:formatDate value="${certificate.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
            </div>

            <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4 mt-5"><i class="bi bi-chat-left-text me-2 text-warning"></i> 발급 용도</h5>
            <div class="p-4 rounded text-white mb-4" style="background: rgba(255,255,255,0.03); border: 1px solid #474761; min-height: 100px; white-space: pre-wrap;">${certificate.usePurpose}</div>

            <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4"><i class="bi bi-journal-text me-2 text-primary"></i> 비고 (특이사항)</h5>
            <div class="p-4 rounded text-white" style="background: rgba(255,255,255,0.03); border: 1px solid #474761; min-height: 100px; white-space: pre-wrap;">${not empty certificate.remark ? certificate.remark : '특이사항 없음'}</div>
        </div>
    </div>

    <div class="col-xl-4">
        <div class="premium-dark-card p-4 h-100 glassmorphism-box border-0">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-gear-fill me-2 text-primary"></i> 진행 상태 관리</h5>

            <div class="p-4 rounded text-center mb-4 border border-secondary" style="background-color: #151521;">
                <span class="d-block text-muted mb-2">현재 상태</span>
                <c:choose>
                    <c:when test="${certificate.issueStatus eq 'WAIT'}"><h2 class="text-warning fw-bold m-0">접수 대기</h2></c:when>
                    <c:when test="${certificate.issueStatus eq 'ING'}"><h2 class="text-primary fw-bold m-0">발급 진행중</h2></c:when>
                    <c:when test="${certificate.issueStatus eq 'DONE'}"><h2 class="text-success fw-bold m-0">발급 완료</h2></c:when>
                    <c:when test="${certificate.issueStatus eq 'REJECT'}"><h2 class="text-danger fw-bold m-0">반려 / 거절</h2></c:when>
                </c:choose>
                <c:if test="${certificate.issueStatus eq 'DONE'}">
                    <span class="d-block text-success mt-2" style="font-size: 12px;">발급일: <fmt:formatDate value="${certificate.issueDt}" pattern="yyyy-MM-dd" /></span>
                </c:if>
            </div>

            <hr class="border-secondary my-4">

            <h6 class="text-white fw-bold mb-3">상태 업데이트</h6>
            <form action="/admin/certificate/updateStatus" method="post">
                <input type="hidden" name="certSeq" value="${certificate.certSeq}">
                <input type="hidden" name="pageNum" value="${params.pageNum}">
                <input type="hidden" name="amount" value="${params.amount}">
                <input type="hidden" name="searchType" value="${params.searchType}">
                <input type="hidden" name="searchStatus" value="${params.searchStatus}">
                <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

                <select name="issueStatus" id="issueStatusSelect" class="form-select dark-search-bar mb-3 border-primary" onchange="toggleRejectReason()">
                    <option value="WAIT" ${certificate.issueStatus eq 'WAIT' ? 'selected' : ''}>접수 대기</option>
                    <option value="ING" ${certificate.issueStatus eq 'ING' ? 'selected' : ''}>발급 진행중</option>
                    <option value="DONE" ${certificate.issueStatus eq 'DONE' ? 'selected' : ''}>발급 완료 처리</option>
                    <option value="REJECT" ${certificate.issueStatus eq 'REJECT' ? 'selected' : ''}>반려 / 거절 처리</option>
                </select>

                <div id="rejectReasonDiv" style="display: ${certificate.issueStatus eq 'REJECT' ? 'block' : 'none'};">
                    <label class="form-label text-danger mb-2" style="font-size: 13px;">반려 사유 작성 (필수)</label>
                    <textarea name="rejectRsn" id="rejectRsn" class="form-control dark-search-bar border-danger mb-3" rows="3" placeholder="반려/거절 사유를 입력해주세요.">${certificate.rejectRsn}</textarea>
                </div>

                <button type="submit" class="btn btn-outline-primary w-100 py-2">상태 저장</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    function toggleRejectReason() {
        var status = document.getElementById('issueStatusSelect').value;
        var rejectDiv = document.getElementById('rejectReasonDiv');
        var rejectInput = document.getElementById('rejectRsn');

        if (status === 'REJECT') {
            rejectDiv.style.display = 'block';
            rejectInput.required = true;
        } else {
            rejectDiv.style.display = 'none';
            rejectInput.required = false;
        }
    }
</script>