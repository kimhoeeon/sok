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
                    <li><a href="/mypage/terms/service">서비스 이용 동의</a></li>
                    <li><a href="/mypage/terms/personal">개인정보 제3자 제공 동의</a></li>
                    <li><a href="/mypage/leave">스페셜올림픽코리아 탈퇴</a></li>
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
                                    <select name="region1" id="region1">
                                        <option value="">시/도 선택</option>
                                    </select>
                                </div>
                                <div class="select">
                                    <select name="region2" id="region2">
                                        <option value="">구/군 선택</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form_row">
                        <div class="form_box">
                            <label><span>마케팅 수신 (선택)</span></label>
                            <div class="input" style="display: flex; align-items: center; min-height: 50px;">
                                <div class="form-check form-switch" style="font-size: 1.2rem; margin: 0;">
                                    <input class="form-check-input" type="checkbox" role="switch" id="marketingToggle" style="cursor:pointer;"
                                    ${sessionScope.userLogin.marketingYn eq 'Y' ? 'checked' : ''} onchange="toggleMarketing(this)">
                                    <label class="form-check-label ms-2" for="marketingToggle" style="font-size: 1rem; cursor: pointer; transform: translateY(2px); display: inline-block;">
                                        이메일 및 SMS 홍보 정보 수신 동의
                                    </label>
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
    // 1. 전국 구/군 데이터 배열 (빠짐없이 추가 완료)
    var regionData = {
        "서울": ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"],
        "부산": ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"],
        "대구": ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구", "군위군"],
        "인천": ["강화군", "계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"],
        "광주": ["광산구", "남구", "동구", "북구", "서구"],
        "대전": ["대덕구", "동구", "서구", "유성구", "중구"],
        "울산": ["남구", "동구", "북구", "울주군", "중구"],
        "세종": ["세종특별자치시"],
        "경기": ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"],
        "강원": ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"],
        "충북": ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시", "충주시"],
        "충남": ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시", "청양군", "태안군", "홍성군"],
        "전북": ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시", "정읍시", "진안군"],
        "전남": ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"],
        "경북": ["경산시", "경주시", "고령군", "구미시", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시"],
        "경남": ["거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시", "통영시", "하동군", "함안군", "함양군", "합천군"],
        "제주": ["서귀포시", "제주시"]
    };

    $(document).ready(function() {
        // 기존 회원의 저장된 지역 값 불러오기
        var savedRegion1 = "${sessionScope.userLogin.region1}";
        var savedRegion2 = "${sessionScope.userLogin.region2}";

        var $region1 = $("#region1");
        var $region2 = $("#region2");

        // 시/도(region1) 드롭다운 초기화
        $.each(regionData, function(sido, guguns) {
            var isSelected = (sido === savedRegion1) ? "selected" : "";
            $region1.append("<option value='" + sido + "' " + isSelected + ">" + sido + "</option>");
        });

        // 구/군(region2) 드롭다운 갱신 함수
        function updateRegion2(sido, targetGugun) {
            $region2.empty().append("<option value=''>구/군 선택</option>");
            if(sido && regionData[sido]) {
                $.each(regionData[sido], function(index, gugun) {
                    var isSelected = (gugun === targetGugun) ? "selected" : "";
                    $region2.append("<option value='" + gugun + "' " + isSelected + ">" + gugun + "</option>");
                });
            }
        }

        // 페이지 진입 시 저장된 값에 맞춰 region2 세팅
        if(savedRegion1) {
            updateRegion2(savedRegion1, savedRegion2);
        }

        // 사용자가 시/도(region1)를 변경할 때 동작할 이벤트
        $region1.on("change", function() {
            var selectedSido = $(this).val();
            updateRegion2(selectedSido, ""); // 시도를 바꾸면 구군은 초기화됨
        });
    });

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

    // 마케팅 수신 동의 실시간 토글 AJAX
    function toggleMarketing(checkbox) {
        var marketingYn = checkbox.checked ? 'Y' : 'N';

        $.ajax({
            url: '/mypage/updateMarketing',
            type: 'POST',
            data: { marketingYn: marketingYn },
            success: function(res) {
                alert('마케팅 수신 동의 설정이 정상적으로 변경되었습니다.');
            },
            error: function() {
                alert('설정 변경 중 오류가 발생했습니다.');
                checkbox.checked = !checkbox.checked; // 실패 시 원래 스위치 상태로 되돌림
            }
        });
    }
</script>