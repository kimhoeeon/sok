<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>선수 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">선수 위원회</div>
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
                    <li class="on"><a href="/intro/commit_ath">선수 위원회</a></li>
                    <li><a href="/intro/commit_nat">전국대회위원회</a></li>
                    <li><a href="/intro/commit_spt">종목별분과위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">김수호</div>
                </div>
                <div class="txt">
                    선수위원회는 발달장애인 선수 및 아티스트, 비장애인 파트너, 성인 멘토가 함께 참여하는 리더십 위원회입니다. <br/>
                    구성원들은 국내·외 행사와 회의, 리더십 프로그램 등에 참여해 SOK의 미션과 철학을 알리고 발달장애인의 권익 증진과 사회 참여 확대를 위해 활동합니다. <br/>
                    선수와 아티스트의 목소리를 대변하고 학교와 지역사회의 다양한 의견을 사무국에 전달하는 가교 역할을 수행합니다. <br/>
                    토론·발표·리더십 교육을 통해 역량을 강화하고 지역사회에서 인식 개선과 통합사회 구축을 위한 활동을 주도합니다.<br/>
                    각종 대회와 행사에서 운영·자원봉사·홍보 역할을 수행하며, 성인 멘토는 발표 준비와 이동, 의사소통 등 선수들의 활동 참여와 성장을 지원합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>