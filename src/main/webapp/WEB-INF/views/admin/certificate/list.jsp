<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="currentMenu" value="certificate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">증명서 신청 관리</h3>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/certificate/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="searchType" class="form-select dark-search-bar" style="max-width: 140px;">
                <option value="">전체 증명서</option>
                <option value="선수등록" ${searchType eq '선수등록' ? 'selected' : ''}>선수등록</option>
                <option value="봉사활동" ${searchType eq '봉사활동' ? 'selected' : ''}>봉사활동</option>
                <option value="경기실적" ${searchType eq '경기실적' ? 'selected' : ''}>경기실적</option>
                <option value="대회참가" ${searchType eq '대회참가' ? 'selected' : ''}>대회참가</option>
            </select>
            <select name="searchStatus" class="form-select dark-search-bar border-start-0" style="max-width: 130px;">
                <option value="">전체 상태</option>
                <option value="WAIT" ${searchStatus eq 'WAIT' ? 'selected' : ''}>접수대기</option>
                <option value="ING" ${searchStatus eq 'ING' ? 'selected' : ''}>발급중</option>
                <option value="DONE" ${searchStatus eq 'DONE' ? 'selected' : ''}>발급완료</option>
                <option value="REJECT" ${searchStatus eq 'REJECT' ? 'selected' : ''}>거절/반려</option>
            </select>
            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="신청자명 또는 연락처" value="${searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="submit" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="8%" class="text-white border-bottom border-secondary">연번</th>
                    <th width="12%" class="text-white border-bottom border-secondary">증명서 종류</th>
                    <th width="12%" class="text-white border-bottom border-secondary">신청자명</th>
                    <th class="text-white border-bottom border-secondary">발급 용도</th>
                    <th width="10%" class="text-white border-bottom border-secondary">처리 상태</th>
                    <th width="12%" class="text-white border-bottom border-secondary">신청일자</th>
                    <th width="12%" class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="7" class="py-5 text-muted border-secondary">증명서 신청 내역이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary">${item.certSeq}</td>
                                <td class="border-secondary"><span class="text-white fw-bold">${item.certType}</span></td>
                                <td class="border-secondary">${item.applyNm}</td>
                                <td class="text-start border-secondary text-truncate" style="max-width: 200px;">${item.usePurpose}</td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.issueStatus eq 'WAIT'}"><span class="badge bg-warning text-dark">접수대기</span></c:when>
                                        <c:when test="${item.issueStatus eq 'ING'}"><span class="badge bg-info text-dark">발급중</span></c:when>
                                        <c:when test="${item.issueStatus eq 'DONE'}"><span class="badge bg-success">발급완료</span></c:when>
                                        <c:when test="${item.issueStatus eq 'REJECT'}"><span class="badge bg-danger">거절/반려</span></c:when>
                                    </c:choose>
                                </td>
                                <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td class="border-secondary">
                                    <a href="/admin/certificate/detail?certSeq=${item.certSeq}" class="btn btn-sm btn-outline-light">상세/처리</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>