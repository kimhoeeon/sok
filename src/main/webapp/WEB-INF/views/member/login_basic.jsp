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
                <form action="/loginProc" method="post" id="loginForm" class="login_form_box">
                    <div class="login_box">
                        <div class="id">
                            <input type="text" name="mbrId" placeholder="아이디를 입력해 주세요." required>
                        </div>
                        <div class="passward">
                            <input type="password" name="mbrPw" placeholder="비밀번호를 입력해 주세요." required>
                        </div>
                        <div class="btn">
                            <a href="javascript:void(0);" onclick="document.getElementById('loginForm').submit(); return false;" class="login">로그인</a>
                            <a href="/join" class="join">회원가입</a>
                        </div>
                        <a href="/findPw" class="find_pass">비밀번호가 기억나지 않습니다. <span>비밀번호 찾기</span></a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // 로그인 실패 시 컨트롤러에서 보낸 errorMessage(Model 객체) 띄우기
    var msg = "<c:out value='${errorMessage}'/>";
    if (msg !== "") {
        alert(msg);
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>