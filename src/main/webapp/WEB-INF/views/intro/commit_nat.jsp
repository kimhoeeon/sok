<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>전국대회위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">전국대회위원회</div>
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
                    <li class="on"><a href="/intro/commit_nat">전국대회위원회</a></li>
                    <li><a href="/intro/commit_spt">종목별분과위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">박민서</div>
                </div>
                <div class="txt">
                    전국대회위원회는 스페셜올림픽코리아 전국대회의 주요 운영 기준과 진행 사항을 심의하는 위원회입니다. <br/>
                    대회 개최 전 참가요강을 결정하고 경기종목·세부종목·종별·시범종목의 채택 및 취소안을 검토합니다. <br/>
                    위원들은 대회 집행임원으로 참여하여 경기와 행사 운영 전반을 관리·지원합니다. <br/>
                    대회 중 발생하는 이의 제기와 소청을 심의하고 필요한 조치를 결정합니다. <br/>
                    또한 개·폐회식 식순 변경 등 주요 행사 운영 사항을 검토하여 대회가 원활하게 진행되도록 지원합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>