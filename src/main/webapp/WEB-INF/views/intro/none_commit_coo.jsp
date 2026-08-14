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
                    <li class="on"><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">우진우</div>
                </div>
                <div class="txt">
                    대외협력위원회는 스페셜올림픽코리아가 주관하는 행사와 국내·외 대회의 원활한 운영을 위해 외부 협력 기반을 마련하는 위원회입니다. <br/>
                    행사 및 대회의 개최와 참가에 필요한 지원·후원 방안을 검토하고 관련 기관·단체와의 협력을 추진합니다. <br/>
                    스포츠 언론단체와 연계하여 스페셜올림픽의 활동과 가치를 알리고 대외 인지도를 높입니다. <br/>
                    찬조·후원자 등 외부 지원자를 발굴하고 행사 지원과 관련 부대사업을 추진합니다. <br/>
                    다양한 대외 네트워크를 구축하여 SOK 사업의 안정적인 운영과 발전에 기여합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>