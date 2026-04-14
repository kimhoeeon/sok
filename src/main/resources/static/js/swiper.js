$(document).ready(function () {

  let totalRealSlides = 0;

  const swiperMainTop = new Swiper('.swiperMainTop', {
    effect: 'fade',
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
    slidesPerView: 1,
    spaceBetween: 0,
    loop: true,

    on: {
      init: function () {
        totalRealSlides = getTotalSlides(this);   // ✅ 05 정확히 계산
        updateFraction(this);
        startSegmentBar(this);
      },

      slideChangeTransitionStart: function () {
        // total이 아직 0이면(드물지만) 다시 계산
        if (!totalRealSlides) totalRealSlides = getTotalSlides(this);

        updateFraction(this);
        startSegmentBar(this);
      },

      autoplayStop: function () {
        stopSegmentBar();
      },

      autoplayStart: function () {
        startSegmentBar(this);
      },

      resize: function () {
        if (typeof getDirection !== 'function') return;
        if (typeof this.changeDirection !== 'function') return;

        this.changeDirection(getDirection());
      },
    },
  });

  function pad2(n) {
    return String(n).padStart(2, '0');
  }

  // ✅ 진짜 슬라이드 개수(복제 제외) 계산
  function getTotalSlides(swiper) {
    const root = swiper.el; // .swiperMainTop 요소
    const realSlides = root.querySelectorAll('.swiper-slide:not(.swiper-slide-duplicate)');
    // 일부 버전/환경에서 duplicate 클래스가 없을 수도 있어 fallback
    return realSlides.length ? realSlides.length : swiper.slides.length;
  }

  function updateFraction(swiper) {
    const current = swiper.realIndex + 1;   // ✅ loop에서 실제 인덱스
    const total = totalRealSlides || getTotalSlides(swiper);

    const el = document.querySelector('.swiperMainTopFraction');
    if (!el) return;

    el.innerHTML = `
      <span class="swiper-pagination-current">${pad2(current)}</span>
      <span class="sep"> / </span>
      <span class="swiper-pagination-total">${pad2(total)}</span>
    `;
  }

  // ✅ “칸칸이 채워지는” 로딩바 (예: 5장이면 20%씩)
  function startSegmentBar(swiper) {
    const wrap = document.querySelector('.swiperMainTopAutoplayBar');
    const bar = wrap ? wrap.querySelector('.bar') : null;
    if (!wrap || !bar) return;

    const total = totalRealSlides || getTotalSlides(swiper);
    const current = swiper.realIndex + 1;

    const delay = (swiper.params.autoplay && swiper.params.autoplay.delay) ? swiper.params.autoplay.delay : 4000;

    const startPct = ((current - 1) / total) * 100;
    const endPct   = (current / total) * 100;

    // transition 방식으로 매번 리셋 후 “현재 구간”만큼 증가
    bar.style.transition = 'none';
    bar.style.width = `${startPct}%`;
    void bar.offsetWidth; // reflow

    bar.style.transition = `width ${delay}ms linear`;
    bar.style.width = `${endPct}%`;
  }

  function stopSegmentBar() {
    const wrap = document.querySelector('.swiperMainTopAutoplayBar');
    const bar = wrap ? wrap.querySelector('.bar') : null;
    if (!bar) return;

    // 멈출 때는 transition 제거(정지된 width 유지)
    bar.style.transition = 'none';
  }

});

$(document).ready(function () {
  const bizSwiper = new Swiper('.bizSwiper', {
    loop: true,
    centeredSlides: true,
    slidesPerView: 'auto',
    spaceBetween: 0,
    speed: 500,
    watchSlidesProgress: true,

    breakpoints: {
      0: {        // 모바일
        spaceBetween: 12,
      },
      768: {      // 태블릿 이상
        spaceBetween: 0,
      }
    }
  });
});