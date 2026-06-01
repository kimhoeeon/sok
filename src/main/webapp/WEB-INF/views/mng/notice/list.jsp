<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="notice" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">공지사항 관리</h3>
    <div>
        <button type="button" class="btn btn-success px-4 fw-bold me-2" onclick="downloadExcel()">
            <i class="bi bi-file-earmark-excel me-1"></i> 엑셀 다운로드
        </button>
        <a href="/mng/notice/form" class="btn btn-primary px-4"><i class="bi bi-pencil-square"></i> 등록</a>
    </div>
</div>

<div class="premium-card p-4">
    <form id="searchForm" action="/mng/notice/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 700px;">
            <select name="amount" class="form-select search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="searchType" class="form-select search-bar border-start-0" style="max-width: 120px;">
                <option value="all" ${params.searchType eq 'all' ? 'selected' : ''}>전체</option>
                <option value="title" ${params.searchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="content" ${params.searchType eq 'content' ? 'selected' : ''}>내용</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control search-bar border-start-0" placeholder="검색어 입력" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center mb-0" style="--bs-table-bg: #ffffff; --bs-table-color: #212529; --bs-table-hover-bg: rgba(0,0,0,0.02); border-top: 1px solid #dee2e6;">
            <thead style="background-color: #f8f9fa;">
                <tr>
                    <th width="8%" class="text-dark border-bottom py-3">연번</th>
                    <th width="8%" class="text-dark border-bottom py-3">중요</th>
                    <th class="text-dark border-bottom py-3">제목</th>
                    <th width="10%" class="text-dark border-bottom py-3">조회수</th>
                    <th width="15%" class="text-dark border-bottom py-3">등록일시</th>
                    <th width="15%" class="text-dark border-bottom py-3">관리</th>
                </tr>
            </thead>
            <tbody style="border-top: 2px solid #dee2e6;">
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" class="py-5 text-muted">조회된 데이터가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">

                            <c:url var="detailUrl" value="/mng/notice/form">
                                <c:param name="brdSeq" value="${item.brdSeq}" />
                                <c:param name="pageNum" value="${pageMaker.cri.pageNum}" />
                                <c:param name="amount" value="${pageMaker.cri.amount}" />
                                <c:param name="category" value="${params.category}" />
                                <c:param name="searchType" value="${params.searchType}" />
                                <c:param name="searchKeyword" value="${params.searchKeyword}" />
                            </c:url>

                            <tr>
                                <td>${item.brdSeq}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.isNotice eq 'Y'}"><i class="bi bi-star-fill text-warning"></i></c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-start">
                                    <a href="${detailUrl}" class="text-dark text-decoration-none fw-bold hover-glow">
                                        <c:if test="${item.isNotice eq 'Y'}"><span class="badge bg-danger me-1">중요</span></c:if>
                                        ${item.title}
                                    </a>
                                    <c:if test="${not empty item.fileList}"><i class="bi bi-paperclip text-muted ms-1"></i></c:if>
                                </td>
                                <td>${item.viewCnt}</td>
                                <td><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <a href="${detailUrl}" class="btn btn-sm btn-outline-secondary me-1">수정</a>
                                    <form action="/mng/notice/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제 후 복구가 어렵습니다. 정말 삭제하시겠습니까?');">
                                        <input type="hidden" name="brdSeq" value="${item.brdSeq}">
                                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                        <input type="hidden" name="category" value="${params.category}"> <input type="hidden" name="searchType" value="${params.searchType}">
                                        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>
                                    </form>
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
            <ul class="pagination pagination-custom m-0">
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

<%@ include file="../layout/footer.jsp" %>

<script>
    function goPage(pageNum) {
        document.getElementById('searchForm').pageNum.value = pageNum;
        document.getElementById('searchForm').submit();
    }
    function searchData() {
        document.getElementById('searchForm').pageNum.value = 1;
        document.getElementById('searchForm').submit();
    }
    // 엑셀 다운로드 함수 추가
    function downloadExcel() {
        var form = document.getElementById('searchForm');
        var originalAction = form.action;
        form.action = '/mng/notice/excel';
        form.submit();
        form.action = originalAction;
    }
</script>