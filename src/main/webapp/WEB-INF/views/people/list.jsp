<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>함께하는 사람들</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">스포츠 안에서 더욱 빛나는 <br/>그들의 이야기를 만나보세요.</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">

            <div class="sub_tab">
                <ul class="board_tab">
                    <li class="${empty params.category ? 'on' : ''}">
                        <a href="/people/list">전체</a>
                    </li>
                    <li class="${params.category eq '선수' ? 'on' : ''}">
                        <a href="/people/list?category=선수">선수</a>
                    </li>
                    <li class="${params.category eq '아티스트' ? 'on' : ''}">
                        <a href="/people/list?category=아티스트">아티스트</a>
                    </li>
                    <li class="${params.category eq '패밀리' ? 'on' : ''}">
                        <a href="/people/list?category=패밀리">패밀리</a>
                    </li>
                    <li class="${params.category eq '프렌즈' ? 'on' : ''}">
                        <a href="/people/list?category=프렌즈">프렌즈</a>
                    </li>
                    <li class="${params.category eq '스폰서' ? 'on' : ''}">
                        <a href="/people/list?category=스폰서">스폰서</a>
                    </li>
                    <li class="${params.category eq '소식' ? 'on' : ''}">
                        <a href="/people/list?category=소식">소식</a>
                    </li>
                </ul>
            </div>

            <div class="board_gallery">
                <div class="board_gallery_box">
                    <ul>
                        <c:choose>
                            <c:when test="${empty list}">
                                <li style="width: 100%; grid-column: 1 / -1; text-align: center; padding: 60px 0; color: #777;">
                                    등록된 인물 또는 소식이 없습니다.
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${list}">

                                    <c:set var="badgeClass" value="sponsor"/>
                                    <c:choose>
                                        <c:when test="${item.category eq '선수'}"><c:set var="badgeClass" value="player"/></c:when>
                                        <c:when test="${item.category eq '아티스트'}"><c:set var="badgeClass"
                                                                                         value="artist"/></c:when>
                                        <c:when test="${item.category eq '패밀리'}"><c:set var="badgeClass"
                                                                                        value="family"/></c:when>
                                        <c:when test="${item.category eq '프렌즈'}"><c:set var="badgeClass"
                                                                                        value="friends"/></c:when>
                                        <c:when test="${item.category eq '스폰서'}"><c:set var="badgeClass"
                                                                                        value="sponsor"/></c:when>
                                        <c:when test="${item.category eq '소식'}"><c:set var="badgeClass"
                                                                                       value="news"/></c:when>
                                    </c:choose>

                                    <li>
                                        <a class="viewGallery"
                                           href="/people/detail?brdSeq=${item.brdSeq}&pageNum=${pageMaker.cri.pageNum}&category=${params.category}">
                                            <div class="txtBox">
                                                <div class="badge ${badgeClass}">${not empty item.category ? item.category : '-'}</div>
                                                <div class="tit">
                                                    <c:if test="${item.isNotice eq 'Y'}"><span
                                                            style="color: #DF0031; font-size: 14px; vertical-align: middle; margin-right: 5px;">[메인]</span></c:if>
                                                        ${item.title}
                                                </div>
                                            </div>
                                            <div class="thumbBox">
                                                <c:choose>
                                                    <c:when test="${not empty item.fileList}">
                                                        <img src="${item.fileList[0].filePath}" alt="썸네일 이미지">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/img/logo.png" alt="기본 썸네일"
                                                             style="object-fit: contain; padding: 30px; background: #f9f9f9; border: 1px solid #eee;">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>

                    <c:if test="${pageMaker.total > 0}">
                        <div class="paging">
                            <c:if test="${pageMaker.prev}">
                                <a href="javascript:goPage(1)" class="first"><img src="/img/btn_first.gif" alt="처음"></a>
                                <a href="javascript:goPage(${pageMaker.startPage - 1})" class="prev"><img
                                        src="/img/btn_prev.gif" alt="이전"></a>
                            </c:if>

                            <ol>
                                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                    <li>
                                        <a href="javascript:goPage(${num})"
                                           class="${pageMaker.cri.pageNum == num ? 'this' : 'other'}">${num}</a>
                                    </li>
                                </c:forEach>
                            </ol>

                            <c:if test="${pageMaker.next}">
                                <a href="javascript:goPage(${pageMaker.endPage + 1})" class="next"><img
                                        src="/img/btn_next.gif" alt="다음"></a>
                            </c:if>
                        </div>
                    </c:if>
                    <form id="searchForm" action="/people/list" method="get" style="display:none;">
                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                        <input type="hidden" name="category" value="${params.category}">
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    function goPage(pageNum) {
        document.getElementById('searchForm').pageNum.value = pageNum;
        document.getElementById('searchForm').submit();
    }
</script>