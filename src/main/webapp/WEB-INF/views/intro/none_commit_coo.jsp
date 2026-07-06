<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>대외협력 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">대외협력 위원회</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/intro/commit_dev">스포츠 위원회</a></li>
                <li class="on"><a href="/intro/none_commit_fam">비스포츠 위원회</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/intro/none_commit_fam">가족 위원회</a></li>
                    <li><a href="/intro/none_commit_ath">선수건강증진 위원회</a></li>
                    <li><a href="/intro/none_commit_art">문화예술 위원회</a></li>
                    <li class="on"><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <ul class="commit_list">
                    <li>
                        <img src="/img/ico_commit06.png" alt="아이콘">
                        <div>행사지원</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit07.png" alt="아이콘">
                        <div>국내·외 종합대회 개최</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit08.png" alt="아이콘">
                        <div>관련 부대사업</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit09.png" alt="아이콘">
                        <div>언론단체 협력</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit10.png" alt="아이콘">
                        <div>외부 지원자의 섭외</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit11.png" alt="아이콘">
                        <div>기타사항</div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>