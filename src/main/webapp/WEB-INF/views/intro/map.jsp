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
                <div class="info_map">
                    <div class="info_grid">
                        <div class="info_card">
                            <img src="/img/ico_gyeonggi.png" alt="오응환">
                            <div class="info_body">
                                <div><span>회장</span> 오응환</div>
                                <div><span>설립일</span> 2011년 12월 14일</div>
                                <div><span>주소</span> 경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)</div>
                                <div><span>전화</span> 031-571-1116</div>
                                <div><span>팩스</span> 031-255-1320</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_seoul.png" alt="전중구">
                            <div class="info_body">
                                <div><span>회장</span> 전중구</div>
                                <div><span>설립일</span> 2013년 12월 19일</div>
                                <div><span>주소</span> 서울특별시 강남구 신사동 614-3 융기빌딩 4층 한국파파존스(주)</div>
                                <div><span>전화</span> 02-465-0999</div>
                                <div><span>팩스</span> 02-6466-2112</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_incheon.png" alt="박민서">
                            <div class="info_body">
                                <div><span>회장</span> 박민서</div>
                                <div><span>설립일</span> 2015년 7월 15일</div>
                                <div><span>주소</span> 인천광역시 남동구 소래로 500 남동체육관 107호</div>
                                <div><span>전화</span> 032-817-3487</div>
                                <div><span>팩스</span> 032-813-3480</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_gangwon.png" alt="조규석">
                            <div class="info_body">
                                <div><span>회장</span> 조규석</div>
                                <div><span>설립일</span> 2012년 11월 30일</div>
                                <div><span>주소</span> 강원특별자치도 춘천시 춘천로 188, 822호(효자동, 메가시티)</div>
                                <div><span>전화</span> 033-642-2071</div>
                                <div><span>팩스</span> 033-642-2074</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_daejeon.png" alt="정찬욱">
                            <div class="info_body">
                                <div><span>회장</span> 정찬욱</div>
                                <div><span>설립일</span> 2011년 12월 14일</div>
                                <div><span>주소</span> 대전광역시 중구 당디로6번길 69(문화동)</div>
                                <div><span>전화</span> 042-471-2905</div>
                                <div><span>팩스</span> 042-587-9229</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_chungbuk.png" alt="장병호">
                            <div class="info_body">
                                <div><span>회장</span> 장병호</div>
                                <div><span>설립일</span> 2013년 12월 19일</div>
                                <div><span>주소</span> 충청북도 제천시 의병대로 45길 84 다하랑 203호(흑석동)</div>
                                <div><span>전화</span> 061-270-2576</div>
                                <div><span>팩스</span> 061-270-2576</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_gyeongbuk.png" alt="김춘희">
                            <div class="info_body">
                                <div><span>회장</span> 김춘희</div>
                                <div><span>설립일</span> 2012년 11월 30일</div>
                                <div><span>주소</span> 경상북도 포항시 북구 용흥동 430-14번지</div>
                                <div><span>전화</span> 054-237-4712</div>
                                <div><span>팩스</span> 054-254-3636</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_daegu.png" alt="김동환">
                            <div class="info_body">
                                <div><span>회장</span> 김동환</div>
                                <div><span>설립일</span> 2016년 9월 29일</div>
                                <div><span>주소</span> 대구광역시 수성구 파동로 51길 26-71(대구장애인복지관 내)</div>
                                <div><span>전화</span> 053-763-1011</div>
                                <div><span>팩스</span> -</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_gyeongnam.png" alt="신석민">
                            <div class="info_body">
                                <div><span>회장</span> 신석민</div>
                                <div><span>설립일</span> 2017년 9월 12일</div>
                                <div><span>주소</span> 경상남도 창원시 의창구 소계동 474-2번지 2층</div>
                                <div><span>전화</span> 02-447-1179</div>
                                <div><span>팩스</span> -</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_ulsan.png" alt="김종길">
                            <div class="info_body">
                                <div><span>회장</span> 김종길</div>
                                <div><span>설립일</span> 2025년 4월 29일</div>
                                <div><span>주소</span> 울산광역시 남구 남산로 354번길 26</div>
                                <div><span>전화</span> 052-220-3525</div>
                                <div><span>팩스</span> 052-220-3489</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_busan.png" alt="임준택">
                            <div class="info_body">
                                <div><span>회장</span> 임준택</div>
                                <div><span>설립일</span> 2025년 4월 29일</div>
                                <div><span>주소</span> 부산광역시 사하구 다대로 605번길 25</div>
                                <div><span>전화</span> 051-255-2332</div>
                                <div><span>팩스</span> 051-245-2331</div>
                            </div>
                        </div>
                        <div class="info_card">
                            <img src="/img/ico_jeju.png" alt="김경보">
                            <div class="info_body">
                                <div><span>회장</span> 김경보</div>
                                <div><span>설립일</span> 2018년 8월 24일</div>
                                <div><span>주소</span> 제주특별자치도 제주시 산천단동길 31, 1층(아라일동)</div>
                                <div><span>전화</span> 064-724-9500</div>
                                <div><span>팩스</span> 064-724-9510</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>