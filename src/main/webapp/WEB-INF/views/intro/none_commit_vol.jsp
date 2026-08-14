<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>자원봉사 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">자원봉사 위원회</div>
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
                    <li class="on"><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">강감창</div>
                </div>
                <div class="txt">
                    자원봉사위원회는 SOK의 다양한 사업에 참여하는 자원봉사자들이 활동 전후에 교류하고 네트워크를 형성할 수 있도록 지원하는 위원회입니다. <br/>
                    자원봉사 활동을 체계적이고 효율적으로 운영하여 참여 경험을 높이고 주요 행사의 원활한 추진을 지원합니다. <br/>
                    발달장애인 상담과 교육을 비롯한 자원봉사 프로그램을 개발·보급하고 안정적인 활동 환경을 조성합니다. <br/>
                    국내·외 자원봉사 협력과 네트워크를 활성화하여 SOK 사업과 조직의 지속적인 발전에 기여합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>