<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>신청·참여</span><span>발급상태 확인하기</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>발급상태 확인하기</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>

        <div class="sub_content">
            <div class="work_wrap">
                <div class="work_tit">
                    <span>증명서 종류, 이름, 휴대폰번호, 이메일 입력 후 신청 내역을 확인</span>하실 수 있습니다.<br/>
                    자세한 사항은 SOK 문의처를 통해 확인하시기 바랍니다.
                </div>
                <div class="work_tit mt-30 mb-60">
                    ※ 문의전화 : 02)447-1179
                </div>
                <form id="statusForm" class="apply_info" action="/certificate/statusResult" method="post"
                      onsubmit="return submitStatusCheck()">
                    <div class="form_row">
                        <div class="form_box essen">
                            <label><span>증명서 종류</span></label>
                            <div class="input radio_btn">
                                <input type="radio" name="certType" id="cert1" value="선수등록확인서" checked>
                                <label for="cert1">선수등록확인서</label>

                                <input type="radio" name="certType" id="cert2" value="봉사활동확인서">
                                <label for="cert2">봉사활동확인서</label>

                                <input type="radio" name="certType" id="cert3" value="경기실적증명서">
                                <label for="cert3">경기실적증명서</label>

                                <input type="radio" name="certType" id="cert4" value="대회참가확인서">
                                <label for="cert4">대회참가확인서</label>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>이름</span></label>
                            <div class="input">
                                <input type="text" name="applyNm" placeholder="홍길동" required>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>휴대전화</span></label>
                            <div class="input w-33">
                                <div class="select">
                                    <select id="phone1">
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                        <option value="019">019</option>
                                    </select>
                                </div>
                                - <input type="text" id="phone2" maxlength="4" required>
                                - <input type="text" id="phone3" maxlength="4" required>
                                <input type="hidden" name="phone" id="phone">
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>이메일</span></label>
                            <div class="input email w-33">
                                <input type="text" id="email1" required>
                                @ <input type="text" id="email2" required>
                                <div class="select">
                                    <select id="emailDomain" onchange="setEmailDomain()">
                                        <option value="">직접입력</option>
                                        <option value="naver.com">naver.com</option>
                                        <option value="daum.net">daum.net</option>
                                        <option value="gmail.com">gmail.com</option>
                                        <option value="hanmail.net">hanmail.net</option>
                                    </select>
                                </div>
                                <input type="hidden" name="email" id="email">
                            </div>
                        </div>
                    </div>

                    <div class="apply_btn">
                        <button type="submit" class="main-c apply">확인하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
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

    function submitStatusCheck() {
        var phone = $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val();
        $("#phone").val(phone);

        var email = $("#email1").val() + "@" + $("#email2").val();
        $("#email").val(email);
        return true;
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>