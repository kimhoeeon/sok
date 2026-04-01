<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="currentMenu" value="volunteer" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">자원봉사 관리</h3>
    <button type="button" class="btn btn-success px-4 fw-bold" onclick="downloadExcel()">
        <i class="bi bi-file-earmark-excel me-1"></i> 엑셀 다운로드
    </button>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/volunteer/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="searchSupportArea" class="form-select dark-search-bar border-start-0" style="max-width: 150px;">
                <option value="">전체 지원분야</option>
                <option value="스포츠" ${params.searchSupportArea eq '스포츠' ? 'selected' : ''}>스포츠</option>
                <option value="문화예술" ${params.searchSupportArea eq '문화예술' ? 'selected' : ''}>문화예술</option>
                <option value="기타" ${params.searchSupportArea eq '기타' ? 'selected' : ''}>기타</option>
            </select>
            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="신청자명 또는 행사명 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
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
                                    <a href="/admin/volunteer/detail?volSeq=${item.volSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&searchSupportArea=${params.searchSupportArea}&searchKeyword=${params.searchKeyword}" class="btn btn-sm btn-outline-light">상세보기</a>
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

    // ★ [엑셀 다운로드 함수 추가]
    function downloadExcel() {
        var form = document.getElementById('searchForm');
        var originalAction = form.action;
        form.action = '/admin/volunteer/excel';
        form.submit();
        form.action = originalAction;
    }
</script>

<%@ include file="../layout/footer.jsp" %>