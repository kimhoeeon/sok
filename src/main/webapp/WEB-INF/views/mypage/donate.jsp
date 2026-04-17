<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>마이페이지</span><span>기부현황</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top"><span>${sessionScope.userLogin.mbrNm} 님</span></div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <div class="sub_content">
            <div class="donation_wrap">
                <div class="all_donation">
                    <c:if test="${summary.totalCount > 0}">
                        <span onclick="openAllDonationPopup(${summary.totalAmt})">전체 기부증서</span>
                    </c:if>
                </div>

                <div class="donation_list">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div style="text-align: center; padding: 60px 0; color: #777;">
                                등록된 기부 내역이 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${list}" varStatus="status">
                                <div class="donation_item">
                                    <div class="donation_top">
                                        <div class="tit">기부내역</div>
                                        <div class="border" style="cursor:pointer;"
                                             onclick="openDonationPopup('<fmt:formatDate value="${item.payDt}"
                                                                                         pattern="yyyy-MM-dd"/>', ${item.payAmt})">
                                            기부증서
                                        </div>
                                    </div>
                                    <div class="donation_content">
                                        <ul>
                                            <li>
                                                <div class="gu">기부횟수</div>
                                                <div class="nae">${summary.totalCount - status.index}회</div>
                                            </li>
                                            <li>
                                                <div class="gu">직접기부</div>
                                                <div class="nae">
                                                    <fmt:formatNumber value="${item.payAmt}" pattern="#,###"/>원
                                                </div>
                                            </li>
                                            <li>
                                                <div class="gu">누적기부</div>
                                                <div class="nae">
                                                    <fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/>원
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="donation_cost">
                                            <div class="total_dona">
                                                누적 기부금 <fmt:formatNumber value="${summary.totalAmt}" pattern="#,###"/>
                                            </div>
                                            <div class="current_dona">
                                                <fmt:formatNumber value="${item.payAmt}" pattern="#,###"/>원
                                            </div>
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

<div class="popup donations_pop" id="donationsPopup" style="display: none;">
    <div class="pop_wrap">
        <div class="pop_tit">
            <div class="tit">기부증서</div>
            <button type="button" class="support_cls popup_close_btn" aria-label="닫기">
                <img src="/img/ico_close.png" alt="닫기">
            </button>
        </div>
        <div class="donations_card">
            <div class="card_tit">기부증서</div>
            <div class="card_name">${sessionScope.userLogin.mbrNm}</div>
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
            <div class="company">스페셜코리아올림픽</div>
        </div>
        <div class="btn down_btn">
            <button type="button" class="down">이미지 다운로드</button>
            <button type="button" class="share">카카오톡 공유</button>
        </div>

        <div class="donations_btn">
            <button type="button" class="close_btn popup_close_btn">닫기</button>
        </div>
    </div>
</div>

<script>
    // 단일 기부증서 팝업 열기
    function openDonationPopup(dateStr, amt) {
        var d = new Date(dateStr);
        var formatted = d.getFullYear() + '년 ' + ('0' + (d.getMonth() + 1)).slice(-2) + '월 ' + ('0' + d.getDate()).slice(-2) + '일';

        $('#popupDate').text(formatted);
        $('#popupAmt').text(Number(amt).toLocaleString() + '원');
        $('#donationsPopup').fadeIn(200);
    }

    // 전체 기부증서 팝업 열기 (누적)
    function openAllDonationPopup(totalAmt) {
        var d = new Date(); // 전체 내역은 오늘 기준
        var formatted = d.getFullYear() + '년 ' + ('0' + (d.getMonth() + 1)).slice(-2) + '월 ' + ('0' + d.getDate()).slice(-2) + '일';

        $('#popupDate').text(formatted + " (누적)");
        $('#popupAmt').text(Number(totalAmt).toLocaleString() + '원');
        $('#donationsPopup').fadeIn(200);
    }

    // 팝업 닫기
    $('.popup_close_btn').on('click', function () {
        $('#donationsPopup').fadeOut(200);
    });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>