<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>공정 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">공정 위원회</div>
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
                    <li><a href="/intro/commit_dev">경기력향상 위원회</a></li>
                    <li><a href="/intro/commit_rec">생활체육 위원회</a></li>
                    <li class="on"><a href="/intro/commit_fair">공정 위원회</a></li>
                    <li><a href="/intro/commit_ath">선수 위원회</a></li>
                    <li><a href="/intro/commit_nat">전국대회위원회</a></li>
                    <li><a href="/intro/commit_spt">종목별분과위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">박순관</div>
                </div>
                <div class="txt">
                    스포츠공정위원회는 공정하고 객관적인 기준에 따라 각종 상벌 사항을 심의·의결하는 기구입니다. <br/>
                    우수 선수, 지도자, 아티스트 등에 대한 스페셜올림픽코리아 회장상 및 문화체육관광부 장관상 후보자를 공적과 기여도를 종합적으로 검토하여 선정합니다. <br/>
                    또한 선수, 지도자, 등의 규정 위반이나 품위 손상 등 사안이 발생할 경우 사실관계와 관련 규정을 면밀히 검토하여 <br/>
                    적정한 징계 여부와 수위를 심의함으로써 조직의 공정성과 신뢰성을 유지하고 건전한 스포츠 문화를 조성하는 역할을 수행합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>