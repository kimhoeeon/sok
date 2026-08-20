<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="footer_banner">
    <div class="inner">
        <div class="swiper sponsorSwiper">
            <!-- [수정] id 부여 및 하드코딩 슬라이드 뼈대 제거 -->
            <div class="swiper-wrapper" id="promoter_list">
                <!-- AJAX를 통해 관리자가 등록한 후원사 이미지가 동적으로 삽입됩니다. -->
            </div>
            <%--<div class="swiper-wrapper">
                <div class="swiper-slide">
                    <a href="javascript:void(0);">
                        <img src="/img/footer_logo01.png" alt="후원사1">
                    </a>
                </div>
            </div>--%>
        </div>
    </div>
</div>

<!-- footer -->
<div id="footer">
    <div class="inner">
        <div class="tbox">
            <div class="nav">
                <a href="/" class="ft_logo"><img src="/img/logo_b.png"></a>
                <div class="menu_wrap">
                    <ul class="menu">
                        <li>
                            사)스페셜올림픽코리아
                        </li>
                        <li>
                            회장: 정양석
                        </li>
                    </ul>
                    <ul class="menu">
                        <li>
                            서울특별시 강남구 강남대로132길 53(논현동) 4~6층
                        </li>
                        <li>
                            연락처: 02)447-1179 팩스:02)447-1345
                        </li>
                    </ul>
                    <ul class="menu">
                        <li>
                            이메일: sokorea@sokorea.or.kr
                        </li>
                        <li>
                            고유번호: 206-82-09551
                        </li>
                        <li>
                            통신판매업신고번호: 2020-서울강남-01579
                        </li>
                    </ul>
                </div>
            </div>
            <div class="right">
                <ul class="f_sns">
                    <li>
                        <a href="https://www.instagram.com/specialolympics_korea/" target="_blank">
                            <img src="/img/sns_insta.png" alt="인스타그램 바로가기">
                        </a>
                    </li>
                    <li>
                        <a href="https://blog.naver.com/specialolympicskorea" target="_blank">
                            <img src="/img/sns_blog.png" alt="네이버 블로그 바로가기">
                        </a>
                    </li>
                </ul>
                <ul class="f_privacy">
                    <li>
                        <a href="/rules/privacy">개인정보처리방침</a>
                    </li>
                    <li>
                        <a href="/rules/terms">이용약관</a>
                    </li>
                    <li>
                        <a href="/rules/policy">관련규정</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- //footer -->

<script src="/js/jquery-3.5.1.min.js"></script>
<script src="/js/script.js"></script>
<script src="/js/swiper.js"></script>
<script src="/js/board.js"></script>
<script src="/js/form.js"></script>

<script src="/js/blogApi.js"></script>
<script src="/js/instagramApi.js"></script>

<!-- 후원사 동적 호출 및 렌더링 스크립트 -->
<script>
    $(document).ready(function() {
        // 1. Swiper 인스턴스를 전역 변수로 선언 (외부에서 제어하기 위해)
        var sponsorSwiper = null;

        $.ajax({
            type: "POST",
            dataType: "json",
            cache: false,
            url: "/promoter/list",
            beforeSend: function(xhr) {
                // 서버로 요청을 보내기 직전에 CSRF 토큰을 헤더에 장착
                xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
            },
            success: function (response) {
                var wrapper = $('#promoter_list');
                wrapper.empty();

                if (response && response.length > 0) {
                    for (var i = 0; i < response.length; i++) {
                        var item = response[i];
                        var safeName = item.promoterName ? item.promoterName.replace(/"/g, '&quot;') : '';

                        var html = '<div class="swiper-slide">' +
                            '<a href="javascript:void(0);" title="' + safeName + '">' +
                            '<img src="/file/img?type=promoter&filename=' + item.fileName + '" alt="' + safeName + ' 로고" style="max-width: 100%; height: auto;">' +
                            '</a>' +
                            '</div>';
                        wrapper.append(html);
                    }

                    // 2. 데이터 로드 후 Swiper 초기화 또는 업데이트
                    initSponsorSwiper(response.length);
                } else {
                    wrapper.append('<div class="swiper-slide" style="width: 100%; text-align: center; color: #777;">등록된 후원사가 없습니다.</div>');
                }
            },
            error: function (xhr, status, error) {
                console.error("후원사 데이터 로드 실패:", error);
            }
        });

        // 3. Swiper 초기화 함수
        function initSponsorSwiper(dataCount) {
            // 이미 인스턴스가 있다면 파괴 후 재생성 (비동기 데이터 갱신 대응)
            if (sponsorSwiper) sponsorSwiper.destroy(true, true);

            sponsorSwiper = new Swiper('.sponsorSwiper', {
                slidesPerView: 6,
                spaceBetween: 20,
                loop: dataCount > 6, // 루프가 자연스럽게 돌도록 설정
                autoplay: {
                    delay: 2500,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: true
                },
                breakpoints: {
                    0: { slidesPerView: 2, spaceBetween: 12 },
                    576: { slidesPerView: 3, spaceBetween: 16 },
                    768: { slidesPerView: 4, spaceBetween: 16 },
                    1024: { slidesPerView: 5, spaceBetween: 20 },
                    1400: { slidesPerView: 6, spaceBetween: 20 }
                }
            });
        }
    });
</script>

</body>
</html>