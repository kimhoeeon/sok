<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>후원 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">후원 위원회</div>
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
                    <li><a href="/intro/none_commit_ath">선수건강증진 위원회</a></li>
                    <li><a href="/intro/none_commit_art">문화예술 위원회</a></li>
                    <li><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li class="on"><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">김형대</div>
                </div>
                <div class="txt">
                    후원위원회는 스페셜올림픽코리아의 안정적인 후원 기반을 마련하고 사업 확대와 사무국의 운영 자립을 지원하는 위원회입니다. <br/>
                    후원사업 계획과 정책을 수립하고, SOK 주관 행사와 국내·외 대회에 필요한 지원·후원 협력을 추진합니다. <br/>
                    개인 모금과 외부 후원자 섭외를 활성화하고 후원조직과 협력 네트워크를 체계적으로 관리합니다. <br/>
                    후원 관련 자문과 협력을 바탕으로 국내·외 봉사활동을 활성화하고 발달장애인 지원 프로그램을 개발합니다. <br/>
                    지속 가능한 후원체계를 구축하여 SOK의 자립도 향상과 안정적인 사업 운영에 기여합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>