<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>신청·참여</span><span>자원봉사 신청</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>자원봉사 신청</span></div>
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
                    스페셜올림픽코리아 자원봉사는 발달장애인과 함께<br/> 따뜻한 사회를 만들어가는 행동입니다
                </div>
                <div class="work_desc">
                    스페셜올림픽의 모든 사업은 전 세계 75만 명 이상의 자원봉사자들의 시간과 열정, 헌신적인 노력으로 이루어집니다. <br/>자원봉사자들이 봉사를 통해 선수들에게 특별한 경험과
                    기회를 제공할 때, 무엇과도 비교할 수 없는 기쁨과 긍지를 느끼게 됩니다.
                </div>
                <ul class="work_guide">
                    <li>
                        <div><img src="/img/work_guide01.png" alt="자원봉사 신청 가이드"></div>
                        <div>
                            <div class="gu">신청 자격</div>
                            <div class="desc">만 14세 이상으로 <br/>개인 및 단체 누구나 참여가능</div>
                        </div>
                    </li>
                    <li>
                        <div><img src="/img/work_guide02.png" alt="자원봉사 신청 가이드"></div>
                        <div>
                            <div class="gu">모집 시기</div>
                            <div class="desc">연중수시등록가능 <br/>단, 대회자원봉사는 2달전 <br/>홈페이지를 통해 별도 모집공지</div>
                        </div>
                    </li>
                    <li>
                        <div><img src="/img/work_guide03.png" alt="자원봉사 신청 가이드"></div>
                        <div>
                            <div class="gu">활동 분야</div>
                            <div class="desc">연중 수시모집 자원봉사</div>
                        </div>
                    </li>
                </ul>

                <form id="volunteerForm" class="apply_info" onsubmit="return false;">
                    <input type="hidden" name="agreeYn" id="agreeYn" value="N">

                    <div class="form_row">
                        <div class="form_box">
                            <label><span>지원 분야</span></label>
                            <div class="input radio_btn">
                                <input type="radio" name="supportArea" id="sa1" value="스포츠" checked>
                                <label for="sa1">스포츠분야</label>

                                <input type="radio" name="supportArea" id="sa2" value="문화예술">
                                <label for="sa2">문화예술분야</label>

                                <input type="radio" name="supportArea" id="sa3" value="기타">
                                <label for="sa3">기타</label>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box">
                            <label><span>봉사 희망 횟수</span></label>
                            <div class="input radio_btn">
                                <input type="radio" name="freqType" id="ft1" value="OFTEN" checked>
                                <label for="ft1">수시로</label>

                                <input type="radio" name="freqType" id="ft2" value="ONCE">
                                <label for="ft2">한번만</label>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box">
                            <label><span>자원봉사 신청</span></label>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>행사명</span></label>
                            <div class="input">
                                <input type="text" name="eventNm" id="eventNm" required
                                       placeholder="참여를 희망하는 행사명을 입력해주세요">
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>이름</span></label>
                            <div class="input">
                                <input type="text" name="applyNm" id="applyNm" required placeholder="신청자명 또는 단체명">
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>연락처</span></label>
                            <div class="input w-33">
                                <div class="select">
                                    <select id="phone1">
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                        <option value="019">019</option>
                                        <option value="032">032</option>
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
                            <label><span>개인정보처리방침</span></label>
                            <div class="input w-100">
                                <textarea readonly>[ 개인정보처리방침 ]&#10;&#10;스페셜올림픽코리아(이하 ‘회사’ 라 함)는 귀하의 개인정보보호를 매우 중요시하며, 『개인정보보호법』을 준수 하고 있습니다. 회사는 개인정보처리방침을 통하여 귀하께서 제공하시는 개인정보가 어떠한 용도와 방식으 로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다. 이 개인정보처리방침의 순서는 다음과 같습니다.&#10;&#10;1. 수집하는 개인정보의 항목 및 수집방법&#10;&#10;회사는 회원가입 시 서비스 이용을 위해 필요한 최소한의 개인정보만을 수집합니다. 귀하가 회사(는)의 서비스를 이용하기 위해서는 회원가입 시 필수항목과 선택항목이 있는데, 메일수신여부 등과 같은 선택 항목은 입력하지 않더라도 서비스 이용에는 제한이 없습니다.&#10;&#10;[홈페이지 회원가입 시 수집항목]&#10;- 필수항목 : 성명, 아이디, 비밀번호, 주소, 연락처(전화번호, 휴대폰번호)&#10;- 선택항목 : 이메일, 메일수신여부&#10;- 서비스 이용 과정이나 서비스 제공 업무 처리 과정에서 다음과 같은 정보들이 자동으로 생성되어 수집 될 수 있습니다. : 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보</textarea>
                                <div class="agree">
                                    <label>
                                        <input type="checkbox" id="agreeChk" required>
                                        <div class="chk_box"></div>
                                        <div>이용약관에 동의합니다.</div>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box sub_box essen">
                            <label><span>자동입력방지</span></label>
                            <div class="input prevention">
                                <div class="prevention_wrap">
                                    <div class="prevention_img"><img src="/img/prevention_img.png" alt="자동입력방지"></div>
                                    <input type="text" id="captchaInput" required>
                                    <button type="button"><img src="/img/sound_icon.png" alt="다시 듣기"></button>
                                    <button type="button"><img src="/img/restore_icon.png" alt="리셋"></button>
                                </div>
                                <div class="txt">자동등록방지 숫자를 순서대로 입력하세요.</div>
                            </div>
                        </div>
                    </div>
                </form>

                <div class="apply_btn">
                    <button type="button" class="main-c apply" onclick="submitVolunteer()">신청하기</button>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    function submitVolunteer() {
        var form = document.getElementById("volunteerForm");

        // 브라우저 기본 유효성 검사 실행 (required 등)
        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        // 약관 동의 체크 검증
        if (!document.getElementById("agreeChk").checked) {
            alert("개인정보처리방침에 동의해 주세요.");
            return;
        } else {
            $("#agreeYn").val("Y"); // Y로 변경
        }

        // 전화번호 조립
        var phoneStr = $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val();
        $("#phone").val(phoneStr);

        var formData = $(form).serialize();

        // AJAX 통신
        $.ajax({
            type: "POST",
            url: "/volunteer/applyProc",
            data: formData,
            success: function (response) {
                alert(response);
                // 신청 성공 시 메인 화면으로 이동
                location.href = "/";
            },
            error: function (xhr) {
                alert("신청 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
</script>