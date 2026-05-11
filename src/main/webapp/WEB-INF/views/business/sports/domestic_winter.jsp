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
                    <span>주요사업</span><span>스포츠</span><span>국내대회개최</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">국내대회개최</div>
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
                    <li class="on"><a href="/business/sports/domestic">국내대회개최</a></li>
                    <li><a href="/business/sports/unif">통합스포츠</a></li>
                    <li><a href="/business/sports/other">기타</a></li>
                </ul>
            </div>

            <div class="contest">
                <ul class="contest_tab column">
                    <li><a href="/business/sports/domestic">전국하계대회</a></li>
                    <li class="on"><a href="/business/sports/domestic-winter">전국동계대회</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">스페셜올림픽코리아는 전국 동계대회 개최를 통해 전국의 발달장애인들에게 <br/>
                    동계 종목의 경기 참여 기회를 제공하고 있으며 대회 결과를 통해 세계동계대회 선발 자료로 활용하고 있습니다.<br/>
                    총 6개의 종목(알파인스키,스노보드,크로스컨트리,스노슈잉,쇼트트랙,스피드스케이팅,피겨스케이팅)이 운영되고 있습니다.

                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/7Wg9Bl9-eWQ&t?mute=1&controls=0&loop=1&playlist=7Wg9Bl9-eWQ'
                                frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
                <div class="video" style="margin-top: 10px;">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/5Z2kymbvjEg&t?mute=1&controls=0&loop=1&playlist=5Z2kymbvjEg'
                                frameborder='0' allowfullscreen></iframe>
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
                    <div class="sub_top_tit" id="tts_sub_int_picture">전국 동계대회 사진</div>
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
                        <img src="/img/contest_img_intl25.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl26.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl27.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl28.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl29.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl30.png" alt="스포츠 이미지">
                    </li>
                </ul>
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
                    <div class="sub_top_tit" id="tts_sub_cont_win">스페셜올림픽 역대 동계대회</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_cont_win">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view contest_sum">
                <ul class="img_item">
                    <li>
                        <span class="badge blue">1회차</span>
                        <div class="gu">2012 스페셜올림픽코리아 <br/>전국동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 평창, 강릉</div>
                            <div class="scale">참가인원 : 313</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">2회차</span>
                        <div class="gu">2016 스페셜올림픽코리아 <br/>전국동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 평창, 고양</div>
                            <div class="scale">참가인원 : 520</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">3회차</span>
                        <div class="gu">2019 스페셜올림픽코리아 <br/>전국동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 평창, 서울</div>
                            <div class="scale">참가인원 : 360</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">4회차</span>
                        <div class="gu">2022 스페셜올림픽코리아 <br/>전국동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 평창, 의정부</div>
                            <div class="scale">참가인원 : 212</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">5회차</span>
                        <div class="gu">2023 스페셜올림픽코리아 <br/>전국동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 평창, 경기</div>
                            <div class="scale">참가인원 : 235</div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>