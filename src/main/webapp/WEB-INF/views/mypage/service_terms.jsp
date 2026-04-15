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
                    <li class="on"><a href="/mypage/terms/service">서비스 이용 동의</a></li>
                    <li><a href="/mypage/terms/personal">개인정보 제3자 제공 동의</a></li>
                    <li><a href="/mypage/leave">스페셜올림픽코리아 탈퇴</a></li>
                </ul>

                <form id="serviceTermsForm" class="profile_info terms_info" onsubmit="return false;">
                    <div class="tit">서비스 이용약관에 동의해주세요</div>

                    <div class="agree">
                        <label>
                            <input type="checkbox" name="marketingYn"
                                   value="Y" ${sessionScope.userLogin.marketingYn eq 'Y' ? 'checked' : ''}>
                            <span class="chk_box"></span>
                            <div>[선택] 서비스 이용 및 마케팅 수신 동의</div>
                        </label>
                    </div>

                    <div class="terms_box">
                        <div class="terms_txt">
                            <div class="tit">[목적]</div>
                            <div class="desc">스페셜올림픽코리아 서비스에 참여한 이용자 식별 및 회원관리</div>
                        </div>
                        <div class="terms_txt">
                            <div class="tit">[항목]</div>
                            <div class="desc">나이, 성별, 연락처, 지역, 이메일</div>
                        </div>
                        <div class="terms_txt">
                            <div class="tit">[보유기간]</div>
                            <div class="desc">회원 탈퇴 시 또는 동의 철회 시 지체 없이 파기<br/>
                                * 단, 스페셜올림픽코리아 서비스에 참여한 경우 해당 서비스 참여기간 동안은 일부 항목에 대한 동의 철회가 제한 될 수 있습니다.<br/>
                                - 프로젝트팀 운영자 : 연락처, 이메일
                            </div>
                        </div>
                    </div>

                    <div class="info_txt">
                        선택 항목에 동의하지 않아도 서비스 이용이 가능합니다.<br/>
                        더 자세한 내용에 대해서는 <span>개인정보처리방침</span>을 참고하시기 바랍니다.
                    </div>

                    <div class="btn save_btn">
                        <button type="button" onclick="submitServiceTerms()">저장하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function submitServiceTerms() {
        var formData = $('#serviceTermsForm').serialize();

        $.ajax({
            type: "POST",
            url: "/mypage/terms/serviceProc",
            data: formData,
            success: function (response) {
                alert(response);
            },
            error: function (xhr) {
                alert("설정 저장 중 서버 오류가 발생했습니다.");
            }
        });
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>