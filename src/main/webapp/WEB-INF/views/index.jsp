<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">

    <section class="main_top">
        <div class="swiper swiperMainTop">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <div class="bg_img" style="background-image: url('/img/main_visual01.jpg');"></div>
                    <div class="txt_box">
                        <p class="tit">Be a fan<br>of Special Olympics</p>
                        <p class="txt">스페셜올림픽코리아는 발달장애인들의 스포츠 및 문화예술 활동을 지원합니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<c:forEach var="popup" items="${popupList}">
    <div id="popup_${popup.popSeq}" class="main_popup_layer"
         style="position:absolute; top:${popup.topPos}px; left:${popup.leftPos}px; width:${popup.width}px; height:${popup.height}px; z-index:9999; background:#fff; border:1px solid #ddd; box-shadow: 5px 5px 15px rgba(0,0,0,0.2); display:none;">

        <div class="pop_content" style="width:100%; height:calc(100% - 35px); overflow-y:auto; padding:10px;">
                ${popup.content}
        </div>

        <div class="pop_footer"
             style="width:100%; height:35px; background:#333; color:#fff; display:flex; justify-content:space-between; align-items:center; padding:0 10px; font-size:12px;">
            <label style="cursor:pointer; display:flex; align-items:center;">
                <input type="checkbox" id="chk_hide_${popup.popSeq}" onclick="closePopupToday('${popup.popSeq}')"
                       style="margin-right:5px;"> 오늘 하루 보지 않기
            </label>
            <a href="javascript:void(0);" onclick="$('#popup_${popup.popSeq}').hide();"
               style="color:#fff; text-decoration:none; font-weight:bold;">[닫기]</a>
        </div>
    </div>
</c:forEach>

<script>
    $(document).ready(function () {
        // 1. 페이지 로드 시 각 팝업별 쿠키 확인 후 노출 여부 결정
        <c:forEach var="popup" items="${popupList}">
        if (getCookie("popup_hide_${popup.popSeq}") !== "Y") {
            $('#popup_${popup.popSeq}').show();
        }
        </c:forEach>
    });

    // 2. 오늘 하루 보지 않기 처리 (24시간 쿠키 설정)
    function closePopupToday(seq) {
        if ($("#chk_hide_" + seq).is(":checked")) {
            setCookie("popup_hide_" + seq, "Y", 1);
            $('#popup_' + seq).hide();
        }
    }

    // 쿠키 설정 함수
    function setCookie(name, value, exp) {
        var date = new Date();
        date.setTime(date.getTime() + (exp * 24 * 60 * 60 * 1000));
        document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
    }

    // 쿠키 가져오기 함수
    function getCookie(name) {
        var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
        return value ? value[2] : null;
    }
</script>