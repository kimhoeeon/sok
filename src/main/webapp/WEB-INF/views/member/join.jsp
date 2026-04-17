<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>홈</span><span>회원가입</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>회원가입</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">
            <div class="join_wrap">
                <form id="joinForm" class="join_info" onsubmit="return false;" enctype="multipart/form-data">
                    <div class="join_tit">
                        <div>개인인 경우, 카카오 로그인을 이용해 주세요</div>
                    </div>
                    <div class="form_row">
                        <div class="form_tit">기본 정보</div>
                        <div class="form_box essen">
                            <label><span>아이디</span></label>
                            <div class="input">
                                <input type="text" name="mbrId" id="mbrId" placeholder="아이디를 입력하세요." required>
                            </div>
                        </div>
                        <div class="form_box essen">
                            <label><span>비밀번호</span></label>
                            <div class="input">
                                <input type="password" name="mbrPw" id="mbrPw" placeholder="비밀번호를 입력하세요." required>
                            </div>
                            <div class="info_txt">영어 소문자, 숫자, 특수문자 중 2개 이상 조합하여 8~15자리 이내</div>
                        </div>
                        <div class="form_box essen">
                            <label><span>비밀번호 확인</span></label>
                            <div class="input">
                                <input type="password" id="mbrPwConfirm" placeholder="비밀번호를 다시 입력하세요." required>
                            </div>
                        </div>
                    </div>

                    <div class="form_row">
                        <div class="form_tit mt-30">기관 정보</div>
                        <div class="form_box essen">
                            <label><span>단체/기관 유형</span></label>
                            <div class="select">
                                <select name="instType" required>
                                    <option value="">선택해주세요</option>
                                    <option value="단체(사회복지시설)">단체(사회복지시설)</option>
                                    <option value="단체(사회복지법인)">단체(사회복지법인)</option>
                                    <option value="단체(복지관)">단체(복지관)</option>
                                    <option value="단체(비영리법인 및 민간단체)">단체(비영리법인 및 민간단체)</option>
                                    <option value="단체(비영리임의단체)">단체(비영리임의단체)</option>
                                    <option value="사회적경제영역(소셜벤처)">사회적경제영역(소셜벤처)</option>
                                    <option value="사회적경제영역(사회적기업)">사회적경제영역(사회적기업)</option>
                                    <option value="사회적경제영역(협동조합)">사회적경제영역(협동조합)</option>
                                    <option value="개인사업자">개인사업자</option>
                                    <option value="법인사업자">법인사업자</option>
                                    <option value="유한회사">유한회사</option>
                                    <option value="미등록단체(모임)">미등록단체(모임)</option>
                                    <option value="기타">기타</option>
                                </select>
                            </div>
                        </div>
                        <div class="form_box essen">
                            <label><span>기관명</span></label>
                            <div class="input">
                                <input type="text" name="instNm" required>
                            </div>
                        </div>
                        <div class="form_box essen">
                            <label><span>사업자등록번호</span></label>
                            <div class="input radio">
                                <label>
                                    <input type="radio" name="bizNoType" value="N" checked onchange="toggleBizNo(this)">
                                    <label>없음</label>
                                </label>
                                <label>
                                    <input type="radio" name="bizNoType" value="Y" onchange="toggleBizNo(this)">
                                    <label>있음</label>
                                    <input type="text" name="bizNo" id="bizNoInput" disabled placeholder="숫자만 입력">
                                </label>
                            </div>
                        </div>
                        <div class="form_box">
                            <label><span>사업자등록증</span></label>
                            <div class="input">
                                <input type="file" name="bizFile" id="bizFile" style="display:none;" onchange="updateFileName(this)">
                                <button type="button" class="btn_file" onclick="document.getElementById('bizFile').click();">
                                    첨부하기
                                </button>
                            </div>
                            <div class="upload_file" id="fileDisplayArea" style="display:none;">
                                <span id="fileNameText"></span>
                                <a href="javascript:void(0);" onclick="removeFile()">
                                    <img src="/img/ico_close.png" alt="닫기 버튼">
                                </a>
                            </div>
                        </div>
                        <div class="form_box essen">
                            <label><span>담당자명</span></label>
                            <div class="input">
                                <input type="text" name="mgrNm" required>
                            </div>
                        </div>
                        <div class="form_box essen">
                            <label><span>직함/직위</span></label>
                            <div class="input">
                                <input type="text" name="mgrPos" required>
                            </div>
                        </div>
                        <div class="form_box essen">
                            <label><span>연락처</span></label>
                            <div class="input w-33">
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
                                <input type="hidden" name="phone" id="phoneHidden">
                            </div>
                        </div>
                        <div class="form_box essen">
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
                                    </select>
                                </div>
                                <input type="hidden" name="email" id="emailHidden">
                            </div>
                        </div>
                    </div>

                    <div class="agree_row">
                        <div class="agree_tit">서비스 이용약관에 동의해주세요</div>
                        <div class="agree_all">
                            <label>
                                <input type="checkbox" id="chkAll">
                                <span class="chk_box"></span>
                                <div>모두 동의합니다.</div>
                            </label>
                        </div>
                        <div class="agree_check">
                            <div class="agree_item">
                                <label>
                                    <input type="checkbox" class="chk-req" required>
                                    <span class="chk_box"></span>
                                    <div>[필수] 만 14세 이상입니다.</div>
                                </label>
                            </div>
                            <div class="agree_item">
                                <label>
                                    <input type="checkbox" class="chk-req" required>
                                    <span class="chk_box"></span>
                                    <div>[필수] 서비스 이용약관 동의</div>
                                </label>
                                <button type="button" class="btn-open-terms" data-terms="service">
                                    <img src="/img/ico_back_arrow.svg" alt="">
                                </button>
                            </div>
                            <div class="agree_item">
                                <label>
                                    <input type="checkbox" class="chk-req" required>
                                    <span class="chk_box"></span>
                                    <div>[필수] 개인정보 처리 방침 동의</div>
                                </label>
                                <button type="button" class="btn-open-terms" data-terms="privacy">
                                    <img src="/img/ico_back_arrow.svg" alt="">
                                </button>
                            </div>
                            <div class="agree_item">
                                <label>
                                    <input type="checkbox" name="marketingYn" value="Y">
                                    <span class="chk_box"></span>
                                    <div>[선택] 마케팅 정보 수신 동의</div>
                                </label>
                                <button type="button" class="btn-open-terms" data-terms="privacy">
                                    <img src="/img/ico_back_arrow.svg" alt="">
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="info_txt">
                        선택 항목에 동의하지 않아도 서비스 이용이 가능합니다. 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으며, 동의 거부 시 회원 서비스 이용이 제한됩니다.
                    </div>

                    <div class="join_btn">
                        <button type="button" class="join" onclick="submitJoin()">회원가입</button>
                        <button type="button" class="home" onclick="location.href='/'">홈으로 돌아가기</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<script>
    // 1. 전체 동의 체크박스 로직
    $('#chkAll').on('click', function () {
        var isChecked = $(this).is(':checked');
        $('.agree_check input[type="checkbox"]').prop('checked', isChecked);
    });

    $('.agree_check input[type="checkbox"]').on('click', function () {
        var total = $('.agree_check input[type="checkbox"]').length;
        var checked = $('.agree_check input[type="checkbox"]:checked').length;
        $('#chkAll').prop('checked', total === checked);
    });

    // 2. 이메일 도메인 자동입력
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

    // 3. 사업자 등록번호 활성/비활성 토글
    function toggleBizNo(radio) {
        if (radio.value === 'Y') {
            $('#bizNoInput').prop('disabled', false).prop('required', true);
        } else {
            $('#bizNoInput').prop('disabled', true).prop('required', false).val('');
        }
    }

    // 4. 파일명 디자인 연동
    function updateFileName(input) {
        if (input.files && input.files[0]) {
            $('#fileNameText').text(input.files[0].name);
            $('#fileDisplayArea').css('display', 'flex');
        }
    }

    function removeFile() {
        $('#bizFile').val('');
        $('#fileDisplayArea').css('display', 'none');
    }

    // 5. 최종 서브밋 로직
    function submitJoin() {
        var form = document.getElementById("joinForm");

        // 브라우저 기본 유효성 검사 (required 필드 체크)
        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        // 비밀번호 정규식 및 일치 확인
        var pw = $('#mbrPw').val();
        var pwConfirm = $('#mbrPwConfirm').val();
        var pwRegex = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,15}$/;

        if (!pwRegex.test(pw)) {
            alert("비밀번호는 영어 소문자, 숫자, 특수문자 중 2개 이상 조합하여 8~15자리 이내여야 합니다.");
            $('#mbrPw').focus();
            return;
        }

        if (pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            $('#mbrPwConfirm').focus();
            return;
        }

        // 전화번호 및 이메일 병합 세팅
        $('#phoneHidden').val($('#phone1').val() + "-" + $('#phone2').val() + "-" + $('#phone3').val());
        $('#emailHidden').val($('#email1').val() + "@" + $('#email2').val());

        // 폼데이터 AJAX 전송 (파일 포함)
        var formData = new FormData(form);

        $.ajax({
            type: "POST",
            url: "/joinProc",
            data: formData,
            processData: false, // 파일 전송시 필수
            contentType: false, // 파일 전송시 필수
            success: function (response) {
                alert(response);
                location.href = "/login"; // 성공 시 로그인 화면으로
            },
            error: function (xhr) {
                if (xhr.status === 400) {
                    alert(xhr.responseText); // "이미 사용중인 아이디입니다." 등 노출
                } else {
                    alert("가입 처리 중 서버 오류가 발생했습니다.");
                }
            }
        });
    }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>