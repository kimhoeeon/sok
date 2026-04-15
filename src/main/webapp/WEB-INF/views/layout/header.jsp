<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="SOK 스페셜올림픽코리아">
    <meta name="format-detection" content="telephone=no" />

    <meta property="og:type" content="website">
    <meta property="og:locale" content="ko_KR">
    <meta property="og:title" content="스페셜올림픽코리아">
    <meta property="og:image" content="/img/og_img.jpg">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.png">
    <title>스페셜올림픽코리아</title>

    <link href="/css/reset.css" rel="stylesheet">
    <link href="/css/font.css" rel="stylesheet">
    <link href="/css/base.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <link href="/css/responsive.css" rel="stylesheet">
</head>
<body>

    <div id="header">
        <div class="inner">
            <div class="logo"><a href="/"><img src="/img/logo.png" alt="SOK 로고"></a></div>
            <div class="nav_wrap">
                <ul class="menu">
                    <li class="has-sub">
                        <a href="#">SOK</a>
                        <ul class="sub_menu">
                            <li><a href="/intro">SOK 소개</a></li>
                            <li><a href="/greeting">인사말</a></li>
                            <li><a href="/ci">CI</a></li>
                            <li><a href="/location">오시는 길</a></li>
                        </ul>
                    </li>
                    <li><a href="/people/list">함께하는 사람들</a></li>
                    <li class="has-sub">
                        <a href="#">주요사업</a>
                        <ul class="sub_menu">
                            <li><a href="/business/sports">스포츠</a></li>
                            <li><a href="/business/arts">문화예술</a></li>
                            <li><a href="/business/community">커뮤니티</a></li>
                            <li><a href="/business/awareness">인식개선</a></li>
                        </ul>
                    </li>
                    <li class="has-sub">
                        <a href="#">뉴스·자료</a>
                        <ul class="sub_menu">
                            <li><a href="/notice/list">공지사항</a></li>
                            <li><a href="/management/list">경영공시</a></li>
                            <li><a href="/bidding/list">입찰정보</a></li>
                            <li><a href="/news/list">보도자료</a></li>
                            <li><a href="/report/list">활동보고서</a></li>
                        </ul>
                    </li>
                    <li class="has-sub">
                        <a href="#">신청·참여</a>
                        <ul class="sub_menu">
                            <li><a href="/sponsor/donate">후원하기</a></li>
                            <li><a href="/volunteer/apply">자원봉사 신청</a></li>
                            <li><a href="/certificate/apply">증명서 신청</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="utils">
                    <li class="utils_item has_dropdown accessibility_exempt">
                        <button type="button" class="utils_btn conven_btn"><img src="/img/ico_convenience.png" alt="접근성 아이콘">접근성</button>
                        <div class="dropdown">
                            <div class="control_group line">
                                <span>글씨 크기</span>
                                <div class="btns">
                                    <button type="button" class="font_plus"><img src="/img/ico_plus.png" alt="플러스 버튼"></button>
                                    <button type="button" class="font_minus"><img src="/img/ico_minus.png" alt="마이너스 버튼"></button>
                                </div>
                            </div>
                            <div class="control_group">
                                <span>줄간격</span>
                                <div class="btns">
                                    <button type="button" class="line_plus"><img src="/img/ico_plus.png" alt="플러스 버튼"></button>
                                    <button type="button" class="line_minus"><img src="/img/ico_minus.png" alt="마이너스 버튼"></button>
                                </div>
                            </div>
                            <div class="control_group">
                                <span>설정 초기화</span>
                                <div class="btns">
                                    <button type="button" class="reset_btn"><img src="/img/ico_reset.png" alt="설정 초기화 버튼"></button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="utils_item">
                        <a href="/sponsor/donate" class="donate_btn">후원하기</a>
                    </li>
                    <li class="utils_item flex">
                        <ul>
                            <li class="utils_item has_dropdown">
                                <button type="button" class="utils_btn profile_btn"><img src="/img/ico_profile.png" alt="마이페이지"></button>
                                <div class="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.userLogin}">
                                            <a href="/mypage/donate">기부내역</a>
                                            <a href="/mypage/info">마이페이지</a>
                                            <a href="/logout">로그아웃</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/login">로그인</a>
                                            <a href="/join">회원가입</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li class="megamenu">
                        <span>메뉴</span>
                    </li>
                </ul>
            </div>

            <div class="hd_site_map">
                <div class="site_map_box">
                    <div class="site_map_top">
                        <div class="site_map_top_btn">
                            <c:choose>
                                <c:when test="${not empty sessionScope.userLogin}">
                                    <a href="/logout" class="login">LOGOUT</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/login" class="login">LOGIN</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="site_map_top_link">
                            <a href="/mypage/info" class="hd_top_sns">마이페이지</a>
                            <a href="/mypage/donate" class="hd_top_sns">기부현황</a>
                        </div>
                    </div>
                    </div>
            </div>
        </div>
    </div>