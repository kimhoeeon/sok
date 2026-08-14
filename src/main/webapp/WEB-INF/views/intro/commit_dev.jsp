<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>경기력향상위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">경기력향상위원회</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li class="on"><a href="/intro/commit_dev">스포츠 위원회</a></li>
                <li><a href="/intro/dis_commit_tkw">종목별위원회</a></li>
                <li><a href="/intro/none_commit_fam">비스포츠 위원회</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li class="on"><a href="/intro/commit_dev">경기력향상 위원회</a></li>
                    <li><a href="/intro/commit_rec">생활체육 위원회</a></li>
                    <li><a href="/intro/commit_fair">공정 위원회</a></li>
                    <li><a href="/intro/commit_ath">선수 위원회</a></li>
                    <li><a href="/intro/commit_nat">전국대회위원회</a></li>
                    <li><a href="/intro/commit_spt">종목별분과위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">차정훈</div>
                </div>
                <div class="txt">
                    경기력향상위원회는 대표선수의 경기력 향상과 발달장애인 체육 발전을 위한 주요 사항을 심의·지원하는 위원회입니다. <br/>
                    발달장애인 선수들의 경기력 향상의 기반을 마련하고, 전문지도자 육성 프로그램을 제안합니다. <br/>
                    또한, 우수선수 발굴을 통해 육성하며 세계대회 선수단 훈련 및 파견에 필요한 사항을 지원합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>