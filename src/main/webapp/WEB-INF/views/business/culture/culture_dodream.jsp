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
                    <span>주요사업</span><span>문화예술</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">문화예술</div>
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
                    <li><a href="/business/culture-art">스페셜올림픽 미술대회</a></li>
                    <li class="on"><a href="/business/culture-dodream">두드림 페스티벌</a></li>
                    <li><a href="/business/culture-support">국내외 공연 참가 지원</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    누구나 쉽게 접할 수 있는 '타악'이라는 장르를 통해 발달장애인과 가족, 비장애인이 다같이 즐길 수 있는 타악 축제로, <br/>다양한 문화예술을 체험하고 하나의 음악을 함께
                    완성해가는 통합 문화 페스티벌입니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/c5jqdSspIDw?mute=1&controls=0&loop=1&playlist=c5jqdSspIDw'
                                frameborder='0' allowfullscreen></iframe>
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
                        <div class="sub_top_tit" id="tts_sub_cult_dodoream">두드림 페스티벌 사진</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_dodoream">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/img_dodream1.jpg" alt="두드림 이미지">
                        </li>
                        <li>
                            <img src="/img/img_dodream2.jpg" alt="두드림 이미지">
                        </li>
                        <li>
                            <img src="/img/img_dodream3.jpg" alt="두드림 이미지">
                        </li>
                        <li>
                            <img src="/img/img_dodream4.jpg" alt="두드림 이미지">
                        </li>
                        <li>
                            <img src="/img/img_dodream5.jpg" alt="두드림 이미지">
                        </li>
                        <li>
                            <img src="/img/img_dodream6.jpg" alt="두드림 이미지">
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