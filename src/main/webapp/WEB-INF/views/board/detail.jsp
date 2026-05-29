<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="boardUrl" value=""/>
<c:set var="boardName" value=""/>
<c:choose>
    <c:when test="${board.brdType eq 'NOTICE'}">
        <c:set var="boardUrl" value="/notice"/>
        <c:set var="boardName" value="공지사항"/>
    </c:when>
    <c:when test="${board.brdType eq 'BIDDING'}">
        <c:set var="boardUrl" value="/bidding"/>
        <c:set var="boardName" value="입찰정보"/>
    </c:when>
    <c:when test="${board.brdType eq 'CAREERS'}">
        <c:set var="boardUrl" value="/careers"/>
        <c:set var="boardName" value="채용정보"/>
    </c:when>
    <c:when test="${board.brdType eq 'PRESS'}">
        <c:set var="boardUrl" value="/press"/>
        <c:set var="boardName" value="자료실"/>
    </c:when>
    <c:when test="${board.brdType eq 'REPORT'}">
        <c:set var="boardUrl" value="/report"/>
        <c:set var="boardName" value="활동보고서"/>
    </c:when>
    <c:when test="${board.brdType eq 'NEWS'}">
        <c:set var="boardUrl" value="/news"/>
        <c:set var="boardName" value="SOK 소식"/>
    </c:when>
    <c:when test="${board.brdType eq 'MANAGEMENT'}">
        <c:set var="boardUrl" value="/management"/>
        <c:set var="boardName" value="운영자료"/>
    </c:when>
</c:choose>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <%--<div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>
                        <c:choose>
                            <c:when test="${board.brdType eq 'MANAGEMENT'}">SOK 소개</c:when>
                            <c:otherwise>알림공간</c:otherwise>
                        </c:choose>
                    </span><span>${boardName}</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">${boardName}</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>

            <c:if test="${board.brdType ne 'MANAGEMENT'}">
                <ul class="sub_top_tab">
                    <li class="${board.brdType eq 'NOTICE' ? 'on' : ''}"><a href="/notice/list">공지사항</a></li>
                    <li class="${board.brdType eq 'BIDDING' ? 'on' : ''}"><a href="/bidding/list">입찰정보</a></li>
                    <li class="${board.brdType eq 'CAREERS' ? 'on' : ''}"><a href="/careers/list">채용정보</a></li>
                    <li class="${board.brdType eq 'PRESS' ? 'on' : ''}"><a href="/press/list">자료실</a></li>
                    <li class="${board.brdType eq 'REPORT' ? 'on' : ''}"><a href="/report/list">활동보고서</a></li>
                    <li class="${board.brdType eq 'NEWS' ? 'on' : ''}"><a href="/news/list">스페셜올림픽코리아 소식</a></li>
                    &lt;%&ndash;<li class="${board.brdType eq 'MANAGEMENT' ? 'on' : ''}"><a href="/management/list">운영자료</a></li>&ndash;%&gt;
                </ul>
            </c:if>
        </div>--%>

        <div class="sub_top view_top">
            <div class="sub_top_box">
                <div class="sub_top_tit" id="tts_title_top">
                    <c:out value="${board.title}"/>
                </div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_title_top">
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
                <div class="view_file">
                    <c:forEach var="file" items="${board.fileList}" varStatus="status">
                        <div>
                            ${status.count}.
                                <a href="/file/download?filePath=${file.filePath}&fileName=${file.orgFileNm}" class="hover-glow text-decoration-none">
                                <c:out value="${file.orgFileNm}"/>
                                <span style="color: #777;">
                                    (<fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,##0.0"/> KB)
                                </span>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <div class="view_detail">
                <div class="editor-content">
                    <c:out value="${board.content}" escapeXml="false" />
                </div>
            </div>

            <ul class="view_post">
                <c:choose>
                    <c:when test="${not empty prevBoard}">
                        <li class="prev_post"
                            onclick="location.href='${boardUrl}/detail?brdSeq=${prevBoard.brdSeq}&pageNum=${params.pageNum}&searchType=${params.searchType}&searchKeyword=${params.searchKeyword}'"
                            style="cursor: pointer;">
                            <div style="min-width: 60px;">이전글</div>
                            <div class="tit"><c:out value="${prevBoard.title}"/></div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="prev_post text-muted">
                            <div style="min-width: 60px;">이전글</div>
                            <div class="tit text-muted">이전 글이 없습니다.</div>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${not empty nextBoard}">
                        <li class="next_post"
                            onclick="location.href='${boardUrl}/detail?brdSeq=${nextBoard.brdSeq}&pageNum=${params.pageNum}&searchType=${params.searchType}&searchKeyword=${params.searchKeyword}'"
                            style="cursor: pointer;">
                            <div style="min-width: 60px;">다음글</div>
                            <div class="tit"><c:out value="${nextBoard.title}"/></div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="next_post text-muted">
                            <div style="min-width: 60px;">다음글</div>
                            <div class="tit text-muted">다음 글이 없습니다.</div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <div class="btn">
                <a href="${boardUrl}/list?pageNum=${params.pageNum}&searchType=${params.searchType}&searchKeyword=${params.searchKeyword}"
                   class="move_list">목록으로</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    $(document).ready(function() {
        // ★ 에디터 본문 내 링크 자동화 처리 스크립트
        $('.editor-content a').each(function() {
            var url = $(this).attr('href');
            if (!url) return;

            // 1. 모든 본문 링크를 강제로 새창에서 열리도록 설정 (보안 속성 추가)
            $(this).attr('target', '_blank');
            $(this).attr('rel', 'noopener noreferrer');

            // 2. 유튜브 링크 정규식 (youtube.com, youtu.be 모두 감지)
            var ytRegex = /(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/;
            var match = url.match(ytRegex);

            // 3. 유튜브 링크가 맞다면 반응형 플레이어(iframe)를 링크 바로 아래에 자동 삽입
            if (match && match[1]) {
                var videoId = match[1];
                var iframeHtml = '<div class="video_container" style="margin-top: 15px; margin-bottom: 25px;">' +
                    '<iframe src="https://www.youtube.com/embed/' + videoId + '" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>' +
                    '</div>';

                // 중복 삽입을 방지하기 위해 바로 뒤에 video_container가 없는 경우에만 추가
                if(!$(this).next().hasClass('video_container')) {
                    $(this).after(iframeHtml);
                }
            }
        });
    });
</script>