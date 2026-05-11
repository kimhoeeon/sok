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
                    <li class="on"><a href="/business/sports/domestic">전국하계대회</a></li>
                    <li><a href="/business/sports/domestic-winter">전국동계대회</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">스페셜올림픽코리아는 전국 하계대회 개최를 통해 전국의 발달 장애인들에게 다양한 경기 종목의 참여 기회를 제공하고 <br/>
                    우수 선수 발굴 및 육성을 통해 스페셜올림픽 세계대회 및 Virtus 글로벌게임 선발 자료로 활용하고 있습니다.<br/>
                    총 12개 정식 종목(배구, 축구, 탁구, 농구, 배드민턴, 육상, 수영, 골프, 보체, 롤러스케이트, 역도, 태권도(품새))과 2개 시범종목(핸드볼, MATP)이 있습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/FFDaS88z5J8?mute=1&controls=0&loop=1&playlist=FFDaS88z5J8'
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
                    <div class="sub_top_tit" id="tts_sub_int_picture">전국 하계대회 사진</div>
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
                        <img src="/img/contest_img_intl19.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl20.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl21.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl22.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl23.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl24.png" alt="스포츠 이미지">
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
                    <div class="sub_top_tit" id="tts_sub_cont_sum">역대 전국하계대회</div>
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
                        <span class="badge orange">1회차</span>
                        <div class="gu">1999 한국 스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 순천향대학교</div>
                            <div class="scale">참가인원 : -</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2회차</span>
                        <div class="gu">2000 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 명지대학교</div>
                            <div class="scale">참가인원 : -</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">3회차</span>
                        <div class="gu">2002 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 국군체육부대</div>
                            <div class="scale">참가인원 : -</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">4회차</span>
                        <div class="gu">2005 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 국군체육부대</div>
                            <div class="scale">참가인원 : -</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">5회차</span>
                        <div class="gu">2006 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 명지대학교</div>
                            <div class="scale">참가인원 : 1,394</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">6회차</span>
                        <div class="gu">2008 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 강원도 평창군</div>
                            <div class="scale">참가인원 : 1,424</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">7회차</span>
                        <div class="gu">2009 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 우석대학교</div>
                            <div class="scale">참가인원 : 1,924</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">8회차</span>
                        <div class="gu">2010 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 대구광역시</div>
                            <div class="scale">참가인원 : 2,100</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">9회차</span>
                        <div class="gu">2012 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 경상북도 경산시</div>
                            <div class="scale">참가인원 : 1,200</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">10회차</span>
                        <div class="gu">2013 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 경기도 수원시</div>
                            <div class="scale">참가인원 : 3,000</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">11회차</span>
                        <div class="gu">2014 한국스페셜올림픽 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 강원도 일대</div>
                            <div class="scale">참가인원 : 2,500</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">12회차</span>
                        <div class="gu">2016 스페셜올림픽코리아 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 서울특별시</div>
                            <div class="scale">참가인원 : 1,833</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">13회차</span>
                        <div class="gu">2017 스페셜올림픽코리아 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 경상남도 창원시</div>
                            <div class="scale">참가인원 : 2,200</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">14회차</span>
                        <div class="gu">2018 스페셜올림픽코리아 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 충청남도 홍성군</div>
                            <div class="scale">참가인원 : 2,500</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">15회차</span>
                        <div class="gu">2021 스페셜올림픽코리아 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 제주도 서귀포시</div>
                            <div class="scale">참가인원 : 1,100</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">16회차</span>
                        <div class="gu">2022 스페셜올림픽코리아 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 제주도 서귀포시</div>
                            <div class="scale">참가인원 : 2,000</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">17회차</span>
                        <div class="gu">2024 스페셜올림픽코리아 <br/>전국하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 인천광역시</div>
                            <div class="scale">참가인원 : 2,479</div>
                        </div>
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
                        <div class="gu">1977 콜로라도 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 콜로라도(미국)</div>
                            <div class="scale">대회규모 : 500명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">2회차</span>
                        <div class="gu">1981 버몬트 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 버몬트(미국)</div>
                            <div class="scale">대회규모 : 600명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">3회차</span>
                        <div class="gu">1985 유타 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 유타(미국)</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">4회차</span>
                        <div class="gu">1989 네바다 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 네바다(미국)</div>
                            <div class="scale">대회규모 : 1,000명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">5회차</span>
                        <div class="gu">1993 잘츠부르크 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 잘츠부르크(오스트리아)</div>
                            <div class="scale">대회규모 : 1,600명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">6회차</span>
                        <div class="gu">1997 토론토 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 토론토(캐나다)</div>
                            <div class="scale">대회규모 : 2,000명 / 참가인원 : 19명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">7회차</span>
                        <div class="gu">2001 앵커리지 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 앵커리지(미국)</div>
                            <div class="scale">대회규모 : 1,800명 / 참가인원 : 36명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">8회차</span>
                        <div class="gu">2005 나가노 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 나가노(일본)</div>
                            <div class="scale">대회규모 : 2,600명 / 참가인원 : 44명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">9회차</span>
                        <div class="gu">2009 아이다호 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 아이다호(미국)</div>
                            <div class="scale">대회규모 : 2,750명 / 참가인원 : 94명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">10회차</span>
                        <div class="gu">2013 평창 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 평창(대한민국)</div>
                            <div class="scale">대회규모 : 3,003명 / 참가인원 : 236명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">11회차</span>
                        <div class="gu">2017 그라츠,쉴라드밍 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 그라츠,쉴라드밍(오스트리아)</div>
                            <div class="scale">대회규모 : 2,700명 / 참가인원 : 93명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">12회차</span>
                        <div class="gu">2022 카잔 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 카잔(러시아)</div>
                            <div class="scale">대회취소</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge blue">13회차</span>
                        <div class="gu">2025 토리노 <br/>스페셜올림픽 세계동계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 토리노(이탈리아)</div>
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