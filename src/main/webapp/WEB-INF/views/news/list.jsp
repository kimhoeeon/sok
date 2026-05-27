<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>알림공간</span><span>스페셜올림픽코리아 소식</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">스페셜올림픽코리아 소식</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>

            <ul class="sub_top_tab">
                <li><a href="/notice/list">공지사항</a></li>
                <li><a href="/bidding/list">입찰정보</a></li>
                <li><a href="/careers/list">채용정보</a></li>
                <li><a href="/press/list">자료실</a></li>
                <li><a href="/report/list">활동보고서</a></li>
                <li class="on"><a href="/news/list">스페셜올림픽코리아 소식</a></li>
            </ul>
        </div>

        <div class="sub_content">

            <div class="board_gallery">
                <div class="board_gallery_box">

                    <form id="searchForm" action="/news/list" method="get" style="display:none;">
                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    </form>

                    <c:choose>
                        <c:when test="${empty list}">
                            <div style="text-align: center; padding: 60px 0; color: #777;">
                                등록된 스페셜올림픽코리아 소식이 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <ul>
                                <c:forEach var="item" items="${list}">
                                    <li>
                                        <a class="viewGallery" href="/news/detail?brdSeq=${item.brdSeq}">
                                            <div class="txtBox">
                                                <div class="badge news">소식</div>
                                                <div class="tit">${item.title}</div>
                                            </div>
                                            <div class="thumbBox">
                                                <c:choose>
                                                    <c:when test="${not empty item.thumbPath}">
                                                        <img src="${item.thumbPath}" alt="${item.title} 썸네일">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/img/thum_img.png" alt="썸네일 이미지">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${pageMaker.total > 0}">
                        <div class="paging">
                            <c:if test="${pageMaker.prev}">
                                <a href="javascript:goPage(1)" class="first"><img src="/img/btn_first.gif" alt="처음"></a>
                                <a href="javascript:goPage(${pageMaker.startPage - 1})" class="prev">
                                    <img src="/img/btn_prev.gif" alt="이전">
                                </a>
                            </c:if>

                            <ol>
                                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                    <li>
                                        <a href="javascript:goPage(${num})" class="${pageMaker.cri.pageNum == num ? 'this' : 'other'}">
                                            ${num}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ol>

                            <c:if test="${pageMaker.next}">
                                <a href="javascript:goPage(${pageMaker.endPage + 1})" class="next">
                                    <img src="/img/btn_next.gif" alt="다음">
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    // 페이지 이동 스크립트
    function goPage(pageNum) {
        document.getElementById('searchForm').pageNum.value = pageNum;
        document.getElementById('searchForm').submit();
    }
</script>