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
                    <span>사업소개</span><span>문화예술</span><span>국내외 문화예술 활동 지원</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">국내외 문화예술 활동 지원</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/business/sports">스포츠</a></li>
                <li class="on"><a href="/business/culture">문화예술</a></li>
                <li><a href="/business/commu">커뮤니티</a></li>
                <li><a href="/business/awareness">인식개선</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/business/culture">국제 스페셜 뮤직&아트 페스티벌</a></li>
                    <li><a href="/business/culture-ensemble">SOK 앙상블</a></li>
                    <li><a href="/business/culture-concert">SOK 연말음악회</a></li>
                    <li><a href="/business/culture-dodream">두드림 페스티벌</a></li>
                    <li><a href="/business/culture-support">국내외 공연 참가 지원</a></li>
                    <li class="on"><a href="/business/culture-support-act">국내외 문화예술 활동 지원</a></li>
                </ul>
            </div>
            <div class="contest">
                <ul class="contest_tab column">
                    <li><a href="/business/culture-art">스페셜올림픽 미술대회</a></li>
                    <li class="on"><a href="/business/culture-support-act">국내외 공연 참가 지원</a></li>
                </ul>
            </div>
            <div class="culture_history">
                <div class="history_item right">
                    <span class="year">2021.11</span>
                    <p>2021 이웃사랑 나눔콘서트 (KBS홀)</p>
                </div>
                <div class="history_item left">
                    <span class="year">2019.03</span>
                    <p>아부다비 스페셜올림픽세계하계대회 개회식 축하공연<br>
                        (에미레이트 팰리스 오디토리움)</p>
                </div>
                <div class="history_item right">
                    <span class="year">2018.12</span>
                    <p>UN 세계 장애인의 날 기념행사 공연 (UN본부)</p>
                </div>
                <div class="history_item left">
                    <span class="year">2018.03</span>
                    <p>SOKEH 공연 - 강릉아트센터 사임당홀<br>
                        (SPECIAL OLYMPICS KOREA ECHO & HARMONY)</p>
                </div>
                <div class="history_item right">
                    <span class="year">2014 ~ 2018</span>
                    <p>UN 세계 장애인의 날 기념행사 공연 (UN본부)</p>
                </div>
            </div>
        </div>

        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>