<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>마이페이지</span><span>설정</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>${sessionScope.userLogin.mbrNm} 님</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">
            <div class="mypage_wrap">
                <ul class="sub_top_tab">
                    <li><a href="/mypage/info">프로필 수정</a></li>
                    <li><a href="">서비스 이용 동의</a></li>
                    <li><a href="">개인정보 제3자 제공 동의</a></li>
                    <li class="on"><a href="/mypage/leave">스페셜올림픽코리아 탈퇴</a></li>
                </ul>

                <form class="profile_info leave_info" onsubmit="return false;">
                    <div class="tit">스페셜올림픽코리아 탈퇴하기</div>
                    <div class="sub_tit">탈퇴 시 삭제되는 정보를 확인해주세요.</div>

                    <div class="img">
                        <img src="/img/leave_icon.png" alt="탈퇴 로고">
                    </div>

                    <div class="leave_box">
                        <div class="leave_txt">
                            <div class="tit">1. 삭제되는 정보</div>
                            <div class="desc">프로필 이미지, 닉네임, 전화번호, 작성한 댓글과 게시물</div>
                        </div>
                        <div class="leave_txt">
                            <div class="tit">2. 삭제되지 않는 정보</div>
                            <div class="desc">1) 기부내역<br/>소득세법 제 160조</div>
                            <div class="desc">2) 모금함 및 프로젝트팀 정보<br/>소득세법 제 160조</div>
                        </div>
                    </div>

                    <div class="info_txt">
                        위 내용을 모두 확인하셨다면, <br class="mo_only"/>아래 탈퇴 버튼을 통해 탈퇴 하실 수 있습니다.
                    </div>

                    <div class="btn leave_btn">
                        <button type="button" onclick="submitLeave()">탈퇴하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function submitLeave() {
        if (confirm("정말 스페셜올림픽코리아에서 탈퇴하시겠습니까?\n탈퇴 시 프로필 등의 일부 정보는 복구할 수 없습니다.")) {
            $.ajax({
                type: "POST",
                url: "/mypage/leaveProc",
                success: function (response) {
                    alert(response);
                    location.href = "/"; // 탈퇴 완료 후 메인 페이지로 이동
                },
                error: function (xhr) {
                    alert("탈퇴 처리 중 서버 오류가 발생했습니다.");
                }
            });
        }
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>