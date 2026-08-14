<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>생활체육위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">생활체육위원회</div>
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
                    <li class="on"><a href="/intro/commit_rec">생활체육 위원회</a></li>
                    <li><a href="/intro/commit_fair">공정 위원회</a></li>
                    <li><a href="/intro/commit_ath">선수 위원회</a></li>
                    <li><a href="/intro/commit_nat">전국대회위원회</a></li>
                    <li><a href="/intro/commit_spt">종목별분과위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="txt">
                    생활체육위원회는 발달장애인 생활체육의 기본방침과 진흥정책을 조사·연구하고 SOK의 주요 사업에 자문하는 위원회입니다. <br/>
                    생활체육지도자 양성, 프로그램 개발·보급, 시설 운영 및 시·도지부 지원 등 생활체육 활성화 방안을 논의하고 <br/>
                    전국대회 개최지와 유치 신청서를 심의·의결합니다. <br/>
                    또한 유관 체육단체 및 시·도지부와 협력하여 발달장애인의 지속적인 체육 참여 기반을 확대합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>