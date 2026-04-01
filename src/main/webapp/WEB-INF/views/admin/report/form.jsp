<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuGroup" value="menu" scope="request" />
<c:set var="currentMenu" value="report" scope="request" />
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
    .note-modal-content { background-color: #1e1e2d; color: #fff; border: 1px solid #474761; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">활동보고서 ${empty report.brdSeq ? '등록' : '수정'}</h3>
    <a href="/admin/report/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/report/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${report.brdSeq}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-12 mb-3">
                <label class="form-label text-muted">분류</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="연차보고서" id="cat1" ${report.category eq '연차보고서' or empty report.category ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat1">연차보고서</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="사업보고서" id="cat2" ${report.category eq '사업보고서' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat2">사업보고서</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="기타자료" id="cat3" ${report.category eq '기타자료' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat3">기타자료</label>
                    </div>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">보고서 제목</label>
                <input type="text" name="title" class="form-control dark-search-bar" value="${report.title}" required placeholder="예) 2025 스페셜올림픽코리아 연차보고서">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">보고서 파일 첨부 (PDF, 이미지 등 다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control dark-search-bar" multiple>
                <div class="form-text text-secondary mt-1"><i class="bi bi-info-circle"></i> Ctrl 키를 누른 상태로 여러 파일을 첨부할 수 있습니다.</div>

                <c:if test="${not empty report.fileList}">
                    <div class="mt-3 p-3 border rounded" style="border-color: #474761 !important; background-color: #151521;">
                        <span class="d-block text-muted mb-2">기존 첨부파일 목록</span>
                        <ul class="list-unstyled mb-0">
                            <c:forEach var="file" items="${report.fileList}">
                                <li class="text-white mb-1">
                                    <i class="bi bi-file-earmark-pdf me-2 text-danger"></i> ${file.orgFileNm}
                                    <span class="text-muted ms-2" style="font-size: 11px;">(${file.fileSize} byte)</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">보고서 상세 설명</label>
                <textarea id="summernote" name="content">${report.content}</textarea>
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
            placeholder: '보고서에 대한 요약 설명이나 목차 등을 입력해주세요.',
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