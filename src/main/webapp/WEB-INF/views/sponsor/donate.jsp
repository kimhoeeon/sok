<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<script src="https://js.tosspayments.com/v1/payment"></script>

<div id="container">
    <div class="inner">

        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>신청·참여</span><span>후원하기</span>
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
                        <div class="tit">함께 걷고, 보고, 배우는 훈련장애인 야유회</div>
                        <div class="cost"><fmt:formatNumber value="${summary.totalDonationAmt}" pattern="#,###"/>원</div>
                        <div class="join">총 <fmt:formatNumber value="${summary.totalDonorCnt}" pattern="#,###"/>명 참여중
                        </div>
                        <div class="join_graph">
                            <div class="bar"></div>
                            <div class="txt">
                                <div class="ongoing">이번 달 목표를 향해 달려가고 있어요!</div>
                                <div class="total">
                                    총 <fmt:formatNumber value="${summary.totalDonationAmt}" pattern="#,###"/>원 달성
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="support_form_current">
                        <div class="tit">모금함 기부현황</div>
                        <ul class="current_box">
                            <li class="total">
                                <div class="gu">
                                    총 기부 (<fmt:formatNumber value="${summary.totalDonorCnt}" pattern="#,###"/>명)
                                </div>
                                <div class="nae">
                                    <fmt:formatNumber value="${summary.totalDonationAmt}" pattern="#,###"/>원
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
                <li onclick="addAmount(5000)">+ 5천원</li>
                <li onclick="addAmount(10000)">+ 1만원</li>
                <li onclick="addAmount(30000)">+ 3만원</li>
                <li onclick="addAmount(50000)">+ 5만원</li>
                <li onclick="addAmount(100000)">+ 10만원</li>
                <li onclick="addAmount(500000)">+ 50만원</li>
                <li onclick="addAmount(1000000)">+ 100만원</li>
                <li onclick="customAmount()">직접입력</li>
            </ul>
            <div class="txt">기부는 1천원부터 가능합니다.</div>
        </div>
        <div class="support_textarea">
            <textarea id="cheerMsg" placeholder="응원하는 따뜻한 한마디를 남겨주세요."></textarea>
        </div>
        <div class="support_btn">
            <button type="button" class="btn sup_btn" onclick="requestTossPayment()">기부하기</button>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
    let currentAmount = 0;

    // 발주사에서 발급받을 토스페이먼츠 클라이언트 키 (테스트용 키 삽입)
    const clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq';
    const tossPayments = TossPayments(clientKey);

    function openDonatePopup() {
        $('#supportPopup').fadeIn(200);
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

    // 토스 페이먼츠 결제창 호출 로직
    function requestTossPayment() {
        // 1. 로그인 체크
        const isLogin = ${not empty sessionScope.userLogin};
        if (!isLogin) {
            alert("로그인 후 기부가 가능합니다. 로그인 페이지로 이동합니다.");
            location.href = "/login/basic?redirect=/sponsor/donate";
            return;
        }

        // 2. 금액 체크
        if (currentAmount < 1000) {
            alert("기부 금액은 1,000원 이상이어야 합니다.");
            return;
        }

        // 3. 팝업창 내 데이터 수집
        var cheerMsg = $('#cheerMsg').val();
        var isAnon = $('#isAnon').is(':checked') ? 'Y' : 'N';

        // 익명 체크 시 토스 결제창에 표시될 이름 변경 (DB의 TB_MEMBER와 무관하게 결제 영수증 표기용)
        var customerName = '${sessionScope.userLogin.mbrNm}';
        if (isAnon === 'Y') {
            customerName = '익명후원자';
        }

        // 4. 백엔드로 결제 초기화(주문번호 채번 및 WAIT 상태 저장) 요청
        $.ajax({
            url: '/sponsor/donate/init',
            type: 'POST',
            data: {
                payAmt: currentAmount,
                payType: 'ONCE', // 일시결제
                cheerMsg: cheerMsg
            },
            success: function (orderId) {
                // 5. 서버에서 받아온 검증된 orderId로 토스 결제창 호출
                tossPayments.requestPayment('카드', {
                    amount: currentAmount,
                    orderId: orderId,
                    orderName: '스페셜올림픽코리아 후원금',
                    customerName: customerName,
                    successUrl: window.location.origin + '/sponsor/donate/success',
                    failUrl: window.location.origin + '/sponsor/donate/fail'
                }).catch(function (error) {
                    if (error.code === 'USER_CANCEL') {
                        // 사용자가 창을 닫은 경우 조용히 넘어감
                    } else {
                        alert('결제창 호출 중 오류가 발생했습니다: ' + error.message);
                    }
                });
            },
            error: function () {
                alert('서버와 통신 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
            }
        });
    }
</script>