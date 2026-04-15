<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>뉴스·자료</span><span>활동보고서</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">활동보고서</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>

            <ul class="sub_top_tab">
                <li><a href="/notice/list">공지사항</a></li>
                <li><a href="/management/list">경영공시</a></li>
                <li><a href="/bidding/list">입찰정보</a></li>
                <li><a href="/news/list">보도자료</a></li>
                <li class="on"><a href="/report/list">활동보고서</a></li>
            </ul>
        </div>
        <div class="sub_content gallery_wrap report">

            <div class="board_top">
                <div class="total">총 <span><fmt:formatNumber value="${pageMaker.total}" pattern="#,###"/></span>건</div>
                <div class="search_box">
                    <form action="/report/list" method="get" id="searchForm" class="search_box">
                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">

                        <div class="select">
                            <select name="searchType">
                                <option value="title" ${params.searchType eq 'title' ? 'selected' : ''}>제목</option>
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

            <div class="gallery_list">
                <ul>
                    <c:choose>
                        <c:when test="${empty list}">
                            <li style="width: 100%; text-align: center; padding: 60px 0; color: #777;">
                                등록된 활동보고서가 없습니다.
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${list}">
                                <li onclick="location.href='/report/detail?brdSeq=${item.brdSeq}'"
                                    style="cursor: pointer;">

                                    <div>
                                        <c:choose>
                                            <c:when test="${not empty item.fileList}">
                                                <img src="${item.fileList[0].filePath}" alt="보고서 표지">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="/img/logo.png" alt="기본 이미지"
                                                     style="object-fit: contain; padding: 20px; background: #f8f9fa; border: 1px solid #d5d5d5;">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>

                                    <div class="tit">${item.title}</div>
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

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>