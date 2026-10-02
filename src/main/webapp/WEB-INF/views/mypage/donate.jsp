<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>마이페이지</span><span>기부내역관리</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span><c:out value="${sessionScope.userLogin.mbrNm}"/> 님</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">
            <div class="donation_wrap">

                <!-- 1. 상단 기부 요약 (총 기부금, 총 기부 횟수) -->
                <div class="situation_box">
                    <div>총 기부금 <span class="fw-bold"><fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/></span>원</div>
                    <div>총 기부 횟수 <span class="fw-bold"><fmt:formatNumber value="${summary.totalCount}" pattern="#,###"/></span>회</div>
                </div>

                <!-- 2. 필터 및 정렬 영역 -->
                <!-- 폼이 변경될 때마다 자동 Submit 되도록 스크립트 연결 -->
                <form id="searchForm" action="/mypage/donate" method="get">
                    <input type="hidden" name="payType" id="payType" value="${params.payType}">

                    <div class="donation_diff">
                        <!-- 일회성 / 정기기부 탭 -->
                        <ul class="donation_tab">
                            <li class="${empty params.payType ? 'on' : ''}" onclick="changePayType('')">전체보기</li>
                            <li class="${params.payType eq 'ONCE' ? 'on' : ''}" onclick="changePayType('ONCE')">일회성 기부</li>
                            <li class="${params.payType eq 'REGULAR' ? 'on' : ''}" onclick="changePayType('REGULAR')">정기기부</li>
                        </ul>

                        <!-- 전체 기부증서 다운로드 및 정렬 드롭다운 -->
                        <div class="d-flex align-items-center" style="gap: 15px;">
                            <c:if test="${summary.totalCount > 0}">
                                <div class="all_donation mb-0">
                                    <span style="cursor:pointer;" onclick="openAllDonationPopup(${summary.totalAmt})">전체 기부증서</span>
                                </div>
                            </c:if>
                            <div class="select">
                                <select name="sortOrder" onchange="document.getElementById('searchForm').submit();">
                                    <option value="DESC" ${params.sortOrder ne 'ASC' ? 'selected' : ''}>최신순</option>
                                    <option value="ASC" ${params.sortOrder eq 'ASC' ? 'selected' : ''}>오래된순</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- 3. 기부 내역 리스트 -->
                <div class="donation_list">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div style="text-align: center; padding: 60px 0; color: #777; border: 1px solid #d5d5d5; border-radius: 20px;">
                                등록된 기부 내역이 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${list}">
                                <div class="donation_item on">
                                    <div class="donation_top">
                                        <div class="tit">기부내역</div>
                                        <div class="border" style="cursor:pointer;" onclick="openDonationPopup('<fmt:formatDate value="${item.payDt}" pattern="yyyy-MM-dd"/>', ${item.payAmt})">기부증서</div>
                                    </div>
                                    <div class="donation_content">
                                        <ul>
                                            <li>
                                                <div class="gu">결제일시</div>
                                                <div class="nae"><fmt:formatDate value="${item.payDt}" pattern="yyyy.MM.dd"/></div>
                                            </li>
                                            <li>
                                                <div class="gu">기부회차</div>
                                                <!-- 일회성 기부는 회차 숨김, 정기기부만 회차 표기 -->
                                                <c:choose>
                                                    <c:when test="${item.payType eq 'REGULAR'}">
                                                        <div class="nae">${item.regularRound}회차</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="nae">-</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                            <li>
                                                <div class="gu">직접기부</div>
                                                <div class="nae"><fmt:formatNumber value="${item.payAmt}" pattern="#,###"/>원</div>
                                            </li>
                                        </ul>
                                        <div class="donation_cost">
                                            <div class="total_dona">
                                                <c:choose>
                                                    <c:when test="${item.payType eq 'REGULAR'}">월 기부금</c:when>
                                                    <c:otherwise>일회성 기부금</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="current_dona"><fmt:formatNumber value="${item.payAmt}" pattern="#,###"/>원</div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>

        </div>
    </div>
</div>

<div class="popup donations_pop" id="donationsPopup" style="display: none; z-index: 9999;">
    <div class="pop_wrap">
        <div class="pop_tit">
            <div class="tit">기부증서</div>
            <button type="button" class="support_cls popup_close_btn" aria-label="닫기">
                <img src="/img/ico_close.png" alt="닫기">
            </button>
        </div>

        <!-- 캡처를 위한 영역 id="certificateArea" 부여 -->
        <div class="donations_card" id="certificateArea">
            <div class="card_tit">기부증서</div>
            <div class="card_name"><c:out value="${sessionScope.userLogin.mbrNm}"/></div>
            <ul>
                <li>
                    <div class="gu">기부 유형</div>
                    <div class="nae">기부금</div>
                </li>
                <li>
                    <div class="gu">기부 일시</div>
                    <div class="nae" id="popupDate"></div>
                </li>
                <li>
                    <div class="gu">기부 금액</div>
                    <div class="nae" id="popupAmt"></div>
                </li>
            </ul>
            <div class="card_txt">
                소중한 나눔으로 발달장애인들의 마음에 작은 울림을 전하고, 꿈과 희망을 키워갈 수 있었습니다. 희망을 이어주신 따뜻한 마음에 깊이 감사드립니다.
            </div>
            <jsp:useBean id="now" class="java.util.Date"/>
            <div class="card_date"><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일"/></div>
            <div class="company">스페셜올림픽코리아</div>
        </div>

        <div class="btn down_btn">
            <button type="button" class="down" onclick="downloadCertificate()">이미지 다운로드</button>
            <button type="button" class="share" onclick="shareKakao()">카카오톡 공유</button>
        </div>

        <div class="donations_btn">
            <button type="button" class="close_btn popup_close_btn">닫기</button>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.6.0/kakao.min.js"></script>

<script>
    // 카카오톡 SDK 초기화 (본인 앱 키가 있으면 교체)
    if (!Kakao.isInitialized()) {
        Kakao.init('96c765806d01c47a180599a9f9d158b6');
    }

    // 탭 클릭 시 검색 조건 변경 후 Submit
    function changePayType(type) {
        document.getElementById('payType').value = type;
        document.getElementById('searchForm').submit();
    }

    // 1. 단일 기부증서 팝업 열기 (결제일시 및 금액 세팅)
    function openDonationPopup(dateStr, amt) {
        var d = new Date(dateStr);
        var formatted = d.getFullYear() + '년 ' + ('0' + (d.getMonth() + 1)).slice(-2) + '월 ' + ('0' + d.getDate()).slice(-2) + '일';

        $('#popupDate').text(formatted);
        $('#popupAmt').text(Number(amt).toLocaleString() + '원');
        $('#donationsPopup').fadeIn(200);
    }

    // 2. 전체(누적) 기부증서 팝업 열기
    function openAllDonationPopup(totalAmt) {
        var d = new Date();
        var formatted = d.getFullYear() + '년 ' + ('0' + (d.getMonth() + 1)).slice(-2) + '월 ' + ('0' + d.getDate()).slice(-2) + '일';

        $('#popupDate').text(formatted + " (누적)");
        $('#popupAmt').text(Number(totalAmt).toLocaleString() + '원');
        $('#donationsPopup').fadeIn(200);
    }

    // 팝업 닫기 공통 이벤트
    $('.popup_close_btn').on('click', function () {
        $('#donationsPopup').fadeOut(200);
    });

    // 3. 기부증서 이미지 다운로드
    function downloadCertificate() {
        var target = document.getElementById('certificateArea');

        html2canvas(target, {
            scale: 2, // 고해상도 캡처
            useCORS: true,
            backgroundColor: null
        }).then(function(canvas) {
            var el = document.createElement("a");
            el.href = canvas.toDataURL("image/png");
            el.download = "스페셜올림픽코리아_기부증서.png";
            el.click();
        });
    }

    // 4. 카카오톡 공유 기능
    function shareKakao() {
        Kakao.Share.sendDefault({
            objectType: 'feed',
            content: {
                title: '스페셜올림픽코리아 기부증서',
                description: '<c:out value="${sessionScope.userLogin.mbrNm}"/>님의 따뜻한 나눔으로 발달장애인들의 꿈과 희망을 응원해 주셔서 감사합니다.',
                imageUrl: 'https://sokorea.or.kr/img/og_img.jpg',
                link: {
                    mobileWebUrl: window.location.origin,
                    webUrl: window.location.origin,
                },
            },
            buttons: [
                {
                    title: '홈페이지 방문하기',
                    link: {
                        mobileWebUrl: window.location.origin,
                        webUrl: window.location.origin,
                    },
                },
            ],
        });
    }
</script>