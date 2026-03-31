<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>SOK 스페셜올림픽코리아 관리자</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <link href="/css/mngStyle.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body style="background-color: #151521;">

<div class="d-flex flex-nowrap min-vh-100">

    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp">
        <jsp:param name="menuGroup" value="${menuGroup}" />
        <jsp:param name="subMenuGroup" value="${subMenuGroup}" />
        <jsp:param name="menuId" value="${currentMenu}" />
    </jsp:include>

    <div class="d-flex flex-column flex-grow-1" style="min-width: 0;">

        <div class="d-flex justify-content-end align-items-center p-4 border-bottom" style="border-color: rgba(255,255,255,0.05) !important;">
            <div class="d-flex align-items-center glassmorphism-box px-4 py-2">
                <i class="bi bi-person-circle fs-3 me-2 neon-icon"></i>
                <span class="fw-bold text-white">${adminLogin.mbrNm} 관리자님</span>
            </div>
        </div>

        <div class="p-5 flex-grow-1 overflow-auto">