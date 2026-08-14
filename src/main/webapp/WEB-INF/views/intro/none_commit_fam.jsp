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
                <li><a href="/intro/dis_commit_tkw">종목별위원회</a></li>
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
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">송재형</div>
                </div>
                <div class="txt">
                    가족위원회는 선수 가족 관련 협력 업무를 효율적으로 추진하여 선수와 가족, 스페셜올림픽코리아의 발전을 지원하는 위원회입니다. <br/>
                    대회의 원활한 개최와 선수 및 가족의 참가를 위한 후원 활동을 추진합니다. <br/>
                    주요 행사와 프로그램을 홍보하고 가족들의 적극적인 참여를 독려하며 필요한 외부 지원자를 섭외합니다. <br/>
                    선수 가족 간 정보 교류를 활성화하고 지속적인 소통과 협력이 가능한 네트워크를 구축합니다. <br/>
                    이와 관련된 다양한 부대사업을 통해 선수 가족의 참여 기반을 확대합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>