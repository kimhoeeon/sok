<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>홈</span><span>통합검색</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">통합검색</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="sub_content search_wrap">
        <div class="search_top">
            <div class="search_box">
                <input type="text" id="innerSearchKeyword" placeholder="검색어를 입력하세요" value="${fn:escapeXml(keyword)}"
                       onkeypress="if(event.keyCode==13) { executeInnerSearch(); return false; }">
                <button type="button" class="search_submit" onclick="executeInnerSearch()">
                    <img src="/img/ico_search_main.png" alt="검색">
                </button>
            </div>
        </div>
    </div>
    <div class="sub_content search_data">
        <div class="inner">

            <c:choose>
                <c:when test="${totalSum > 0}">

                    <div class="search_count">
                        <div>
                            "<span>${keyword}</span>" 에 관한 검색결과 <em>"<fmt:formatNumber value="${totalSum}" pattern="#,###"/>" 건</em>
                        </div>
                    </div>

                    <c:if test="${menuTotal > 0}">
                        <div class="search_data_list search_menu">
                            <div class="list_t">
                                <div class="tit">메뉴 <span class="num">(<span>${menuTotal}</span>건)</span></div>
                            </div>
                            <div class="list_data">
                                <c:forEach var="item" items="${menuList}">
                                    <a href="${item.url}">
                                        <div>${item.html}</div>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${noticeTotal > 0}">
                        <div class="search_data_list search_notice">
                            <div class="list_t">
                                <div class="tit">공지사항 <span class="num">(<span>${noticeTotal}</span>건)</span></div>
                                <c:if test="${noticeTotal > 5}">
                                    <div class="btn result_btn">
                                        <a href="/notice/list?searchKeyword=${keyword}">검색결과 더보기 +</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="list_data">
                                <ul>
                                    <c:forEach var="item" items="${noticeList}">
                                        <li>
                                            <a href="/notice/detail?brdSeq=${item.brdSeq}">
                                                <div class="flex">
                                                    <div class="tit">${item.title}</div>
                                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                                </div>
                                                <div class="desc">${item.content}</div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${bidTotal > 0}">
                        <div class="search_data_list">
                            <div class="list_t">
                                <div class="tit">입찰정보 <span class="num">(<span>${bidTotal}</span>건)</span></div>
                                <c:if test="${bidTotal > 5}">
                                    <div class="btn result_btn">
                                        <a href="/bidding/list?searchKeyword=${keyword}">검색결과 더보기 +</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="list_data">
                                <ul>
                                    <c:forEach var="item" items="${bidList}">
                                        <li>
                                            <a href="/bidding/detail?brdSeq=${item.brdSeq}">
                                                <div class="flex">
                                                    <div class="tit">${item.title}</div>
                                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                                </div>
                                                <div class="file">공고문(${item.title})</div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${careersTotal > 0}">
                        <div class="search_data_list">
                            <div class="list_t">
                                <div class="tit">채용정보 <span class="num">(<span>${careersTotal}</span>건)</span></div>
                                <c:if test="${careersTotal > 5}">
                                    <div class="btn result_btn">
                                        <a href="/careers/list?searchKeyword=${keyword}">검색결과 더보기 +</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="list_data">
                                <ul>
                                    <c:forEach var="item" items="${careersList}">
                                        <li>
                                            <a href="/careers/detail?brdSeq=${item.brdSeq}">
                                                <div class="flex">
                                                    <div class="tit">${item.title}</div>
                                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                                </div>
                                                <div class="file">채용공고 전문 보기</div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${pressTotal > 0}">
                        <div class="search_data_list">
                            <div class="list_t">
                                <div class="tit">자료실 <span class="num">(<span>${pressTotal}</span>건)</span></div>
                                <c:if test="${pressTotal > 5}">
                                    <div class="btn result_btn">
                                        <a href="/press/list?searchKeyword=${keyword}">검색결과 더보기 +</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="list_data">
                                <ul>
                                    <c:forEach var="item" items="${pressList}">
                                        <li>
                                            <a href="/press/detail?brdSeq=${item.brdSeq}">
                                                <div class="flex">
                                                    <div class="tit">${item.title}</div>
                                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                                </div>
                                                <div class="file">상세 및 첨부파일 보기</div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${reportTotal > 0}">
                        <div class="search_data_list">
                            <div class="list_t">
                                <div class="tit">활동보고서 <span class="num">(<span>${reportTotal}</span>건)</span></div>
                                <c:if test="${reportTotal > 5}">
                                    <div class="btn result_btn">
                                        <a href="/report/list?searchKeyword=${keyword}">검색결과 더보기 +</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="list_data">
                                <ul>
                                    <c:forEach var="item" items="${reportList}">
                                        <li>
                                            <a href="/report/detail?brdSeq=${item.brdSeq}">
                                                <div class="flex">
                                                    <div class="tit">${item.title}</div>
                                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                                </div>
                                                <div class="file">보고서 전문 보기</div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${newsTotal > 0}">
                        <div class="search_data_list search_news">
                            <div class="list_t">
                                <div class="tit">스페셜올림픽코리아 소식 <span class="num">(<span>${newsTotal}</span>건)</span>
                                </div>
                                <c:if test="${newsTotal > 5}">
                                    <div class="btn result_btn">
                                        <a href="/news/list?searchKeyword=${keyword}">검색결과 더보기 +</a>
                                    </div>
                                </c:if>
                            </div>
                            <div class="list_data">
                                <ul>
                                    <c:forEach var="item" items="${newsList}">
                                        <li>
                                            <a href="/news/detail?brdSeq=${item.brdSeq}">
                                                <div class="thum">
                                                    <img src="${not empty item.thumbPath ? item.thumbPath : '/img/img_default.jpg'}"
                                                         alt="${item.title}">
                                                </div>
                                                <div class="txt_box">
                                                    <div class="tit">${item.title}</div>
                                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy.MM.dd"/></div>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                </c:when>

                <c:otherwise>
                    <div class="search_count" style="margin-bottom: 80px; text-align: center; padding: 100px 0; border: 1px solid #d5d5d5; border-radius: 20px; background: #f9f9f9;">
                        <img src="/img/ico_notice.png" alt="안내" style="width: 48px; opacity: 0.5; margin-bottom: 20px;">
                        <div style="font-size: 1.25em;">
                            '<span style="color:var(--mainColor); font-weight:bold;">${keyword}</span>'에 대한 검색 결과가 없습니다.
                        </div>
                        <p style="color: #777; margin-top: 10px; font-size: 1em;">검색어의 철자가 정확한지 확인해 보세요.</p>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    // 페이지 내부의 검색창 전용 자바스크립트
    function executeInnerSearch() {
        var keyword = document.getElementById('innerSearchKeyword').value;
        if (!keyword.trim()) {
            alert('검색어를 입력해주세요.');
            document.getElementById('innerSearchKeyword').focus();
            return;
        }
        location.href = '/search?keyword=' + encodeURIComponent(keyword);
    }
</script>