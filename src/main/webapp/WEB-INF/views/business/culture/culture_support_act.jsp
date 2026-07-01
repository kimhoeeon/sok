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
            <div class="art_info mt-60">
                <div class="txt">
                    뉴욕 UN 본부 공연, 아부다비 뮤직 페스티벌, 네덜란드 유나이티드 바이 뮤직 등의 해외 공연 및 국내에서 열리는 스페셜 연말음악회와 <br />다양한 스포츠 이벤트의 축하 공연 등에 국제 스페셜 뮤직&아트 페스티벌 출신 발달장애 아티스트들이 무대에 설 수 있도록 적극적으로 지원하고 있습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/B1IOg2evv7I?mute=1&controls=0&loop=1&playlist=B1IOg2evv7I' frameborder='0' allowfullscreen></iframe>
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
                        <div class="sub_top_tit" id="tts_sub_cult_join">국내외 공연 참가 지원 사진</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_join">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/support.jpg" alt="국내외 공연 참가 지원 이미지">
                        </li>
                        <li>
                            <img src="/img/support2.jpg" alt="국내외 공연 참가 지원 이미지">
                        </li>
                        <li>
                            <img src="/img/support3.jpg" alt="국내외 공연 참가 지원 이미지">
                        </li>
                        <li>
                            <img src="/img/support4.jpg" alt="국내외 공연 참가 지원 이미지">
                        </li>
                        <li>
                            <img src="/img/support5.jpg" alt="국내외 공연 참가 지원 이미지">
                        </li>
                        <li>
                            <img src="/img/support6.jpg" alt="국내외 공연 참가 지원 이미지">
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