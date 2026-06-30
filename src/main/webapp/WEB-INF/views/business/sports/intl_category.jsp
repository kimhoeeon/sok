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
                    <span>사업소개</span><span>스포츠</span><span>국제대회참가</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">종목별 국제대회</div>
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
                    <li class="on"><a href="/business/sports/intl">국제대회참가</a></li>
                    <li><a href="/business/sports/domestic">국내대회개최</a></li>
                    <li><a href="/business/sports/unif">통합스포츠</a></li>
                    <li><a href="/business/sports/other">기타</a></li>
                </ul>
            </div>

            <div class="contest">
                <ul class="contest_tab column">
                    <li><a href="/business/sports/intl">스페셜올림픽세계대회</a></li>
                    <li><a href="/business/sports/intl-global">VIRTUS 글로벌게임</a></li>
                    <li class="on"><a href="/business/sports/intl-category">종목별 국제대회</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">스페셜올림픽코리아는 스페셜올림픽 세계대회뿐만 아니라 지역별(SOEA)대회 및 VIRTUS 주최 종목별 국제대회 및 친선 교류전을 개최 및 참가하고 있습니다.
                    <br/>
                    이를 통해 발달장애인 선수단에 다양한 기회를 제공하고 있으며, 대한민국 발달장애인 체육의 위상을 널리 알리기 위해 노력하고 있습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/9wRyLjG0aP0&t?mute=1&controls=0&loop=1&playlist=9wRyLjG0aP0'
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
                    <div class="sub_top_tit" id="tts_sub_int_picture">종목별 국제대회 사진</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_int_picture">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view">
                <ul class="img_item">
                    <li><img src="/img/contest_img_intl13.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl14.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl15.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl16.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl17.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl18.png" alt="스포츠 이미지"></li>
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
                    <div class="sub_top_tit" id="tts_sub_cont_sum">역대 종목별 국제대회</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_cont_sum">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view contest_sum">
                <ul class="img_item">
                    <li>
                        <span class="badge orange">2015</span>
                        <div class="gu">제 6회 중국 <br />롤러스케이트 대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국</div>
                            <div class="scale">참가규모 : 10</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2015</span>
                        <div class="gu">SOEA 통합보체 대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 대만</div>
                            <div class="scale">참가규모 : 6</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2016</span>
                        <div class="gu">SOEA 배드민턴대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국</div>
                            <div class="scale">참가규모 : 6</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2016</span>
                        <div class="gu">인도 통합축구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 인도</div>
                            <div class="scale">참가규모 : 20</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2016</span>
                        <div class="gu">일본 통합축구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 일본</div>
                            <div class="scale">참가규모 : 20</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2016</span>
                        <div class="gu">홍콩 종목별 대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 홍콩</div>
                            <div class="scale">참가규모 : 42</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2016</span>
                        <div class="gu">스페인오픈탁구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 스페인</div>
                            <div class="scale">참가규모 : 9</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2017</span>
                        <div class="gu">SOEA 통합농구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국</div>
                            <div class="scale">참가규모 : 10</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2016</span>
                        <div class="gu">스페인오픈탁구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 스페인</div>
                            <div class="scale">참가규모 : 9</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2017</span>
                        <div class="gu">SOEA 통합농구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국</div>
                            <div class="scale">참가규모 : 10</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2018</span>
                        <div class="gu">50주년 기념 시카고 스페셜올림픽 통합축구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 미국 시카고</div>
                            <div class="scale">참가규모 : 15</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2018</span>
                        <div class="gu">스페셜올림픽 동아시아지역 보체대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 홍콩</div>
                            <div class="scale">참가규모 : 13</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2018</span>
                        <div class="gu">SOEA 통합스쿨 축구리그 대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국, 상해 스포츠대학교</div>
                            <div class="scale">참가규모 : 13</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2019</span>
                        <div class="gu"> SOAP 통합배드민턴 대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 방콕, 태국</div>
                            <div class="scale">참가규모 : 6</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2019</span>
                        <div class="gu">SOEA 통합농구대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국</div>
                            <div class="scale">참가규모 : 8</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2019</span>
                        <div class="gu">한일발달장애인 스포츠교류전</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 도쿄, 일본</div>
                            <div class="scale">참가규모 : 29</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2019</span>
                        <div class="gu">SOEA 통합스쿨 축구리그</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 쿤밍, 중국</div>
                            <div class="scale">참가규모 : 13</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2019</span>
                        <div class="gu">Special Olympics International Football Championship </div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 첸나이, 인도 </div>
                            <div class="scale">참가규모 : 11</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2019</span>
                        <div class="gu">INAS 글로벌게임 참가</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 브리즈번, 호주</div>
                            <div class="scale">참가규모 : 42</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2022</span>
                        <div class="gu">디트로이트 스페셜올림픽 유니파이드컵</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 미국, 디트로이트</div>
                            <div class="scale">참가규모 : 21</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2023</span>
                        <div class="gu">SOEA 상하이 통합플로어볼 대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 중국, 상하이 </div>
                            <div class="scale">참가규모 : 12</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2023</span>
                        <div class="gu">SOEA 홍콩 보체대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 홍콩 다푸 구</div>
                            <div class="scale">참가규모 : 13</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2025</span>
                        <div class="gu">제49회 스페셜올림픽 홍콩 수영대회 </div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 홍콩 쭈엔완구</div>
                            <div class="scale">참가규모 : 7</div>
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