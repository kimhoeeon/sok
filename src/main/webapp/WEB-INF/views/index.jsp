<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">
        <div class="main_slide">
            <div class="main_top sub_top">
                <div class="sub_top_box">
                    <div class="flex">
                        <div class="sub_top_tit" id="tts_main_top">작은 응원이 일상이 되는 곳 <br/>스페셜 올림픽 코리아</div>
                        <a class="go_link" href="/intro/about">더 보기</a>
                    </div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_main_top">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>

            <div class="main_slide_wrap">
                <div class="swiper_box">
                    <div class="paging-wrap"></div>

                    <div class="swiper swiper_main_t">
                        <ul class="swiper-wrapper">
                            <li class="swiper-slide">
                                <a href="">
                                    <img src="/img/main_banner01.png" class="pc_img" alt="배너">
                                    <img src="/img/main_banner01_m.png" class="m_img" alt="배너">
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="">
                                    <img src="/img/main_banner02.png" class="pc_img" alt="배너">
                                    <img src="/img/main_banner02.png" class="m_img" alt="배너">
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="">
                                    <img src="/img/main_banner03.png" class="pc_img" alt="배너">
                                    <img src="/img/main_banner03.png" class="m_img" alt="배너">
                                </a>
                            </li>
                            <li class="swiper-slide">
                                <a href="">
                                    <img src="/img/main_banner04.png" class="pc_img" alt="배너">
                                    <img src="/img/main_banner04.png" class="m_img" alt="배너">
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main_apply">
            <div class="main_top sub_top">
                <div class="sub_top_box">
                    <div class="flex">
                        <div class="sub_top_tit" id="tts_main_apply">누구나 변화를 만들어갈 수 있어요</div>
                        <a class="go_link" href="/people/list">더 보기</a>
                    </div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_main_apply">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="main_apply_box">
                <div class="tit">같이 기부</div>
                <div class="desc">긍정적인 사회 변화를 위한 <br/>공익 프로젝트를 진행할 수 있어요!</div>
                <a href="/sponsor/donate">나도 참여하기</a>
            </div>
            <div class="main_apply_how">
                <ul>
                    <li>
                        <div class="num">1</div>
                        <div class="tit">후원 유형 선택</div>
                        <div class="desc">정기후원 또는 일시후원 중 <br/>원하는 후원 유형을 선택합니다.</div>
                    </li>
                    <li>
                        <div class="num">2</div>
                        <div class="tit">후원 금액 선택</div>
                        <div class="desc">부담 없는 금액부터 <br/>마음이 닿는 만큼 정할 수 있어요.</div>
                    </li>
                    <li>
                        <div class="num">3</div>
                        <div class="tit">후원 정보 입력</div>
                        <div class="desc">간단한 정보 입력으로 <br/>후원을 빠르게 진행합니다.</div>
                    </li>
                    <li>
                        <div class="num">4</div>
                        <div class="tit">결제 및 참여 완료</div>
                        <div class="desc">안전한 결제로 <br/>따뜻한 마음을 전달합니다.</div>
                    </li>
                    <li>
                        <div class="num">5</div>
                        <div class="tit">변화 소식 확인</div>
                        <div class="desc">후원이 만들어낸 이야기와 <br/>변화의 순간을 만나보세요.</div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="main_sns">
            <div class="main_top sub_top">
                <div class="sub_top_box">
                    <div class="flex">
                        <div class="sub_top_tit" id="tts_main_sns">소식으로 만나는 변화</div>
                        <a class="go_link" href="" target="_blank">더 보기</a>
                    </div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_main_sns">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>

            <div class="main_sns_list">
                <div class="instagram">
                    <div class="gu">인스타그램</div>
                    <ul>
                        <li><a href=""><img src="/img/sns_img_sample.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample02.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample03.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample02.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample03.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample02.png" alt="인스타그램 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample03.png" alt="인스타그램 이미지"></a></li>
                    </ul>
                </div>

                <div class="blog">
                    <div class="gu">네이버블로그</div>
                    <ul>
                        <li><a href=""><img src="/img/sns_img_sample.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample02.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample03.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample02.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample03.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample02.png" alt="네이버블로그 이미지"></a></li>
                        <li><a href=""><img src="/img/sns_img_sample03.png" alt="네이버블로그 이미지"></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
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