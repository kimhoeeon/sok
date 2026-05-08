<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK</span><span>오시는 길</span>
                </div>
                <!--

                --소리듣기 재사용--
                id=tts_2
                data-taret=tts_2

                -->
                <div class="sub_top_tit" id="tts_sub_top">스페셜올림픽코리아로 <br/>찾아오시는 길을 안내해 드립니다.</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content way">
            <div class="way_wrap">
                <div class="map">
                    <div id="daumRoughmapContainer1777354743639"
                         class="root_daum_roughmap root_daum_roughmap_landing"></div>
                    <script charset="UTF-8" class="daum_roughmap_loader_script"
                            src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
                    <ul class="way_txt">
                        <li>
                            <div class="gu">주소</div>
                            <div class="nae">서울특별시 강남구 강남대로132길 53(논현동) 4~6층 (성신빌딩)</div>
                        </li>
                        <li>
                            <div class="gu">대표전화</div>
                            <div class="nae">02-447-1179</div>
                        </li>
                        <li>
                            <div class="gu">팩스</div>
                            <div class="nae">02-447-1345</div>
                        </li>
                        <li>
                            <div class="gu">이메일주소</div>
                            <div class="nae">sokorea@sokorea.or.kr</div>
                        </li>
                    </ul>
                </div>
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_transport">대중교통</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_transport">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                    <div class="transport">
                        <div class="transport_tit">지하철 이용시</div>
                        <div>지하철 7호선 논현역 8번출구, 7호선 학동역 6번 출구 (걸어서 10분 이내 거리)</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- //section -->

        <!-- section -->
        <div class="sub_content map">
            <div class="tit">시도지부</div>
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
                    <img src="/img/korea_map_jeonbuk.png" alt="" class="map_piece jeonbuk">
                    <img src="/img/korea_map_jeonnam.png" alt="" class="map_piece jeonnam">
                    <img src="/img/korea_map_jeju.png" alt="" class="map_piece jeju">

                    <!-- 클릭용 투명 버튼 -->
                    <button type="button" class="map_btn seoul_btn on" data-prov="seoul">서울경기</button>
                    <button type="button" class="map_btn gangwon_btn" data-prov="gangwon">강원</button>
                    <button type="button" class="map_btn chungnam_btn" data-prov="chungnam">충남</button>
                    <button type="button" class="map_btn chungbuk_btn" data-prov="chungbuk">충북</button>
                    <button type="button" class="map_btn gyeongbuk_btn" data-prov="gyeongbuk">경북</button>
                    <button type="button" class="map_btn gyeongnam_btn" data-prov="gyeongnam">경남</button>
                    <button type="button" class="map_btn jeonbuk_btn" data-prov="jeonbuk">전북</button>
                    <button type="button" class="map_btn jeonnam_btn" data-prov="jeonnam">전남</button>
                    <button type="button" class="map_btn jeju_btn" data-prov="jeju">제주</button>
                </div>

                <div class="info_map">
                    <div class="info_grid" id="infoGrid"></div>
                    <!-- paging -->
                    <div class="paging">
                        <a href="" class="first"><img src="/img/btn_first.gif"></a>
                        <a href="" class="prev"><img src="/img/btn_prev.gif"></a>
                        <ol>
                            <li><a href="" class="this">1</a></li>
                            <li><a href="" class="other">2</a></li>
                            <li><a href="" class="other">3</a></li>
                            <li><a href="" class="other">4</a></li>
                            <li><a href="" class="other">5</a></li>
                        </ol>
                        <a href="" class="next"><img src="/img/btn_next.gif"></a>
                        <a href="" class="last"><img src="/img/btn_last.gif"></a>
                    </div>
                    <!-- //paging -->
                </div>
            </div>
            <!-- //section -->
        </div>
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script charset="UTF-8">
    new daum.roughmap.Lander({
        "timestamp": "1777354743639",
        "key": "2b28djb63wgx",
        "mapWidth": "640",
        "mapHeight": "540"
    }).render();
</script>