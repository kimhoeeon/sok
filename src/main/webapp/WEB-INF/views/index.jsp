<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* 1. 팝업 전체 영역 스크롤 및 삐져나옴 방지 */
    .main-popup {
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3); /* 완성도를 높여주는 그림자 효과 추가 */
    }

    /* 2. 푸터 높이를 45px로 명확히 고정하여 계산 오차 완벽 차단 */
    .popup-footer {
        display: flex; justify-content: space-between; align-items: center;
        padding: 0 15px;
        background: #222; color: #fff;
        height: 45px;
        box-sizing: border-box;
    }
    .popup-footer label { display: flex; align-items: center; cursor: pointer; gap: 8px; margin: 0; }
    .popup-footer input[type="checkbox"] { display: none; }
    .popup-footer .chk_box { width: 20px; height: 20px; flex-shrink: 0; background: url(/img/pop_check_off.png) no-repeat center; background-size: contain; }
    .popup-footer input[type="checkbox"]:checked + .chk_box { background: url(/img/pop_check_on.png) no-repeat center; background-size: contain; }
    .popup-footer button { cursor: pointer; background: inherit; border: none; color: #fff; font-weight: bold; font-size: 15px; padding: 0; }

    /* 동적 리스트 텍스트 줄임(Truncate) 스타일 보완 */
    .board_table ul li .gu { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 80%; }

    /* 모바일 환경(화면 너비 768px 이하) 팝업 반응형 처리 */
    @media (max-width: 768px) {
        .main-popup {
            width: 90vw !important;
            max-width: 400px !important;
            height: auto !important;
            max-height: 80vh !important;
            /* 모바일 화면에서 완벽한 중앙 정렬을 위해 left와 transform 적용 */
            left: 50% !important;
            transform: translateX(-50%) !important;
            top: 10vh !important;
        }

        .popup-content {
            height: auto !important;
            /* 이미지가 길 경우 푸터(45px)를 밀어내지 않도록 내부 스크롤 최대치 지정 */
            max-height: calc(80vh - 45px) !important;
        }

        .popup-content img {
            width: 100% !important;
            height: auto !important;
        }
    }
</style>

<c:if test="${not empty popupList}">
    <c:forEach var="popup" items="${popupList}">
        <div id="main_popup_${popup.popSeq}" class="main-popup"
             style="width: ${popup.width}px; height: ${popup.height}px; top: ${popup.topPos}px; left: ${popup.leftPos}px; display: none; position: absolute; z-index: 9999;">

            <!-- 3. 콘텐츠 영역의 높이를 (전체 - 푸터 45px)로 정확히 일치시킴 -->
            <div class="popup-content" style="height: calc(100% - 45px); overflow-y: auto; overflow-x: hidden;">
                <c:choose>
                    <c:when test="${not empty popup.popupImage and not empty popup.popupImage.filePath}">
                        <!-- 이미지가 있을 경우 -->
                        <c:choose>
                            <c:when test="${not empty popup.linkUrl}">
                                <!-- 4. a 태그의 기본 하단 여백 제거 (display: block; line-height: 0;) -->
                                <a href="${popup.linkUrl}" target="_blank" rel="noopener noreferrer" style="display: block; line-height: 0; height: 100%;">
                                    <!-- 5. 이미지 높이를 100%로 강제하여 미세한 오차로 인한 스크롤 방지 -->
                                    <img src="${popup.popupImage.filePath}" alt="${popup.title}" style="width: 100%; height: 100%; display: block; object-fit: fill;">
                                </a>
                            </c:when>
                            <c:otherwise>
                                <!-- 링크가 없을 경우 -->
                                <a href="javascript:void(0);" style="cursor: default; display: block; line-height: 0; height: 100%;">
                                    <img src="${popup.popupImage.filePath}" alt="${popup.title}" style="width: 100%; height: 100%; display: block; object-fit: fill;">
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <!-- 에디터 본문(텍스트/HTML)만 있을 경우 -->
                        <c:choose>
                            <c:when test="${not empty popup.linkUrl}">
                                <a href="${popup.linkUrl}" target="_blank" rel="noopener noreferrer" style="text-decoration: none; color: inherit; display: block;">
                                        ${popup.content}
                                </a>
                            </c:when>
                            <c:otherwise>
                                ${popup.content}
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="popup-footer">
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

<c:set var="isMainPage" value="true" scope="request" />

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container" class="main">

    <!-- section -->
    <div class="main_slide">
        <div class="main_slide_wrap">
            <div class="swiper_box">
                <div class="paging-wrap"></div>

                <div class="swiper swiper_main_t">
                    <ul class="swiper-wrapper">
                        <c:choose>
                            <c:when test="${empty bannerList}">
                                <!-- 등록된 배너가 없을 경우 기본 하드코딩 배너 1개 노출 -->
                                <li class="swiper-slide">
                                    <img src="/img/main_banner01.png" class="pc_img" alt="배너 기본 이미지">
                                    <img src="/img/main_banner01_m.png" class="m_img" alt="배너 기본 이미지">

                                    <%--<div class="inner">
                                        <div class="txt">
                                            <div class="top_tit">작은 응원이 일상이 되는 곳 <br>스페셜 올림픽 코리아</div>
                                            <a class="go_link" href="/intro/about">더 보기</a>
                                        </div>
                                    </div>--%>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <!-- DB에서 가져온 배너 리스트 반복 출력 -->
                                <c:forEach var="banner" items="${bannerList}">
                                    <li class="swiper-slide">
                                        <!-- 1. 클릭 없음 (단순 이미지) - a 태그 제거 -->
                                        <img src="/file/img?type=banner&filename=${banner.fileName}" class="pc_img" alt="${banner.title}">
                                        <img src="/file/img?type=banner&filename=${banner.fileName}" class="m_img" alt="${banner.title}">

                                        <%--<div class="inner">
                                            <div class="txt">
                                                <div class="top_tit">${banner.title} <br>스페셜 올림픽 코리아</div>
                                                <a href="${banner.linkUrl}" class="go_link" target="${banner.targetType}">더 보기</a>
                                            </div>
                                        </div>--%>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- //section -->

    <div class="inner">
        <!-- section -->
        <%--<div class="main_apply">
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
        </div>--%>
        <!-- //section -->

        <!-- section -->
        <div class="main_news">
            <div class="main_top sub_top">
                <div class="sub_top_box">
                    <div class="flex">
                        <div class="sub_top_tit" id="tts_main_news">스페셜올림픽코리아 소식</div>
                    </div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_main_news">
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
                    <div class="main_news_item">
                        <c:choose>
                            <c:when test="${not empty mainNewsList}">
                                <c:forEach var="news" items="${mainNewsList}">
                                    <a href="/news/detail?brdSeq=${news.brdSeq}">
                                        <div class="thum">
                                            <img src="${not empty news.thumbPath ? news.thumbPath : '/img/img_default.jpg'}" alt="SOK 소식 썸네일">
                                        </div>
                                        <div class="desc">
                                            ${news.title}
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="thum">
                                    <img src="/img/img_default.jpg" alt="썸네일 이미지 기본">
                                </div>
                                <div class="desc text-muted">등록된 SOK 소식이 없습니다.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
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
                    <ul id="instagram_list">
                        <!-- ajax를 통해 동적으로 li 태그들이 삽입됩니다. -->
                    </ul>
                </div>

                <div class="blog">
                    <div class="gu">네이버블로그</div>
                    <ul id="naverblog_list">
                        <!-- ajax를 통해 동적으로 li 태그들이 삽입됩니다. -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>