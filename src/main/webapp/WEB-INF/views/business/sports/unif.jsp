<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>주요사업</span><span>스포츠</span><span>통합스포츠</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">통합스포츠</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li class="on"><a href="/business/sports">스포츠</a></li>
                <li><a href="/business/culture">문화예술</a></li>
                <li><a href="/business/commu">커뮤니티</a></li>
                <li><a href="/business/awareness">인식개선</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab">
                    <li><a href="/business/sports">종목소개</a></li>
                    <li><a href="/business/sports/intl">국제대회참가</a></li>
                    <li><a href="/business/sports/domestic">국내대회개최</a></li>
                    <li class="on"><a href="/business/sports/unif">통합스포츠</a></li>
                    <li><a href="/business/sports/other">기타</a></li>
                </ul>
            </div>

            <div class="contest">
                <ul class="contest_tab column">
                    <li class="on"><a href="/business/sports/unif">통합스포츠단 지원</a></li>
                    <li><a href="/business/sports/unif-sport">국제통합스포츠대회</a></li>
                    <li><a href="/business/sports/unif-k-league">K리그 통합축구</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">통합스포츠는 발달장애인과 비장애인이 한 팀을 이루어 훈련하고, 경기에 참가하며 <br />
                    서로를 이해하고 기량을 향상시키는 스포츠 활동으로서 스페셜올림픽 국제 본부(SOI)가 중점적으로 진행하고 있는 프로그램입니다. <br />
                    이에 스페셜올림픽코리아에서는 매년 36개의 통합스포츠단 운영을 지원하고 있습니다.<br /><br />
                    ※ 지원 종목: 총 5종목(통합 농구,배구,축구,플로어볼, 배드민턴)
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/S_-mxTZPYpo?mute=1&controls=0&loop=1&playlist=S_-mxTZPYpo' frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
            </div>

        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>