<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="certificate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">증명서 발급 신청 관리</h3>
    <button type="button" class="btn btn-success px-4 fw-bold" onclick="downloadExcel()">
        <i class="bi bi-file-earmark-excel me-1"></i> 엑셀 다운로드
    </button>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/certificate/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 800px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="searchType" class="form-select dark-search-bar border-start-0" style="max-width: 140px;">
                <option value="">전체 증명서</option>
                <option value="선수등록" ${params.searchType eq '선수등록' ? 'selected' : ''}>선수등록</option>
                <option value="봉사활동" ${params.searchType eq '봉사활동' ? 'selected' : ''}>봉사활동</option>
                <option value="경기실적" ${params.searchType eq '경기실적' ? 'selected' : ''}>경기실적</option>
                <option value="대회참가" ${params.searchType eq '대회참가' ? 'selected' : ''}>대회참가</option>
            </select>

            <select name="searchStatus" class="form-select dark-search-bar border-start-0" style="max-width: 130px;">
                <option value="">전체 상태</option>
                <option value="WAIT" ${params.searchStatus eq 'WAIT' ? 'selected' : ''}>접수 대기</option>
                <option value="ING" ${params.searchStatus eq 'ING' ? 'selected' : ''}>발급 진행중</option>
                <option value="DONE" ${params.searchStatus eq 'DONE' ? 'selected' : ''}>발급 완료</option>
                <option value="REJECT" ${params.searchStatus eq 'REJECT' ? 'selected' : ''}>반려/거절</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="신청자명 또는 연락처 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="8%" class="text-white border-bottom border-secondary">신청번호</th>
                    <th width="15%" class="text-white border-bottom border-secondary">증명서 종류</th>
                    <th class="text-white border-bottom border-secondary">신청자 정보</th>
                    <th width="15%" class="text-white border-bottom border-secondary">신청일시</th>
                    <th width="12%" class="text-white border-bottom border-secondary">처리상태</th>
                    <th width="10%" class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr><td colspan="6" class="py-5 text-muted border-secondary">접수된 증명서 발급 신청이 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary">${item.certSeq}</td>
                                <td class="border-secondary"><span class="badge bg-secondary">${item.certType}</span></td>
                                <td class="text-start border-secondary">
                                    <span class="text-white fw-bold">${item.applyNm}</span>
                                    <span class="text-muted ms-2" style="font-size: 13px;">${item.phone}</span>
                                </td>
                                <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.issueStatus eq 'WAIT'}"><span class="badge bg-warning text-dark">접수 대기</span></c:when>
                                        <c:when test="${item.issueStatus eq 'ING'}"><span class="badge bg-primary">발급 진행중</span></c:when>
                                        <c:when test="${item.issueStatus eq 'DONE'}"><span class="badge bg-success">발급 완료</span></c:when>
                                        <c:when test="${item.issueStatus eq 'REJECT'}"><span class="badge bg-danger">반려/거절</span></c:when>
                                    </c:choose>
                                </td>
                                <td class="border-secondary">
                                    <a href="/admin/certificate/detail?certSeq=${item.certSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&searchType=${params.searchType}&searchStatus=${params.searchStatus}&searchKeyword=${params.searchKeyword}" class="btn btn-sm btn-outline-light">상세 확인</a>
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
                <c:if test="${pageMaker.prev}">
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.startPage - 1})"><i class="bi bi-chevron-left"></i></a></li>
                </c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                        <a class="page-link" href="javascript:goPage(${num})">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.endPage + 1})"><i class="bi bi-chevron-right"></i></a></li>
                </c:if>
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

    function downloadExcel() {
        var form = document.getElementById('searchForm');
        var originalAction = form.action;

        // action을 엑셀 다운로드용으로 변경 후 전송
        form.action = '/admin/certificate/excel';
        form.submit();

        // 전송 후 다시 원래 action으로 복구 (이후 일반 검색을 위해)
        form.action = originalAction;
    }
</script>
<%@ include file="../layout/footer.jsp" %>