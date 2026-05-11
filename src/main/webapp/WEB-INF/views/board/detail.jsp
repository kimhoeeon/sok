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
    <c:when test="${board.brdType eq 'MANAGEMENT'}">
        <c:set var="boardUrl" value="/management"/>
        <c:set var="boardName" value="경영공시"/>
    </c:when>
    <c:when test="${board.brdType eq 'BIDDING'}">
        <c:set var="boardUrl" value="/bidding"/>
        <c:set var="boardName" value="입찰정보"/>
    </c:when>
    <c:when test="${board.brdType eq 'NEWS'}">
        <c:set var="boardUrl" value="/news"/>
        <c:set var="boardName" value="보도자료"/>
    </c:when>
    <c:when test="${board.brdType eq 'REPORT'}">
        <c:set var="boardUrl" value="/report"/>
        <c:set var="boardName" value="활동보고서"/>
    </c:when>
</c:choose>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>뉴스·자료</span><span>${boardName}</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">${boardName}</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>

            <ul class="sub_top_tab">
                <li class="${board.brdType eq 'NOTICE' ? 'on' : ''}"><a href="/notice/list">공지사항</a></li>
                <li class="${board.brdType eq 'MANAGEMENT' ? 'on' : ''}"><a href="/management/list">경영공시</a></li>
                <li class="${board.brdType eq 'BIDDING' ? 'on' : ''}"><a href="/bidding/list">입찰정보</a></li>
                <li class="${board.brdType eq 'NEWS' ? 'on' : ''}"><a href="/news/list">보도자료</a></li>
                <li class="${board.brdType eq 'REPORT' ? 'on' : ''}"><a href="/report/list">활동보고서</a></li>
            </ul>
        </div>
        <div class="sub_top view_top" style="padding: 0; padding-bottom: 20px;">
            <div class="sub_top_box">
                <div class="sub_top_tit" id="tts_title_top" style="font-size: 2em;">
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
                            <a href="${file.filePath}" target="_blank" download class="hover-glow text-decoration-none">
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
                <div>
                    ${board.content}
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