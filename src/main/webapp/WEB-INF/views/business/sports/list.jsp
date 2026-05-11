<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>주요사업</span><span>스포츠</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">스포츠</div>
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
                    <li class="on"><a href="/business/sports">종목소개</a></li>
                    <li><a href="/business/sports/intl">국제대회참가</a></li>
                    <li><a href="/business/sports/domestic">국내대회개최</a></li>
                    <li><a href="/business/sports/unif">통합스포츠</a></li>
                    <li><a href="/business/sports/other">기타</a></li>
                </ul>
            </div>

            <div class="sports_wrap">
                <div class="sports_list">
                    <div class="sports_item">
                        <div class="tit">동계 스포츠</div>
                        <ul class="list">
                            <li><a href="/business/sports/view?brdSeq=1">플로어하키</a></li>
                            <li><a href="">피겨스케이트</a></li>
                            <li><a href="">스피드스케이트</a></li>
                            <li><a href="">스노보드</a></li>
                            <li><a href="">스노슈잉</a></li>
                            <li><a href="">크로스컨트리</a></li>
                            <li><a href="">노르딕스키</a></li>
                            <li><a href="">알파인스키</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">구기 스포츠</div>
                        <ul class="list">
                            <li><a href="">테니스</a></li>
                            <li><a href="">소프트볼</a></li>
                            <li><a href="">넷볼</a></li>
                            <li><a href="">핸드볼</a></li>
                            <li><a href="">배구</a></li>
                            <li><a href="">탁구</a></li>
                            <li><a href="">축구</a></li>
                            <li><a href="">풋살</a></li>
                            <li><a href="">농구</a></li>
                            <li><a href="">배드민턴</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">수상·해양 스포츠</div>
                        <ul class="list">
                            <li><a href="">요트</a></li>
                            <li><a href="">카약</a></li>
                            <li><a href="">실외수영</a></li>
                            <li><a href="">수영</a></li>
                            <li><a href="">조정</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">개인기록 스포츠</div>
                        <ul class="list">
                            <li><a href="">육상</a></li>
                            <li><a href="">사이클</a></li>
                            <li><a href="">역도</a></li>
                            <li><a href="">롤러스케이트</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">기타 스포츠</div>
                        <ul class="list">
                            <li><a href="">유도</a></li>
                            <li><a href="">리듬체조</a></li>
                            <li><a href="">기계체조</a></li>
                            <li><a href="">승마</a></li>
                            <li><a href="">크리켓</a></li>
                            <li><a href="">볼링</a></li>
                            <li><a href="">골프</a></li>
                            <li><a href="">보체</a></li>
                        </ul>
                    </div>

                </div>
                <div class="comt">
                    ※ 스페셜올림픽코리아는 스페셜올림픽에서 시행하는 종목을 소개하고 대회를 개최·운영하는 역할을 하고 있습니다. <br/>
                    상기 스포츠 종목을 배우기를 희망하시거나, 관련 기관 및 협회 관련 사항은 해당 기관(복지관, 센터 등) 및 유관단체로 문의하시기 바랍니다.
                </div>
            </div>
        </div>

        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>