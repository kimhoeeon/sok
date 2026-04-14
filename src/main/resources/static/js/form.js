$(document).ready(function () {


    /* 
    add1 - 회사명
    add2 - 담당자명
    add3 - 연락처
    add4 - 이메일주소
    add5 - 문의내용
    */


    $('.form_box font').contents().unwrap().wrap('<p></p>'); //font 태그 p태그로 변경
    $('.form_box > tbody > tr > td:nth-child(1)').addClass('gubun'); // 제목 태그 클래스 추가
    $('.form_box > tbody > tr > td:nth-child(2)').addClass('naeyong'); // 입력 태그 클래스 추가
    $('.form_box > tbody > tr > td').removeAttr('style'); // 기존에 지정되어있던 style 제거


    $('.form_box input[name="add1"]').attr("placeholder", "휴대폰 번호를 입력해주세요").addClass('essen');
    $('.form_box input[name="add2"]').attr("placeholder", "담당자명"); // 담당자명
    $('.form_box input[name="add3"]').attr("placeholder", "연락처"); // 연락처
    $('.form_box input[name="add4"]').attr("placeholder", "성함을 입력해주세요").addClass('essen'); 
    $('.form_box textarea[name="description1"]').attr("placeholder", "문의 내용을 입력해주세요"); //문의내용

    $('.form_box input[name="add1"]').closest('tr').addClass('essen');
    $('.form_box input[name="add4"]').closest('tr').addClass('essen');
    $('.form_box textarea[name="description1"]').closest('tr').addClass('w100 essen');
    $('.form_box .gubun:contains("개인정보")').parents('tr').addClass('privacy_wrap');
    $('#captcha').closest('tr').addClass('captcha_wrap');
    $('.input_check').each(function() {
        // 현재 td 내부의 input 요소
        var inputElement = $(this).find('input');
        
        // 현재 td 내부의 텍스트
        var textContent = $(this).text().trim();
        
        // input과 텍스트를 감싸는 label 생성
        var labelElement = $('<label></label>').append(inputElement).append(textContent);
        
        // 현재 td의 내용을 label로 대체
        $(this).html(labelElement);
    });

    
    
});