<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="home" scope="request" />
<c:set var="currentMenu" value="popup" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">팝업 ${empty popup.popSeq ? '등록' : '상세/수정'}</h3>
    <a href="/admin/popup/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/popup/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="popSeq" value="${popup.popSeq}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-12 mb-3">
                <label class="form-label text-muted">팝업 제목</label>
                <input type="text" name="title" class="form-control dark-search-bar" value="${popup.title}" required placeholder="팝업 제목을 입력하세요">
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">게시 시작 일시</label>
                <input type="datetime-local" name="startDt" class="form-control dark-search-bar"
                       value="<fmt:formatDate value='${popup.startDt}' pattern='yyyy-MM-dd\"T\"HH:mm'/>" required>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">게시 종료 일시</label>
                <input type="datetime-local" name="endDt" class="form-control dark-search-bar"
                       value="<fmt:formatDate value='${popup.endDt}' pattern='yyyy-MM-dd\"T\"HH:mm'/>" required>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">팝업 이미지 등록</label>
                <input type="file" name="uploadFile" class="form-control dark-search-bar" accept="image/*">

                <c:if test="${not empty popup.popupImage}">
                    <div class="mt-3 p-3 border rounded" style="border-color: #474761 !important; background-color: #151521;">
                        <span class="text-white d-block mb-2"><i class="bi bi-image"></i> 현재 등록된 이미지: ${popup.popupImage.orgFileNm}</span>
                        <img src="${popup.popupImage.filePath}" alt="팝업 이미지" style="max-width: 100%; height: auto; border-radius: 8px;">
                    </div>
                </c:if>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">사용(노출) 여부</label>
                <div class="form-check form-switch mt-2">
                    <input class="form-check-input" type="checkbox" role="switch" id="useYn" name="useYn" value="Y" ${popup.useYn eq 'Y' ? 'checked' : ''}>
                    <label class="form-check-label text-white" for="useYn">활성화 시 홈페이지 메인에 팝업이 노출됩니다.</label>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-neon px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>