<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SOK 스페셜올림픽코리아 관리자</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <link href="/css/mngStyle.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function getCsrfTokenFromCookie() {
            let name = "XSRF-TOKEN=";
            let decodedCookie = decodeURIComponent(document.cookie);
            let ca = decodedCookie.split(';');
            for(let i = 0; i < ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }

        $(document).ready(function() {
            // 모든 관리자 AJAX 요청에 CSRF 헤더 세팅
            $.ajaxSetup({
                beforeSend: function(xhr, settings) {
                    if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
                        xhr.setRequestHeader("X-XSRF-TOKEN", getCsrfTokenFromCookie());
                    }
                }
            });

            // 관리자 내 모든 일반 form POST 요청 시 hidden input 자동 생성
            $(document).on('submit', 'form', function() {
                let method = $(this).attr('method');
                if (method && method.toUpperCase() === 'POST') {
                    if ($(this).find('input[name="_csrf"]').length === 0) {
                        $('<input>').attr({
                            type: 'hidden',
                            name: '_csrf',
                            value: getCsrfTokenFromCookie()
                        }).appendTo($(this));
                    }
                }
            });
        });
    </script>
</head>
<body>

<div class="d-flex flex-nowrap min-vh-100">

    <jsp:include page="/WEB-INF/views/mng/layout/sidebar.jsp">
        <jsp:param name="menuId" value="${currentMenu}" />
    </jsp:include>

    <c:if test="${not empty errorMessage}">
    <script>
        alert('${errorMessage}');
    </script>
    </c:if>

    <c:if test="${not empty successMessage}">
    <script>
        alert('${successMessage}');
    </script>
    </c:if>

    <div class="d-flex flex-column flex-grow-1" style="min-width: 0;">

        <div class="d-flex justify-content-end align-items-center p-4 border-bottom" style="border-color: rgba(255,255,255,0.05) !important;">

            <a href="/mng/admin/ip/list" class="btn btn-dark me-3 shadow-sm" style="border-radius: 8px; padding: 8px 16px;">
                <i class="bi bi-shield-check"></i> 접근 IP 관리
            </a>

            <div class="d-flex align-items-center glassmorphism-box px-4 py-2">
                <i class="bi bi-person-circle fs-3 me-2 neon-icon"></i>
                <span class="fw-bold text-dark">${adminLogin.admNm} 관리자님</span>
            </div>

        </div>

        <div class="p-5 flex-grow-1 overflow-auto">