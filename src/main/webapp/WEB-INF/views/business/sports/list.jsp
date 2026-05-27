<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>사업소개</span><span>스포츠</span>
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
                            <li><a href="/business/sports/floorhockey">플로어하키</a></li>
                            <li><a href="/business/sports/figureskate">피겨스케이트</a></li>
                            <li><a href="/business/sports/speedskate">스피드스케이트</a></li>
                            <li><a href="/business/sports/snowboard">스노보드</a></li>
                            <li><a href="/business/sports/snowshoe">스노슈잉</a></li>
                            <li><a href="/business/sports/crosscountry">크로스컨트리</a></li>
                            <li><a href="/business/sports/nordicski">노르딕스키</a></li>
                            <li><a href="/business/sports/alpineski">알파인스키</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">구기 스포츠</div>
                        <ul class="list">
                            <li><a href="/business/sports/tennis">테니스</a></li>
                            <li><a href="/business/sports/softball">소프트볼</a></li>
                            <li><a href="/business/sports/netball">넷볼</a></li>
                            <li><a href="/business/sports/handball">핸드볼</a></li>
                            <li><a href="/business/sports/volleyball">배구</a></li>
                            <li><a href="/business/sports/tabletennis">탁구</a></li>
                            <li><a href="/business/sports/football">축구</a></li>
                            <li><a href="/business/sports/futsal">풋살</a></li>
                            <li><a href="/business/sports/basketball">농구</a></li>
                            <li><a href="/business/sports/badminton">배드민턴</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">수상·해양 스포츠</div>
                        <ul class="list">
                            <li><a href="/business/sports/yacht">요트</a></li>
                            <li><a href="/business/sports/kayak">카약</a></li>
                            <li><a href="/business/sports/outdoorswim">실외수영</a></li>
                            <li><a href="/business/sports/swim">수영</a></li>
                            <li><a href="/business/sports/rowing">조정</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">개인기록 스포츠</div>
                        <ul class="list">
                            <li><a href="/business/sports/athletics">육상</a></li>
                            <li><a href="/business/sports/cycling">사이클</a></li>
                            <li><a href="/business/sports/weightlifting">역도</a></li>
                            <li><a href="/business/sports/rollerskate">롤러스케이트</a></li>
                        </ul>
                    </div>
                    <div class="sports_item">
                        <div class="tit">기타 스포츠</div>
                        <ul class="list">
                            <li><a href="/business/sports/judo">유도</a></li>
                            <li><a href="/business/sports/rhythmic">리듬체조</a></li>
                            <li><a href="/business/sports/gymnastics">기계체조</a></li>
                            <li><a href="/business/sports/horseback">승마</a></li>
                            <li><a href="/business/sports/cricket">크리켓</a></li>
                            <li><a href="/business/sports/bowling">볼링</a></li>
                            <li><a href="/business/sports/golf">골프</a></li>
                            <li><a href="/business/sports/bocce">보체</a></li>
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