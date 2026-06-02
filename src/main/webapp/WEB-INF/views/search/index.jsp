<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <!-- section -->
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
        <!-- //section -->

        <div class="sub_content">
            <div class="search_wrap">
                <div class="search_result_top">
                    <div class="txt">
                        '<span class="keyword" style="color:var(--mainColor); font-weight:bold;">${keyword}</span>'에 대한
                        검색 결과는
                        총 <span class="count" style="color:var(--mainColor); font-weight:bold;">${totalSum}</span>건 입니다.
                    </div>
                </div>

                <div class="search_sec">
                    <div class="sec_top"
                         style="display:flex; justify-content:space-between; align-items:center; border-bottom:2px solid #222; padding-bottom:15px; margin-bottom:20px;">
                        <div class="tit" style="font-size:1.5rem; font-weight:bold;">공지사항 <span
                                style="color:#888; font-size:1rem; font-weight:normal;">(${noticeTotal != null ? noticeTotal : 0}건)</span>
                        </div>
                        <c:if test="${noticeTotal > 5}">
                            <a href="/notice/list?searchKeyword=${keyword}" class="go_link" style="color:#555;">더 보기
                                +</a>
                        </c:if>
                    </div>
                    <div class="board_table">
                        <ul>
                            <c:forEach var="item" items="${noticeList}">
                                <li style="cursor:pointer;"
                                    onclick="location.href='/notice/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty noticeList}">
                                <li style="text-align:center; padding:40px 0; color:#888;">'${keyword}'에 대한 검색 결과가
                                    없습니다.
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>

                <div class="search_sec" style="margin-top:60px;">
                    <div class="sec_top"
                         style="display:flex; justify-content:space-between; align-items:center; border-bottom:2px solid #222; padding-bottom:15px; margin-bottom:20px;">
                        <div class="tit" style="font-size:1.5rem; font-weight:bold;">SOK 소식 <span
                                style="color:#888; font-size:1rem; font-weight:normal;">(${newsTotal != null ? newsTotal : 0}건)</span>
                        </div>
                        <c:if test="${newsTotal > 5}">
                            <a href="/news/list?searchKeyword=${keyword}" class="go_link" style="color:#555;">더 보기 +</a>
                        </c:if>
                    </div>
                    <div class="board_table">
                        <ul>
                            <c:forEach var="item" items="${newsList}">
                                <li style="cursor:pointer;"
                                    onclick="location.href='/news/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty newsList}">
                                <li style="text-align:center; padding:40px 0; color:#888;">'${keyword}'에 대한 검색 결과가
                                    없습니다.
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>

                <div class="search_sec" style="margin-top:60px;">
                    <div class="sec_top"
                         style="display:flex; justify-content:space-between; align-items:center; border-bottom:2px solid #222; padding-bottom:15px; margin-bottom:20px;">
                        <div class="tit" style="font-size:1.5rem; font-weight:bold;">채용공고 <span
                                style="color:#888; font-size:1rem; font-weight:normal;">(${careersTotal != null ? careersTotal : 0}건)</span>
                        </div>
                        <c:if test="${careersTotal > 5}">
                            <a href="/careers/list?searchKeyword=${keyword}" class="go_link" style="color:#555;">더 보기
                                +</a>
                        </c:if>
                    </div>
                    <div class="board_table">
                        <ul>
                            <c:forEach var="item" items="${careersList}">
                                <li style="cursor:pointer;"
                                    onclick="location.href='/careers/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty careersList}">
                                <li style="text-align:center; padding:40px 0; color:#888;">'${keyword}'에 대한 검색 결과가
                                    없습니다.
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>

                <div class="search_sec" style="margin-top:60px;">
                    <div class="sec_top"
                         style="display:flex; justify-content:space-between; align-items:center; border-bottom:2px solid #222; padding-bottom:15px; margin-bottom:20px;">
                        <div class="tit" style="font-size:1.5rem; font-weight:bold;">입찰공고 <span
                                style="color:#888; font-size:1rem; font-weight:normal;">(${bidTotal != null ? bidTotal : 0}건)</span>
                        </div>
                        <c:if test="${bidTotal > 5}">
                            <a href="/bidding/list?searchKeyword=${keyword}" class="go_link" style="color:#555;">더 보기
                                +</a>
                        </c:if>
                    </div>
                    <div class="board_table">
                        <ul>
                            <c:forEach var="item" items="${bidList}">
                                <li style="cursor:pointer;"
                                    onclick="location.href='/bidding/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd"/></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty bidList}">
                                <li style="text-align:center; padding:40px 0; color:#888;">'${keyword}'에 대한 검색 결과가
                                    없습니다.
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>