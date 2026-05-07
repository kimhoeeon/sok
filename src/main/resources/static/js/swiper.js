$(document).ready(function () {

    function getDirection() {
        return window.innerWidth <= 768 ? 'horizontal' : 'horizontal';
    }

    var mainVisualEl = document.querySelector('.swiper_main_t');

    if (mainVisualEl) {
        var swiper = new Swiper('.swiper_main_t', {
            slidesPerView: 1,
            spaceBetween: 0,
            direction: getDirection(),
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.paging-wrap',
                clickable: true,
            },
            on: {
                resize: function () {
                    this.changeDirection(getDirection());
                },
                slideChange: function () {
                    var counter = document.querySelector('.mainVisual-counter');
                    if (counter) {
                        counter.innerHTML =
                            '<span>' + (this.realIndex + 1) + '</span> / ' + this.slides.length;
                    }
                }
            }
        });
    }

    function createSwiper(containerSelector) {
        var $container = $(containerSelector);
        if (!$container.length) return null;

        return new Swiper($container[0], {
            slidesPerView: 1,
            spaceBetween: 20,
            direction: getDirection(),
            loop: true,
            autoHeight: true,
            autoplay: false,
            navigation: {
                nextEl: $container.find('.swiper-button-next')[0],
                prevEl: $container.find('.swiper-button-prev')[0],
            },
            on: {
                resize: function () {
                    this.changeDirection(getDirection());
                }
            }
        });
    }

    if ($('.swiperMainCont').length) {
        var options = {};

        if ($(".swiperMainCont .swiper-slide").length <= 1) {
            options = {
                slidesPerView: 1,
                navigation: {
                    nextEl: '.mainContNext',
                    prevEl: '.mainContPrev',
                },
                touchRatio: 0,
            };
        } else {
            options = {
                slidesPerView: 1,
                spaceBetween: 0,
                direction: getDirection(),
                navigation: {
                    nextEl: '.mainContNext',
                    prevEl: '.mainContPrev',
                },
                loop: true,
                touchRatio: 0,
                on: {
                    resize: function () {
                        this.changeDirection(getDirection());
                    },
                },
            };
        }

        var swiperMainCont = new Swiper(".swiperMainCont", options);
    }
});