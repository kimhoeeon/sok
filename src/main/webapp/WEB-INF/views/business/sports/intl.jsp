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

                <div class="sub_top_tit" id="tts_sub_top">국제대회참가</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li class="on"><a href="/business/sports">스포츠</a></li>
                <li><a href="/business/arts">문화예술</a></li>
                <li><a href="/business/community">커뮤니티</a></li>
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
                    <li><a href="/business/domestic">국내대회개최</a></li>
                    <li><a href="/business/unif">통합스포츠</a></li>
                    <li><a href="/business/other">기타</a></li>
                </ul>
            </div>

            <div class="contest">
                <ul class="contest_tab column">
                    <li class="on"><a href="/business/sports/intl">스페셜올림픽세계대회</a></li>
                    <li><a href="/business/sports/intl_global">VIRTUS 글로벌게임</a></li>
                    <li><a href="/business/sports/intl_category">종목별 국제대회</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">국제올림픽위원회(IOC, International Olympic Committee)와의 협약을 통해 <br/>
                    스페셜올림픽은 올림픽, 패럴림픽과 더불어‘올림픽’이라는 명칭을 공식적으로 사용할 수 있는 세계 대회를 개최하고 있습니다. <br/>
                    1968년 제1회 대회(시카고, 미국)를 시작으로 2년에 한 번씩 하계대회와 동계대회를 번갈아 개최하고 있으며, <br/>
                    대한민국은 2013년 평창에서 세계동계대회를 성공적으로 개최한 바 있습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/Ij2PbWIqqnM&t?mute=1&controls=0&loop=1&playlist=Ij2PbWIqqnM&t'
                                frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
                <div class="btn link_btn">
                    <a href="http://worldgame.sokorea.or.kr/" class="b_hover" target="_blank">사이트 바로가기</a>
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
                    <div class="sub_top_tit" id="tts_sub_int_picture">스페셜올림픽 대회 사진</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_int_picture">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view">
                <ul class="img_item">
                    <li><img src="/img/contest_img_intl01.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl02.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl03.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl04.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl05.png" alt="스포츠 이미지"></li>
                    <li><img src="/img/contest_img_intl06.png" alt="스포츠 이미지"></li>
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
                    <div class="sub_top_tit" id="tts_sub_cont_sum">스페셜올림픽 역대 하계대회</div>
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
                        <div class="gu">1968 시카고 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 시카고(미국)</div>
                            <div class="scale">대회규모 : 1,000명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">2회차</span>
                        <div class="gu">1970 시카고 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 시카고(미국)</div>
                            <div class="scale">대회규모 : 2,000명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">3회차</span>
                        <div class="gu">1972 로스엔젤레스 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 로스엔젤레스(미국)</div>
                            <div class="scale">대회규모 : 2,500명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">4회차</span>
                        <div class="gu">1975 미시건 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 미시건(미국)</div>
                            <div class="scale">대회규모 : 3,200명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">5회차</span>
                        <div class="gu">1979 뉴욕 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 뉴욕(미국)</div>
                            <div class="scale">대회규모 : 3,500명 / 참가인원 : 4명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">6회차</span>
                        <div class="gu">1983 루이지애나 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 루이지애나(미국)</div>
                            <div class="scale">대회규모 : 4,000명 / 참가인원 : 7명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">7회차</span>
                        <div class="gu">1987 인디아나 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 인디아나(미국)</div>
                            <div class="scale">대회규모 : 4,700명 / 참가인원 : 34명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">8회차</span>
                        <div class="gu">1991 미네아폴리스 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 미네아폴리스(미국)</div>
                            <div class="scale">대회규모 : 6,000명 / 참가인원 : 52명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">9회차</span>
                        <div class="gu">1995 코네티켓 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 코네티켓(미국)</div>
                            <div class="scale">대회규모 : 7,000명 / 참가인원 : 40명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">10회차</span>
                        <div class="gu">1999 노스캐롤라이나 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 노스캐롤라이나(미국)</div>
                            <div class="scale">대회규모 : 7,000명 / 참가인원 : 30명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">11회차</span>
                        <div class="gu">2003 더블린 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 더블린(아일랜드)</div>
                            <div class="scale">대회규모 : 6,500명 / 참가인원 : 40명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">12회차</span>
                        <div class="gu">2007 상하이 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 상하이(중국)</div>
                            <div class="scale">대회규모 : 7,291명 / 참가인원 : 50명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">13회차</span>
                        <div class="gu">2011 아테네 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 아테네(그리스)</div>
                            <div class="scale">대회규모 : 7,000명 / 참가인원 : 111명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">14회차</span>
                        <div class="gu">2015 로스엔젤레스 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 로스엔젤레스(미국)</div>
                            <div class="scale">대회규모 : 7,000명 / 참가인원 : 131명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">15회차</span>
                        <div class="gu">2019 아부다비 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 아부다비(UAE)</div>
                            <div class="scale">대회규모 : 7,000명 / 참가인원 : 151명</div>
                        </div>
                    </li>
                    <li>
                        <span class="badge orange">16회차</span>
                        <div class="gu">2023 베를린 <br/>스페셜올림픽 세계하계대회</div>
                        <div class="txt_box">
                            <div class="venue">개최지 : 베를린(독일)</div>
                            <div class="scale">대회규모 : 6,500명 / 참가인원 : 150명</div>
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