<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>스포츠 위원회</span><span>공정 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">공정 위원회</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li class="on"><a href="/intro/commit_dev">스포츠 위원회</a></li>
                <li><a href="/intro/none_commit_fam">비스포츠 위원회</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/intro/commit_dev">경기력향상 위원회</a></li>
                    <li><a href="/intro/commit_rec">생활체육 위원회</a></li>
                    <li class="on"><a href="/intro/commit_fair">공정 위원회</a></li>
                    <li><a href="/intro/commit_ath">선수 위원회</a></li>
                </ul>
            </div>

            <div class="coming">
                업데이트 예정입니다.
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>