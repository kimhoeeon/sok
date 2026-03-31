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
<body>
<div class="d-flex">
  <div class="sidebar premium-dark-card p-3 min-vh-100" style="width: 260px; border-radius: 0;">
    <h4 class="text-center mb-5 mt-3 fw-bold"><i class="bi bi-lightning-charge-fill neon-icon"></i> SOK ADMIN</h4>
    <ul class="nav flex-column">
      <li class="nav-item"><a class="nav-link" href="/admin/main"><i class="bi bi-speedometer2 me-2"></i> 대시보드</a></li>
      <li class="nav-item"><a class="nav-link active" href="/admin/notice/list"><i class="bi bi-megaphone me-2"></i> 공지사항 관리</a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/sponsor/list"><i class="bi bi-heart me-2"></i> 후원 관리</a></li>
      <li class="nav-item mt-5"><a class="nav-link text-danger" href="/admin/logout"><i class="bi bi-box-arrow-right me-2"></i> 로그아웃</a></li>
    </ul>
  </div>
  <div class="flex-grow-1 p-5">