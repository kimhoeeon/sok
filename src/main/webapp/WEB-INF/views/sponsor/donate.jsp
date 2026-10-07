<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<script src="https://js.tosspayments.com/v1/payment"></script>

<style>
    .support_form .support_form_top .bar::before {
        display: none !important;
    }
    .support_form .support_form_top .bar .active-bar {
        height: 100%;
        background: var(--mainColor);
        border-radius: 20px;
        transition: width 0.8s ease-in-out;
    }
</style>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>참여공간</span><span>후원하기</span>
                </div>
                <div class="sub_top_tit" id="tts_sub_top">후원하기</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>

        <div class="sub_content">
            <div class="support_wrap">
                <div class="detail">
                    <div class="txt">
                        <div class="tit">가능성은 함께할 때 더 멀리 나아갑니다</div>
                        <div class="nae mt-30">누군가의 가능성은 혼자만의 노력만으로 충분히 펼쳐지지 않을 때가 있습니다. 훈련을 이어갈 기회, 대회에 참여할 환경, 사람들과
                            연결되는 경험은 누군가의 응원과 참여가 있을 때 더 멀리 나아갈 수 있습니다. 그래서 후원은 단순한 도움이 아니라, 가능성을 이어주는 힘이 됩니다.
                        </div>
                    </div>
                    <div class="txt">
                        <div class="tit">후원은 단순한 지원이 아니라 <br/>가능성을 이어주는 힘입니다.</div>
                        <div class="nae">
                            <img src="/img/sup_img01.png" alt="후원하기 이미지">
                            <div>
                                발달장애인에게 스포츠는 단지 경기의 영역이 아닙니다. <br/>
                                <span>스스로 할 수 있다는 자신감을 배우는 시간</span>이고, 사람들과 어울리며 사회의 구성원으로
                                <span>살아갈 수 있다는 가능성을 확인하는 과정</span>입니다.
                                누군가는 처음으로 자신의 이름이 불리는 순간을 경험하고, 누군가는 처음으로
                                끝까지 해냈다는 성취를 느끼며, 또 누군가는 스포츠를 통해 세상과 연결되는 기회를 얻습니다.
                                이 변화는 선수 한 사람에게서 끝나지 않습니다. 가족에게는 버틸 힘이 되고, 지역사회에는 함께 살아가는 방법을 배우게 하며,
                                우리 사회에는 장애와 비장애의 거리를 조금 더 좁히는 계기가 됩니다.
                                여러분의 후원은 바로 그 변화를 가능하게 합니다.
                            </div>
                        </div>
                    </div>
                    <div class="txt">
                        <div class="tit">당신의 후원이 닿는 곳</div>
                        <div class="nae">
                            <img src="/img/sup_img02.png" alt="후원하기 이미지">
                            <div>
                                여러분의 마음은 발달장애인의 스포츠 훈련과 대회 참여, 교육과 프로그램 운영,
                                그리고 더 많은 사람들이 함께할 수 있는 환경을 만드는 데 사용됩니다.
                                누군가에게는 훈련을 계속할 수 있는 기회가 되고, 누군가에게는 세상 밖으로
                                한 걸음 더 나아갈 용기가 되며, 누군가의 가족에게는 <span>“우리도 함께할 수 있다”</span>는 희망이 됩니다.
                                후원은 한 번의 도움이 아니라, 삶이 다시 움직일 수 있도록 곁을 내어주는 일입니다.
                            </div>
                        </div>
                    </div>
                    <div class="txt">
                        <div class="tit">왜 지금, 함께해야 할까요</div>
                        <div class="nae">
                            <img src="/img/sup_img03.png" alt="후원하기 이미지">
                            <div>
                                변화는 거창한 곳에서 시작되지 않습니다. 누군가의 가능성을 믿어주는 마음, 포기하지 않도록 옆에 서주는 손길,
                                “당신은 혼자가 아니에요”라고 말해주는 참여에서 시작됩니다.
                                발달장애인이 더 많이 배우고, 더 많이 도전하고, 더 당당하게 사회 안에서
                                살아갈 수 있도록 지금의 응원이 필요합니다.
                            </div>
                        </div>
                    </div>
                    <div class="txt">
                        <div class="tit">후원으로 당신에게 돌아오는 가치</div>
                        <div class="nae">
                            <img src="/img/sup_img04.png" alt="후원하기 이미지">
                            <div>
                                후원은 단지 무엇을 내어주는 일이 아닙니다. 누군가의 삶이 달라지는 과정을 함께 지켜보며, 우리 사회가 조금 더 따뜻하고
                                건강한 방향으로 나아가고 있음을 확인하는 일입니다.
                                당신의 참여는 한 사람의 가능성을 키우고, 가족의 내일을 지탱하며, 장애와
                                비장애가 함께 살아가는 사회를 만드는 데 기여합니다.
                                결국 후원은 누군가를 위한 일이면서 동시에 우리가 함께 살아갈 사회를
                                더 나은 방향으로 바꾸는 선택입니다.
                            </div>
                        </div>
                    </div>
                    <div class="txt">
                        <div class="tit">작은 마음이 모이면 <br/>누군가의 오늘은 덜 무거워지고, <br/>내일은 더 단단해집니다</div>
                        <div class="nae">
                            <img src="/img/sup_img05.png" alt="후원하기 이미지">
                            <div>
                                스페셜올림픽코리아는 발달장애인이 스포츠를 통해 자신의 가능성을 발견하고,
                                사회와 더 넓게 연결될 수 있도록 함께하고 있습니다.
                                여러분의 후원은 한 사람의 도전과 성장, 그리고 모두가 함께하는
                                사회를 만드는 변화로 이어집니다.
                                <span>지금, 그 따뜻한 변화의 시작에 함께해 주세요.</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="support_form">
                    <div class="support_form_top">
                        <div class="tit">${not empty campaign ? campaign.title : '진행중인 캠페인이 없습니다.'}</div>
                        <div class="cost">목표액 <fmt:formatNumber value="${not empty campaign ? campaign.goalAmt : 0}" pattern="#,###"/>원</div>
                        <div class="join">총 <fmt:formatNumber value="${not empty campaign ? campaign.donorCount : 0}" pattern="#,###"/>명 참여중</div>
                        <div class="join_graph">
                            <div class="bar">
                                <div class="active-bar" style="width: ${not empty campaign ? (campaign.achievementRate > 100 ? 100 : campaign.achievementRate) : 0}%;"></div>
                            </div>

                            <div class="txt">
                                <div class="ongoing">
                                    <c:set var="rate" value="${not empty campaign ? campaign.achievementRate : 0}" />
                                    <c:choose>
                                        <c:when test="${rate >= 100}">
                                            🎉 와우! 목표 금액을 100% 달성했습니다! 감사합니다.
                                        </c:when>
                                        <c:when test="${rate >= 80}">
                                            🔥 목표 달성이 코앞이에요! 조금만 더 힘을 내요.
                                        </c:when>
                                        <c:when test="${rate >= 50}">
                                            🏃 절반을 넘어 목표를 향해 달려가고 있어요!
                                        </c:when>
                                        <c:when test="${rate > 0}">
                                            🌱 따뜻한 마음이 하나둘 모이고 있어요.
                                        </c:when>
                                        <c:otherwise>
                                            ✨ 시작이 반입니다! 첫 번째 후원자가 되어주세요.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="total">
                                    총 <fmt:formatNumber value="${not empty campaign ? campaign.currentAmt : 0}" pattern="#,###"/>원 달성
                                    <strong style="color: #005baa; margin-left: 5px;">(${not empty campaign ? campaign.achievementRate : 0}%)</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="support_form_current">
                        <div class="tit">모금함 기부현황</div>
                        <ul class="current_box">
                            <li class="total">
                                <div class="gu">
                                    총 기부 (<fmt:formatNumber value="${not empty campaign ? campaign.donorCount : 0}" pattern="#,###"/>명)
                                </div>
                                <div class="nae">
                                    <fmt:formatNumber value="${not empty campaign ? campaign.currentAmt : 0}" pattern="#,###"/>원
                                </div>
                            </li>
                        </ul>
                        <ul class="support_txt">
                            <li>기부 시 결제 수수료는 스페셜 올림픽 코리아에서 부담합니다.</li>
                            <li>기부금은 100% 단체에 전달됩니다.</li>
                        </ul>
                        <div class="btn sup_btn">
                            <button type="button" onclick="openDonatePopup()">기부하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="popup support_pop" id="supportPopup" style="display: none;">
    <div class="pop_wrap">
        <div class="pop_tit">
            <div class="tit">기부하기</div>
            <button type="button" class="support_cls" onclick="closeDonatePopup()" aria-label="닫기">
                <img src="/img/ico_close.png" alt="닫기">
            </button>
        </div>
        <div class="support_id">
            <div class="id_box">
                <div>아이디</div>
                <c:choose>
                    <c:when test="${not empty sessionScope.userLogin}">
                        <div class="id fw-bold text-primary">${sessionScope.userLogin.mbrId}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="id">비로그인</div>
                        <div class="txt">
                            <span>로그인 후 이용 가능합니다. <a href="/login/basic" style="color:var(--mainColor);">로그인 바로가기</a></span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="anon">
                <label>
                    <div>익명으로 기부하고 싶어요!</div>
                    <input type="checkbox" id="isAnon" name="isAnon" value="Y">
                    <span class="chk_box"></span>
                </label>
            </div>
        </div>

        <div class="support_cost">
            <div class="sup_cost_top">
                <div class="tit">기부금액</div>
                <div class="nae">
                    <div class="cost" id="displayAmount">0 원</div>
                    <div class="reset">
                        <button type="button" onclick="resetAmount()">
                            <img src="/img/sup_cost_reset.png" alt="리셋">
                        </button>
                    </div>
                </div>
            </div>
            <ul class="sup_cost_btn">
                <li onclick="addAmount(1000)">+ 1천원</li>
                <li onclick="addAmount(5000)">+ 5천원</li>
                <li onclick="addAmount(10000)">+ 1만원</li>
                <li onclick="addAmount(30000)">+ 3만원</li>
                <li onclick="addAmount(50000)">+ 5만원</li>
                <li onclick="addAmount(100000)">+ 10만원</li>
                <li onclick="addAmount(500000)">+ 50만원</li>
                <li onclick="addAmount(1000000)">+ 100만원</li>
                <li onclick="addAmount(2000000)">+ 200만원</li>
                <%--<li onclick="customAmount()">직접입력</li>--%>
            </ul>
            <div class="txt">기부는 1천원부터 가능합니다.</div>
        </div>

        <div class="support_textarea">
            <textarea id="cheerMsg" placeholder="응원하는 따뜻한 한마디를 남겨주세요."></textarea>
        </div>

        <!-- 약관 영역: 기본적으로 숨김 처리 -->
        <div class="support_agree" id="supportAgreeArea" style="display: none;">
            <label>
                <input type="checkbox" id="agreeRegTerms" value="Y">
                <span class="chk_box"></span>
                <div>자동결제 및 정기기부 약관에 동의합니다.</div>
            </label>
            <div class="agree_txt">
                <div>정기기부 안내</div>
                <ul>
                    <li>· 선택한 금액이 매월 자동 결제됩니다. </li>
                    <li>· 정기기부는 마이페이지에서 조회 및 관리할 수 있습니다.</li>
                </ul>
            </div>
            <textarea readonly>
정기기부 이용약관

제1조 (목적)
본 약관은 정기기부 신청자가 정기적인 기부금 납부를 신청함에 있어 필요한 사항과 기부금 결제, 변경, 해지 등에 관한 내용을 정하는 것을 목적으로 합니다.

제2조 (정기기부 신청)
정기기부는 신청자가 지정한 금액을 매월 자동으로 결제하는 방식으로 진행됩니다.
정기기부 신청 시 신청자는 본인 명의의 유효한 결제수단을 등록해야 합니다.
정기기부 금액 및 결제수단은 운영 정책에 따라 변경할 수 있습니다.
등록된 결제수단의 정보가 변경되거나 결제가 불가능한 경우 정기기부가 정상적으로 처리되지 않을 수 있습니다.

제3조 (자동결제)
신청자는 정기기부 신청과 동시에 등록한 결제수단을 통한 자동결제에 동의한 것으로 봅니다.
정기기부금은 최초 신청 시 안내된 결제일 또는 정해진 정기결제일에 자동으로 결제됩니다.
결제일이 휴일이거나 결제사의 사정 등에 따라 실제 결제일이 변경될 수 있습니다.
카드정보 등 결제수단의 세부 정보는 전자결제대행사(PG사)를 통해 처리될 수 있습니다.

제4조 (결제 실패)
카드 한도 초과, 유효기간 만료, 잔액 부족, 결제수단 오류 등으로 정기결제가 실패할 수 있습니다.
결제 실패 시 재결제가 시도될 수 있으며, 재결제 일정 및 횟수는 결제대행사 및 운영 정책에 따라 달라질 수 있습니다.
지속적으로 결제가 실패하는 경우 정기기부가 중단될 수 있습니다.

제5조 (정기기부 금액 변경)
신청자는 정기기부 금액의 변경을 요청할 수 있습니다.
변경 신청 시점에 따라 당월 결제에는 반영되지 않고 다음 결제일부터 적용될 수 있습니다.
금액 변경 방법 및 적용 시점은 홈페이지 또는 별도 안내를 통해 확인할 수 있습니다.

제6조 (정기기부 해지)
신청자는 언제든지 정기기부 해지를 신청할 수 있습니다.
해지 신청이 완료된 이후부터는 다음 정기결제가 진행되지 않습니다.
이미 결제가 완료된 기부금은 단순 변심에 따른 취소 또는 환불이 제한될 수 있습니다.
부득이한 사유로 환불이 필요한 경우 별도의 기부금 취소 및 환불 기준에 따라 처리됩니다.

제7조 (기부금 영수증)
기부금 영수증 발급을 원하는 경우 발급에 필요한 정보를 정확하게 입력해야 합니다.
입력 정보가 정확하지 않은 경우 기부금 영수증 발급이 제한되거나 지연될 수 있습니다.
기부금 영수증 발급 방법 및 일정은 관련 법령 및 기관의 운영 기준에 따릅니다.

제8조 (개인정보 및 결제정보 처리)
정기기부 신청 및 관리를 위해 필요한 개인정보는 개인정보처리방침에 따라 수집·이용됩니다.
카드번호, 유효기간 등 주요 결제정보는 결제대행사(PG사)를 통해 직접 처리될 수 있으며, 홈페이지에서 직접 저장하지 않을 수 있습니다.
정기결제에 필요한 결제수단 식별정보 또는 빌링키 등은 정기기부 유지 및 결제 처리를 위해 사용될 수 있습니다.

제9조 (서비스 변경 및 중단)
천재지변, 시스템 장애, 결제대행사 장애, 기타 불가피한 사유가 발생하는 경우 정기기부 결제 또는 관련 서비스가 일시적으로 중단될 수 있습니다.

제10조 (기타)
본 약관에서 정하지 않은 사항은 관련 법령, 개인정보처리방침, 결제대행사 정책 및 기관의 운영 기준에 따릅니다.
            </textarea>
        </div>
        <div class="support_btn">
            <button type="button" class="btn one_btn" onclick="openConfirmPopup('ONCE')">일회성기부</button>
            <button type="button" class="btn sup_btn" onclick="openConfirmPopup('REGULAR')">정기기부</button>
        </div>
    </div>
</div>

<!-- 센터 팝업 -->
<div class="popup center_pop" id="confirmPopup" style="display: none; z-index: 9999;">
    <div class="pop_wrap" style="text-align: center; padding: 20px;">
        <div class="center-popup_body">
            <h3 class="center-popup_title" style="margin-bottom: 25px; font-size: 1.25em;">결제 확인</h3>
            <p id="confirmMessage" style="font-size: 1.125em; line-height: 1.6; color: #444; font-weight: 500;">
                <!-- 이 곳에 JS로 동적 메시지 삽입 -->
            </p>
        </div>
        <div class="center-popup_footer" style="padding-top: 10px;">
            <button type="button" class="btn btn-gray" onclick="$('#confirmPopup').fadeOut(150);" style="background-color: #eee; color: #444;">취소</button>
            <button type="button" class="btn btn-primary" onclick="executePayment()">후원하기</button>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    let currentAmount = 0;
    let selectedPayType = 'ONCE'; // 현재 선택된 결제 방식 저장

    // 1. Controller에서 전달받은 실제/테스트 클라이언트 키 주입 (중복 선언 제거)
    const tossClientKey = '${tossClientKey}';
    const tossPayments = TossPayments(tossClientKey);

    function openDonatePopup() {
        $('#supportPopup').fadeIn(200);
        $('#supportAgreeArea').hide(); // 창을 열 때 약관은 숨김 상태로 시작
        $('#agreeRegTerms').prop('checked', false);
    }

    function closeDonatePopup() {
        $('#supportPopup').fadeOut(200);
    }

    // 금액 합산
    function addAmount(val) {
        currentAmount += val;
        updateAmountDisplay();
    }

    // 직접 입력
    function customAmount() {
        const input = prompt("원하시는 기부 금액을 입력해주세요. (숫자만)");
        if (input && !isNaN(input)) {
            currentAmount += parseInt(input);
            updateAmountDisplay();
        }
    }

    // 금액 리셋
    function resetAmount() {
        currentAmount = 0;
        updateAmountDisplay();
    }

    function updateAmountDisplay() {
        $('#displayAmount').text(currentAmount.toLocaleString() + ' 원');
    }

    // '일회성기부' / '정기기부' 버튼 클릭 시 최종 팝업 띄우기
    function openConfirmPopup(payType) {
        selectedPayType = payType;

        // 1. 공통 유효성 검사 (로그인 및 금액)
        const isLogin = ${not empty sessionScope.userLogin};
        if (!isLogin) {
            alert("로그인 후 기부가 가능합니다. 로그인 페이지로 이동합니다.");
            location.href = "/login/basic?redirect=/sponsor/donate";
            return;
        }
        if (currentAmount < 1000) {
            alert("기부 금액은 1,000원 이상이어야 합니다.");
            return;
        }

        // 2. 정기기부일 경우 약관 동의 검증 및 UI 제어
        if (payType === 'REGULAR') {
            if ($('#supportAgreeArea').is(':hidden')) {
                // 약관 영역이 안 보이면 보여주고 리턴 (사용자가 약관을 읽고 동의할 기회 제공)
                $('#supportAgreeArea').slideDown(250);
                return;
            }
            if (!$('#agreeRegTerms').is(':checked')) {
                alert("정기기부 이용약관에 동의해 주세요.");
                return;
            }
            $('#confirmMessage').html(`<span style="color:var(--mainColor); font-weight:700;">매월 \${currentAmount.toLocaleString()}원</span>씩 정기기부를 진행하시겠습니까?`);
        } else {
            // 일회성 기부일 경우 약관 영역 다시 숨김
            $('#supportAgreeArea').slideUp(200);
            $('#confirmMessage').html(`<span style="color:var(--mainColor); font-weight:700;">\${currentAmount.toLocaleString()}원</span>을 일회성으로 후원하시겠습니까?`);
        }

        // 최종 확인 팝업 노출
        $('#confirmPopup').fadeIn(200);
    }

    // 2. 토스 페이먼츠 결제창 호출 로직 (HTML의 기부하기 버튼과 연결됨)
    function executePayment() {
        $('#confirmPopup').fadeOut(100); // 확인 팝업 닫기

        var cheerMsg = $('#cheerMsg').val();
        var isAnon = $('#isAnon').is(':checked') ? 'Y' : 'N';
        var customerName = '${sessionScope.userLogin.mbrNm}';
        if (isAnon === 'Y') customerName = '익명후원자';

        // 백엔드 요청
        $.ajax({
            url: '/sponsor/donate/init',
            type: "POST",
            data: {
                payAmt: currentAmount,
                payType: selectedPayType, // ONCE 또는 REGULAR 전송
                cheerMsg: cheerMsg,
                isAnon: isAnon
                <c:if test="${not empty campaign}">,campSeq: ${campaign.campSeq}</c:if>
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
            },
            success: function (orderId) {
                // 1. 일시 결제 처리
                if (selectedPayType === 'ONCE') {
                    tossPayments.requestPayment('카드', {
                        amount: currentAmount,
                        orderId: orderId,
                        orderName: '스페셜올림픽코리아 후원금 (일시)',
                        customerName: customerName,
                        successUrl: window.location.origin + '/sponsor/donate/success',
                        failUrl: window.location.origin + '/sponsor/donate/fail'
                    }).catch(function (error) {
                        if (error.code !== 'USER_CANCEL') alert('결제창 호출 중 오류가 발생했습니다: ' + error.message);
                    });
                }
                // 2. 정기 결제 (빌링) 처리
                else {
                    tossPayments.requestBillingAuth('카드', {
                        customerKey: '${sessionScope.userLogin.mbrId}', // 정기결제는 고객 식별키(mbrId) 필수
                        successUrl: window.location.origin + '/sponsor/donate/billing/success?orderId=' + orderId + '&amount=' + currentAmount,
                        failUrl: window.location.origin + '/sponsor/donate/fail'
                    }).catch(function (error) {
                        if (error.code !== 'USER_CANCEL') alert('정기결제창 호출 중 오류가 발생했습니다: ' + error.message);
                    });
                }
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인 세션이 만료되었습니다. 다시 로그인해 주세요.');
                    location.href = '/login/basic';
                } else {
                    alert('서버와 통신 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
                }
            }
        });
    }
</script>