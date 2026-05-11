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
                    <li><a href="/business/sports/unif">통합스포츠단 지원</a></li>
                    <li class="on"><a href="/business/sports/unif-sport">국제통합스포츠대회</a></li>
                    <li><a href="/business/sports/unif-k-league">K리그 통합축구</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">국제통합스포츠대회는 발달장애인과 비장애인이 함께 참여하는 대회로서 <br />
                    SOK의 공모사업으로 운영되는 통합스포츠단 및 스페셜올림픽동아시아본부(SOEA) 소속 통합스포츠팀이 참가하여 그간 쌓아온 서로의 기량을 선보이는 대회입니다. <br />
                    대회 결과는 각종 스페셜올림픽 국제대회 통합스포츠 종목의 국가대표 선수 선발자료로 활용됩니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/x5-xnH4S6Wk?mute=1&controls=0&loop=1&playlist=x5-xnH4S6Wk' frameborder='0' allowfullscreen></iframe>
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
                    <div class="sub_top_tit" id="tts_sub_int_picture">국제통합스포츠대회 사진</div>
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
                        <img src="/img/contest_img_intl31.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl32.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl33.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl34.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl35.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl36.png" alt="스포츠 이미지">
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>