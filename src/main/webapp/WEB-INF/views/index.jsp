<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* ★ 팝업 전용 커스텀 체크박스 스타일 추가 */
    .popup-footer { display: flex; justify-content: space-between; align-items: center; padding: 15px 20px; background: #222; color: #fff; }
    .popup-footer label { display: flex; align-items: center; cursor: pointer; gap: 8px; margin: 0; }
    .popup-footer input[type="checkbox"] { display: none; } /* appearance:none 으로 숨겨진 기본 인풋 완전히 숨김 */
    .popup-footer .chk_box { width: 24px; height: 24px; flex-shrink: 0; background: url(/img/pop_check_off.png) no-repeat center; background-size: contain; }
    .popup-footer input[type="checkbox"]:checked + .chk_box { background: url(/img/pop_check_on.png) no-repeat center; background-size: contain; }
    .popup-footer button { cursor: pointer; background: inherit; border: none; color: #fff; font-weight: bold; font-size: 16px; padding: 0; }
</style>

<c:if test="${not empty popupList}">
    <c:forEach var="popup" items="${popupList}">
        <div id="main_popup_${popup.popSeq}" class="main-popup"
             style="width: ${popup.width}px; height: ${popup.height}px; top: ${popup.topPos}px; left: ${popup.leftPos}px; display: none;">

            <div class="popup-content" style="height: calc(100% - 40px); overflow-y: auto;">
                <c:choose>
                    <c:when test="${not empty popup.popupImage and not empty popup.popupImage.filePath}">
                        <a href="javascript:void(0);">
                            <img src="${popup.popupImage.filePath}" alt="${popup.title}" style="width: 100%; display: block;">
                        </a>
                    </c:when>
                    <c:otherwise>
                        ${popup.content}
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="popup-footer">
                <!-- ★ SOK 프로젝트 전용 chk_box 구조로 완벽 교체 -->
                <label for="chk_hide_${popup.popSeq}">
                    <input type="checkbox" id="chk_hide_${popup.popSeq}">
                    <div class="chk_box"></div>
                    <span>오늘 하루 보지 않기</span>
                </label>
                <button type="button" onclick="closePopup('${popup.popSeq}');">닫기 [X]</button>
            </div>

        </div>
    </c:forEach>
</c:if>

<script>
    // 1. 완벽한 자정(23:59:59) 기준 쿠키 만료 설정
    function setPopupCookie(name, value, expiredays) {
        let todayDate = new Date();
        todayDate.setHours(23, 59, 59, 999);
        document.cookie = name + "=" + encodeURIComponent(value) + "; path=/; expires=" + todayDate.toUTCString() + ";";
    }

    // 2. 정규식을 활용한 안전한 쿠키 읽기
    function getPopupCookie(name) {
        let matches = document.cookie.match(new RegExp(
            "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
        ));
        return matches ? decodeURIComponent(matches[1]) : undefined;
    }

    // 3. 팝업 닫기 및 쿠키 굽기 로직
    function closePopup(popSeq) {
        let chkBox = document.getElementById("chk_hide_" + popSeq);

        if (chkBox && chkBox.checked) {
            setPopupCookie("sok_popup_" + popSeq, "done", 1);
        }

        let popupDiv = document.getElementById("main_popup_" + popSeq);
        if (popupDiv) {
            popupDiv.style.display = "none";
        }
    }

    // 4. 페이지 로드 시 쿠키 검사 (let 활용으로 다중 팝업 스코프 충돌 방지)
    document.addEventListener("DOMContentLoaded", function() {
        <c:if test="${not empty popupList}">
        <c:forEach var="popup" items="${popupList}">
        let pSeq_${popup.popSeq} = "${popup.popSeq}";
        let cookieData_${popup.popSeq} = getPopupCookie("sok_popup_" + pSeq_${popup.popSeq});

        if (cookieData_${popup.popSeq} !== "done") {
            let popupTarget = document.getElementById("main_popup_" + pSeq_${popup.popSeq});
            if (popupTarget) {
                popupTarget.style.display = "block";
            }
        }
        </c:forEach>
        </c:if>
    });
</script>

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