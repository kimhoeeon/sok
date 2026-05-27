<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_badge ${fn:contains(sport.description, '[INAS]') and not fn:contains(sport.description, '[Special Olympic]') ? 'blue' : ''}">
                    <c:if test="${fn:contains(sport.description, '[Special Olympic]')}"><span>SO</span></c:if>
                    <c:if test="${fn:contains(sport.description, '[Unified Sports]')}"><span>US</span></c:if>
                    <c:if test="${fn:contains(sport.description, '[INAS]')}"><span>INAS</span></c:if>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">
                    ${sport.name}
                </div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
                <div class="sport_info">
                    <div class="txt">
                        ${sport.description}
                    </div>
                    <c:if test="${not empty sport.fileUrl}">
                        <div class="down">
                            <a href="${sport.fileUrl}">경기규정 다운로드</a>
                        </div>
                    </c:if>
                </div>
            </div>

        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sports_wrap">
                <div class="sports_view">
                    <div class="tit">Photo</div>

                    <ul class="img_item">
                        <li><img src="/img/sports/${sportId}_img01.jpg" alt="${sport.name} 이미지 1"></li>
                        <li><img src="/img/sports/${sportId}_img02.jpg" alt="${sport.name} 이미지 2"></li>
                        <li><img src="/img/sports/${sportId}_img03.jpg" alt="${sport.name} 이미지 3"></li>
                    </ul>

                    <div class="btn">
                        <button type="button" onclick="location.href='/business/sports'">목록으로</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>