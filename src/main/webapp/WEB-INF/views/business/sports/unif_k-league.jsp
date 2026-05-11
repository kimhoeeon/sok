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
                    <li><a href="/business/sports/unif-sport">국제통합스포츠대회</a></li>
                    <li class="on"><a href="/business/sports/unif-k-league">K리그 통합축구</a></li>
                </ul>
            </div>

            <div class="contest_info">
                <div class="txt">통합축구는 발달장애인 스페셜 선수 6명과 비장애인 파트너 선수 5명이 한 팀을 이루어 <br/>
                    함께 훈련하며 경기에 참여하는 축구입니다. 발달장애인과 비장애인이 스포츠를 통해 서로를 이해하고, <br/>
                    더 나아가 발달장애인에 대한 사회적 포용과 평등의 가치를 실현하는 것을 목표로 합니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/xKFgE8nT-Dg?mute=1&controls=0&loop=1&playlist=xKFgE8nT-Dg'
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
                    <div class="sub_top_tit" id="tts_sub_k-league">스페셜올림픽코리아 K리그 통합축구 Unified Cup 역대 참가팀 명단</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_k-league">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="league_table">
                <table>
                    <colgroup>
                        <col width="4%">
                        <col width="6%">
                        <col width="15%">
                        <col width="4%">
                        <col width="6%">
                        <col width="15%">
                        <col width="4%">
                        <col width="6%">
                        <col width="15%">
                        <col width="4%">
                        <col width="6%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th colspan="3">2002년</th>
                        <th colspan="3">2022년</th>
                        <th colspan="3">2023년</th>
                        <th colspan="3">2024년</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td rowspan="4">A조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem01.jpg" alt="리그 로고">
                        </td>
                        <td>서울이랜드FC</td>
                        <td rowspan="5">A조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem01.jpg" alt="리그 로고">
                        </td>
                        <td>서울이랜드FC</td>
                        <td rowspan="4">A조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem03.jpg" alt="리그 로고">
                        </td>
                        <td>제주유나이티드FC</td>
                        <td rowspan="3">A조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem03.jpg" alt="리그 로고">
                        </td>
                        <td>제주유나이티드FC</td>
                    </tr>
                    <tr>
                        <td class="mark">
                            <img src="/img/icon_emblem02.jpg" alt="리그 로고">
                        </td>
                        <td>부산아이파크</td>
                        <td class="mark">
                            <img src="/img/icon_emblem02.jpg" alt="리그 로고">
                        </td>
                        <td>부산아이파크</td>
                        <td class="mark">
                            <img src="/img/icon_emblem02.jpg" alt="리그 로고">
                        </td>
                        <td>부산아이파크</td>
                        <td class="mark">
                            <img src="/img/icon_emblem06.jpg" alt="리그 로고">
                        </td>
                        <td>경남FC</td>
                    </tr>
                    <tr>
                        <td class="mark">
                            <img src="/img/icon_emblem03.jpg" alt="리그 로고">
                        </td>
                        <td>제주유나이티드FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem03.jpg" alt="리그 로고">
                        </td>
                        <td>제주유나이티드FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem06.jpg" alt="리그 로고">
                        </td>
                        <td>경남FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem02.jpg" alt="리그 로고">
                        </td>
                        <td>부산아이파크</td>
                    </tr>
                    <tr>
                        <td class="mark">
                            <img src="/img/icon_emblem04.jpg" alt="리그 로고">
                        </td>
                        <td>수원삼성블루윙즈</td>
                        <td class="mark">
                            <img src="/img/icon_emblem05.jpg" alt="리그 로고">
                        </td>
                        <td>인천유나이티드</td>
                        <td class="mark">
                            <img src="/img/icon_emblem12.jpg" alt="리그 로고">
                        </td>
                        <td>부천FC1995</td>
                        <td rowspan="4">B조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem11.jpg" alt="리그 로고">
                        </td>
                        <td>포항스틸러스</td>
                    </tr>
                    <tr>
                        <td rowspan="4">B조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem05.jpg" alt="리그 로고">
                        </td>
                        <td>인천유나이티드</td>
                        <td class="mark">
                            <img src="/img/icon_emblem09.jpg" alt="리그 로고">
                        </td>
                        <td>전북현대모터스</td>
                        <td rowspan="4">B조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem09.jpg" alt="리그 로고">
                        </td>
                        <td>전북현대모터스</td>
                        <td class="mark">
                            <img src="/img/icon_emblem10.jpg" alt="리그 로고">
                        </td>
                        <td>성남FC</td>
                    </tr>
                    <tr>
                        <td class="mark">
                            <img src="/img/icon_emblem06.jpg" alt="리그 로고">
                        </td>
                        <td>경남FC</td>
                        <td rowspan="5">B조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem06.jpg" alt="리그 로고">
                        </td>
                        <td>경남FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem10.jpg" alt="리그 로고">
                        </td>
                        <td>성남FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem12.jpg" alt="리그 로고">
                        </td>
                        <td>부천FC1995</td>
                    </tr>
                    <tr>
                        <td class="mark">
                            <img src="/img/icon_emblem07.jpg" alt="리그 로고">
                        </td>
                        <td>강원FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem10.jpg" alt="리그 로고">
                        </td>
                        <td>성남FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem11.jpg" alt="리그 로고">
                        </td>
                        <td>포항스틸러스</td>
                        <td class="mark">
                            <img src="/img/icon_emblem05.jpg" alt="리그 로고">
                        </td>
                        <td>인천유나이티드</td>
                    </tr>
                    <tr>
                        <td class="mark">
                            <img src="/img/icon_emblem08.jpg" alt="리그 로고">
                        </td>
                        <td>대전하나시티즌</td>
                        <td class="mark">
                            <img src="/img/icon_emblem11.jpg" alt="리그 로고">
                        </td>
                        <td>포항스틸러스</td>
                        <td class="mark">
                            <img src="/img/icon_emblem05.jpg" alt="리그 로고">
                        </td>
                        <td>인천유나이티드</td>
                        <td rowspan="4">C조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem16.png" alt="리그 로고">
                        </td>
                        <td>대구FC</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="mark">
                            <img src="/img/icon_emblem12.jpg" alt="리그 로고">
                        </td>
                        <td>부천FC1995</td>
                        <td rowspan="3">C조</td>
                        <td class="mark">
                            <img src="/img/icon_emblem14.jpg" alt="리그 로고">
                        </td>
                        <td>충남아산FC</td>
                        <td class="mark">
                            <img src="/img/icon_emblem17.png" alt="리그 로고">
                        </td>
                        <td>전남드래곤즈</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="mark">
                            <img src="/img/icon_emblem08.jpg" alt="리그 로고">
                        </td>
                        <td>대전하나시티즌</td>
                        <td class="mark">
                            <img src="/img/icon_emblem08.jpg" alt="리그 로고">
                        </td>
                        <td>대전하나시티즌</td>
                        <td class="mark korea">
                            <img src="/img/icon_emblem15.png" alt="리그 로고">
                        </td>
                        <td>한국프로축구연맹</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="mark korea">
                            <img src="/img/icon_emblem15.png" alt="리그 로고">
                        </td>
                        <td>한국프로축구연맹</td>
                        <td class="mark">
                            <img src="/img/icon_emblem08.jpg" alt="리그 로고">
                        </td>
                        <td>대전하나시티즌</td>
                    </tr>
                    <tr>

                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- section -->
        <div class="sub_content p-0">
            <div class="sub_top">
                <div class="sub_top_box">
                    <!--

                    --소리듣기 재사용--
                    id=tts_2
                    data-taret=tts_2

                    -->
                    <div class="sub_top_tit" id="tts_sub_int_picture">K리그 통합축구 사진</div>
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
                        <img src="/img/contest_img_intl37.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl38.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl39.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl40.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl41.png" alt="스포츠 이미지">
                    </li>
                    <li>
                        <img src="/img/contest_img_intl42.png" alt="스포츠 이미지">
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>