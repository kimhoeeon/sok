$(document).ready(function () {

    ////////////////////// 카테고리 탭형식
    $('.sul_menu font').removeAttr('style');
    $('.sul_menu').addClass('cate_menu'); // 제목 태그 클래스 추가

    ////////////////////// 갤러리 게시판 리스트 페이지
    $('.gal_list *').removeAttr('style');


    $('.gal_list .bbsnewf5 img').each(function () {
        var imgSrc = $(this).attr('src');
        // img 요소가 src 속성을 가지고 있고, 그 src가 이미지 파일을 가리키는지 확인
        if (imgSrc && imgSrc.match(/\.(jpg|jpeg|png|gif)$/i)) {
            $(this).closest('td').addClass('gallery_img');
        }
    });

    // font 안에 있는 텍스트를 기준으로 각 태그에 클래스 부여
    $('.gallery_etc font').each(function () {
        var text = $(this).text().trim(); // 공백 제거 후 텍스트 가져오기

        if (text.includes('작성일자')) {
            $(this).addClass('date');
        }
        // else if (text.includes('발주처')) {
        //     $(this).addClass('clients');
        // } 
    });

    // 각 구분 텍스트 삭제
    $('.gallery_etc .date').each(function () {
        $(this).text($(this).text().replace('작성일자 : ', ''));
    });

    // 게시물 선택 체크박스
    $('.gal_list > tbody > tr').each(function () {
        const $inputCheck = $(this).find('input[type="checkbox"]');
        $inputCheck.addClass('gallery_check');
    });

    $('.gallery_check').parent('td').addClass('gallery_check_wrap');


    /////////////////////////// 웹진 게시판 리스트 페이지
    // 게시물 선택 체크박스
    $('.webz_list > tbody > tr').each(function () {
        const $inputCheck = $(this).find('input[type="checkbox"]');
        $inputCheck.addClass('webz_check');
    });

    $('.webz_check').parents('td').addClass('webz_check_wrap');
    $('tr').each(function () {
        if ($(this).children('.webzine_type2_table_line').length > 0) {
            $(this).css('display', 'none');
        }
    });


    // 게시판 추출
    $('.gallery_output > table').addClass('swiper-slide'); // 제목 태그 클래스 추가



});