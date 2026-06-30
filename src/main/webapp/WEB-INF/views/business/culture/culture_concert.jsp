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
                    <span>사업소개</span><span>문화예술</span><span>SOK 연말음악회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">SOK 연말음악회</div>
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
                    <li class="on"><a href="/business/culture-concert">SOK 연말음악회</a></li>
                    <li><a href="/business/culture-dodream">두드림 페스티벌</a></li>
                    <li><a href="/business/culture-support">국내외 공연 참가 지원</a></li>
                    <li><a href="/business/culture-support-act">국내외 문화예술 활동 지원</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    국제 스페셜 뮤직&아트 페스티벌에서 배출된 음악적 재능이 있는 발달장애 아티스트들과 멘토와 함께하는 <br /> 무대를 통해 사회적 인식개선 및 전문연주자로서의 성장을 지원합니다.
                </div>
                <div class="poster">
                    <ul>
                        <li>
                            <img src="/img/concert_poster01.png" alt="포스터">
                            <div class="date">2025.12</div>
                            <div class="txt">2025 스페셜 하모니 <br>(장천아트홀)</div>
                        </li>
                        <li>
                            <img src="/img/concert_poster02.png" alt="포스터">
                            <div class="date">2025.05</div>
                            <div class="txt">2025 초청음악회 스페셜 하모니 <br>(건국대학교 새천년관 대공연장)</div>
                        </li>
                        <li>
                            <img src="/img/concert_poster03.png" alt="포스터">
                            <div class="date">2024.11</div>
                            <div class="txt">2024 스페셜 하모니 <br>(예술의 전당 IBK홀)</div>
                        </li>
                        <li>
                            <img src="/img/concert_poster04.png" alt="포스터">
                            <div class="date">2023.11</div>
                            <div class="txt">2023 스페셜 나이트 <br>(광림아트센터 BBCH홀)</div>
                        </li>
                        <li>
                            <img src="/img/concert_poster05.png" alt="포스터">
                            <div class="date">2019. 12</div>
                            <div class="txt">2019 스페셜 나이트 <br>(세종문화회관 M시어터)</div>
                        </li>
                    </ul>
                </div>
                <div class="video mt-60">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/-PjzQIhPIUU?mute=1&controls=0&loop=1&playlist=-PjzQIhPIUU' frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
                <div class="video mt-30">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/DJ_98jr1NUU?mute=1&controls=0&loop=1&playlist=DJ_98jr1NUU' frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
            </div>
            <div class="cult_img">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_cult_concert">SOK 연말음악회</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_concert">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/img_concert1.png" alt="연말음악회 이미지">
                        </li>
                        <li>
                            <img src="/img/img_concert2.png" alt="연말음악회 이미지">
                        </li>
                        <li>
                            <img src="/img/img_concert3.png" alt="연말음악회 이미지">
                        </li>
                        <li>
                            <img src="/img/img_concert4.png" alt="연말음악회 이미지">
                        </li>
                        <li>
                            <img src="/img/img_concert5.png" alt="연말음악회 이미지">
                        </li>
                        <li>
                            <img src="/img/img_concert6.png" alt="연말음악회 이미지">
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>