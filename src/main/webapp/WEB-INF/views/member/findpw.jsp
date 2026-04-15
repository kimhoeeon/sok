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
                <form id="findPwForm" class="finepw_form" onsubmit="return false;">
                    <div class="login_tit">비밀번호가 기억나지 않나요?</div>

                    <div class="form_row">
                        <div class="form_box">
                            <label><span>인증방법</span></label>
                            <div class="input radio_btn">
                                <input type="radio" name="authMethod" id="authPhone" value="phone" checked
                                       onchange="toggleAuthMethod()">
                                <label for="authPhone">휴대폰</label>

                                <input type="radio" name="authMethod" id="authEmail" value="email"
                                       onchange="toggleAuthMethod()">
                                <label for="authEmail">이메일</label>
                            </div>
                        </div>
                    </div>

                    <div class="form_row" id="phoneBlock">
                        <div class="form_box">
                            <label><span>휴대전화</span></label>
                            <div class="input flex">
                                <div class="select">
                                    <select id="phone1">
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="019">019</option>
                                        <option value="032">032</option>
                                    </select>
                                </div>
                                - <input type="text" id="phone2" maxlength="4" required>
                                - <input type="text" id="phone3" maxlength="4" required>
                                <button type="button" class="main-c cert" onclick="sendCertCode('phone')">인증하기</button>
                            </div>
                        </div>
                        <input type="hidden" name="phone" id="phoneHidden">
                    </div>

                    <div class="form_row" id="emailBlock" style="display: none;">
                        <div class="form_box">
                            <label><span>이메일</span></label>
                            <div class="input email flex">
                                <input type="text" id="email1">
                                @ <input type="text" id="email2">
                                <div class="select">
                                    <select id="emailDomain" onchange="setEmailDomain()">
                                        <option value="">직접입력</option>
                                        <option value="naver.com">naver.com</option>
                                        <option value="daum.net">daum.net</option>
                                        <option value="gmail.com">gmail.com</option>
                                    </select>
                                </div>
                                <button type="button" class="main-c cert" onclick="sendCertCode('email')">인증하기</button>
                            </div>
                        </div>
                        <input type="hidden" name="email" id="emailHidden">
                    </div>

                    <div class="btn">
                        <button type="button" class="main-c w-100" onclick="submitResetPw()">비밀번호 초기화</button>
                    </div>
                    <a href="/customer/inquiry" class="find_pass">휴대폰 번호, 이메일 주소가 변경되었나요? <span>고객센터 문의</span></a>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. 인증 수단 토글 (휴대폰 <-> 이메일)
    function toggleAuthMethod() {
        var method = $('input[name="authMethod"]:checked').val();
        if (method === 'phone') {
            $('#phoneBlock').show();
            $('#phone2, #phone3').prop('required', true);
            $('#emailBlock').hide();
            $('#email1, #email2').prop('required', false);
        } else {
            $('#phoneBlock').hide();
            $('#phone2, #phone3').prop('required', false);
            $('#emailBlock').show();
            $('#email1, #email2').prop('required', true);
        }
    }

    // 2. 이메일 도메인 선택
    function setEmailDomain() {
        var domain = document.getElementById("emailDomain").value;
        if (domain === "") {
            document.getElementById("email2").readOnly = false;
            document.getElementById("email2").value = "";
            document.getElementById("email2").focus();
        } else {
            document.getElementById("email2").readOnly = true;
            document.getElementById("email2").value = domain;
        }
    }

    // 3. 인증번호 발송 모의 스크립트 (향후 API 연동 필요)
    function sendCertCode(type) {
        if (type === 'phone') {
            if (!$('#phone2').val() || !$('#phone3').val()) {
                alert("휴대폰 번호를 정확히 입력해주세요.");
                return;
            }
            alert("입력하신 휴대폰 번호로 인증번호가 발송되었습니다.");
        } else {
            if (!$('#email1').val() || !$('#email2').val()) {
                alert("이메일 주소를 정확히 입력해주세요.");
                return;
            }
            alert("입력하신 이메일로 인증번호가 발송되었습니다.");
        }
    }

    // 4. 비밀번호 초기화 서브밋
    function submitResetPw() {
        var form = document.getElementById("findPwForm");

        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        var method = $('input[name="authMethod"]:checked').val();

        if (method === 'phone') {
            $('#phoneHidden').val($('#phone1').val() + "-" + $('#phone2').val() + "-" + $('#phone3').val());
            $('#emailHidden').val('');
        } else {
            $('#phoneHidden').val('');
            $('#emailHidden').val($('#email1').val() + "@" + $('#email2').val());
        }

        var formData = $(form).serialize();

        $.ajax({
            type: "POST",
            url: "/findPwProc",
            data: formData,
            success: function (response) {
                alert(response); // "임시 비밀번호가 발송되었습니다."
                location.href = "/login";
            },
            error: function (xhr) {
                alert("처리 중 오류가 발생했습니다.");
            }
        });
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>