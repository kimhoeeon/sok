<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="home" scope="request" />
<c:set var="currentMenu" value="popup" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">팝업 관리 (고도화)</h3>
    <a href="/admin/popup/form" class="btn btn-neon px-4"><i class="bi bi-plus-lg"></i> 새 팝업 등록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/popup/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group w-50">
            <input type="text" name="title" class="form-control dark-search-bar" placeholder="팝업 제목 검색" value="${searchTitle}">
            <button class="btn btn-secondary" type="submit">검색</button>
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
                        <td class="text-start fw-bold text-white">${item.title}</td>
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
                            <a href="/admin/popup/form?popSeq=${item.popSeq}" class="btn btn-sm btn-outline-light me-1">수정</a>
                            <form action="/admin/popup/delete" method="post" style="display:inline;" onsubmit="return confirm('삭제하시겠습니까?');">
                                <input type="hidden" name="popSeq" value="${item.popSeq}">
                                <button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>