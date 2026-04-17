<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<c:set var="phoneArr" value="${fn:split(sessionScope.userLogin.phone, '-')}"/>
<c:set var="emailArr" value="${fn:split(sessionScope.userLogin.email, '@')}"/>

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
                    <li class="on"><a href="/mypage/info">프로필 수정</a></li>
                    <li><a href="">서비스 이용 동의</a></li>
                    <li><a href="">개인정보 제3자 제공 동의</a></li>
                    <li><a href="">스페셜올림픽코리아 탈퇴</a></li>
                </ul>

                <form id="profileForm" class="profile_info" onsubmit="return false;">
                    <input type="hidden" name="profileImg" id="profileImg"
                           value="${not empty sessionScope.userLogin.profileImg ? sessionScope.userLogin.profileImg : '/img/profile_img.png'}">

                    <div class="profile_img">
                        <div class="main">
                            <img id="mainProfilePreview"
                                 src="${not empty sessionScope.userLogin.profileImg ? sessionScope.userLogin.profileImg : '/img/profile_img.png'}"
                                 alt="프로필 이미지">
                        </div>
                        <div class="sub_img">
                            <div onclick="selectProfileImg('/img/profile_img_sub01.png')">
                                <img src="/img/profile_img_sub01.png" alt="프로필 선택">
                            </div>
                            <div onclick="selectProfileImg('/img/profile_img_sub02.png')">
                                <img src="/img/profile_img_sub02.png" alt="프로필 선택">
                            </div>
                            <div onclick="selectProfileImg('/img/profile_img_sub03.png')">
                                <img src="/img/profile_img_sub03.png" alt="프로필 선택">
                            </div>
                            <div onclick="selectProfileImg('/img/profile_img_sub04.png')">
                                <img src="/img/profile_img_sub04.png" alt="프로필 선택">
                            </div>
                        </div>
                    </div>

                    <div class="form_row">
                        <div class="form_box">
                            <label><span>닉네임</span></label>
                            <div class="input">
                                <input type="text" value="${sessionScope.userLogin.mbrNm}" disabled>
                            </div>
                        </div>
                    </div>

                    <div class="form_row w-33">
                        <div class="form_box">
                            <label><span>연락처</span></label>
                            <div class="input">
                                <div class="select">
                                    <select id="phone1">
                                        <option value="010" ${phoneArr[0] eq '010' ? 'selected' : ''}>010</option>
                                        <option value="011" ${phoneArr[0] eq '011' ? 'selected' : ''}>011</option>
                                        <option value="019" ${phoneArr[0] eq '019' ? 'selected' : ''}>019</option>
                                        <option value="032" ${phoneArr[0] eq '032' ? 'selected' : ''}>032</option>
                                    </select>
                                </div>
                                - <input type="text" id="phone2" maxlength="4" value="${phoneArr[1]}" required>
                                - <input type="text" id="phone3" maxlength="4" value="${phoneArr[2]}" required>
                                <input type="hidden" name="phone" id="phoneHidden">
                            </div>
                        </div>
                    </div>

                    <div class="form_row w-33">
                        <div class="form_box email">
                            <label><span>이메일</span></label>
                            <div class="input">
                                <input type="text" id="email1" value="${emailArr[0]}" required>
                                @ <input type="text" id="email2" value="${emailArr[1]}" required>
                                <div class="select">
                                    <select id="emailDomain" onchange="setEmailDomain()">
                                        <option value="">직접입력</option>
                                        <option value="naver.com" ${emailArr[1] eq 'naver.com' ? 'selected' : ''}>
                                            naver.com
                                        </option>
                                        <option value="daum.net" ${emailArr[1] eq 'daum.net' ? 'selected' : ''}>
                                            daum.net
                                        </option>
                                        <option value="gmail.com" ${emailArr[1] eq 'gmail.com' ? 'selected' : ''}>
                                            gmail.com
                                        </option>
                                    </select>
                                </div>
                                <input type="hidden" name="email" id="emailHidden">
                            </div>
                        </div>
                    </div>

                    <div class="form_row">
                        <div class="form_box">
                            <label><span>나이</span></label>
                            <div class="select">
                                <select name="birthYear">
                                    <option value="">선택해주세요</option>
                                    <c:forEach var="year" begin="1950" end="2010" step="1">
                                        <c:set var="reverseYear" value="${2010 - (year - 1950)}"/>
                                        <option value="${reverseYear}" ${sessionScope.userLogin.birthYear eq reverseYear ? 'selected' : ''}>${reverseYear}년생</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form_row w-33">
                        <div class="form_box">
                            <label><span>성별</span></label>
                            <div class="input gender">
                                <input type="radio" name="gender" id="male"
                                       value="male" ${sessionScope.userLogin.gender eq 'male' ? 'checked' : ''}>
                                <label for="male">남자</label>

                                <input type="radio" name="gender" id="female"
                                       value="female" ${sessionScope.userLogin.gender eq 'female' ? 'checked' : ''}>
                                <label for="female">여자</label>

                                <input type="radio" name="gender" id="none"
                                       value="none" ${sessionScope.userLogin.gender eq 'none' || empty sessionScope.userLogin.gender ? 'checked' : ''}>
                                <label for="none">선택안함</label>
                            </div>
                        </div>
                    </div>

                    <div class="form_row w-50">
                        <div class="form_box">
                            <label><span>지역</span></label>
                            <div class="input">
                                <div class="select">
                                    <select name="region1">
                                        <option value="">선택</option>
                                        <option value="서울" ${sessionScope.userLogin.region1 eq '서울' ? 'selected' : ''}>
                                            서울
                                        </option>
                                        <option value="경기도" ${sessionScope.userLogin.region1 eq '경기도' ? 'selected' : ''}>
                                            경기도
                                        </option>
                                        <option value="부산" ${sessionScope.userLogin.region1 eq '부산' ? 'selected' : ''}>
                                            부산
                                        </option>
                                        <option value="충청도" ${sessionScope.userLogin.region1 eq '충청도' ? 'selected' : ''}>
                                            충청도
                                        </option>
                                    </select>
                                </div>
                                <div class="select">
                                    <select name="region2">
                                        <option value="">선택</option>
                                        <option value="관악구" ${sessionScope.userLogin.region2 eq '관악구' ? 'selected' : ''}>
                                            관악구
                                        </option>
                                        <option value="노원구" ${sessionScope.userLogin.region2 eq '노원구' ? 'selected' : ''}>
                                            노원구
                                        </option>
                                        <option value="중구" ${sessionScope.userLogin.region2 eq '중구' ? 'selected' : ''}>
                                            중구
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="btn save_btn">
                        <button type="button" onclick="submitProfile()">저장하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    // 이메일 도메인 자동입력
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

    // 프로필 이미지 선택 변경 로직
    function selectProfileImg(imgSrc) {
        document.getElementById('mainProfilePreview').src = imgSrc;
        document.getElementById('profileImg').value = imgSrc;
    }

    // 폼 저장 AJAX 로직
    function submitProfile() {
        var form = document.getElementById("profileForm");

        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        // 전화번호 및 이메일 병합 세팅
        $('#phoneHidden').val($('#phone1').val() + "-" + $('#phone2').val() + "-" + $('#phone3').val());
        $('#emailHidden').val($('#email1').val() + "@" + $('#email2').val());

        var formData = $(form).serialize();

        $.ajax({
            type: "POST",
            url: "/mypage/updateProc",
            data: formData,
            success: function (response) {
                alert(response);
                location.reload(); // 세션 정보 반영을 위해 새로고침
            },
            error: function (xhr) {
                alert("프로필 수정 중 오류가 발생했습니다.");
            }
        });
    }
</script>