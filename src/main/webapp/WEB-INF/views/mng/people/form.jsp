<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="people" scope="request" />
<%@ include file="../layout/header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>

<style>
    /* ★ 신규 추가: Summernote 링크 삽입 팝업 UI/UX 개선 */
    /* 1. 프론트에서 자동 처리하므로 혼동을 유발하는 새창열기/프로토콜 체크박스 숨김 */
    .note-modal-form .checkbox {
        display: none !important;
    }
    /* 2. 팝업 하단에 링크 삽입 버튼이 딱 붙어있는 디자인 버그 해결 */
    .note-modal-footer {
        padding: 15px 20px 20px 0 !important;
        height: auto !important;
    }
    .note-modal-footer .note-btn {
        margin-right: 0 !important;
    }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">SOK 스토리 ${empty people.brdSeq ? '등록' : '수정'}</h3>
    <a href="/mng/people/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-card p-4">
    <form action="/mng/people/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${people.brdSeq}">

        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">인물 분류</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="선수" id="cat1" ${people.category eq '선수' or empty people.category ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat1">선수</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="아티스트" id="cat2" ${people.category eq '아티스트' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat2">아티스트</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="패밀리" id="cat3" ${people.category eq '패밀리' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat3">패밀리</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="프렌즈" id="cat4" ${people.category eq '프렌즈' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat4">프렌즈</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="스폰서" id="cat5" ${people.category eq '스폰서' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat5">스폰서</label>
                    </div>
                    <%--<div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="소식" id="cat6" ${people.category eq '소식' ? 'checked' : ''}>
                        <label class="form-check-label text-dark" for="cat6">소식</label>
                    </div>--%>
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">홈페이지 메인 노출 여부</label>
                <div class="form-check form-switch mt-2">
                    <input class="form-check-input" type="checkbox" role="switch" id="isNotice" name="isNotice" value="Y" ${people.isNotice eq 'Y' ? 'checked' : ''}>
                    <label class="form-check-label text-dark" for="isNotice">활성화 시 메인 화면에 우선 노출됩니다.</label>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">이름 및 직책 (타이틀)</label>
                <input type="text" name="title" class="form-control search-bar" value="${people.title}" required placeholder="예) 김연아 / 스페셜올림픽코리아 홍보대사">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">유튜브 영상 <i class="bi bi-youtube text-danger"></i> (선택)</label>
                <input type="text" name="youtubeUrl" id="youtubeUrl" class="form-control search-bar border-danger" value="${people.youtubeUrl}" placeholder="유튜브 영상 URL을 붙여넣으세요" oninput="previewYoutube()">
                <small class="text-muted d-block mt-2">예: https://www.youtube.com/watch?v=xxxxxxx 또는 https://youtu.be/xxxxxxx</small>

                <div id="youtubePreview" class="mt-3" style="display: none; border-radius: 8px; overflow: hidden; max-width: 560px;">
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">프로필 이미지 등록 (다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control search-bar" multiple accept="image/*">

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
            <button type="submit" class="btn btn-primary px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    // 유튜브 URL에서 ID 추출
    function extractVideoID(url) {
        var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        var match = url.match(regExp);
        if (match && match[2].length === 11) {
            return match[2];
        }
        return null;
    }

    // 유튜브 썸네일/iframe 렌더링
    function previewYoutube() {
        var url = document.getElementById('youtubeUrl').value;
        var preview = document.getElementById('youtubePreview');
        var videoId = extractVideoID(url);

        if (videoId) {
            preview.innerHTML = '<iframe width="100%" height="315" src="https://www.youtube.com/embed/' + videoId + '" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';
            preview.style.display = 'block';
        } else {
            preview.innerHTML = '';
            preview.style.display = 'none';
        }
    }

    $(document).ready(function() {
        // 기존 썸머노트 렌더링 유지
        $('#summernote').summernote({
            height: 400,
            lang: "ko-KR",
            dialogsInBody: true,
            placeholder: '약력 및 상세 소개를 입력해주세요 (선택사항)',
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

        // 수정 시 기존 URL이 있으면 미리보기 즉시 실행
        if(document.getElementById('youtubeUrl').value) {
            previewYoutube();
        }
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