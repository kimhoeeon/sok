<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="subMenuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="sponsor_member" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">가입자 목록</h3>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/sponsor/member/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="mbrType" class="form-select dark-search-bar" style="max-width: 120px;">
                <option value="">전체 유형</option>
                <option value="INDIVIDUAL" ${mbrType eq 'INDIVIDUAL' ? 'selected' : ''}>개인</option>
                <option value="CORP" ${mbrType eq 'CORP' ? 'selected' : ''}>단체/기업</option>
            </select>
            <select name="isDonor" class="form-select dark-search-bar border-start-0" style="max-width: 150px;">
                <option value="">구분(후원여부)</option>
                <option value="Y" ${isDonor eq 'Y' ? 'selected' : ''}>실제 후원자</option>
                <option value="N" ${isDonor eq 'N' ? 'selected' : ''}>단순 가입자</option>
            </select>
            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="이름 또는 아이디/이메일 검색" value="${searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="submit" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="6%" class="text-white border-bottom border-secondary">연번</th>
                    <th width="10%" class="text-white border-bottom border-secondary">구분</th>
                    <th width="10%" class="text-white border-bottom border-secondary">회원유형</th>
                    <th class="text-white border-bottom border-secondary">성함(아이디)</th>
                    <th width="12%" class="text-white border-bottom border-secondary">연락처</th>
                    <th width="10%" class="text-white border-bottom border-secondary">누적후원건수</th>
                    <th width="12%" class="text-white border-bottom border-secondary">누적후원금액</th>
                    <th width="12%" class="text-white border-bottom border-secondary">가입일시</th>
                    <th width="10%" class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="9" class="py-5 text-muted border-secondary">조회된 가입자 내역이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary">${item.mbrSeq}</td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.isDonor eq 'Y'}"><span class="text-success fw-bold">후원자</span></c:when>
                                        <c:otherwise><span class="text-muted">일반가입</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.mbrType eq 'INDIVIDUAL'}"><span class="badge bg-secondary">개인</span></c:when>
                                        <c:otherwise><span class="badge bg-info">단체/기업</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-start border-secondary fw-bold text-white">
                                    ${item.mbrNm} <br>
                                    <span class="text-muted fw-normal" style="font-size: 12px;">(${item.mbrId})</span>
                                </td>
                                <td class="border-secondary">${item.phone}</td>
                                <td class="border-secondary fw-bold text-white"><fmt:formatNumber value="${item.totalDonateCnt}" pattern="#,###"/> 건</td>
                                <td class="border-secondary fw-bold" style="color: #ff99e2;"><fmt:formatNumber value="${item.totalDonateAmt}" pattern="#,###"/> 원</td>
                                <td class="border-secondary"><fmt:formatDate value="${item.joinDt}" pattern="yyyy-MM-dd" /></td>
                                <td class="border-secondary">
                                    <a href="/admin/sponsor/member/detail?mbrSeq=${item.mbrSeq}" class="btn btn-sm btn-outline-light">상세보기</a>
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