<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="news" scope="request" />
<%@ include file="../layout/header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<style>
    .note-editor.note-frame { border: 1px solid #474761 !important; }
    .note-editing-area .note-editable { background-color: #151521; color: #fff; }
    .note-toolbar { background-color: #1e1e2d !important; border-bottom: 1px solid #474761 !important; }
    .note-btn { color: #fff !important; background-color: #2b2b40 !important; border-color: #474761 !important; }
    .note-btn:hover { background-color: #39ff14 !important; color: #000 !important; }
    .note-modal-content { background-color: #1e1e2d; color: #fff; border: 1px solid #474761; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">${empty news.brdSeq ? '보도자료 등록' : '보도자료 상세/수정'}</h3>

    <a href="/admin/news/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchType=${params.searchType}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light">
    <i class="bi bi-list"></i> 목록으로
</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/news/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${news.brdSeq}">
        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchType" value="${params.searchType}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">카테고리</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="공지" id="cat1" ${news.category eq '공지' or empty news.category ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat1">공지</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="입찰" id="cat2" ${news.category eq '입찰' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat2">입찰</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="서류" id="cat3" ${news.category eq '서류' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat3">서류</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="리포트" id="cat4" ${news.category eq '리포트' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat4">리포트</label>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">중요 여부</label>
                <div class="form-check form-switch mt-2">
                    <input class="form-check-input" type="checkbox" role="switch" id="isNotice" name="isNotice" value="Y" ${news.isNotice eq 'Y' ? 'checked' : ''}>
                    <label class="form-check-label text-white" for="isNotice">상단 중요 공지로 설정</label>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">제목</label>
                <input type="text" name="title" class="form-control dark-search-bar" value="${news.title}" required placeholder="제목을 입력하세요">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">파일 첨부 (다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control dark-search-bar" multiple>
                <div class="form-text text-secondary mt-1"><i class="bi bi-info-circle"></i> Ctrl 키를 누른 상태로 클릭하면 여러 파일을 첨부할 수 있습니다.</div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">본문 내용</label>
                <textarea id="summernote" name="content">${news.content}</textarea>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-neon px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 500,                 // 에디터 높이
            minHeight: null,             // 최소 높이
            maxHeight: null,             // 최대 높이
            focus: true,                 // 에디터 로딩후 포커스를 맞출지 여부
            lang: "ko-KR",               // 한글 설정
            placeholder: '본문 내용을 입력해주세요.',
            callbacks: {
                onImageUpload: function(files) {
                    // 다중 이미지 업로드 처리
                    for (var i = 0; i < files.length; i++) {
                        uploadSummernoteImage(files[i], this);
                    }
                }
            }
        });
    });

    // Summernote 이미지 서버 전송 AJAX
    function uploadSummernoteImage(file, editor) {
        var data = new FormData();
        data.append("file", file);
        $.ajax({
            data: data,
            type: "POST",
            url: "/admin/file/uploadImage",
            contentType: false,
            processData: false,
            success: function(data) {
                if(data.responseCode === "success") {
                    // 항상 브라우저에서 접근 가능한 URL이 삽입됨 (/upload/summernote/...)
                    $(editor).summernote('insertImage', data.url);
                } else {
                    alert("이미지 업로드에 실패했습니다.");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error(textStatus + " " + errorThrown);
            }
        });
    }
</script>