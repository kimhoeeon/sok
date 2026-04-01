<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="subMenuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="sponsor_donate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">기부금(결제) 상세 내역</h3>
    <a href="/admin/sponsor/donate/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="premium-dark-card p-5">

            <div class="row mb-5 text-center align-items-center">
                <div class="col-md-3 mb-3 mb-md-0 border-end border-secondary">
                    <span class="d-block text-muted mb-1">결제 금액</span>
                    <h2 class="text-white fw-bold mb-0"><fmt:formatNumber value="${donation.payAmt}" pattern="#,###"/> <small class="fs-6 text-muted">원</small></h2>
                </div>
                <div class="col-md-3 mb-3 mb-md-0 border-end border-secondary">
                    <span class="d-block text-muted mb-1">후원자명 (회원가입자)</span>
                    <h5 class="text-white fw-bold mb-1">
                        <a href="/admin/sponsor/member/detail?mbrSeq=${donation.mbrSeq}" class="text-info text-decoration-none hover-glow">
                            ${donation.mbrNm} <i class="bi bi-box-arrow-up-right ms-1" style="font-size: 12px;"></i>
                        </a>
                    </h5>
                    <span class="text-muted" style="font-size: 12px;">(${donation.phone})</span>
                </div>
                <div class="col-md-3 mb-3 mb-md-0 border-end border-secondary">
                    <span class="d-block text-muted mb-1">주문/승인 번호</span>
                    <span class="text-white fw-bold fs-6">${donation.orderId}</span>
                </div>
                <div class="col-md-3">
                    <span class="d-block text-muted mb-2">현재 상태</span>
                    <c:choose>
                        <c:when test="${donation.payStatus eq 'DONE'}"><span class="badge bg-success fs-5 px-3 py-2 shadow-sm">결제완료</span></c:when>
                        <c:when test="${donation.payStatus eq 'WAIT'}"><span class="badge bg-warning text-dark fs-5 px-3 py-2 shadow-sm">결제대기</span></c:when>
                        <c:when test="${donation.payStatus eq 'REFUND'}"><span class="badge bg-danger fs-5 px-3 py-2 shadow-sm">환불완료</span></c:when>
                        <c:when test="${donation.payStatus eq 'CANCEL'}"><span class="badge bg-secondary fs-5 px-3 py-2 shadow-sm">취소완료</span></c:when>
                        <c:otherwise><span class="badge bg-dark fs-5 px-3 py-2 shadow-sm">기타 오류</span></c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:if test="${not empty donation.cheerMsg}">
                <div class="mb-5 p-4 rounded text-center" style="background: rgba(255,255,255,0.03); border: 1px dashed rgba(255,255,255,0.2);">
                    <i class="bi bi-quote fs-3 text-muted"></i>
                    <p class="text-white fs-5 fw-bold fst-italic mb-0 mt-2">"${donation.cheerMsg}"</p>
                </div>
            </c:if>

            <div class="row g-5 mb-5">
                <div class="col-md-6">
                    <h6 class="text-white fw-bold border-bottom border-secondary pb-2 mb-3"><i class="bi bi-card-list me-2"></i>결제 메타 데이터</h6>
                    <table class="table table-borderless table-sm text-white" style="font-size: 14px;">
                        <tbody>
                            <tr>
                                <td class="text-muted w-25 pb-3">결제 수단</td>
                                <td class="fw-bold pb-3">${not empty donation.payMethod ? donation.payMethod : '-'}</td>
                            </tr>
                            <tr>
                                <td class="text-muted pb-3">후원 유형</td>
                                <td class="fw-bold pb-3">
                                    ${donation.payType eq 'REGULAR' ? '정기 후원' : '일시 후원'}
                                    <c:if test="${donation.payType eq 'REGULAR'}">
                                        <span class="badge bg-primary ms-2">${donation.regularRound} 회차</span>
                                    </c:if>
                                </td>
                            </tr>
                            <c:if test="${donation.payStatus eq 'CANCEL'}">
                                <tr>
                                    <td class="text-danger pb-3">취소 사유</td>
                                    <td class="text-danger pb-3">${donation.cancelRsn}</td>
                                </tr>
                            </c:if>
                            <c:if test="${donation.payStatus eq 'REFUND'}">
                                <tr>
                                    <td class="text-danger pb-3">환불 사유</td>
                                    <td class="text-danger pb-3">${donation.refundRsn}</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="col-md-6">
                    <h6 class="text-white fw-bold border-bottom border-secondary pb-2 mb-3"><i class="bi bi-clock-history me-2"></i>진행 일시 타임라인</h6>
                    <div class="position-relative ms-2 ps-3" style="border-left: 2px solid #474761;">

                        <div class="mb-4 position-relative">
                            <i class="bi bi-circle-fill position-absolute text-secondary" style="left: -21px; top: 3px; font-size: 10px;"></i>
                            <span class="d-block text-muted" style="font-size: 12px;">결제 요청 (DB 등록)</span>
                            <span class="text-white"><fmt:formatDate value="${donation.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                        </div>

                        <div class="mb-4 position-relative">
                            <i class="bi bi-circle-fill position-absolute ${not empty donation.payDt ? 'text-success' : 'text-secondary'}" style="left: -21px; top: 3px; font-size: 10px; ${not empty donation.payDt ? 'text-shadow: 0 0 5px #39ff14;' : ''}"></i>
                            <span class="d-block text-muted" style="font-size: 12px;">결제 승인 완료</span>
                            <span class="${not empty donation.payDt ? 'text-white fw-bold' : 'text-muted'}">
                                ${not empty donation.payDt ? '<fmt:formatDate value="' += donation.payDt += '" pattern="yyyy-MM-dd HH:mm:ss" />' : '대기중 / 미승인'}
                            </span>
                        </div>

                        <c:if test="${not empty donation.cancelDt or not empty donation.refundDt}">
                            <div class="position-relative">
                                <i class="bi bi-circle-fill position-absolute text-danger" style="left: -21px; top: 3px; font-size: 10px; text-shadow: 0 0 5px #e61938;"></i>
                                <span class="d-block text-danger" style="font-size: 12px;">${not empty donation.cancelDt ? '취소 일시' : '환불 일시'}</span>
                                <span class="text-white fw-bold">
                                    <fmt:formatDate value="${not empty donation.cancelDt ? donation.cancelDt : donation.refundDt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <hr class="border-secondary mb-4">

            <form action="/admin/sponsor/donate/updateStatus" method="post" id="statusForm" class="glassmorphism-box p-4 border-0" style="background: rgba(230, 25, 56, 0.05);">
                <input type="hidden" name="paySeq" value="${donation.paySeq}">
                <h6 class="text-danger fw-bold mb-3"><i class="bi bi-exclamation-triangle me-2"></i>관리자 강제 상태 변경 (PG사 연동 반영)</h6>

                <div class="row align-items-center">
                    <div class="col-md-4 mb-3 mb-md-0">
                        <select name="payStatus" id="payStatus" class="form-select dark-search-bar border-danger">
                            <option value="DONE" ${donation.payStatus eq 'DONE' ? 'selected' : ''}>[결제완료] 상태로 변경/유지</option>
                            <option value="WAIT" ${donation.payStatus eq 'WAIT' ? 'selected' : ''}>[결제대기] 상태로 변경</option>
                            <option value="CANCEL" ${donation.payStatus eq 'CANCEL' ? 'selected' : ''}>[결제취소] 처리 (PG 승인 전)</option>
                            <option value="REFUND" ${donation.payStatus eq 'REFUND' ? 'selected' : ''}>[결제환불] 처리 (PG 승인 후)</option>
                        </select>
                    </div>

                    <div class="col-md-5 mb-3 mb-md-0" id="reasonDiv" style="display: none;">
                        <input type="text" name="cancelRsn" id="cancelRsn" class="form-control dark-search-bar" placeholder="취소 사유를 입력하세요 (필수)" value="${donation.cancelRsn}">
                        <input type="text" name="refundRsn" id="refundRsn" class="form-control dark-search-bar" placeholder="환불 사유를 입력하세요 (필수)" value="${donation.refundRsn}" style="display:none;">
                    </div>

                    <div class="col-md-3 text-end">
                        <button type="submit" class="btn btn-neon w-100" onclick="return confirm('결제 상태를 강제로 변경하시겠습니까?');">상태 업데이트 적용</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        toggleReasonDiv();

        $('#payStatus').change(function() {
            toggleReasonDiv();
            // 상태를 바꿀 때 기존 입력되어 있던 사유를 초기화하여 새로 쓰게 유도
            $('#cancelRsn, #refundRsn').val('');
        });

        function toggleReasonDiv() {
            var status = $('#payStatus').val();
            if (status === 'CANCEL') {
                $('#reasonDiv').fadeIn();
                $('#cancelRsn').show().prop('required', true);
                $('#refundRsn').hide().prop('required', false);
            } else if (status === 'REFUND') {
                $('#reasonDiv').fadeIn();
                $('#refundRsn').show().prop('required', true);
                $('#cancelRsn').hide().prop('required', false);
            } else {
                $('#reasonDiv').hide();
                $('#cancelRsn, #refundRsn').prop('required', false);
            }
        }
    });
</script>

<%@ include file="../layout/footer.jsp" %>