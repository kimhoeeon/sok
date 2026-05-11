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
                    <span>주요사업</span><span>스포츠</span><span>국제대회참가</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">스페셜올림픽 세계대회</div>
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
                    <li class="on"><a href="/business/sports/intl-global">VIRTUS 글로벌게임</a></li>
                    <li><a href="/business/sports/intl-category">종목별 국제대회</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">VIRTUS 글로벌게임은 세계 최대 규모의 발달장애인 엘리트 스포츠 대회입니다. <br/>
                    4년마다 개최되며 전 세계에서 천 명이 넘는 선수들이 모여 17개 종목에서 메달을 놓고 경쟁합니다.<br/><br/>

                    현재 정식 종목 12개(육상, 농구, 크리켓, 사이클, 승마, 풋볼/풋살, 유도, 조정, 스키, 수영, 탁구, 테니스)와<br/>
                    시범 종목 5개(골프, 가라테, 파라 하키, 요트, 태권도)를 운영하고 있습니다.<br/><br/>

                    2004년 스웨덴에서 제 1회 글로벌게임이 시작되었으며 2023년 프랑스 비시에서 제 6회 대회가 개최되었습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/nyW19ZLbuuQ&t?mute=1&controls=0&loop=1&playlist=nyW19ZLbuuQ'
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
                    <div class="sub_top_tit" id="tts_sub_int_picture">VIRTUS 글로벌게임 사진</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_int_picture">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view">
                <ul class="img_item">
                    <li><img src="/img/contest_img_intl07.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl08.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl09.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl10.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl11.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl12.png" alt="스포츠 이미지"></li>
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
                    <div class="sub_top_tit" id="tts_sub_cont_sum">VIRTUS 글로벌게임 역대 대회</div>
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
                        <span class="badge orange">하계 1회차</span>
                        <div class="gu">2004 볼라스 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 볼라스(스웨덴)</div>
                            <div class="scale">대회규모 : 1,000명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">하계 2회차</span>
                        <div class="gu">2009 리베레츠 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 리베레츠(체코)</div>
                            <div class="scale">대회규모 : 800명 / 참가인원 : 24명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">하계 3회차</span>
                        <div class="gu">2011 리구리아주 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 리구리아주(이탈리아)</div>
                            <div class="scale">대회규모 : 700명 / 참가인원 : 36명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">하계 4회차</span>
                        <div class="gu">2015 과야킬, 과란다 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 과야킬, 과란다(에콰도르)</div>
                            <div class="scale">대회규모 : 600명 / 참가인원 : 23명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">하계 5회차</span>
                        <div class="gu">2019 브리즈번 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 브리즈번(호주)</div>
                            <div class="scale">대회규모 : 814명 / 참가인원 : 42명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">하계 6회차</span>
                        <div class="gu">2023 비시 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 비시(프랑스)</div>
                            <div class="scale">대회규모 : 1,000명 / 참가인원 : 40명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">하계 7회차</span>
                        <div class="gu">2027 카이로 <br/>VIRTUS 글로벌게임</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 카이로(이집트)</div>
                            <div class="scale">대회예정</div>
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