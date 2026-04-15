<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="dev" scope="request" />
<%@ include file="../layout/header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<style>
    .note-editor.note-frame { border: 1px solid #474761 !important; }
    .note-editing-area .note-editable { background-color: #151521; color: #fff; font-size: 14px; }
    .note-toolbar { background-color: #1e1e2d !important; border-bottom: 1px solid #474761 !important; }
    .note-btn { color: #fff !important; background-color: #2b2b40 !important; border-color: #474761 !important; }
    .note-btn:hover { background-color: #e61938 !important; color: #fff !important; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">유지보수 요청 등록</h3>
    <a href="/admin/dev/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/dev/saveRequest" method="post" enctype="multipart/form-data">
        <div class="row mb-4 glassmorphism-box p-4 border-0">

            <div class="col-md-6 mb-4">
                <label class="form-label text-muted">문의 유형</label>
                <select name="reqType" class="form-select dark-search-bar fw-bold" required>
                    <option value="">유형을 선택하세요</option>
                    <option value="유지보수">🛠️ 유지보수</option>
                    <option value="단순문의">❓ 단순문의</option>
                    <option value="기능오류">🚨 기능오류</option>
                </select>
            </div>

            <div class="col-md-6 mb-4">
                <label class="form-label text-muted">긴급 처리 여부</label>
                <div class="form-check form-switch mt-2">
                    <input class="form-check-input" type="checkbox" role="switch" id="urgency" name="urgency" value="Y">
                    <label class="form-check-label text-danger fw-bold" for="urgency">업무 마비 등 심각한 오류일 경우 체크해주세요.</label>
                </div>
            </div>

            <div class="col-12 mb-4">
                <label class="form-label text-muted">요청 제목</label>
                <input type="text" name="title" class="form-control dark-search-bar" required placeholder="무엇을 도와드릴까요?">
            </div>

            <div class="col-12 mb-4">
                <label class="form-label text-muted">참고 파일 첨부 (화면 캡처, 기획서 등)</label>
                <input type="file" name="uploadFiles" class="form-control dark-search-bar" multiple>
                <div class="form-text text-secondary mt-1">Ctrl 키를 누르고 여러 파일을 선택할 수 있습니다.</div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">상세 요청 내용</label>
                <textarea id="summernote" name="content"></textarea>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-neon px-5 py-3 fs-5 w-50">요청글 등록 (개발사 알림 발송)</button>
        </div>
    </form>
</div>

<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 400,
            lang: "ko-KR",
            placeholder: '오류 발생 경로, 수정되어야 할 텍스트 등 상세한 내용을 기재해 주시면 빠른 처리에 도움이 됩니다.',
            callbacks: {
                onImageUpload: function(files) {
                    for (var i = 0; i < files.length; i++) {
                        var data = new FormData();
                        data.append("file", files[i]);
                        var editor = this;
                        $.ajax({
                            data: data, type: "POST", url: "/admin/file/uploadImage",
                            contentType: false, processData: false,
                            success: function(data) {
                                if(data.responseCode === "success") $(editor).summernote('insertImage', data.url);
                            }
                        });
                    }
                }
            }
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>