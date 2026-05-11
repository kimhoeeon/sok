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
                    <li class="on"><a href="/business/culture-art">스페셜올림픽 미술대회</a></li>
                    <li><a href="/business/culture-dodream">두드림 페스티벌</a></li>
                    <li><a href="/business/culture-support">국내외 공연 참가 지원</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    통합스포츠는 발달장애인과 비장애인이 한 팀을 이루어 훈련하고, 경기에 참가하며 <br/>
                    서로를 이해하고 기량을 향상시키는 스포츠 활동으로서 스페셜올림픽 국제 본부(SOI)가 중점적으로 진행하고 있는 프로그램입니다. <br/>
                    이에 스페셜올림픽코리아에서는 매년 36개의 통합스포츠단 운영을 지원하고 있습니다. <br/><br/>
                    ※ 지원 종목: 총 5종목(통합 농구,배구,축구,플로어볼,배드민턴)
                </div>
                <div class="img">
                    <img src="/img/culture_art_img.png" alt="미술대회 포스터">
                </div>
                <div class="btn link_btn">
                    <a href="">온라인 전시관 보러가기</a>
                </div>
            </div>
            <div class="cult_mento">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_cult_judge">스페셜올림픽 미술대회 심사위원장 및 심사위원</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_judge">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="executive_table">
                    <table>
                        <colgroup>
                            <col width="20%">
                            <col width="30%">
                            <col width="50%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>이름</th>
                            <th>직위</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>심사위원장</td>
                            <td>강애란</td>
                            <td class="left">- 현 이화여자대학교 조형예술대학 서양화전공 교수 <br/>
                                - 현 동대학원 융합미술치료학전공주임교수 <br/>
                                - 현 이화크리에이티브아트센터장 / 한국여성연구원장
                            </td>
                        </tr>
                        <tr>
                            <td>심사위원</td>
                            <td>문경원</td>
                            <td class="left">- 현 이화여자대학교 조형예술대학 서양화전공 교수 <br/>
                                - 현 국립현대미술관 & SBS 주관 올해의 작가상 운영위원
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="cult_features">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_cult_features">스페셜올림픽 미술대회 특징</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_features">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <ul class="cult_features_list">
                    <li>
                        <img src="/img/culture_guide05.png" alt="특징 아이콘">
                        <div class="tit">기회</div>
                        <div class="txt">예술적 재능과 열정을 발휘하는 미술대회</div>
                    </li>
                    <li>
                        <img src="/img/culture_guide06.png" alt="특징 아이콘">
                        <div class="tit">소통</div>
                        <div class="txt">예술을 통해 표현하고 교류하는 미술대회</div>
                    </li>
                    <li>
                        <img src="/img/culture_guide07.png" alt="특징 아이콘">
                        <div class="tit">성장</div>
                        <div class="txt">전문 교육과 심리정서적 지원을 통해, 사회 진출을 통해 성장하는 미술대회</div>
                    </li>
                    <li>
                        <img src="/img/culture_guide08.png" alt="특징 아이콘">
                        <div class="tit">통합</div>
                        <div class="txt">장애인과 비장애인이 예술을 매개로 화합하는 “Together We Draw, Together We Grow"의 가치</div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>