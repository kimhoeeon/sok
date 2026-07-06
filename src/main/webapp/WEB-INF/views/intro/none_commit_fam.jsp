<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>가족위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">가족위원회</div>
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
                    <li class="on"><a href="/intro/none_commit_fam">가족 위원회</a></li>
                    <li><a href="/intro/none_commit_ath">선수건강증진 위원회</a></li>
                    <li><a href="/intro/none_commit_art">문화예술 위원회</a></li>
                    <li><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="txt">
                    가족위원회는 스페셜올림픽 선수가족 관련 협력 업무들을 효율적으로 추진하여 <br />선수와 가족, 스페셜올림픽코리아의 발전을 도모하기 위한 위원회입니다.
                </div>
                <ul class="commit_list commit_fam">
                    <li>
                        <img src="/img/ico_commit01.png" alt="아이콘">
                        <div>대회 개최 및 참가후원</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit02.png" alt="아이콘">
                        <div>정보 교환 및 네트워크 구성</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit03.png" alt="아이콘">
                        <div>참가홍보 및 독려</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit04.png" alt="아이콘">
                        <div>외부 지원자의 섭외</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit05.png" alt="아이콘">
                        <div>관련 부대사업</div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>