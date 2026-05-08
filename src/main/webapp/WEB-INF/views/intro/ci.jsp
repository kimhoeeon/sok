<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK</span><span>CI</span>
                </div>
                <!--

                --소리듣기 재사용--
                id=tts_2
                data-taret=tts_2

                -->
                <div class="sub_top_tit" id="tts_sub_top">스페셜올림픽코리아의 <br/>아이덴티티를 담은 CI를 소개합니다.</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content ci">
            <div class="ci_wrap">
                <div class="logo_ci">
                    <div class="tit">LOGO</div>
                    <div class="txt">심플하고 균형 잡힌 스페셜올림픽코리아 로고는 고객의 신뢰를 바탕으로 <br/>미래를 향해 도약하는 우리의 모습을 담고 있습니다.</div>
                </div>
                <div class="symbol_ci">
                    <div class="sub_tit">Symbol</div>
                    <div class="symbol">
                        <img src="/img/symbol.png" alt="심볼">
                    </div>
                    <div class="down">
                        <a href="">AI 다운로드</a>
                        <a href="">pdf 다운로드</a>
                    </div>
                </div>
                <div class="color_ci">
                    <div class="tit">COLOR</div>
                    <div class="txt">심플하고 균형 잡힌 스페셜올림픽코리아 로고는 고객의 신뢰를 바탕으로 <br/>미래를 향해 도약하는 우리의 모습을 담고 있습니다.</div>
                </div>
                <div class="primary_ci">
                    <div class="sub_tit">Primary Color</div>
                    <div class="primary">
                        <img src="/img/primary_01.png" alt="Primary">
                        <img src="/img/primary_02.png" alt="Primary">
                    </div>
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>