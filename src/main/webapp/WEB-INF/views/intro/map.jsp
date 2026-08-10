<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>조직구성</span><span>시도지부</span>
                </div>
                <!--

                --소리듣기 재사용--
                id=tts_2
                data-taret=tts_2

                -->
                <div class="sub_top_tit" id="tts_sub_top">시도지부</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/intro/org">사무국</a></li>
                <li><a href="/intro/member">임원 현황</a></li>
                <li class="on"><a href="/intro/map">시도지부</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content map">
            <div class="prov_map_content">
                <div class="prov_map">
                    <!-- 회색 전체 지도 -->
                    <img src="/img/korea_map.png" alt="전국 지도" class="map_base">

                    <!-- 보라색 선택 지도 조각 -->
                    <img src="/img/korea_map_seoul.png" alt="" class="map_piece seoul on">
                    <img src="/img/korea_map_gangwon.png" alt="" class="map_piece gangwon">
                    <img src="/img/korea_map_chungnam.png" alt="" class="map_piece chungnam">
                    <img src="/img/korea_map_chungbuk.png" alt="" class="map_piece chungbuk">
                    <img src="/img/korea_map_gyeongbuk.png" alt="" class="map_piece gyeongbuk">
                    <img src="/img/korea_map_gyeongnam.png" alt="" class="map_piece gyeongnam">
                    <%--<img src="/img/korea_map_jeonbuk.png" alt="" class="map_piece jeonbuk">
                    <img src="/img/korea_map_jeonnam.png" alt="" class="map_piece jeonnam">--%>
                    <img src="/img/korea_map_jeju.png" alt="" class="map_piece jeju">

                    <!-- 클릭용 투명 버튼 -->
                    <button type="button" class="map_btn seoul_btn on" data-prov="seoul">서울경기</button>
                    <button type="button" class="map_btn gangwon_btn" data-prov="gangwon">강원</button>
                    <button type="button" class="map_btn chungnam_btn" data-prov="chungnam">충남</button>
                    <button type="button" class="map_btn chungbuk_btn" data-prov="chungbuk">충북</button>
                    <button type="button" class="map_btn gyeongbuk_btn" data-prov="gyeongbuk">경북</button>
                    <button type="button" class="map_btn gyeongnam_btn" data-prov="gyeongnam">경남</button>
                    <%--<button type="button" class="map_btn jeonbuk_btn" data-prov="jeonbuk">전북</button>
                    <button type="button" class="map_btn jeonnam_btn" data-prov="jeonnam">전남</button>--%>
                    <button type="button" class="map_btn jeju_btn" data-prov="jeju">제주</button>
                </div>

                <div class="info_map">
                    <div class="info_grid" id="infoGrid"></div>
                </div>
            </div>
            <!-- //section -->
        </div>

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>