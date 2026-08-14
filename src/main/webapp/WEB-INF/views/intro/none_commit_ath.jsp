<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>선수건강증진 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">선수건강증진 위원회</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/intro/commit_dev">스포츠 위원회</a></li>
                <li><a href="/intro/dis_commit_tkw">종목별위원회</a></li>
                <li class="on"><a href="/intro/none_commit_fam">비스포츠 위원회</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/intro/none_commit_fam">가족 위원회</a></li>
                    <li class="on"><a href="/intro/none_commit_ath">선수건강증진 위원회</a></li>
                    <li><a href="/intro/none_commit_art">문화예술 위원회</a></li>
                    <li><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">우봉식</div>
                </div>
                <div class="txt">
                    발달장애를 가진 스페셜올림픽 선수들에게 맞춤형 건강검진을 통해 신체적응력 및 경기능력을 향상시키는 프로그램입니다. <br/>
                    발달장애인들은 본인의 질병을 적절한 시기에 인지하지 못해 제대로 된 의료지원을 받지 못하는 경우가 많은데, <br/>
                    이러한 상황들은 질병을 악화시키거나 합병증을 동반하기도 합니다. <br/>
                    이처럼 의료 사각지대에 놓여있는 발달장애인들에게 수준 높은 의료서비스를 제공해서 <br/>
                    발달장애인들의 삶의 질을 향상시키고자 스페셜올림픽 대회에서 선수건강증진프로그램을 함께 진행합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>