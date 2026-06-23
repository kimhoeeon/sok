<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="currentMenu" value="report" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">활동보고서 관리</h3>
    <a href="/mng/report/form" class="btn btn-primary px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-card p-4">
    <form id="searchForm" action="/mng/report/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="amount" class="form-select search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="category" class="form-select search-bar border-start-0" style="max-width: 150px;">
                <option value="">전체 분류</option>
                <option value="연차보고서" ${params.category eq '연차보고서' ? 'selected' : ''}>연차보고서</option>
                <option value="사업보고서" ${params.category eq '사업보고서' ? 'selected' : ''}>사업보고서</option>
                <option value="기타자료" ${params.category eq '기타자료' ? 'selected' : ''}>기타자료</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control search-bar border-start-0" placeholder="보고서 제목 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <c:set var="startNum" value="${pageMaker.total - ((pageMaker.cri.pageNum - 1) * pageMaker.cri.amount)}" />

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center mb-0" style="--bs-table-bg: #ffffff; --bs-table-color: #212529; --bs-table-hover-bg: rgba(0,0,0,0.02); border-top: 1px solid #dee2e6;">
            <thead style="background-color: #f8f9fa;">
                <tr>
                    <th width="8%" class="text-dark border-bottom py-3">연번</th>
                    <th width="15%" class="text-dark border-bottom py-3">분류</th>
                    <th class="text-dark border-bottom py-3">보고서 제목</th>
                    <th width="10%" class="text-dark border-bottom py-3">조회수</th>
                    <th width="15%" class="text-dark border-bottom py-3">등록일시</th>
                    <th width="15%" class="text-dark border-bottom py-3">관리</th>
                </tr>
            </thead>
            <tbody style="border-top: 2px solid #dee2e6;">
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" class="py-5 text-muted">등록된 활동보고서가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}" varStatus="st">

                            <c:url var="detailUrl" value="/mng/report/form">
                                <c:param name="brdSeq" value="${item.brdSeq}" />
                                <c:param name="pageNum" value="${pageMaker.cri.pageNum}" />
                                <c:param name="amount" value="${pageMaker.cri.amount}" />
                                <c:param name="category" value="${params.category}" />
                                <c:param name="searchKeyword" value="${params.searchKeyword}" />
                            </c:url>

                            <tr>
                                <td>${startNum - st.index}</td>
                                <td><span class="badge bg-secondary">${item.category}</span></td>
                                <td class="text-start">
                                    <a href="${detailUrl}" class="text-dark text-decoration-none fw-bold hover-glow">
                                        ${item.title}
                                    </a>
                                </td>
                                <td>${item.viewCnt}</td>
                                <td><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <a href="${detailUrl}" class="btn btn-sm btn-outline-secondary me-1">수정</a>
                                    <form action="/mng/report/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제하시겠습니까?');">
                                        <input type="hidden" name="brdSeq" value="${item.brdSeq}">
                                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                        <input type="hidden" name="category" value="${params.category}">
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
</script>