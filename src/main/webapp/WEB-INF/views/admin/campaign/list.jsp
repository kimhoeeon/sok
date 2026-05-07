<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="sponsor_campaign" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">기부 캠페인 관리</h3>
    <a href="/admin/campaign/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/campaign/list" method="get" class="d-flex justify-content-between mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">

        <div class="d-flex gap-2">
            <select name="searchUseYn" class="form-select dark-search-bar" style="width: 150px;"
                    onchange="searchData()">
                <option value="" ${empty params.searchUseYn ? 'selected' : ''}>노출 전체</option>
                <option value="Y" ${params.searchUseYn == 'Y' ? 'selected' : ''}>노출</option>
                <option value="N" ${params.searchUseYn == 'N' ? 'selected' : ''}>미노출</option>
            </select>
        </div>

        <div class="input-group shadow-sm" style="max-width: 400px;">
            <input type="text" name="searchKeyword" class="form-control dark-search-bar" placeholder="캠페인 제목 검색"
                   value="${params.searchKeyword}" onkeypress="if(event.keyCode==13) searchData();">
            <button class="btn btn-neon" type="button" onclick="searchData()"><i class="bi bi-search"></i></button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-dark-custom text-center align-middle">
            <thead>
            <tr>
                <th>연번</th>
                <th>썸네일</th>
                <th>캠페인 제목</th>
                <th>모금 기간</th>
                <th>목표액</th>
                <th>달성률</th>
                <th>노출여부</th>
                <th>등록일</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty list}">
                    <tr>
                        <td colspan="8" class="py-5 text-muted">등록된 캠페인이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="c" items="${list}" varStatus="status">
                        <tr>
                            <td>${pageMaker.total - ((pageMaker.cri.pageNum - 1) * pageMaker.cri.amount) - status.index}</td>
                            <td>
                                <c:if test="${not empty c.thumbPath}">
                                    <img src="${c.thumbPath}" alt="썸네일"
                                         style="width: 60px; height: 45px; object-fit: cover; border-radius: 4px;">
                                </c:if>
                                <c:if test="${empty c.thumbPath}">
                                    <span class="text-muted">-</span>
                                </c:if>
                            </td>
                            <td class="text-start">
                                <a href="/admin/campaign/form?campSeq=${c.campSeq}&pageNum=${params.pageNum}&amount=${params.amount}&searchKeyword=${params.searchKeyword}&searchUseYn=${params.searchUseYn}"
                                   class="text-white text-decoration-none action-hover fw-bold">
                                        ${c.title}
                                </a>
                            </td>
                            <td>
                                <fmt:formatDate value="${c.startDt}" pattern="yyyy.MM.dd"/> ~
                                <fmt:formatDate value="${c.endDt}" pattern="yyyy.MM.dd"/>
                            </td>
                            <td><fmt:formatNumber value="${c.goalAmt}" pattern="#,###"/>원</td>
                            <td>
                                    <span class="badge ${c.achievementRate >= 100 ? 'bg-success' : 'bg-primary'} bg-opacity-75">
                                        ${c.achievementRate}%
                                    </span>
                            </td>
                            <td>
                                    <span class="badge ${c.useYn == 'Y' ? 'bg-info' : 'bg-secondary'} bg-opacity-75 text-dark">
                                            ${c.useYn == 'Y' ? '노출' : '미노출'}
                                    </span>
                            </td>
                            <td><fmt:formatDate value="${c.regDt}" pattern="yyyy.MM.dd"/></td>
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
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.startPage - 1})"><i
                            class="bi bi-chevron-left"></i></a></li>
                </c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                        <a class="page-link" href="javascript:goPage(${num})">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.endPage + 1})"><i
                            class="bi bi-chevron-right"></i></a></li>
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