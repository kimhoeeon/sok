<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="home" scope="request" />
<c:set var="currentMenu" value="popup" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">팝업 관리</h3>
    <a href="/admin/popup/form" class="btn btn-neon px-4"><i class="bi bi-plus-lg"></i> 새 팝업 등록</a>
</div>

<div class="premium-dark-card p-4">
    <form id="searchForm" action="/admin/popup/list" method="get" class="d-flex justify-content-end align-items-center mb-4">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

        <div class="form-check form-check-inline me-3 mb-0">
            <input class="form-check-input" type="checkbox" id="searchUseYnOnly" name="searchUseYnOnly" value="Y" ${params.searchUseYnOnly eq 'Y' ? 'checked' : ''} onchange="searchData()" style="cursor: pointer; border-color: #474761;">
            <label class="form-check-label text-white" for="searchUseYnOnly" style="cursor: pointer; font-size: 14px;">사용 팝업만 보기</label>
        </div>

        <div class="input-group shadow-sm" style="max-width: 450px;">
            <select name="amount" class="form-select dark-search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="팝업 제목 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="5%">연번</th>
                    <th width="12%">썸네일</th>
                    <th>팝업 제목</th>
                    <th width="22%">게시 기간</th>
                    <th width="10%">진행상태</th>
                    <th width="10%">사용여부</th>
                    <th width="12%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr><td colspan="7" class="py-5 text-muted border-secondary">등록된 팝업 내역이 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td>${item.popSeq}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.popupImage}">
                                            <img src="${item.popupImage.filePath}" style="width: 80px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #474761;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-muted" style="font-size: 11px;">이미지 없음</div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-start">
                                    <a href="/admin/popup/form?popSeq=${item.popSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&searchKeyword=${params.searchKeyword}&searchUseYnOnly=${params.searchUseYnOnly}" class="fw-bold text-white text-decoration-none hover-glow">
                                        ${item.title}
                                    </a>
                                </td>

                                <td class="text-muted" style="font-size: 13px;">
                                    <fmt:formatDate value="${item.startDt}" pattern="yyyy-MM-dd HH:mm" /><br>
                                    ~ <fmt:formatDate value="${item.endDt}" pattern="yyyy-MM-dd HH:mm" />
                                </td>

                                <td>
                                    <c:set var="status" value="${item.displayStatus}" />
                                    <c:choose>
                                        <c:when test="${status eq '게시중'}"><span class="badge bg-success">게시중</span></c:when>
                                        <c:when test="${status eq '게시예정'}"><span class="badge bg-primary">게시예정</span></c:when>
                                        <c:when test="${status eq '게시종료'}"><span class="badge bg-danger">게시종료</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary">사용안함</span></c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${item.useYn eq 'Y'}"><span class="text-success fw-bold">Y</span></c:when>
                                        <c:otherwise><span class="text-muted">N</span></c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <a href="/admin/popup/form?popSeq=${item.popSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&searchKeyword=${params.searchKeyword}&searchUseYnOnly=${params.searchUseYnOnly}" class="btn btn-sm btn-outline-light me-1">수정</a>
                                    <form action="/admin/popup/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제하시겠습니까?');">
                                        <input type="hidden" name="popSeq" value="${item.popSeq}">
                                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">
                                        <input type="hidden" name="searchUseYnOnly" value="${params.searchUseYnOnly}">
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