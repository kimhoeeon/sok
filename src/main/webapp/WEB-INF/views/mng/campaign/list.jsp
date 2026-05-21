<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="sponsor_campaign" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">기부 캠페인 관리</h3>
    <a href="/mng/campaign/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-card p-4">
    <form id="searchForm" action="/mng/campaign/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">

        <div class="input-group shadow-sm" style="max-width: 700px;">
            <select name="searchUseYn" class="form-select search-bar" style="max-width: 150px;" onchange="searchData()">
                <option value="" ${empty params.searchUseYn ? 'selected' : ''}>노출 전체</option>
                <option value="Y" ${params.searchUseYn == 'Y' ? 'selected' : ''}>노출</option>
                <option value="N" ${params.searchUseYn == 'N' ? 'selected' : ''}>미노출</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control search-bar border-start-0" placeholder="캠페인 제목 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center mb-0" style="--bs-table-bg: #ffffff; --bs-table-color: #212529; --bs-table-hover-bg: rgba(0,0,0,0.02); border-top: 1px solid #dee2e6;">
            <thead style="background-color: #f8f9fa;">
                <tr>
                    <th class="text-dark border-bottom py-3">연번</th>
                    <th class="text-dark border-bottom py-3">썸네일</th>
                    <th class="text-dark border-bottom py-3">캠페인 제목</th>
                    <th class="text-dark border-bottom py-3">모금 기간</th>
                    <th class="text-dark border-bottom py-3">목표액</th>
                    <th class="text-dark border-bottom py-3">달성률</th>
                    <th class="text-dark border-bottom py-3">노출여부</th>
                    <th class="text-dark border-bottom py-3">등록일</th>
                </tr>
            </thead>
            <tbody style="border-top: 2px solid #dee2e6;">
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="8" class="py-5 text-muted">등록된 캠페인이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}" varStatus="status">

                            <c:url var="detailUrl" value="/mng/campaign/form">
                                <c:param name="campSeq" value="${item.campSeq}" />
                                <c:param name="pageNum" value="${pageMaker.cri.pageNum}" />
                                <c:param name="amount" value="${pageMaker.cri.amount}" />
                                <c:param name="searchKeyword" value="${params.searchKeyword}" />
                                <c:param name="searchUseYn" value="${params.searchUseYn}" />
                            </c:url>

                            <tr>
                                <td>${pageMaker.total - ((pageMaker.cri.pageNum - 1) * pageMaker.cri.amount) - status.index}</td>
                                <td>
                                    <c:if test="${not empty item.thumbPath}">
                                        <img src="${item.thumbPath}" alt="썸네일" style="width: 60px; height: 45px; object-fit: cover; border-radius: 4px;">
                                    </c:if>
                                    <c:if test="${empty item.thumbPath}">
                                        <span class="text-muted">-</span>
                                    </c:if>
                                </td>
                                <td class="text-start">
                                    <a href="${detailUrl}" class="text-dark text-decoration-none action-hover fw-bold">
                                        ${item.title}
                                    </a>
                                </td>
                                <td>
                                    <fmt:formatDate value="${item.startDt}" pattern="yyyy.MM.dd"/> ~
                                    <fmt:formatDate value="${item.endDt}" pattern="yyyy.MM.dd"/>
                                </td>
                                <td><fmt:formatNumber value="${item.goalAmt}" pattern="#,###"/>원</td>
                                <td>
                                    <span class="badge ${item.achievementRate >= 100 ? 'bg-success' : 'bg-primary'} bg-opacity-75">
                                        ${item.achievementRate}%
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${item.useYn == 'Y' ? 'bg-info' : 'bg-secondary'} bg-opacity-75 text-dark">
                                        ${item.useYn == 'Y' ? '노출' : '미노출'}
                                    </span>
                                </td>
                                <td><fmt:formatDate value="${item.regDt}" pattern="yyyy.MM.dd"/></td>
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
                    <li class="page-item">
                        <a class="page-link" href="javascript:goPage(${pageMaker.startPage - 1})">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                </c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                        <a class="page-link" href="javascript:goPage(${num})">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link" href="javascript:goPage(${pageMaker.endPage + 1})">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
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