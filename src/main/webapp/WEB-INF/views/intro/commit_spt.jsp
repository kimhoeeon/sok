<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>종목별분과위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">종목별분과위원회</div>
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
                    <li><a href="/intro/commit_fair">공정 위원회</a></li>
                    <li><a href="/intro/commit_ath">선수 위원회</a></li>
                    <li><a href="/intro/commit_nat">전국대회위원회</a></li>
                    <li class="on"><a href="/intro/commit_spt">종목별분과위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="txt">
                    종목별 분과위원회는 종목의 체계적인 발전과 원활한 운영을 위한 종목별 육성계획을 수립합니다. <br/>
                    종목별 경기 현안과 개선 사항을 검토하고 전문적인 자문과 건의를 수행합니다. <br/>
                    국내·외 대회의 개최 및 참가에 필요한 사항을 논의하고 경기 운영을 지원합니다. <br/>
                    각 종목의 선수와 지도자를 선발하고 지속적으로 육성합니다. <br/>
                    종목별 사업과 대회 전반을 관리·운영하여 경기의 전문성과 경쟁력 향상에 기여합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>