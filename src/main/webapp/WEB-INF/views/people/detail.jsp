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
    <%--<c:when test="${board.category eq '소식'}"><c:set var="badgeClass" value="news"/></c:when>--%>
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

            <c:if test="${not empty board.fileList}">
                <div class="profile_images" style="display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; margin-bottom: 50px;">
                    <c:forEach var="file" items="${board.fileList}">
                        <div style="text-align: center;">
                            <img src="${file.filePath}" alt="${file.orgFileNm}" style="max-width: 100%; height: auto; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <div class="view_detail center">
                <div class="editor-content">
                    <c:out value="${board.content}" escapeXml="false" />
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

<script>
    $(document).ready(function() {
        // ★ 에디터 본문 내 링크 자동화 처리 스크립트 (유튜브 및 새창 열기)
        $('.editor-content a').each(function() {
            var url = $(this).attr('href');
            if (!url) return;

            // 새창에서 열리도록 설정
            $(this).attr('target', '_blank');
            $(this).attr('rel', 'noopener noreferrer');

            // 유튜브 링크 추출 정규식
            var ytRegex = /(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/;
            var match = url.match(ytRegex);

            // 유튜브 영상이 감지되면 iframe 생성
            if (match && match[1]) {
                var videoId = match[1];
                var iframeHtml = '<div class="video_container" style="margin-top: 15px; margin-bottom: 25px;">' +
                    '<iframe src="https://www.youtube.com/embed/' + videoId + '" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>' +
                    '</div>';

                if(!$(this).next().hasClass('video_container')) {
                    $(this).after(iframeHtml);
                }
            }
        });
    });
</script>