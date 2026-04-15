<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>신청·참여</span><span>발급상태 확인하기</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>발급상태 확인하기</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">
            <div class="work_wrap">

                <%-- DB 조회 결과에 따른 동적 메시지 노출 (클래스는 원본 유지) --%>
                <c:choose>
                    <%-- 1. 조회 결과가 없을 경우 --%>
                    <c:when test="${empty result}">
                        <div class="work_tit">
                            입력하신 정보와 일치하는 <span style="color: var(--mainColor);">신청 내역이 없습니다.</span><br/>
                            이름, 휴대전화, 이메일이 정확한지 다시 한번 확인해 주세요.
                        </div>
                    </c:when>

                    <%-- 2. 조회 결과가 있을 경우 --%>
                    <c:otherwise>
                        <div class="work_tit">
                            <span>현재
                                <c:choose>
                                    <c:when test="${result.issueStatus eq 'WAIT'}">신청 대기</c:when>
                                    <c:when test="${result.issueStatus eq 'ING'}">발급 진행</c:when>
                                    <c:when test="${result.issueStatus eq 'DONE'}">발급 완료</c:when>
                                    <c:when test="${result.issueStatus eq 'REJECT'}">발급 거절(반려)</c:when>
                                </c:choose>
                            중</span>입니다.<br/>

                                <%-- 반려일 경우 반려 사유 추가 노출 --%>
                            <c:if test="${result.issueStatus eq 'REJECT'}">
                                <span style="font-size: 16px; color: #777;">[반려 사유: ${result.rejectRsn}]</span><br/>
                            </c:if>

                            자세한 사항은 SOK 문의처를 통해 확인하시기 바랍니다.
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="work_tit mt-30 mb-60">
                    ※ 문의전화 : 02)447-1179
                </div>
                <div class="apply_btn">
                    <button type="button" class="main-c home" onclick="location.href='/'">홈으로</button>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>