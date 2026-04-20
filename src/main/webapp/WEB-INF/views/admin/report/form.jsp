<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <a href="/admin/report/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchType=${params.searchType}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/report/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${report.brdSeq}">
        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchType" value="${params.searchType}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

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
                <label class="form-label" style="color:#39ff14 !important;">목록 썸네일 이미지 (단일 첨부, 권장 비율 16:9)</label>
                <input type="file" name="thumbFile" class="form-control dark-search-bar" accept="image/*">
                <c:if test="${not empty report.thumbPath}">
                    <div class="mt-2 p-2 rounded" style="background-color: rgba(255,255,255,0.05);">
                        <span class="text-white align-middle me-2">현재 등록된 썸네일: </span>
                        <img src="${report.thumbPath}" alt="썸네일 미리보기" style="height: 60px; border-radius: 4px; object-fit: cover;">
                    </div>
                </c:if>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">보고서 파일 첨부 (PDF, 이미지 등 다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control dark-search-bar" multiple>
                <div class="form-text text-secondary mt-1"><i class="bi bi-info-circle"></i> Ctrl 키를 누른 상태로 여러 파일을 첨부할 수 있습니다.</div>

                <c:if test="${not empty report.fileList}">
                    <div class="mt-3 p-3 border rounded" style="border-color: #474761 !important; background-color: #151521;">
                        <span class="d-block text-muted mb-2"><i class="bi bi-paperclip me-1"></i> 기존 첨부파일 목록 (클릭 시 다운로드)</span>
                        <ul class="list-unstyled mb-0">
                            <c:forEach var="file" items="${report.fileList}">
                                <li class="mb-2">
                                    <a href="${file.filePath}" target="_blank" class="text-white text-decoration-none hover-glow d-inline-flex align-items-center">
                                        <i class="bi bi-file-earmark-pdf me-2 text-danger fs-5"></i>
                                        <span>${file.orgFileNm}</span>
                                        <span class="text-muted ms-2" style="font-size: 11px;">
                                            (<fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,###.0"/> KB)
                                        </span>
                                        <i class="bi bi-download ms-2 text-info" style="font-size: 12px;"></i>
                                    </a>
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

<%@ include file="../layout/footer.jsp" %>

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
            url: "/admin/file/uploadImage",
            contentType: false,
            processData: false,
            success: function(url) {
                // 컨트롤러가 반환한 URL 문자열을 그대로 에디터에 삽입
                $(editor).summernote('insertImage', url);
            },
            error: function() {
                alert("이미지 업로드에 실패했습니다.");
            }
        });
    }
</script>