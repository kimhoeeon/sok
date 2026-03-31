<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="menuGroup" value="menu" scope="request"/>
<c:set var="currentMenu" value="notice" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold">공지사항 ${empty notice.brdSeq ? '등록' : '수정'}</h3>
    <a href="/admin/notice/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록</a>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/notice/save" method="post">
        <input type="hidden" name="brdSeq" value="${notice.brdSeq}">

        <div class="row mb-4 glassmorphism-box p-3">
            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">카테고리</label>
                <div class="d-flex gap-3 mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="공지" id="cat1" ${notice.category eq '공지' or empty notice.category ? 'checked' : ''}>
                        <label class="form-check-label" for="cat1">공지</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="입찰" id="cat2" ${notice.category eq '입찰' ? 'checked' : ''}>
                        <label class="form-check-label" for="cat2">입찰</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="서류" id="cat3" ${notice.category eq '서류' ? 'checked' : ''}>
                        <label class="form-check-label" for="cat3">서류</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="category" value="리포트" id="cat4" ${notice.category eq '리포트' ? 'checked' : ''}>
                        <label class="form-check-label" for="cat4">리포트</label>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label text-muted">중요 여부</label>
                <div class="form-check form-switch mt-2">
                    <input class="form-check-input" type="checkbox" role="switch" id="isNotice" name="isNotice" value="Y" ${notice.isNotice eq 'Y' ? 'checked' : ''}>
                    <label class="form-check-label" for="isNotice">상단 중요 공지로 설정</label>
                </div>
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">제목</label>
                <input type="text" name="title" class="form-control dark-search-bar" value="${notice.title}" required placeholder="제목을 입력하세요">
            </div>

            <div class="col-12 mb-3">
                <label class="form-label text-muted">본문 내용</label>
                <textarea name="content" class="form-control dark-search-bar" rows="10" placeholder="에디터가 연동될 영역입니다. 본문을 입력하세요.">${notice.content}</textarea>
            </div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-neon px-5 py-2 fs-5">저장하기</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>