<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="currentMenu" value="volunteer" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">자원봉사 관리</h3>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/volunteer/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group shadow-sm" style="max-width: 500px;">
            <select name="searchSupportArea" class="form-select dark-search-bar" style="max-width: 150px;">
                <option value="">전체 지원분야</option>
                <option value="스포츠" ${searchSupportArea eq '스포츠' ? 'selected' : ''}>스포츠</option>
                <option value="문화예술" ${searchSupportArea eq '문화예술' ? 'selected' : ''}>문화예술</option>
                <option value="기타" ${searchSupportArea eq '기타' ? 'selected' : ''}>기타</option>
            </select>
            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="신청자명 또는 행사명 검색" value="${searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="submit" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="8%" class="text-white border-bottom border-secondary">연번</th>
                    <th width="12%" class="text-white border-bottom border-secondary">지원분야</th>
                    <th class="text-white border-bottom border-secondary">신청 행사명</th>
                    <th width="12%" class="text-white border-bottom border-secondary">신청자(단체)명</th>
                    <th width="10%" class="text-white border-bottom border-secondary">인원</th>
                    <th width="10%" class="text-white border-bottom border-secondary">빈도</th>
                    <th width="15%" class="text-white border-bottom border-secondary">신청일시</th>
                    <th width="10%" class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="8" class="py-5 text-muted border-secondary">등록된 자원봉사 신청 내역이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary">${item.volSeq}</td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.supportArea eq '스포츠'}"><span class="badge bg-primary">스포츠</span></c:when>
                                        <c:when test="${item.supportArea eq '문화예술'}"><span class="badge bg-info text-dark">문화예술</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary">기타</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-start border-secondary fw-bold text-white">${item.eventNm}</td>
                                <td class="border-secondary text-white">${item.applyNm}</td>
                                <td class="border-secondary fw-bold">${item.applyCnt}명</td>
                                <td class="border-secondary">
                                    ${item.freqType eq 'ONCE' ? '<span class="text-muted">1회용</span>' : '<span class="text-success fw-bold">정기/수시</span>'}
                                </td>
                                <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td class="border-secondary">
                                    <a href="/admin/volunteer/detail?volSeq=${item.volSeq}" class="btn btn-sm btn-outline-light">상세보기</a>
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