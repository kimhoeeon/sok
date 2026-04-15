<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="badgeClass" value="sponsor"/>
<c:choose>
    <c:when test="${board.category eq '선수'}"><c:set var="badgeClass" value="player"/></c:when>
    <c:when test="${board.category eq '아티스트'}"><c:set var="badgeClass" value="artist"/></c:when>
    <c:when test="${board.category eq '패밀리'}"><c:set var="badgeClass" value="family"/></c:when>
    <c:when test="${board.category eq '프렌즈'}"><c:set var="badgeClass" value="friends"/></c:when>
    <c:when test="${board.category eq '스폰서'}"><c:set var="badgeClass" value="sponsor"/></c:when>
    <c:when test="${board.category eq '소식'}"><c:set var="badgeClass" value="news"/></c:when>
</c:choose>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top view_top">
            <div class="sub_top_box">
                <div class="badge ${badgeClass}">${not empty board.category ? board.category : '-'}</div>

                <div class="sub_top_tit" id="tts_sub_top">${board.title}</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>

                <div class="date">
                    <fmt:formatDate value="${board.regDt}" pattern="yyyy-MM-dd"/>
                </div>
            </div>
        </div>
        <div class="view_wrap">
            <div class="view_detail center">
                <div>
                    ${board.content}
                </div>
            </div>

            <div class="btn">
                <a href="/people/list?pageNum=${params.pageNum}&category=${params.category}&searchKeyword=${params.searchKeyword}"
                   class="move_list">목록으로</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>