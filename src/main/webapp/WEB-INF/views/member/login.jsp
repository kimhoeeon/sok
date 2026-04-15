<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>홈</span><span>로그인</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top"><span>로그인</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">
            <div class="login_wrap">
                <div class="kakao_login">
                    <div class="tit">개인 회원</div>
                    <img src="/img/kakao_login.png" alt="개인회원 로그인">
                    <a href="/oauth2/authorization/kakao">카카오로 3초 만에 시작하기</a>
                </div>

                <div class="basic_login">
                    <div class="tit">단체 회원</div>
                    <img src="/img/basic_login.png" alt="단체회원 로그인">
                    <a href="/login/basic">일반 로그인</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>