<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="sponsor_campaign" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<style>
    /* 1. Summernote 링크 삽입 팝업 UI/UX 개선 */
    .note-modal-form .checkbox {
        display: none !important;
    }
    .note-modal-footer {
        padding: 15px 20px 20px 0 !important;
        height: auto !important;
    }
    .note-modal-footer .note-btn {
        float: unset;
    }

    /* 2. ★ 신규 추가: 전체화면(Fullscreen) 레이아웃 깨짐 방지용 */
    .note-editor.note-frame.fullscreen {
        z-index: 9999 !important;
        background: #ffffff !important;
    }
    /* JS로 제어할 임시 클래스 (전체화면 시 기준점을 가두는 요소 무력화) */
    .disable-backdrop {
        backdrop-filter: none !important;
        -webkit-backdrop-filter: none !important;
        transform: none !important;
    }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">기부 캠페인 ${empty campaign.campSeq ? '등록' : '수정'}</h3>
    <div>
        <a href="/mng/campaign/list?pageNum=${params.pageNum}&amount=${params.amount}&searchKeyword=${params.searchKeyword}&searchUseYn=${params.searchUseYn}"
           class="btn btn-outline-secondary px-4 me-2 text-dark">목록</a>
        <c:if test="${not empty campaign.campSeq}">
            <button type="button" class="btn btn-danger px-4" onclick="deleteCampaign()"><i class="bi bi-trash"></i> 삭제
            </button>
        </c:if>
    </div>
</div>

<div class="premium-card p-4">
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
            <button type="submit" class="btn btn-primary px-5 py-2 fs-5">저장하기</button>
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
            dialogsInBody: true,
            placeholder: '캠페인 소개 및 모금액 사용 계획 등을 상세히 기재해주세요.',
            fontNames: [
                'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New',
                'Helvetica Neue', 'Helvetica', 'Impact', 'Lucida Grande',
                'Tahoma', 'Times New Roman', 'Verdana',
                'NanumSquareNeo', '맑은 고딕', '굴림', '돋움', '바탕', '궁서'
            ],
            fontNamesIgnoreCheck: ['NanumSquareNeo'],
            callbacks: {
                onImageUpload: function (files) {
                    for (var i = 0; i < files.length; i++) {
                        uploadSummernoteImage(files[i], this);
                    }
                }
            }
        });

        // 전체화면 버튼 클릭 이벤트 감지하여 부모의 CSS 속성(backdrop-filter) 임시 해제
        $(document).on('click', '.note-btn.btn-fullscreen', function() {
            // Summernote가 클래스를 토글할 시간을 벌어주기 위해 0.05초 대기 후 상태 확인
            setTimeout(function() {
                var isFullscreen = $('.note-editor').hasClass('fullscreen');
                if (isFullscreen) {
                    // 전체화면 상태일 때 가두는 속성을 가진 부모의 효과 제거
                    $('.glassmorphism-box, .premium-card').addClass('disable-backdrop');
                } else {
                    // 원래 화면으로 복귀 시 유리 효과 원상복구
                    $('.glassmorphism-box, .premium-card').removeClass('disable-backdrop');
                }
            }, 50);
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
            // ★ 핵심 1: Spring Security 403 에러 방지를 위한 CSRF 헤더 전송
            beforeSend: function(xhr) {
                xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
            },
            success: function (data) {
                if (data.responseCode === 'success') {
                    // 서버에서 넘겨준 진짜 이미지 경로(data.url)를 에디터에 삽입
                    $(editor).summernote('insertImage', data.url);
                } else {
                    alert(data.message || '이미지 업로드에 실패했습니다.');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("업로드 에러 :", textStatus, errorThrown);
                console.error("HTTP 상태 코드 :", jqXHR.status); // 403인지 500인지 콘솔에 명확히 출력

                if (jqXHR.status === 403) {
                    alert('보안 검증(CSRF)에 실패했습니다. 페이지를 새로고침(F5) 해주세요.');
                } else if (jqXHR.status === 413) {
                    alert('파일 용량이 너무 큽니다. 더 작은 이미지를 올려주세요.');
                } else {
                    alert('서버 오류로 이미지 업로드에 실패했습니다. (코드: ' + jqXHR.status + ')');
                }
            }
        });
    }

    function deleteCampaign() {
        if (confirm("정말로 이 캠페인을 삭제하시겠습니까?\n삭제 시 사용자 화면에서도 즉시 사라집니다.")) {
            document.getElementById('deleteForm').submit();
        }
    }
</script>