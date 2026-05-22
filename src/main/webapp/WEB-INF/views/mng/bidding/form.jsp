<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="bidding" scope="request"/>
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
        background-color: #2b2b40 !important;
        border-color: #474761 !important;
    }

    .note-btn:hover {
        background-color: #e61938 !important;
        color: #fff !important;
    }

    .note-modal-content {
        background-color: #1e1e2d;
        color: #fff;
        border: 1px solid #474761;
    }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">입찰정보 ${empty bidding.brdSeq ? '등록' : '수정'}</h3>
    <a href="/mng/bidding/list?pageNum=${params.pageNum}&amount=${params.amount}&category=${params.category}&searchKeyword=${params.searchKeyword}"
       class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-card p-4">
    <form action="/mng/bidding/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="brdSeq" value="${bidding.brdSeq}">

        <input type="hidden" name="pageNum" value="${params.pageNum}">
        <input type="hidden" name="amount" value="${params.amount}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-12 mb-3">
                <label class="form-label text-muted">진행 상태</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="진행중"
                               id="cat1" ${bidding.category eq '진행중' or empty bidding.category ? 'checked' : ''}>
                        <label class="form-check-label text-dark fw-bold text-success" for="cat1">진행중</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="마감"
                               id="cat2" ${bidding.category eq '마감' ? 'checked' : ''}>
                        <label class="form-check-label text-dark text-muted" for="cat2">마감</label>
                    </div>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">입찰 공고명</label>
                <input type="text" name="title" class="form-control search-bar" value="${bidding.title}" required
                       placeholder="예) 2026 스페셜올림픽코리아 홈페이지 리뉴얼 용역 입찰 공고">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">제안요청서 등 문서 첨부 (다중 선택 가능)</label>
                <input type="file" name="uploadFiles" class="form-control search-bar" multiple>
                <div class="form-text text-secondary mt-1"><i class="bi bi-info-circle"></i> Ctrl 키를 누른 상태로 제안요청서,
                    과업지시서, 입찰참가신청서 등을 모두 선택하세요.
                </div>

                <c:if test="${not empty bidding.fileList}">
                    <div class="mt-3 p-3 border rounded"
                         style="border-color: #474761 !important; background-color: #151521;">
                        <span class="d-block text-muted mb-2">기존 첨부파일 목록</span>
                        <ul class="list-unstyled mb-0">
                            <c:forEach var="file" items="${bidding.fileList}">
                                <li class="text-dark mb-1">
                                    <i class="bi bi-file-earmark-arrow-down me-2 text-info"></i> ${file.orgFileNm}
                                    <span class="text-muted ms-2"
                                          style="font-size: 11px;">(${file.fileSize} byte)</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">상세 공고 내용</label>
                <textarea id="summernote" name="content">${bidding.content}</textarea>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-neon px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    $(document).ready(function () {
        $('#summernote').summernote({
            height: 500,
            lang: "ko-KR",
            placeholder: '입찰 세부 내용, 참가 자격, 제출 기한 등을 상세히 기재해주세요.',
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
            // ★ 핵심 1: Spring Security 403 에러 방지를 위한 CSRF 헤더 전송
            beforeSend: function(xhr) {
                xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
            },
            success: function (data) {
                // ★ 핵심 2: 백엔드가 반환하는 JSON 규격(responseCode, url)에 맞춰 이미지 삽입
                if (data.responseCode === 'success') {
                    $(editor).summernote('insertImage', data.url);
                } else {
                    alert(data.message || '이미지 업로드에 실패했습니다.');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("업로드 에러:", textStatus, errorThrown);
                alert('서버와 통신 중 오류가 발생했습니다.');
            }
        });
    }
</script>