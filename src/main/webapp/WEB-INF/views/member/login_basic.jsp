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
                <form action="/common/loginProc" method="post" id="loginForm" class="login_form_box">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="loginType" value="member">

                    <div class="login_box">
                        <div class="id">
                            <input type="text" name="username" placeholder="아이디를 입력해 주세요." onkeyup="handleEnter(event)" required>
                        </div>
                        <div class="passward">
                            <input type="password" name="password" placeholder="비밀번호를 입력해 주세요." onkeyup="handleEnter(event)" required>
                        </div>
                        <div class="btn">
                            <a href="javascript:void(0);" onclick="executeLogin();" class="login">로그인</a>
                            <a href="/join" class="join">회원가입</a>
                        </div>
                        <a href="/findPw" class="find_pass">비밀번호가 기억나지 않습니다. <span>비밀번호 찾기</span></a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<c:if test="${not empty param.errorMessage}">
    <script>
        alert("${param.errorMessage}");
    </script>
</c:if>

<script>
    // 엔터키 입력 감지 함수
    function handleEnter(event) {
        if (event.key === 'Enter' || event.keyCode === 13) {
            executeLogin();
        }
    }

    // 로그인 유효성 검사 및 전송 함수
    function executeLogin() {
        var form = document.getElementById('loginForm');
        var username = form.username.value.trim();
        var password = form.password.value.trim();

        if (username === '') {
            alert('아이디를 입력해 주세요.');
            form.username.focus();
            return false;
        }

        if (password === '') {
            alert('비밀번호를 입력해 주세요.');
            form.password.focus();
            return false;
        }

        // 유효성 검사를 통과하면 폼 전송
        form.submit();
    }
</script>