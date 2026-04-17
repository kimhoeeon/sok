<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>뉴스·자료</span><span>입찰정보</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top">입찰정보</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>

            <ul class="sub_top_tab">
                <li><a href="/notice/list">공지사항</a></li>
                <li><a href="/management/list">경영공시</a></li>
                <li class="on"><a href="/bidding/list">입찰정보</a></li>
                <li><a href="/news/list">보도자료</a></li>
                <li><a href="/report/list">활동보고서</a></li>
            </ul>
        </div>
        <div class="sub_content board_wrap">
            <div class="board_top">
                <div class="total">총 <span><fmt:formatNumber value="${pageMaker.total}" pattern="#,###"/></span>건</div>
                <div class="search_box">
                    <form action="/bidding/list" method="get" id="searchForm" class="search_box">
                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

                        <div class="select">
                            <select name="searchType">
                                <option value="all" ${params.searchType eq 'all' ? 'selected' : ''}>전체</option>
                                <option value="title" ${params.searchType eq 'title' ? 'selected' : ''}>글제목</option>
                                <option value="content" ${params.searchType eq 'content' ? 'selected' : ''}>내용</option>
                            </select>
                        </div>
                        <div class="input">
                            <input type="text" name="searchKeyword" value="${params.searchKeyword}"
                                   placeholder="검색어를 입력하세요.">
                            <a href="javascript:void(0);" onclick="searchData()" class="search_btn"></a>
                        </div>
                    </form>
                </div>
            </div>

            <div class="board_list">
                <ul>
                    <c:choose>
                        <c:when test="${empty list}">
                            <li style="text-align: center; padding: 60px 0; color: #777;">
                                등록된 입찰정보가 없습니다.
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${list}">
                                <li class="${item.isNotice eq 'Y' ? 'import' : ''}"
                                    onclick="location.href='/bidding/detail?brdSeq=${item.brdSeq}'"
                                    style="cursor: pointer;">

                                    <div class="tit ${not empty item.fileList ? 'file' : ''}">
                                            <%-- 관리자에서 설정한 진행중/마감 상태 표시 --%>
                                        <c:choose>
                                            <c:when test="${item.category eq '진행중'}">
                                                <span style="color:var(--mainColor); margin-right:5px; font-weight:900;">[진행중]</span>
                                            </c:when>
                                            <c:when test="${item.category eq '마감'}">
                                                <span style="color:#777; margin-right:5px; font-weight:900;">[마감]</span>
                                            </c:when>
                                        </c:choose>
                                            ${item.title}
                                    </div>

                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

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
                        <a href="javascript:goPage(${pageMaker.endPage + 1})" class="next"><img src="/img/btn_next.gif"
                                                                                                alt="다음"></a>
                    </c:if>
                </div>
            </c:if>
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

    // 검색 버튼 클릭 스크립트
    function searchData() {
        document.getElementById('searchForm').pageNum.value = 1;
        document.getElementById('searchForm').submit();
    }
</script>