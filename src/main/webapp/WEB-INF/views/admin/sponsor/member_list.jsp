<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="member" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">후원자(회원) 관리</h3>
    <button type="button" class="btn btn-success px-4 fw-bold" onclick="downloadExcel()">
        <i class="bi bi-file-earmark-excel me-1"></i> 엑셀 다운로드
    </button>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/sponsor/member/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 700px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="mbrType" class="form-select dark-search-bar border-start-0" style="max-width: 120px;">
                <option value="">회원구분</option>
                <option value="INDIVIDUAL" ${params.mbrType eq 'INDIVIDUAL' ? 'selected' : ''}>개인</option>
                <option value="CORP" ${params.mbrType eq 'CORP' ? 'selected' : ''}>기업/단체</option>
            </select>
            <select name="isDonor" class="form-select dark-search-bar border-start-0" style="max-width: 130px;">
                <option value="">후원이력</option>
                <option value="Y" ${params.isDonor eq 'Y' ? 'selected' : ''}>후원자 (Y)</option>
                <option value="N" ${params.isDonor eq 'N' ? 'selected' : ''}>일반회원 (N)</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="이름, 아이디, 이메일 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="8%">No.</th>
                    <th width="10%">회원구분</th>
                    <th class="text-start">회원명 (아이디)</th>
                    <th width="15%">연락처</th>
                    <th width="12%">가입일</th>
                    <th width="12%">누적 기부횟수</th>
                    <th width="15%">누적 기부금액</th>
                    <th width="10%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr><td colspan="8" class="py-5 text-muted">등록된 회원이 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.mbrSeq}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.mbrType eq 'INDIVIDUAL'}"><span class="badge bg-secondary">개인</span></c:when>
                                        <c:when test="${item.mbrType eq 'CORP'}"><span class="badge bg-primary">기업/단체</span></c:when>
                                    </c:choose>
                                </td>
                                <td class="text-start">
                                    <a href="/admin/sponsor/member/detail?mbrSeq=${item.mbrSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&mbrType=${params.mbrType}&isDonor=${params.isDonor}&searchKeyword=${params.searchKeyword}" class="text-white text-decoration-none fw-bold hover-glow">
                                        ${item.mbrNm} <span class="text-muted fw-normal ms-1">(${item.mbrId})</span>
                                    </a>
                                    <c:if test="${item.isDonor eq 'Y'}"><i class="bi bi-heart-fill text-danger ms-1" style="font-size: 12px;"></i></c:if>
                                </td>
                                <td class="text-muted" style="font-size: 13px;">${not empty item.phone ? item.phone : '-'}</td>
                                <td class="text-muted"><fmt:formatDate value="${item.joinDt}" pattern="yyyy-MM-dd" /></td>
                                <td class="fw-bold">${item.totalDonateCnt} 회</td>
                                <td class="text-success fw-bold"><fmt:formatNumber value="${item.totalDonateAmt}" pattern="#,###" /> 원</td>
                                <td>
                                    <a href="/admin/sponsor/member/detail?mbrSeq=${item.mbrSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&mbrType=${params.mbrType}&isDonor=${params.isDonor}&searchKeyword=${params.searchKeyword}" class="btn btn-sm btn-outline-light">상세보기</a>
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

    // ★ [엑셀 다운로드 함수 추가]
    function downloadExcel() {
        var form = document.getElementById('searchForm');
        var originalAction = form.action;
        form.action = '/admin/sponsor/member/excel';
        form.submit();
        form.action = originalAction;
    }
</script>
<%@ include file="../layout/footer.jsp" %>