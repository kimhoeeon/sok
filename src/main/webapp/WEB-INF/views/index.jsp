<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* 팝업 전용 커스텀 체크박스 스타일 추가 */
    .popup-footer { display: flex; justify-content: space-between; align-items: center; padding: 15px 20px; background: #222; color: #fff; }
    .popup-footer label { display: flex; align-items: center; cursor: pointer; gap: 8px; margin: 0; }
    .popup-footer input[type="checkbox"] { display: none; } /* appearance:none 으로 숨겨진 기본 인풋 완전히 숨김 */
    .popup-footer .chk_box { width: 24px; height: 24px; flex-shrink: 0; background: url(/img/pop_check_off.png) no-repeat center; background-size: contain; }
    .popup-footer input[type="checkbox"]:checked + .chk_box { background: url(/img/pop_check_on.png) no-repeat center; background-size: contain; }
    .popup-footer button { cursor: pointer; background: inherit; border: none; color: #fff; font-weight: bold; font-size: 16px; padding: 0; }

    /* 동적 리스트 텍스트 줄임(Truncate) 스타일 보완 */
    .board_table ul li .gu { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 80%; }
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
                <!-- SOK 프로젝트 전용 chk_box 구조로 완벽 교체 -->
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

    // 5. 메인 게시판 탭 전환 스크립트
    function changeBoardTab(index, boardType) {
        // 탭 UI 변경
        const tabs = document.querySelectorAll('.main_board_top .tab_menu li');
        tabs.forEach((tab, i) => {
            if (i === index) tab.classList.add('on');
            else tab.classList.remove('on');
        });

        // 리스트 UI 변경
        const boards = document.querySelectorAll('.main_board_list .board_table');
        boards.forEach((board, i) => {
            if (i === index) board.classList.add('on');
            else board.classList.remove('on');
        });

        // '더 보기' 링크 변경
        const moreLink = document.getElementById('boardMoreLink');
        if (boardType === 'notice') moreLink.href = '/notice/list';
        else if (boardType === 'careers') moreLink.href = '/careers/list';
        else if (boardType === 'bidding') moreLink.href = '/bidding/list';
    }
</script>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">
        <!-- section -->
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
        <!-- //section -->

        <!-- section -->
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
        <!-- //section -->

        <!-- section -->
        <div class="main_news">
            <div class="main_top sub_top">
                <div class="sub_top_box">
                    <div class="flex">
                        <div class="sub_top_tit" id="tts_main_sns">스페셜올림픽코리아 소식</div>
                    </div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_main_sns">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="main_news_list">
                <div class="main_img_list">
                    <div class="main_news_top">
                        <div class="tit">SOK 소식</div>
                        <a class="go_link" href="/news/list">더 보기</a>
                    </div>
                    <c:choose>
                        <c:when test="${not empty mainNews}">
                            <a href="/news/detail?brdSeq=${mainNews.brdSeq}" style="display:block; color:inherit; text-decoration:none;">
                                <div class="thum">
                                    <img src="${not empty mainNews.thumbPath ? mainNews.thumbPath : '/img/img_default.jpg'}" alt="SOK 소식 썸네일" style="width:100%; height:250px; object-fit:cover; border-radius:20px;">
                                </div>
                                <div class="desc" style="margin-top:20px; font-size:1.125em; font-weight:500; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;">
                                    ${mainNews.title}
                                </div>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <div class="thum">
                                <img src="/img/img_default.jpg" alt="썸네일 이미지 기본">
                            </div>
                            <div class="desc text-muted" style="margin-top:20px;">등록된 SOK 소식이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="main_board_list">
                    <div class="main_board_top">
                        <ul class="tab_menu">
                            <li class="on" style="cursor:pointer;" onclick="changeBoardTab(0, 'notice')">공지사항</li>
                            <li style="cursor:pointer;" onclick="changeBoardTab(1, 'careers')">채용정보</li>
                            <li style="cursor:pointer;" onclick="changeBoardTab(2, 'bidding')">입찰정보</li>
                        </ul>
                        <a class="go_link" id="boardMoreLink" href="/notice/list">더 보기</a>
                    </div>
                    <div class="board_table on">
                        <ul>
                            <c:forEach var="item" items="${noticeList}">
                                <li style="cursor:pointer;" onclick="location.href='/notice/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty noticeList}">
                                <li style="text-align:center; padding:30px; color:#777;">등록된 공지사항이 없습니다.</li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="board_table">
                        <ul>
                            <c:forEach var="item" items="${careersList}">
                                <li style="cursor:pointer;" onclick="location.href='/careers/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty careersList}">
                                <li style="text-align:center; padding:30px; color:#777;">등록된 채용정보가 없습니다.</li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="board_table">
                        <ul>
                            <c:forEach var="item" items="${bidList}">
                                <li style="cursor:pointer;" onclick="location.href='/bidding/detail?brdSeq=${item.brdSeq}'">
                                    <div class="gu">${item.title}</div>
                                    <div class="date"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></div>
                                </li>
                            </c:forEach>
                            <c:if test="${empty bidList}">
                                <li style="text-align:center; padding:30px; color:#777;">등록된 입찰정보가 없습니다.</li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="main_sns">
            <div class="main_top sub_top">
                <div class="sub_top_box">
                    <div class="flex">
                        <div class="sub_top_tit" id="tts_main_sns">소식으로 만나는 변화</div>
                        <%--<a class="go_link" href="" target="_blank">더 보기</a>--%>
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