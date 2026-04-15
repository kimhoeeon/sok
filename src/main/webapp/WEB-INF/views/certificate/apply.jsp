<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>신청·참여</span><span>증명서 신청 절차</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>증명서 신청 절차</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>

        <div class="sub_content">
            <div class="work_wrap">
                <div class="issue_btn">
                    <button type="button" onclick="location.href='/certificate/status'">발급상태 확인하기</button>
                </div>
                <ul class="work_guide">
                    <li>
                        <div><img src="/img/work_guide04.png" alt="증명서 신청 가이드"></div>
                        <div>
                            <div class="gu">STEP 01</div>
                            <div class="desc">신청서 제출</div>
                        </div>
                    </li>
                    <li>
                        <div><img src="/img/work_guide05.png" alt="증명서 신청 가이드"></div>
                        <div>
                            <div class="gu">STEP 02</div>
                            <div class="desc">담당자 확인</div>
                        </div>
                    </li>
                    <li>
                        <div><img src="/img/work_guide06.png" alt="증명서 신청 가이드"></div>
                        <div>
                            <div class="gu">STEP 03</div>
                            <div class="desc">e-mail로 증명서 발급</div>
                        </div>
                    </li>
                </ul>

                <form id="certApplyForm" class="apply_info" onsubmit="return false;">

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
                        <div class="form_box essen">
                            <label><span>기본정보 입력</span></label>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>이름</span></label>
                            <div class="input">
                                <input type="text" id="applyNm" name="applyNm" placeholder="홍길동" required>
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
                                @
                                <input type="text" id="email2" required>
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
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>개인정보처리방침</span></label>
                            <div class="input w-100">
                                <textarea readonly>[ 개인정보처리방침 ]&#10;&#10;스페셜올림픽코리아(이하 ‘회사’ 라 함)는 귀하의 개인정보보호를 매우 중요시하며, 『개인정보보호법』을 준수 하고 있습니다. 회사는 개인정보처리방침을 통하여 귀하께서 제공하시는 개인정보가 어떠한 용도와 방식으 로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다. 이 개인정보처리방침의 순서는 다음과 같습니다.&#10;&#10;1. 수집하는 개인정보의 항목 및 수집방법&#10;&#10;회사는 회원가입 시 서비스 이용을 위해 필요한 최소한의 개인정보만을 수집합니다. 귀하가 회사(는)의 서비스를 이용하기 위해서는 회원가입 시 필수항목과 선택항목이 있는데, 메일수신여부 등과 같은 선택 항목은 입력하지 않더라도 서비스 이용에는 제한이 없습니다.&#10;&#10;[홈페이지 회원가입 시 수집항목]&#10;- 필수항목 : 성명, 아이디, 비밀번호, 주소, 연락처(전화번호, 휴대폰번호)&#10;- 선택항목 : 이메일, 메일수신여부&#10;- 서비스 이용 과정이나 서비스 제공 업무 처리 과정에서 다음과 같은 정보들이 자동으로 생성되어 수집 될 수 있습니다. : 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보</textarea>
                                <div class="agree">
                                    <label>
                                        <input type="checkbox" id="agreeYn" required>
                                        <div class="chk_box"></div>
                                        <div>이용약관에 동의합니다.</div>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box">
                            <label><span>추가정보 입력</span></label>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>용도</span></label>
                            <div class="input">
                                <input type="text" name="usePurpose" placeholder="ex. 기관제출용" required>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box">
                            <label><span>소속</span></label>
                            <div class="input">
                                <input type="text" name="belongTo" placeholder="ex. oo클럽, xx학교">
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box remarks">
                            <label><span>비고</span></label>
                            <div class="input w-100">
                                <textarea name="remark" placeholder="30자 이내로 입력해주세요." maxlength="30"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>자동입력방지</span></label>
                            <div class="input prevention">
                                <div class="prevention_wrap">
                                    <div class="prevention_img"><img src="/img/prevention_img.png" alt="자동입력방지"></div>
                                    <input type="text" id="captchaText" required>
                                    <button type="button"><img src="/img/sound_icon.png" alt="다시 듣기"></button>
                                    <button type="button"><img src="/img/restore_icon.png" alt="리셋"></button>
                                </div>
                                <div class="txt">자동등록방지 숫자를 순서대로 입력하세요.</div>
                            </div>
                        </div>
                    </div>
                </form>

                <div class="pre">
                    ※ 발급 신청 후 서류 발급까지 영업일 기준 최소 1주일이 소요되니 신청 시 참고하시기 바랍니다.
                </div>
                <div class="apply_btn">
                    <button type="button" class="main-c apply" onclick="submitCertificate()">신청하기</button>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    // 이메일 도메인 선택 스크립트
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

    // 증명서 신청 폼 제출
    function submitCertificate() {
        // HTML5 기본 유효성 검사 체크
        var form = document.getElementById("certApplyForm");
        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        // 약관 동의 체크 여부 확인
        if (!document.getElementById("agreeYn").checked) {
            alert("개인정보처리방침에 동의해 주세요.");
            return;
        }

        // 전화번호 및 이메일 병합
        var phone = $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val();
        $("#phone").val(phone);

        var email = $("#email1").val() + "@" + $("#email2").val();
        $("#email").val(email);

        // AJAX 폼 전송
        var formData = $(form).serialize();

        $.ajax({
            type: "POST",
            url: "/certificate/applyProc",
            data: formData,
            success: function (response) {
                alert(response);
                // 신청 성공 시 발급상태 확인 페이지 또는 메인으로 이동
                location.href = "/certificate/status";
            },
            error: function (xhr) {
                // 중복 에러 등 서버 에러 메시지 노출 (스토리보드 기재 문구)
                if (xhr.status === 400) {
                    alert(xhr.responseText);
                } else {
                    alert("처리 중 오류가 발생했습니다.");
                }
            }
        });
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>