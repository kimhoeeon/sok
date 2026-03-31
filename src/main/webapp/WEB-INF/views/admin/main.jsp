<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SOK 스페셜올림픽코리아 관리자 로그인</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
            font-family: 'Malgun Gothic', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #333333;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666666;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: #e61938; /* SOK 대표 레드 색상 */
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 10px;
        }

        .btn-login:hover {
            background-color: #cc1631;
        }

        .error-message {
            color: #e61938;
            font-size: 13px;
            margin-bottom: 15px;
        }
    </style>
    <script>
        $(document).ready(function () {
            var errorMessage = "${errorMessage}";
            if (errorMessage) {
                alert(errorMessage);
            }

            $("#loginForm").submit(function (e) {
                if ($("#mbrId").val().trim() === "") {
                    alert("아이디를 입력해주세요.");
                    $("#mbrId").focus();
                    e.preventDefault();
                    return false;
                }
                if ($("#mbrPw").val().trim() === "") {
                    alert("비밀번호를 입력해주세요.");
                    $("#mbrPw").focus();
                    e.preventDefault();
                    return false;
                }
            });
        });
    </script>
</head>
<body>
    <div class="login-container">
        <h2>SOK 관리자 로그인</h2>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        <form id="loginForm" action="/admin/loginProc" method="post">
            <div class="form-group">
                <label for="mbrId">아이디</label>
                <input type="text" id="mbrId" name="mbrId" placeholder="아이디를 입력하세요">
            </div>
            <div class="form-group">
                <label for="mbrPw">비밀번호</label>
                <input type="password" id="mbrPw" name="mbrPw" placeholder="비밀번호를 입력하세요">
            </div>
            <button type="submit" class="btn-login">로그인</button>
        </form>
    </div>
</body>
</html>