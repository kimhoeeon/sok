<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="management" scope="request" />
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
    <h3 class="fw-bold text-white">경영공시 ${empty management.brdSeq ? '등록' : '수정'}</h3>
    <a href="/admin/management/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/management/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${management.brdSeq}">

        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">
        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-12 mb-3">
                <label class="form-label text-muted">분류</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="예산/결산" id="cat1" ${management.category eq '예산/결산' or empty management.category ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat1">예산/결산</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="사업계획" id="cat2" ${management.category eq '사업계획' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat2">사업계획</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="규정/기타" id="cat3" ${management.category eq '규정/기타' ? 'checked' : ''}>
                        <label class="form-check-label text-white" for="cat3">규정/기타</label>
                    </div>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">제목</label>
                <input type="text" name="title" class="form-control dark-search-bar" value="${management.title}" required placeholder="제목을 입력하세요">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">문서 파일 첨부 (다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control dark-search-bar" multiple>
                <div class="form-text text-secondary mt-1"><i class="bi bi-info-circle"></i> Ctrl 키를 누른 상태로 여러 개의 PDF, HWP, DOCX 파일 등을 첨부할 수 있습니다.</div>

                <c:if test="${not empty management.fileList}">
                    <div class="mt-3 p-3 border rounded" style="border-color: #474761 !important; background-color: #151521;">
                        <span class="d-block text-muted mb-2">기존 첨부파일 목록</span>
                        <ul class="list-unstyled mb-0">
                            <c:forEach var="file" items="${management.fileList}">
                                <li class="text-white mb-1"><i class="bi bi-file-earmark-text me-2"></i> ${file.orgFileNm} <span class="text-muted ms-2" style="font-size: 11px;">(${file.fileSize} byte)</span></li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">본문 내용</label>
                <textarea id="summernote" name="content">${management.content}</textarea>
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
            placeholder: '상세 내용을 입력해주세요.',
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