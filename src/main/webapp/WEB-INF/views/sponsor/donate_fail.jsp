<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div id="container">
    <div class="inner">

        <!-- SOK 표준 서브페이지 상단 타이틀 영역 -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>참여공간</span><span>후원하기</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top">후원 결제 실패</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>

        <div class="sub_content" style="text-align: center; padding-bottom: 120px;">

            <div style="margin-bottom: 30px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="#dc3545" class="bi bi-exclamation-circle" viewBox="0 0 16 16" style="margin: 0 auto;">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                    <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
                </svg>
            </div>

            <h3 style="font-size: 28px; font-weight: bold; margin-bottom: 20px; color: #222;">결제가 정상적으로 처리되지 않았습니다.</h3>

            <div style="background: #f8f9fa; border: 1px solid #e9ecef; padding: 40px; border-radius: 20px; display: inline-block; text-align: left; max-width: 650px; width: 100%; box-shadow: 0 4px 15px rgba(0,0,0,0.03);">

                <!-- 오류 코드가 있을 경우 노출 -->
                <c:if test="${not empty errorCode}">
                    <p style="font-size: 15px; color: #777; margin-bottom: 10px;">
                        <strong>오류 코드 :</strong> <span style="color: #444; font-weight: 500;">${errorCode}</span>
                    </p>
                </c:if>

                <p style="font-size: 18px; color: #333; margin-bottom: 15px; border-bottom: 1px solid #ddd; padding-bottom: 15px;">
                    <strong>실패 사유 :</strong>
                    <span style="color: #dc3545; font-weight: 600;">
                        <c:choose>
                            <c:when test="${not empty errorMessage}">${errorMessage}</c:when>
                            <c:otherwise>알 수 없는 네트워크 오류가 발생했습니다.</c:otherwise>
                        </c:choose>
                    </span>
                </p>
                <p style="font-size: 15px; color: #555; line-height: 1.7; margin: 0; font-weight: 500;">
                    - 입력하신 결제 정보(잔액, 한도, 비밀번호 등)를 다시 한번 확인해 주세요.<br>
                    - 일시적인 네트워크 오류일 수 있으니 잠시 후 다시 시도해 주세요.<br>
                    - 문제가 지속될 경우 스페셜올림픽코리아 사무국으로 문의 바랍니다.
                </p>
            </div>

            <div style="margin-top: 50px;">
                <a href="/sponsor/donate" style="display: inline-block; padding: 16px 50px; background: #DF0031; color: #fff; font-size: 18px; font-weight: bold; border-radius: 50px; text-decoration: none; margin: 0 10px; transition: all 0.3s ease;">다시 후원하기</a>
                <a href="/" style="display: inline-block; padding: 16px 50px; background: #6c757d; color: #fff; font-size: 18px; font-weight: bold; border-radius: 50px; text-decoration: none; margin: 0 10px; transition: all 0.3s ease;">메인으로 이동</a>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />