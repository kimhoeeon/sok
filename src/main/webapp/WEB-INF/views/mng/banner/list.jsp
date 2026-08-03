<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="currentMenu" value="banner" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">메인 배너 관리</h3>
    <a href="/mng/banner/form" class="btn btn-primary px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-card p-4">
    <form id="searchForm" action="/mng/banner/list" method="get" class="d-flex justify-content-between mb-4">
        <!-- 페이징 유지를 위한 hidden 파라미터 -->
        <input type="hidden" name="pageNum" value="${params.pageNum != null ? params.pageNum : 1}">

        <!-- 노출 순서 안내 문구 -->
        <div class="text-muted d-flex align-items-center">
            <i class="bi bi-info-circle me-2"></i> 노출 순서(숫자)가 낮을수록 프론트 메인 배너의 앞쪽에(먼저) 배치됩니다.
        </div>

        <div class="input-group shadow-sm" style="max-width: 600px;">
            <!-- 목록 개수 선택 -->
            <select name="amount" class="form-select search-bar" style="max-width: 90px;" onchange="searchData()">
                <option value="10" ${params.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${params.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${params.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <!-- 활성화 상태 검색 -->
            <select name="isActive" class="form-select search-bar border-start-0" style="max-width: 120px;" onchange="searchData()">
                <option value="">상태 전체</option>
                <option value="Y" ${params.isActive eq 'Y' ? 'selected' : ''}>활성 (Y)</option>
                <option value="N" ${params.isActive eq 'N' ? 'selected' : ''}>비활성 (N)</option>
            </select>

            <!-- 키워드 검색 -->
            <input type="text" name="keyword" class="form-control search-bar border-start-0" placeholder="배너 제목 검색" value="${params.keyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center mb-0" style="--bs-table-bg: #ffffff; --bs-table-color: #212529; --bs-table-hover-bg: rgba(0,0,0,0.02); border-top: 1px solid #dee2e6;">
            <thead style="background-color: #f8f9fa;">
                <tr>
                    <th width="8%" class="text-dark border-bottom py-3">노출 순서</th>
                    <th width="15%" class="text-dark border-bottom py-3">이미지 (미리보기)</th>
                    <th class="text-dark border-bottom py-3">배너 제목 / 링크</th>
                    <th width="10%" class="text-dark border-bottom py-3">상태</th>
                    <th width="15%" class="text-dark border-bottom py-3">등록일시</th>
                    <th width="15%" class="text-dark border-bottom py-3">관리</th>
                </tr>
            </thead>
            <tbody style="border-top: 2px solid #dee2e6;">
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="6" class="py-5 text-muted">등록된 배너가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td><span class="badge bg-dark fs-6">${item.displayOrder}</span></td>
                                <td>
                                    <!-- 기존 FileController의 /img 매핑을 활용한 미리보기 -->
                                    <div style="width: 120px; height: 60px; background-color: #f8f9fa; border-radius: 4px; overflow: hidden; margin: 0 auto; border: 1px solid #dee2e6;">
                                        <img src="/file/img?type=banner&filename=${item.fileName}" alt="배너 이미지" style="width: 100%; height: 100%; object-fit: cover;">
                                    </div>
                                </td>
                                <td class="text-start">
                                    <div class="fw-bold text-dark mb-1" style="font-size: 15px;">${item.title}</div>
                                    <div class="text-muted" style="font-size: 12px;">
                                        <i class="bi bi-link-45deg"></i>
                                        <c:choose>
                                            <c:when test="${empty item.linkUrl}">링크 없음</c:when>
                                            <c:otherwise>
                                                <a href="${item.linkUrl}" target="_blank" class="text-primary text-decoration-none">${item.linkUrl}</a>
                                                <span class="badge bg-light text-secondary ms-1 border">${item.targetType eq '_blank' ? '새창' : '현재창'}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.isActive eq 'Y'}"><span class="badge bg-success">노출중</span></c:when>
                                        <c:otherwise><span class="badge bg-danger">숨김</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <a href="/mng/banner/form?seq=${item.seq}&pageNum=${params.pageNum}&amount=${params.amount}&isActive=${params.isActive}&keyword=${params.keyword}" class="btn btn-sm btn-outline-secondary me-1">수정</a>
                                    <form action="/mng/banner/delete" method="post" style="display:inline;" onsubmit="return confirm('정말 이 배너를 삭제하시겠습니까?');">
                                        <input type="hidden" name="seq" value="${item.seq}">
                                        <input type="hidden" name="pageNum" value="${params.pageNum}">
                                        <input type="hidden" name="amount" value="${params.amount}">
                                        <input type="hidden" name="isActive" value="${params.isActive}">
                                        <input type="hidden" name="keyword" value="${params.keyword}">
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

    <!-- 페이징 처리 영역 -->
    <c:if test="${pageMaker.total > 0}">
        <div class="d-flex justify-content-center mt-5">
            <ul class="pagination pagination-custom m-0">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${pageMaker.startPage - 1})"><i class="bi bi-chevron-left"></i></a></li>
                </c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${params.pageNum == num ? 'active' : ''}">
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