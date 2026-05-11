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
                    <span>주요사업</span><span>스포츠</span><span>기타</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">기타</div>
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
                    <li><a href="/business/sports/unif">통합스포츠</a></li>
                    <li class="on"><a href="/business/sports/other">기타</a></li>
                </ul>
            </div>

            <div class="contest">
                <ul class="contest_tab column">
                    <li><a href="/business/sports/other">중증발달장애인 운동프로그램</a></li>
                    <li class="on"><a href="/business/sports/other-one">통합스포츠 한마음 대회</a></li>
                    <li><a href="/business/sports/other-hap">선수건강증진프로그램(HAP)</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">통합스포츠 한마음대회는 스페셜올림픽 정식 종목에 참여하는데 어려움이 있는 발달장애인 선수와 <br />
                    비장애인이 함께 참여할 수 있는 생활 스포츠 대회로서 스페셜올림픽 대회 종목의 규칙을 생활스포츠 형태로 변형하여 <br />
                    모든 참가자가 쉽고 즐겁게 스포츠 활동에 참여할 수 있는 다양한 프로그램을 제공합니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/W65-GB3jj6o?mute=1&controls=0&loop=1&playlist=W65-GB3jj6o' frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
            </div>

        </div>

        <!-- //section -->

        <!-- section -->
        <div class="sub_content p-0">
            <div class="sub_top">
                <div class="sub_top_box">
                    <!--

                    --소리듣기 재사용--
                    id=tts_2
                    data-taret=tts_2

                    -->
                    <div class="sub_top_tit" id="tts_sub_int_picture">통합스포츠 한마음 대회 사진</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_int_picture">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view">
                <ul class="img_item">
                    <li>
                        <img src="/img/contest_img_intl49.png" alt="프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl50.png" alt="프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl51.png" alt="프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl52.png" alt="프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl53.png" alt="프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl54.png" alt="프로그램 이미지">
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>