<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="people" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">함께하는 사람들 관리</h3>
    <a href="/admin/people/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/people/list" method="get" class="d-flex justify-content-end mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <select name="category" class="form-select dark-search-bar border-start-0" style="max-width: 150px;">
                <option value="">전체 분류</option>
                <option value="선수" ${params.category eq '선수' ? 'selected' : ''}>선수</option>
                <option value="아티스트" ${params.category eq '아티스트' ? 'selected' : ''}>아티스트</option>
                <option value="패밀리" ${params.category eq '패밀리' ? 'selected' : ''}>패밀리</option>
                <option value="프렌즈" ${params.category eq '프렌즈' ? 'selected' : ''}>프렌즈</option>
                <option value="스폰서" ${params.category eq '스폰서' ? 'selected' : ''}>스폰서</option>
                <option value="소식" ${params.category eq '소식' ? 'selected' : ''}>소식</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="이름 또는 직책 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
            <tr>
                <th width="8%" class="text-white border-bottom border-secondary">연번</th>
                <th width="15%" class="text-white border-bottom border-secondary">분류</th>
                <th class="text-white border-bottom border-secondary">이름 / 직책 (타이틀)</th>
                <th width="10%" class="text-white border-bottom border-secondary">조회수</th>
                <th width="15%" class="text-white border-bottom border-secondary">등록일시</th>
                <th width="15%" class="text-white border-bottom border-secondary">관리</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty list}">
                    <tr>
                        <td colspan="6" class="py-5 text-muted border-secondary">등록된 인물이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${list}">
                        <tr>
                            <td class="border-secondary">${item.brdSeq}</td>
                            <td class="border-secondary"><span class="badge bg-secondary">${item.category}</span></td>
                            <td class="text-start border-secondary">
                                <a href="/admin/people/form?brdSeq=${item.brdSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="text-white text-decoration-none fw-bold hover-glow">
                                    <c:if test="${item.isNotice eq 'Y'}"><span class="badge bg-danger me-1">메인</span></c:if>
                                        ${item.title}
                                </a>
                            </td>
                            <td class="border-secondary">${item.viewCnt}</td>
                            <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                            <td class="border-secondary">
                                <a href="/admin/people/form?brdSeq=${item.brdSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="btn btn-sm btn-outline-light me-1">수정</a>
                                <form action="/admin/people/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제하시겠습니까?');">
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