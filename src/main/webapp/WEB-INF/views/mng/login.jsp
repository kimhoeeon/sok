<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>SOK 스페셜올림픽코리아 관리자 로그인</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <link href="/css/mngStyle.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* 로그인 페이지 전용 레이아웃 스타일 */
        body {
            /* 메인 컬러(#151521)를 바탕으로 중앙에 살짝 빛이 맺히는 방사형 그라데이션 */
            background: radial-gradient(circle at center, #2b2b40 0%, #151521 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .login-wrapper {
            width: 100%;
            max-width: 420px;
            padding: 40px;
            /* 글래스모피즘 & 프리미엄 다크 카드 융합 */
            background: rgba(30, 30, 45, 0.85);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            position: relative;
            z-index: 10;
        }

        .login-title {
            letter-spacing: 2px;
            margin-bottom: 30px;
        }

        /* 에러 메시지 스타일 */
        .error-alert {
            background: rgba(230, 25, 56, 0.1);
            border: 1px solid rgba(230, 25, 56, 0.3);
            color: #ff6b81;
            border-radius: 8px;
            padding: 12px;
            font-size: 14px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        /* 입력창 라벨 */
        .form-label {
            color: #a1a5b7;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        /* 배경 데코레이션 (빛 번짐 효과) */
        .bg-glow {
            position: absolute;
            width: 300px;
            height: 300px;
            background: #39ff14;
            filter: blur(150px);
            opacity: 0.15;
            border-radius: 50%;
            z-index: 1;
            top: -50px;
            right: -100px;
        }

        .bg-glow-secondary {
            position: absolute;
            width: 250px;
            height: 250px;
            background: #e61938;
            filter: blur(120px);
            opacity: 0.1;
            border-radius: 50%;
            z-index: 1;
            bottom: -50px;
            left: -50px;
        }
    </style>

    <script>
        $(document).ready(function () {
            // 폼 제출 검증
            $("#loginForm").submit(function (e) {
                var mbrId = $("#mbrId").val().trim();
                var mbrPw = $("#mbrPw").val().trim();

                if (mbrId === "") {
                    showError("아이디를 입력해주세요.");
                    $("#mbrId").focus();
                    e.preventDefault();
                    return false;
                }
                if (mbrPw === "") {
                    showError("비밀번호를 입력해주세요.");
                    $("#mbrPw").focus();
                    e.preventDefault();
                    return false;
                }
            });

            // 커스텀 에러 표시 함수
            function showError(msg) {
                var errorDiv = $("#errorContainer");
                if (errorDiv.length === 0) {
                    errorDiv = $('<div id="errorContainer" class="error-alert"><i class="bi bi-exclamation-triangle-fill me-2"></i><span></span></div>');
                    $(".login-title").after(errorDiv);
                }
                errorDiv.find("span").text(msg);
            }

            // 비밀번호 표시/숨기기 토글 로직
            $("#togglePassword").on("click", function() {
                var passwordInput = $("#mbrPw");
                var eyeIcon = $("#eyeIcon");

                if (passwordInput.attr("type") === "password") {
                    passwordInput.attr("type", "text");
                    eyeIcon.removeClass("bi-eye-slash").addClass("bi-eye");
                } else {
                    passwordInput.attr("type", "password");
                    eyeIcon.removeClass("bi-eye").addClass("bi-eye-slash");
                }
            });
        });
    </script>
</head>
<body>

<div class="bg-glow"></div>
<div class="bg-glow-secondary"></div>

<div class="login-wrapper">
    <div class="text-center login-title">
        <h3 class="fw-bold text-white mb-1">
            <i class="bi bi-lightning-charge-fill neon-icon fs-2 align-middle"></i> SOK ADMIN
        </h3>
        <span class="text-muted" style="font-size: 13px;">Special Olympics Korea 관리자 시스템</span>
    </div>

    <c:if test="${not empty errorMessage}">
        <div id="errorContainer" class="error-alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <span>${errorMessage}</span>
        </div>
    </c:if>

    <form id="loginForm" action="/loginProc" method="post">
        <div class="mb-4">
            <label for="mbrId" class="form-label text-uppercase">Admin ID</label>
            <div class="input-group" style="height: 50px;">
                        <span class="input-group-text dark-search-bar border-end-0" style="background-color: rgba(0,0,0,0.2) !important;">
                            <i class="bi bi-person text-muted"></i>
                        </span>
                <input type="text" class="form-control dark-search-bar border-start-0" id="mbrId" name="mbrId"
                       placeholder="아이디를 입력하세요" autocomplete="off">
            </div>
        </div>

        <div class="mb-5">
            <label for="mbrPw" class="form-label text-uppercase">Password</label>
            <div class="input-group" style="height: 50px;">
                <span class="input-group-text dark-search-bar border-end-0" style="background-color: rgba(0,0,0,0.2) !important;">
                    <i class="bi bi-lock text-muted"></i>
                </span>
                <input type="password" class="form-control dark-search-bar border-start-0 border-end-0" id="mbrPw" name="mbrPw"
                       placeholder="비밀번호를 입력하세요">
                <span class="input-group-text dark-search-bar border-start-0" id="togglePassword" style="cursor: pointer; background-color: rgba(0,0,0,0.2) !important;">
                    <i class="bi bi-eye-slash text-muted" id="eyeIcon"></i>
                </span>
            </div>
        </div>

        <button type="submit" class="btn btn-neon w-100 py-3 fs-5" style="border-radius: 8px;">
            Sign In <i class="bi bi-arrow-right-short fs-4 align-middle"></i>
        </button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 뒤로 가기(BFCache)로 페이지가 로딩된 경우 감지하여 강제 새로고침
    window.onpageshow = function(event) {
        // event.persisted: 브라우저 캐시에서 페이지를 로드했는지 여부 (사파리/파이어폭스 등)
        // window.performance.navigation.type == 2: 뒤로가기/앞으로가기로 진입했는지 여부 (크롬 등)
        if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
            window.location.reload();
            // 새로고침 되면 Controller를 다시 타게 되고, 세션이 있으므로 즉시 /mng/main으로 튕겨냅니다.
        }
    };
</script>
</body>
</html>