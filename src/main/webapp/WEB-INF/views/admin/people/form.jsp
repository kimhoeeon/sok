<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuGroup" value="menu" scope="request" />
<c:set var="currentMenu" value="people" scope="request" />
<%@ include file="../layout/header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<style>
    .note-editor.note-frame { border: 1px solid #474761 !important; }
    .note-editing-area .note-editable { background-color: #151521; color: #fff; font-size: 14px; }
    .note-toolbar { background-color: #1e1e2d !important; border-bottom: 1px solid #474761 !important; }
    .note-btn { color: #fff !important; background-color: #2b2b40 !important; border-color: #474761 !important; }
    .note-btn:hover { background-color: #e61938 !important; color: #fff !important; } /* SOK 레드 호버 */
    .note-modal-content { background-color: #1e1e2d; color: #fff; border: 1px solid #474761; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">함께하는 사람들 ${empty people.brdSeq ? '등록' : '수정'}</h3>
    <a href="/admin/people/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/people/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${people.brdSeq}">

        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">인물 분류</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="임원진" id="cat1" ${people.category eq '임원진' or empty people.category ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat1">임원진</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="홍보대사" id="cat2" ${people.category eq '홍보대사' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat2">홍보대사</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="스포츠선수" id="cat3" ${people.category eq '스포츠선수' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat3">스포츠선수</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="문화예술인" id="cat4" ${people.category eq '문화예술인' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat4">문화예술인</label>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">홈페이지 메인 노출 여부</label>
                <div class="form-check form-switch mt-2">
                    <input class="form-check-input" type="checkbox" role="switch" id="isNotice" name="isNotice" value="Y" ${people.isNotice eq 'Y' ? 'checked' : ''}>
                    <label class="form-check-label text-white" for="isNotice">활성화 시 메인 화면에 우선 노출됩니다.</label>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">이름 및 직책 (타이틀)</label>
                <input type="text" name="title" class="form-control dark-search-bar" value="${people.title}" required placeholder="예) 김연아 / 스페셜올림픽코리아 홍보대사">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">프로필 이미지 등록 (다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control dark-search-bar" multiple accept="image/*">

                <c:if test="${not empty people.fileList}">
                    <div class="mt-3 p-3 border rounded d-flex flex-wrap gap-3" style="border-color: #474761 !important; background-color: #151521;">
                        <c:forEach var="file" items="${people.fileList}">
                            <div class="text-center">
                                <img src="${file.filePath}" alt="프로필" style="width: 100px; height: 100px; object-fit: cover; border-radius: 8px; border: 1px solid #474761;">
                                <span class="d-block text-muted mt-1" style="font-size: 11px;">${file.orgFileNm}</span>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">상세 약력 및 소개 (선택)</label>
                <textarea id="summernote" name="content">${people.content}</textarea>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-neon px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 400,
            lang: "ko-KR",
            placeholder: '약력 및 상세 소개를 입력해주세요 (선택사항)',
            callbacks: {
                onImageUpload: function(files) {
                    for (var i = 0; i < files.length; i++) {
                        uploadSummernoteImage(files[i], this);
                    }
                }
            }
        });
    });

    function uploadSummernoteImage(file, editor) {
        var data = new FormData();
        data.append("file", file);
        $.ajax({
            data: data,
            type: "POST",
            url: "/admin/file/uploadSummernoteImage",
            contentType: false,
            processData: false,
            success: function(data) {
                if(data.responseCode === "success") {
                    $(editor).summernote('insertImage', data.url);
                } else {
                    alert("이미지 업로드에 실패했습니다.");
                }
            }
        });
    }
</script>

<%@ include file="../layout/footer.jsp" %>