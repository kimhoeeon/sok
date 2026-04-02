<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="bidding" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">입찰정보 관리</h3>
    <a href="/admin/bidding/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/bidding/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="category" class="form-select dark-search-bar border-start-0" style="max-width: 150px;">
                <option value="">전체 상태</option>
                <option value="진행중" ${params.category eq '진행중' ? 'selected' : ''}>진행중</option>
                <option value="마감" ${params.category eq '마감' ? 'selected' : ''}>마감</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="공고명 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="8%" class="text-white border-bottom border-secondary">연번</th>
                    <th width="12%" class="text-white border-bottom border-secondary">진행상태</th>
                    <th class="text-white border-bottom border-secondary">입찰 공고명</th>
                    <th width="10%" class="text-white border-bottom border-secondary">조회수</th>
                    <th width="15%" class="text-white border-bottom border-secondary">등록일시</th>
                    <th width="15%" class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" class="py-5 text-muted border-secondary">등록된 입찰 공고가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary">${item.brdSeq}</td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.category eq '진행중'}">
                                            <span class="badge bg-success px-3 py-2">진행중</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary px-3 py-2">마감</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-start border-secondary">
                                    <a href="/admin/bidding/form?brdSeq=${item.brdSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="text-white text-decoration-none fw-bold hover-glow">
                                        ${item.title}
                                    </a>
                                </td>
                                <td class="border-secondary">${item.viewCnt}</td>
                                <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td class="border-secondary">
                                    <a href="/admin/bidding/form?brdSeq=${item.brdSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="btn btn-sm btn-outline-light me-1">수정</a>
                                    <form action="/admin/bidding/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제하시겠습니까?');">
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
</script>

<%@ include file="../layout/footer.jsp" %>