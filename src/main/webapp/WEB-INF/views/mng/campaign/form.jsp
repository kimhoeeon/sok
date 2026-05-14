<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="sponsor_campaign" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<style>
    .note-editor.note-frame {
        border: 1px solid #474761 !important;
    }

    .note-editing-area .note-editable {
        background-color: #151521;
        color: #fff;
        font-size: 14px;
    }

    .note-toolbar {
        background-color: #1e1e2d !important;
        border-bottom: 1px solid #474761 !important;
    }

    .note-btn {
        color: #fff !important;
    }

    /* 폼 공통 다크 스타일 */
    .form-label {
        color: #a1a5b7;
        font-weight: 500;
    }

    .form-control, .form-select {
        background-color: #151521;
        border: 1px solid #474761;
        color: #fff;
    }

    .form-control:focus, .form-select:focus {
        background-color: #151521;
        border-color: #00d2ff;
        color: #fff;
        box-shadow: none;
    }

    .form-control::placeholder {
        color: #565674;
    }

    input[type="date"]::-webkit-calendar-picker-indicator {
        filter: invert(1);
    }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">기부 캠페인 ${empty campaign.campSeq ? '등록' : '수정'}</h3>
    <div>
        <a href="/mng/campaign/list?pageNum=${params.pageNum}&amount=${params.amount}&searchKeyword=${params.searchKeyword}&searchUseYn=${params.searchUseYn}"
           class="btn btn-outline-secondary px-4 me-2 text-white">목록</a>
        <c:if test="${not empty campaign.campSeq}">
            <button type="button" class="btn btn-danger px-4" onclick="deleteCampaign()"><i class="bi bi-trash"></i> 삭제
            </button>
        </c:if>
    </div>
</div>

<div class="premium-dark-card p-4">
    <form action="/mng/campaign/save" method="post" enctype="multipart/form-data" id="campaignForm">
        <input type="hidden" name="campSeq" value="${campaign.campSeq}">
        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">
        <input type="hidden" name="searchUseYn" value="${params.searchUseYn}">

        <div class="row g-4">
            <div class="col-md-2">
                <label class="form-label">노출 여부</label>
                <select name="useYn" class="form-select">
                    <option value="Y" ${campaign.useYn == 'Y' ? 'selected' : ''}>노출</option>
                    <option value="N" ${campaign.useYn == 'N' ? 'selected' : ''}>미노출</option>
                </select>
            </div>
            <div class="col-md-10">
                <label class="form-label">캠페인 제목 <span class="text-danger">*</span></label>
                <input type="text" name="title" class="form-control" value="${campaign.title}" required
                       placeholder="예: 2026 희망나눔 캠페인">
            </div>

            <div class="col-md-4">
                <label class="form-label">모금 시작일 <span class="text-danger">*</span></label>
                <input type="date" name="startDt" class="form-control"
                       value="<fmt:formatDate value='${campaign.startDt}' pattern='yyyy-MM-dd'/>" required>
            </div>
            <div class="col-md-4">
                <label class="form-label">모금 종료일 <span class="text-danger">*</span></label>
                <input type="date" name="endDt" class="form-control"
                       value="<fmt:formatDate value='${campaign.endDt}' pattern='yyyy-MM-dd'/>" required>
            </div>
            <div class="col-md-4">
                <label class="form-label">목표 모금액 (원) <span class="text-danger">*</span></label>
                <input type="number" name="goalAmt" class="form-control" value="${campaign.goalAmt}" required
                       placeholder="목표 금액 (숫자만 입력)">
            </div>

            <div class="col-12">
                <label class="form-label">목록 썸네일 <span class="text-muted ms-2" style="font-size: 0.85rem;">(가로 세로 비율 4:3 이미지를 권장합니다)</span></label>
                <input type="file" name="thumbFile" class="form-control" accept="image/*">
                <c:if test="${not empty campaign.thumbPath}">
                    <div class="mt-3 p-3 rounded" style="background-color: #1e1e2d; display: inline-block;">
                        <img src="${campaign.thumbPath}" alt="현재 썸네일" style="height: 100px; border-radius: 4px;">
                        <input type="hidden" name="thumbPath" value="${campaign.thumbPath}">
                    </div>
                </c:if>
            </div>

            <div class="col-12 mt-4">
                <label class="form-label">캠페인 상세 내용</label>
                <textarea id="summernote" name="content">${campaign.content}</textarea>
            </div>
        </div>

        <div class="text-center mt-5">
            <button type="submit" class="btn btn-neon px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>

    <c:if test="${not empty campaign.campSeq}">
        <form id="deleteForm" action="/mng/campaign/delete" method="post" style="display:none;">
            <input type="hidden" name="campSeq" value="${campaign.campSeq}">
            <input type="hidden" name="pageNum" value="${params.pageNum}">
            <input type="hidden" name="amount" value="${params.amount}">
        </form>
    </c:if>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    $(document).ready(function () {
        $('#summernote').summernote({
            height: 500,
            lang: "ko-KR",
            placeholder: '캠페인 소개 및 모금액 사용 계획 등을 상세히 기재해주세요.',
            callbacks: {
                onImageUpload: function (files) {
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
            url: "/mng/file/uploadImage",
            contentType: false,
            processData: false,
            success: function (data) {
                $(editor).summernote('insertImage', data);
            }
        });
    }

    function deleteCampaign() {
        if (confirm("정말로 이 캠페인을 삭제하시겠습니까?\n삭제 시 사용자 화면에서도 즉시 사라집니다.")) {
            document.getElementById('deleteForm').submit();
        }
    }
</script>