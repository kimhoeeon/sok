$(document).ready(function () {

    // header 고정
    $(window).on('scroll', function () {
        if ($(window).scrollTop()) {
            $('#header').addClass('active');
        } else {
            $('#header').removeClass('active');
        }
    });

    // 햄버거 메뉴
    $('#header .hamberg').click(function () {
        $(this).children('span').toggleClass('on');
        $('#header .nav_wrap').toggleClass('on');
        $('#header .lang').toggleClass('on');
        $('#header .side').toggleClass('on');
    });

    // lang 클릭
    $('#header .lang').on('click', function () {

        $('#header .side .langmenu').stop().slideUp();
        $(this).children('.langmenu').stop().slideToggle();
    });

    // side 클릭
    $('#header .side').on('click', function () {

        $('#header .lang .langmenu').stop().slideUp();
        $(this).children('.langmenu').stop().slideToggle();
    });

    // 모바일 슬라이드 메뉴
    $('.megamenu').on('click', function () {
        $(this).toggleClass('on');
        $('.hd_site_map').toggleClass('on');
    });

    // QNA
    $(document).ready(function () {

        $('.main_qna_list .qna_item.on .qna_a').show();

        $('.main_qna_list .qna_q').on('click', function () {
            var $item = $(this).closest('.qna_item');
            var $answer = $item.find('.qna_a');

            $item.toggleClass('on');
            $answer.stop(true, true).slideToggle(250);
        });

    });

    $('.sound_btn .play').hover(
        function () {
            $(this).find('img').attr('src', '/img/ico_sound_w.png');
        },
        function () {
            $(this).find('img').attr('src', '/img/ico_sound.png');
        }
    );

    $(document).ready(function () {
        $('.history_tab button').on('click', function () {
            var target = $(this).data('history');

            $('.history_tab button').removeClass('on');
            $(this).addClass('on');

            $('.history_panel').removeClass('on').hide();
            $('#' + target).fadeIn(200).addClass('on');
        });
    });

    function handleDept1Click(e) {
        var viewportWidth = $(window).width();

        if ($(this).hasClass('link_menu')) {
            return true;
        }

        if (viewportWidth <= 1401) {
            var $dept2 = $(this).find('.dept2');

            if (!$dept2.length) {
                return true;
            }

            e.preventDefault();

            var otherDept2 = $('.site_map_nav .dept1 > li')
                .not($(this))
                .find('.dept2:visible');

            otherDept2.stop(true, true).slideUp();

            $dept2.stop(true, true).slideToggle();
        }
    }

    // 1depth 클릭
    $('.site_map_nav .dept1 > li').on('click', handleDept1Click);

    // dept2 안의 a는 링크 이동되게
    $('.site_map_nav .dept2 a').on('click', function (e) {
        e.stopPropagation();
    });

    // resize
    $(window).on('resize', function () {
        $('.site_map_nav .dept1 > li').off('click', handleDept1Click);
        $('.site_map_nav .dept1 > li').on('click', handleDept1Click);

        $('.site_map_nav .dept2 a').off('click').on('click', function (e) {
            e.stopPropagation();
        });
    });

    // header 이벤트
    function setMenuEvents() {
        $('#header .menu > li').off('mouseover mouseleave click');


        const slideMenu = (selector, child) => {
            $(selector).on('mouseover', function () {
                $(this).children(child).stop().slideDown();
            }).on('mouseleave', function () {
                $(this).children(child).stop().slideUp();
            });
        };

        if (window.innerWidth >= 899) {
            slideMenu('#header .menu > li:has(.submenu)', '.submenu');

        } else {
            $('#header .menu > li').on('click', function () {
                const $submenu = $(this).children('.submenu');
                $('.submenu').not($submenu).slideUp();
                $submenu.slideToggle();
            }).each(function () {
                if ($(this).children('.submenu').length > 0) {
                    $(this).children('a').attr('href', 'javascript:void(0);');
                }
            });
        }
    }

    $(window).on('resize', setMenuEvents); // 화면 크기 변경 시 재설정
    $(document).ready(setMenuEvents); // 초기 로드 시 설정


    $('.parallax_sec').each(function () {
        const img = $(this).find('.parallax_img');
        const url = img.attr('src');
        $(this).css({
            'background-image': `url(${url})`,
        });
        img.hide(); // 원래 이미지 숨김
    });

});

$(document).ready(function () {
    $('.menu > li.has-sub > a').on('click', function (e) {
        if ($(window).width() >= 1400) return;

        e.preventDefault();

        const $parent = $(this).parent('li');

        $('.menu > li.has-sub').not($parent).removeClass('open');
        $parent.toggleClass('open');
    });
});


$('input[name="cmp_type"]').on('change', function () {

    if ($(this).val() === '기타') {
        $('.etc_input').stop().fadeIn(0).focus();
    } else {
        $('.etc_input').stop().fadeOut(0).val('');
    }

});

$(document).ready(function () {

    // 드롭다운 버튼 클릭
    $(document).on('click', '.has_dropdown > .utils_btn', function (e) {
        e.stopPropagation();

        const $parent = $(this).closest('.has_dropdown');

        // 다른 메뉴 닫기
        $('.has_dropdown').not($parent).removeClass('open');

        // 현재 토글
        $parent.toggleClass('open');
    });

    // 바깥 클릭 시 닫기
    $(document).on('click', function () {
        $('.has_dropdown').removeClass('open');
    });

    // 드롭다운 내부 클릭 시 닫히지 않게
    $(document).on('click', '.dropdown', function (e) {
        e.stopPropagation();
    });

});

// 글자 크기, 줄간격, 초기화 기능
$(document).ready(function () {

    const $target = $('body');

    let fontSize = parseInt(localStorage.getItem('fontSize')) || 16;
    let lineHeight = parseFloat(localStorage.getItem('lineHeight')) || 1.4;

    const minFont = 12;
    const maxFont = 26;
    const minLine = 1.2;
    const maxLine = 2.5;

    applyStyle();

    $('.font_plus').on('click', function () {
        if (fontSize < maxFont) {
            fontSize += 1;
            save();
            applyStyle();
        }
    });

    $('.font_minus').on('click', function () {
        if (fontSize > minFont) {
            fontSize -= 1;
            save();
            applyStyle();
        }
    });

    $('.line_plus').on('click', function () {
        if (lineHeight < maxLine) {
            lineHeight = +(lineHeight + 0.1).toFixed(1);
            save();
            applyStyle();
        }
    });

    $('.line_minus').on('click', function () {
        if (lineHeight > minLine) {
            lineHeight = +(lineHeight - 0.1).toFixed(1);
            save();
            applyStyle();
        }
    });

    $('.reset_btn').on('click', function () {
        fontSize = 16;
        lineHeight = 1.4;

        localStorage.removeItem('fontSize');
        localStorage.removeItem('lineHeight');

        applyStyle();
    });

    function applyStyle() {
        $target.css({
            fontSize: fontSize + 'px',
            lineHeight: lineHeight
        });
    }

    function save() {
        localStorage.setItem('fontSize', fontSize);
        localStorage.setItem('lineHeight', lineHeight);
    }

});

// 소리듣기
document.addEventListener('DOMContentLoaded', function () {

    document.addEventListener('click', function (e) {
        const btn = e.target.closest('.sound_btn .play');
        if (!btn) return;

        const targetId = btn.getAttribute('data-target');
        const targetEl = document.getElementById(targetId);

        if (!targetEl) return;

        // 항상 기존 음성 끊고 새로 재생
        window.speechSynthesis.cancel();

        const text = targetEl.innerText.replace(/\n/g, ' ').trim();
        if (!text) return;

        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = 'ko-KR';

        // 한국어 음성 선택
        const voices = speechSynthesis.getVoices();
        const koreanVoice = voices.find(v => v.lang.includes('ko'));
        if (koreanVoice) utterance.voice = koreanVoice;

        speechSynthesis.speak(utterance);
    });

    speechSynthesis.onvoiceschanged = function () {
        speechSynthesis.getVoices();
    };
});

// 아코디언
$(document).ready(function () {
    const $items = $('.truth_txt li');
    const $imgs = $('.truth_img li');

    openAccordion($items.first());
    $imgs.first().addClass('active');

    $('.truth_txt .tit').on('click', function () {
        const $li = $(this).closest('li');
        const index = $li.index();
        if ($li.hasClass('active')) return;

        closeAll();
        openAccordion($li);

        $imgs.removeClass('active').eq(index).addClass('active');
    });

    function openAccordion($li) {
    const $txt = $li.find('.txt');
        if (!$txt.length) return;

        $li.addClass('active');

        $txt.css('max-height', '0px');

        requestAnimationFrame(() => {
            const realHeight = $txt[0].scrollHeight;
            $txt.css('max-height', realHeight + 'px');
        });
    }

    function closeAll() {
        $items.each(function () {
        const $li = $(this);
        const $txt = $li.find('.txt');
        if (!$li.hasClass('active')) {
            $txt.css('max-height', '0px');
            return;
        }

        const currentHeight = $txt[0].scrollHeight;
        $txt.css('max-height', currentHeight + 'px');
        requestAnimationFrame(() => {
            $txt.css('max-height', '0px');
        });

        $li.removeClass('active');
        });
    }

    $(window).on('load', function () {
        const $active = $('.truth_txt li.active .txt');
        if ($active.length) $active.css('max-height', $active[0].scrollHeight + 'px');
    });
});

// 팝업 열기
$('.btn.guide').on('click', function () {
    $('.guide-popup').fadeIn(100);
    $('body').addClass('popup-open'); // 스크롤 잠금용(선택)
});

$('.popup-close').on('click', function () {
    $('.guide-popup').fadeOut(100);
    $('body').removeClass('popup-open');
});

$('.guide-popup').on('click', function (e) {
    if ($(e.target).is('.guide-popup')) {
        $(this).fadeOut(100);
        $('body').removeClass('popup-open');
    }
});

// 개인정보처리방침 팝업
document.addEventListener('DOMContentLoaded', () => {

    const TERMSHEET_LIBRARY = {
        service:{
            title: '개인정보 수집·이용 동의 (필수)',
            text: `
                <div class="stack mt-24 terms_wrap">
                    <div class="sec">
                        <div class="text">
                            <span>스페셜올림픽코리아(이하 “회사”)</span> 은 문의 접수 및 답변, 서비스 상담을 위해 아래와 같이 개인정보를 수집·이용합니다. <br class="terms_br">
                            내용을 확인하신 후 동의해 주세요.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            1. 수집 항목
                        </div>
                        <div class="text">
                            ① 수집 항목
                            <ul>
                                <li><span>필수:</span> 성함, 구분(기업/개인), 연락처, 이메일, 국가, 문의내용</li>
                                <li><span>선택:</span> 작품제목</li>
                                <li><span>첨부 자료:</span> 작품 이미지 파일 및/또는 URL(작품 이미지가 포함될 수 있음)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            2. 수집·이용 목적
                        </div>
                        <div class="text">
                            <ul>
                                <li>문의 접수 및 본인 확인</li>
                                <li>문의 내용 확인, 답변 및 안내(연락/이메일 회신)</li>
                                <li>서비스 이용 상담, 견적 및 진행 관련 커뮤니케이션</li>
                                <li>분쟁 대응 및 민원 처리, 서비스 품질 개선을 위한 내부 참고(비식별/최소 범위 내)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            3. 보유 및 이용 기간
                        </div>
                        <div class="text">
                            <span>문의 처리 완료일로부터 1년 보관 후 파기</span><br class="terms_br">
                            단, 관계 법령에 따라 보관이 필요한 경우 해당 법령에서 정한 기간 동안 보관합니다.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            4. 동의 거부 권리 및 불이익
                        </div>
                        <div class="text">
                            이용자는 개인정보 수집·이용에 대한 동의를 거부할 권리가 있습니다.<br class="terms_br">
                            다만 <span>필수 항목 동의/제공을 거부할 경우 문의 접수 및 답변 제공이 제한</span>될 수 있습니다.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            5. 첨부파일(작품 이미지) 유의사항
                        </div>
                        <div class="text">
                            첨부자료에는 작품 이미지 및 관련 정보가 포함될 수 있으며, 회사는 <span>문의 처리 및 상담 목적 범위 내에서만</span> 이를 이용합니다.<br class="terms_br">
                            민감정보(주민번호, 계좌번호 등)는 입력/첨부하지 않도록 주의해 주세요.
                        </div><br class="terms_br">
                    </div>
                </div>
            `.trim()
        },
        privacy: {
            title: '개인정보 수집·이용 동의 (필수)',
            text: `
                <div class="stack mt-24 terms_wrap">
                    <div class="sec">
                        <div class="text">
                            <span>스페셜올림픽코리아(이하 “회사”)</span> 은 문의 접수 및 답변, 서비스 상담을 위해 아래와 같이 개인정보를 수집·이용합니다.
                            
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            1. 수집 항목
                        </div>
                        <div class="text">
                            ① 수집 항목
                            <ul>
                                <li><span>필수:</span> 성함, 구분(기업/개인), 연락처, 이메일, 국가, 문의내용</li>
                                <li><span>선택:</span> 작품제목</li>
                                <li><span>첨부 자료:</span> 작품 이미지 파일 및/또는 URL(작품 이미지가 포함될 수 있음)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            2. 수집·이용 목적
                        </div>
                        <div class="text">
                            <ul>
                                <li>문의 접수 및 본인 확인</li>
                                <li>문의 내용 확인, 답변 및 안내(연락/이메일 회신)</li>
                                <li>서비스 이용 상담, 견적 및 진행 관련 커뮤니케이션</li>
                                <li>분쟁 대응 및 민원 처리, 서비스 품질 개선을 위한 내부 참고(비식별/최소 범위 내)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            3. 보유 및 이용 기간
                        </div>
                        <div class="text">
                            <span>문의 처리 완료일로부터 1년 보관 후 파기</span><br class="terms_br">
                            단, 관계 법령에 따라 보관이 필요한 경우 해당 법령에서 정한 기간 동안 보관합니다.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            4. 동의 거부 권리 및 불이익
                        </div>
                        <div class="text">
                            이용자는 개인정보 수집·이용에 대한 동의를 거부할 권리가 있습니다.<br class="terms_br">
                            다만 <span>필수 항목 동의/제공을 거부할 경우 문의 접수 및 답변 제공이 제한</span>될 수 있습니다.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            5. 첨부파일(작품 이미지) 유의사항
                        </div>
                        <div class="text">
                            첨부자료에는 작품 이미지 및 관련 정보가 포함될 수 있으며, 회사는 <span>문의 처리 및 상담 목적 범위 내에서만</span> 이를 이용합니다.<br class="terms_br">
                            민감정보(주민번호, 계좌번호 등)는 입력/첨부하지 않도록 주의해 주세요.
                        </div><br class="terms_br">
                    </div>
                </div>
            `.trim()
        },
        serviceEn:{
            title: 'Consent to Collection and Use of Personal Information (Required)',
            text: `
                <div class="stack mt-24 terms_wrap">
                    <div class="sec">
                        <div class="text">
                            <span>Artixel (hereinafter referred to as the "Company")</span> collects and uses personal information as follows for inquiry handling, responses, and service consultation. <br class="terms_br">
                            Please review the details and provide your consent.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            1. Items Collected
                        </div>
                        <div class="text">
                            ① Collected Items
                            <ul>
                                <li><span>Required:</span> Name, Category (Company/Individual), Contact Number, Email, Country, Inquiry Details</li>
                                <li><span>Optional:</span> Artwork Title</li>
                                <li><span>Attachments:</span> Artwork image files and/or URLs (may include artwork images)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            2. Purpose of Collection and Use
                        </div>
                        <div class="text">
                            <ul>
                                <li>Inquiry submission and identity verification</li>
                                <li>Review of inquiry details, response, and guidance (contact/email reply)</li>
                                <li>Service consultation, quotations, and communication related to service processing</li>
                                <li>Dispute resolution, complaint handling, and internal reference for service quality improvement (within non-identifiable and minimal scope)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            3. Retention and Use Period
                        </div>
                        <div class="text">
                            <span>Retained for 1 year from the date of inquiry completion and then destroyed</span><br class="terms_br">
                            However, if retention is required by applicable laws, it will be stored for the period specified by such laws.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            4. Right to Refuse Consent and Disadvantages
                        </div>
                        <div class="text">
                            Users have the right to refuse consent to the collection and use of personal information.<br class="terms_br">
                            However, if you refuse to agree to or provide required items, <span>submission of inquiries and provision of responses may be restricted</span>.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            5. Notes on Attachments (Artwork Images)
                        </div>
                        <div class="text">
                            Attachments may include artwork images and related information, and the Company will use them <span>only within the scope of inquiry handling and consultation purposes</span>.<br class="terms_br">
                            Please do not enter or attach sensitive information (e.g., resident registration number, bank account number).
                        </div><br class="terms_br">
                    </div>
                </div>
            `.trim()
        },
        privacyEn: {
            title: 'Consent to Collection and Use of Personal Information (Required)',
            text: `
                <div class="stack mt-24 terms_wrap">
                    <div class="sec">
                        <div class="text">
                            <span>Artixel (hereinafter referred to as the "Company")</span> collects and uses personal information as follows for inquiry handling, responses, and service consultation.
                            
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            1. Items Collected
                        </div>
                        <div class="text">
                            ① Collected Items
                            <ul>
                                <li><span>Required:</span> Name, Category (Company/Individual), Contact Number, Email, Country, Inquiry Details</li>
                                <li><span>Optional:</span> Artwork Title</li>
                                <li><span>Attachments:</span> Artwork image files and/or URLs (may include artwork images)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            2. Purpose of Collection and Use
                        </div>
                        <div class="text">
                            <ul>
                                <li>Inquiry submission and identity verification</li>
                                <li>Review of inquiry details, response, and guidance (contact/email reply)</li>
                                <li>Service consultation, quotations, and communication related to service processing</li>
                                <li>Dispute resolution, complaint handling, and internal reference for service quality improvement (within non-identifiable and minimal scope)</li>
                            </ul>
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            3. Retention and Use Period
                        </div>
                        <div class="text">
                            <span>Retained for 1 year from the date of inquiry completion and then destroyed</span><br class="terms_br">
                            However, if retention is required by applicable laws, it will be stored for the period specified by such laws.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            4. Right to Refuse Consent and Disadvantages
                        </div>
                        <div class="text">
                            Users have the right to refuse consent to the collection and use of personal information.<br class="terms_br">
                            However, if you refuse to agree to or provide required items, <span>submission of inquiries and provision of responses may be restricted</span>.
                        </div>
                    </div>
                    <div class="sec">
                        <div class="tit">
                            5. Notes on Attachments (Artwork Images)
                        </div>
                        <div class="text">
                            Attachments may include artwork images and related information, and the Company will use them <span>only within the scope of inquiry handling and consultation purposes</span>.<br class="terms_br">
                            Please do not enter or attach sensitive information (e.g., resident registration number, bank account number).
                        </div><br class="terms_br">
                    </div>
                </div>
            `.trim()
        }
    };

    const TERMSHEET_BACKDROP = document.getElementById('centerPopup');
    const TERMSHEET_TITLE = document.getElementById('centerPopupTitle');
    const TERMSHEET_TEXT = document.getElementById('centerPopupTxt');
    const TERMSHEET_OPEN_BTNS = document.querySelectorAll('.btn-open-terms');
    const TERMSHEET_CONFIRM_BTN = TERMSHEET_BACKDROP?.querySelector('[data-popup="center-confirm"]');

    if (!TERMSHEET_BACKDROP || !TERMSHEET_TITLE || !TERMSHEET_OPEN_BTNS.length) return;

    const TERMSHEET_TEXT_EL = TERMSHEET_TEXT || (() => {
        const el = document.createElement('div');
        el.className = 'center-popup_txt';
        el.id = 'centerPopupTxt';
        TERMSHEET_TITLE.insertAdjacentElement('afterend', el);
        return el;
    })();


    function TERMSHEET_nl2br(str = '') {
        return String(str).replace(/\n/g, '<br>');
    }

    function TERMSHEET_open(key) {
        const doc = TERMSHEET_LIBRARY[key];
        if (!doc) return;

        TERMSHEET_TITLE.textContent = doc.title || '';
        TERMSHEET_TEXT_EL.innerHTML = TERMSHEET_nl2br(doc.text || '');

        TERMSHEET_BACKDROP.style.display = 'block';
        TERMSHEET_BACKDROP.classList.add('is-open');

        document.body.classList.add('is-scroll-locked');
    }

    function TERMSHEET_close() {
        TERMSHEET_BACKDROP.classList.remove('is-open');
        TERMSHEET_BACKDROP.style.display = 'none';

        TERMSHEET_TITLE.textContent = '';
        TERMSHEET_TEXT_EL.innerHTML = '';

        document.body.classList.remove('is-scroll-locked');
    }

    TERMSHEET_OPEN_BTNS.forEach(btn => {
        btn.addEventListener('click', () => {

        const key = btn.dataset.terms;
        TERMSHEET_open(key);
        });
    });

    if (TERMSHEET_CONFIRM_BTN) {
        TERMSHEET_CONFIRM_BTN.addEventListener('click', TERMSHEET_close);
    }

    TERMSHEET_BACKDROP.addEventListener('click', (e) => {
        if (e.target === TERMSHEET_BACKDROP) TERMSHEET_close();
    });

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && TERMSHEET_BACKDROP.style.display === 'block') {
        TERMSHEET_close();
        }
    });
});

$(document).ready(function () {

    const data = {
        seoul: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        gangwon: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        chungnam: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        chungbuk: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        gyeongbuk: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        gyeongnam: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        jeonbuk: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        jeonnam: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ],
        jeju: [
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' },
            { img: '/img/sample_img.png', name: '오응환', date: '2011년 12월 14일', addr: '경기도 구리시 산마루로 18 501호 하나로프라자(갈매동)', number: '031-571-1116', fax: '031-255-1320', home: 'http://www.ggsokorea.or.kr' }
        ]
    };

    function renderCards(region) {
        const list = data[region] || [];
        let html = '';

        list.forEach(function (item) {
            html += `
                <div class="info_card">
                    <img src="${item.img}" alt="${item.name}">
                    <div class="info_body">
                        <div><span>회장</span> ${item.name}</div>
                        <div><span>설립일</span> ${item.date}</div>
                        <div><span>주소</span> ${item.addr}</div>
                        <div><span>전화</span> ${item.number}</div>
                        <div><span>팩스</span> ${item.fax}</div>
                        <div><span>홈페이지</span> ${item.home}</div>
                    </div>
                </div>
            `;
        });

        $('#infoGrid').html(html);
    }

    // 👉 클릭만!
    $('.map_btn').on('click', function () {

        const region = $(this).data('prov');

        // 버튼 active
        $('.map_btn').removeClass('on');
        $(this).addClass('on');

        // 지도 변경
        $('.map_piece').removeClass('on');
        $('.map_piece.' + region).addClass('on');

        // 리스트 변경
        renderCards(region);
    });

    // 초기값
    renderCards('seoul');

});