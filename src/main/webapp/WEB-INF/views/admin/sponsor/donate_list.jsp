<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="subMenuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="sponsor_donate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">기부금(결제) 목록</h3>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/sponsor/donate/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group shadow-sm" style="max-width: 400px;">
            <select name="payType" class="form-select dark-search-bar">
                <option value="">후원 유형</option>
                <option value="REGULAR" ${payType eq 'REGULAR' ? 'selected' : ''}>정기후원</option>
                <option value="ONCE" ${payType eq 'ONCE' ? 'selected' : ''}>일시후원</option>
            </select>
            <select name="searchStatus" class="form-select dark-search-bar border-start-0">
                <option value="">결제 상태</option>
                <option value="DONE" ${searchStatus eq 'DONE' ? 'selected' : ''}>결제완료</option>
                <option value="WAIT" ${searchStatus eq 'WAIT' ? 'selected' : ''}>결제대기</option>
                <option value="REFUND" ${searchStatus eq 'REFUND' ? 'selected' : ''}>환불완료</option>
                <option value="CANCEL" ${searchStatus eq 'CANCEL' ? 'selected' : ''}>취소완료</option>
            </select>
            <button class="btn btn-secondary border-start-0" type="submit" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th class="text-white border-bottom border-secondary">주문번호</th>
                    <th class="text-white border-bottom border-secondary">후원자명</th>
                    <th class="text-white border-bottom border-secondary">결제수단</th>
                    <th class="text-white border-bottom border-secondary">후원유형</th>
                    <th class="text-white border-bottom border-secondary">결제금액</th>
                    <th class="text-white border-bottom border-secondary">상태</th>
                    <th class="text-white border-bottom border-secondary">결제/등록 일시</th>
                    <th class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${list}">
                    <tr>
                        <td class="border-secondary"><span style="font-size: 12px; color: #a1a5b7;">${item.orderId}</span></td>
                        <td class="text-white fw-bold border-secondary">${item.mbrNm}</td>
                        <td class="border-secondary">${item.payMethod}</td>
                        <td class="border-secondary">
                            ${item.payType eq 'REGULAR' ? '<span class="badge bg-primary">정기</span>' : '<span class="badge bg-secondary">일시</span>'}
                            <c:if test="${item.payType eq 'REGULAR'}"><br><small>(${item.regularRound}회차)</small></c:if>
                        </td>
                        <td class="border-secondary text-white fw-bold"><fmt:formatNumber value="${item.payAmt}" pattern="#,###"/> 원</td>
                        <td class="border-secondary">
                            <c:choose>
                                <c:when test="${item.payStatus eq 'DONE'}"><span class="badge bg-success">결제완료</span></c:when>
                                <c:when test="${item.payStatus eq 'WAIT'}"><span class="badge bg-warning text-dark">대기중</span></c:when>
                                <c:when test="${item.payStatus eq 'REFUND'}"><span class="badge bg-danger">환불완료</span></c:when>
                                <c:when test="${item.payStatus eq 'CANCEL'}"><span class="badge bg-secondary">취소완료</span></c:when>
                                <c:otherwise><span class="badge bg-dark">실패/기타</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="border-secondary">
                            <fmt:formatDate value="${not empty item.payDt ? item.payDt : item.regDt}" pattern="yyyy-MM-dd HH:mm" />
                        </td>
                        <td class="border-secondary">
                            <a href="/admin/sponsor/donate/detail?paySeq=${item.paySeq}" class="btn btn-sm btn-outline-light">상세/수정</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>