<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="management" scope="request" />
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
        margin-right: 0 !important;
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
    <h3 class="fw-bold text-dark">운영자료 ${empty management.brdSeq ? '등록' : '수정'}</h3>
    <a href="/mng/management/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-card p-4">
    <form action="/mng/management/save" method="post" enctype="multipart/form-data">
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
                        <label class="form-check-label text-dark" for="cat1">예산/결산</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="사업계획" id="cat2" ${management.category eq '사업계획' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat2">사업계획</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="규정/기타" id="cat3" ${management.category eq '규정/기타' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat3">규정/기타</label>
                    </div>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">제목</label>
                <input type="text" name="title" class="form-control search-bar" value="${management.title}" required placeholder="제목을 입력하세요">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">문서 파일 첨부 (다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control search-bar" multiple>
                <div class="form-text text-secondary mt-1"><i class="bi bi-info-circle"></i> Ctrl 키를 누른 상태로 여러 개의 PDF, HWP, DOCX 파일 등을 첨부할 수 있습니다.</div>

                <c:if test="${not empty management.fileList}">
                    <div class="mt-3 p-3 border rounded" style="border-color: #474761 !important; background-color: #151521;">
                        <span class="d-block text-muted mb-2">기존 첨부파일 목록</span>
                        <ul class="list-unstyled mb-0">
                            <c:forEach var="file" items="${management.fileList}">
                                <li class="text-dark mb-1"><i class="bi bi-file-earmark-text me-2"></i> ${file.orgFileNm} <span class="text-muted ms-2" style="font-size: 11px;">(${file.fileSize} byte)</span></li>
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
            <button type="submit" class="btn btn-primary px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 400,
            lang: "ko-KR",
            dialogsInBody: true,
            placeholder: '상세 내용을 입력해주세요.',
            fontNames: [
                'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New',
                'Helvetica Neue', 'Helvetica', 'Impact', 'Lucida Grande',
                'Tahoma', 'Times New Roman', 'Verdana',
                'NanumSquareNeo', '맑은 고딕', '굴림', '돋움', '바탕', '궁서'
            ],
            fontNamesIgnoreCheck: ['NanumSquareNeo'],
            callbacks: {
                onImageUpload: function(files) {
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
</script>