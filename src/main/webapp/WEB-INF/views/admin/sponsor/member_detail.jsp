<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="member" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">회원/후원자 상세 정보</h3>
    <a href="/admin/sponsor/member/list?pageNum=${params.pageNum}&amount=${params.amount}&mbrType=${params.mbrType}&isDonor=${params.isDonor}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row g-4">
    <div class="col-xl-5">
        <div class="premium-dark-card p-4 h-100">
            <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4"><i class="bi bi-person-lines-fill me-2 text-info"></i> 기본 정보 (수정 가능)</h5>

            <form action="/admin/sponsor/member/update" method="post">
                <input type="hidden" name="mbrSeq" value="${member.mbrSeq}">
                <input type="hidden" name="pageNum" value="${params.pageNum}">
                <input type="hidden" name="amount" value="${params.amount}">
                <input type="hidden" name="mbrType" value="${params.mbrType}">
                <input type="hidden" name="isDonor" value="${params.isDonor}">
                <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

                <div class="mb-3">
                    <label class="text-muted mb-1">회원명 (아이디)</label>
                    <input type="text" class="form-control dark-search-bar" value="${member.mbrNm} (${member.mbrId})" disabled>
                </div>
                <div class="mb-3">
                    <label class="text-muted mb-1">회원 구분 / 사업자번호</label>
                    <input type="text" class="form-control dark-search-bar" value="${member.mbrType eq 'CORP' ? '기업/단체' : '개인'} / ${not empty member.bizNo ? member.bizNo : '-'}" disabled>
                </div>
                <div class="mb-3">
                    <label class="text-muted mb-1">연락처</label>
                    <input type="text" name="phone" class="form-control dark-search-bar border-primary" value="${member.phone}">
                </div>
                <div class="mb-3">
                    <label class="text-muted mb-1">이메일</label>
                    <input type="email" name="email" class="form-control dark-search-bar border-primary" value="${member.email}">
                </div>

                <c:if test="${member.mbrType eq 'CORP'}">
                    <div class="row mb-3">
                        <div class="col-6">
                            <label class="text-muted mb-1">담당자명</label>
                            <input type="text" name="managerNm" class="form-control dark-search-bar border-primary" value="${member.managerNm}">
                        </div>
                        <div class="col-6">
                            <label class="text-muted mb-1">담당자 직함</label>
                            <input type="text" name="managerPos" class="form-control dark-search-bar border-primary" value="${member.managerPos}">
                        </div>
                    </div>
                </c:if>

                <div class="text-end mt-4">
                    <button type="submit" class="btn btn-outline-primary px-4">회원 정보 수정</button>
                </div>
            </form>
        </div>
    </div>

    <div class="col-xl-7">
        <div class="premium-dark-card p-4 h-100">
            <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-4"><i class="bi bi-piggy-bank-fill me-2 text-danger"></i> 해당 회원의 기부 결제 내역</h5>

            <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                <table class="table table-hover align-middle text-center" style="font-size: 13px;">
                    <thead style="position: sticky; top: 0; background: #1e1e2d; z-index: 1;">
                        <tr>
                            <th class="text-white border-bottom border-secondary">주문번호</th>
                            <th class="text-white border-bottom border-secondary">기부유형</th>
                            <th class="text-white border-bottom border-secondary">결제금액</th>
                            <th class="text-white border-bottom border-secondary">결제상태</th>
                            <th class="text-white border-bottom border-secondary">결제일시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty member.donationList}">
                                <tr><td colspan="5" class="py-4 text-muted">기부 내역이 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="d" items="${member.donationList}">
                                    <tr>
                                        <td><a href="/admin/sponsor/donate/detail?paySeq=${d.paySeq}" class="text-info text-decoration-none">${d.orderId}</a></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${d.payType eq 'REGULAR'}"><span class="badge bg-primary">정기 (${d.regularRound}회차)</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">일시후원</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-success fw-bold"><fmt:formatNumber value="${d.payAmt}" pattern="#,###" />원</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${d.payStatus eq 'DONE'}"><span class="text-success fw-bold">결제완료</span></c:when>
                                                <c:when test="${d.payStatus eq 'CANCEL'}"><span class="text-danger">결제취소</span></c:when>
                                                <c:when test="${d.payStatus eq 'REFUND'}"><span class="text-danger">환불완료</span></c:when>
                                                <c:when test="${d.payStatus eq 'WAIT'}"><span class="text-warning">입금대기</span></c:when>
                                                <c:otherwise><span class="text-muted">${d.payStatus}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-muted"><fmt:formatDate value="${d.payDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>