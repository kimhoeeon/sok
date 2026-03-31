<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="menu" scope="request" /> <c:set var="currentMenu" value="notice" scope="request" /> <%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">공지사항 관리</h3>
    <a href="/admin/notice/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 등록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/notice/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group w-50 shadow-sm">
            <input type="text" name="title" class="form-control dark-search-bar" placeholder="검색할 제목을 입력하세요" value="${searchTitle}">
            <button class="btn btn-secondary" type="submit" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="8%" class="text-white border-bottom border-secondary">연번</th>
                    <th width="12%" class="text-white border-bottom border-secondary">카테고리</th>
                    <th width="8%" class="text-white border-bottom border-secondary">중요</th>
                    <th class="text-white border-bottom border-secondary">제목</th>
                    <th width="10%" class="text-white border-bottom border-secondary">조회수</th>
                    <th width="15%" class="text-white border-bottom border-secondary">등록일시</th>
                    <th width="15%" class="text-white border-bottom border-secondary">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="7" class="py-5 text-muted border-secondary">조회된 데이터가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary">${item.brdSeq}</td>
                                <td class="border-secondary"><span class="badge bg-secondary">${item.category}</span></td>
                                <td class="border-secondary">
                                    <c:if test="${item.isNotice eq 'Y'}"><i class="bi bi-star-fill text-warning"></i></c:if>
                                </td>
                                <td class="text-start border-secondary">
                                    <a href="/admin/notice/form?brdSeq=${item.brdSeq}" class="text-white text-decoration-none fw-bold">${item.title}</a>
                                </td>
                                <td class="border-secondary">${item.viewCnt}</td>
                                <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                                <td class="border-secondary">
                                    <a href="/admin/notice/form?brdSeq=${item.brdSeq}" class="btn btn-sm btn-outline-light me-1">수정</a>
                                    <form action="/admin/notice/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제 후 복구가 어렵습니다. 정말 삭제하시겠습니까?');">
                                        <input type="hidden" name="brdSeq" value="${item.brdSeq}">
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
</div>

<%@ include file="../layout/footer.jsp" %>