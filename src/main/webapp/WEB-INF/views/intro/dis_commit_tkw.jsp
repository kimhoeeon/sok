<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>종목별위원회</span><span>태권도 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">태권도 위원회</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/intro/commit_dev">스포츠 위원회</a></li>
                <li class="on"><a href="/intro/dis_commit_tkw">종목별위원회</a></li>
                <li><a href="/intro/none_commit_fam">비스포츠 위원회</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li class="on"><a href="/intro/dis_commit_tkw">태권도 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">전광득</div>
                </div>
                <div class="txt">
                    태권도위원회는 발달장애인 태권도 선수와 지도자를 육성하고 관련 대회를 효율적으로 운영하기 위한 위원회입니다. <br/>
                    선수·지도자 선발과 우수선수 발굴·육성을 담당하며 태권도 경기의 기본방침과 진흥정책을 마련합니다. <br/>
                    태권도 기술 레벨테스트 자격심사와 지도자 양성 및 자질 향상을 추진합니다. <br/>
                    발달장애인에게 적합한 태권도 프로그램을 개발·보급하고 관련 대회를 개최·운영합니다. <br/>
                    체육 유관단체와 교류·협력하여 발달장애인 태권도의 저변 확대와 지속적인 발전에 기여합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>