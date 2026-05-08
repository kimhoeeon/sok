<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>스페셜올림림픽코리아</span><span>운영규정</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">이용약관</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/rules/privacy">개인정보 처리방침</a></li>
                <li class="on"><a href="/rules/terms">이용약관</a></li>
                <li><a href="/rules/policy">관련규정</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content">
            <div class="sub_content">
                <div class="privacy_box">
                    <div class="tit">
                        이용약관
                    </div>
                    <div class="nae">
                        내용입니다.
                    </div>
                </div>
            </div>
        </div>

        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>