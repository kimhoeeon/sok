<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="home" scope="request" />
<c:set var="currentMenu" value="popup" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">팝업 상세 설정</h3>
    <a href="/admin/popup/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="premium-dark-card p-5">
            <form action="/admin/popup/save" method="post" enctype="multipart/form-data" onsubmit="return validatePopup()">
                <input type="hidden" name="popSeq" value="${popup.popSeq}">

                <div class="row g-4">
                    <div class="col-md-8">
                        <div class="mb-4">
                            <label class="form-label text-muted">팝업 제목</label>
                            <input type="text" name="title" class="form-control dark-search-bar fs-5 fw-bold" value="${popup.title}" required placeholder="관리용 제목을 입력하세요">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label text-muted">게시 시작 일시</label>
                                <input type="datetime-local" name="startDt" id="startDt" class="form-control dark-search-bar"
                                       value="<fmt:formatDate value='${popup.startDt}' pattern='yyyy-MM-dd\"T\"HH:mm'/>" required>
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label text-muted">게시 종료 일시</label>
                                <input type="datetime-local" name="endDt" id="endDt" class="form-control dark-search-bar"
                                       value="<fmt:formatDate value='${popup.endDt}' pattern='yyyy-MM-dd\"T\"HH:mm'/>" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-muted">노출 여부 설정</label>
                            <div class="form-check form-switch mt-2">
                                <input class="form-check-input" type="checkbox" role="switch" id="useYn" name="useYn" value="Y" ${popup.useYn eq 'Y' ? 'checked' : ''}>
                                <label class="form-check-label text-white" for="useYn">활성화 시 설정된 기간 동안 메인 화면에 팝업이 노출됩니다.</label>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="p-3 rounded border border-secondary text-center" style="background: rgba(0,0,0,0.2);">
                            <label class="form-label text-muted d-block text-start mb-3">팝업 이미지 (이미지 파일 전용)</label>

                            <div class="mb-3">
                                <c:choose>
                                    <c:when test="${not empty popup.popupImage}">
                                        <img id="imgPreview" src="${popup.popupImage.filePath}" class="img-fluid rounded border border-secondary shadow">
                                    </c:when>
                                    <c:otherwise>
                                        <div id="noImg" class="py-5 bg-dark rounded text-muted">
                                            <i class="bi bi-image fs-1 d-block mb-2"></i>
                                            이미지 미리보기
                                        </div>
                                        <img id="imgPreview" class="img-fluid rounded border border-secondary shadow" style="display:none;">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <input type="file" name="uploadFile" id="uploadFile" class="form-control dark-search-bar form-control-sm" accept="image/*" onchange="previewImage(this)">
                        </div>
                    </div>
                </div>

                <div class="text-center mt-5">
                    <button type="submit" class="btn btn-neon px-5 py-3 fs-5">팝업 설정 저장하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 이미지 미리보기
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('#noImg').hide();
                $('#imgPreview').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    // 날짜 유효성 검사
    function validatePopup() {
        const start = new Date($('#startDt').val());
        const end = new Date($('#endDt').val());

        if (start >= end) {
            alert('종료 일시는 시작 일시보다 늦어야 합니다.');
            return false;
        }
        return true;
    }
</script>

<%@ include file="../layout/footer.jsp" %>