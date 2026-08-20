$.ajax({
    type: "POST",
    dataType: "json",
    cache: false,
    url: "/instagram/list",
    beforeSend: function(xhr) {
        // 서버로 요청을 보내기 직전에 CSRF 토큰을 헤더에 장착
        xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
    },
    success: function (response) {
        // 기존 하드코딩된 li 제거
        $('#instagram_list').empty();

        if (response && response.length > 0) {
            let limit = Math.min(response.length, 9);
            for (let i = 0; i < limit; i++) {
                let item = response[i];

                // 파일명이 없으면 기본 이미지 표시
                // 제목에 큰따옴표가 있을 경우 화면이 깨지는 것을 방지
                let safeTitle = item.title ? item.title.replace(/"/g, '&quot;') : '';
                let imageSrc = item.fileName ? '/file/img?type=instagram&filename=' + item.fileName : '/img/sns_img_sample.png';

                let post = '<li>';
                post += '<a href="' + item.linkUrl + '" target="_blank" rel="noopener noreferrer" title="' + safeTitle + '">';
                post += '<img src="' + imageSrc + '" alt="' + safeTitle + '">';
                post += '</a>';
                post += '</li>';

                $('#instagram_list').append(post);
            }
        } else {
            $('#instagram_list').append('<li style="width:100%; text-align:center; color:#777; padding:20px;">등록된 인스타그램 게시물이 없습니다.</li>');
        }
    },
    error: function (xhr, status, error) {
        console.error("인스타그램 데이터 로드 실패:", error);
    }
});

function show_fallback(el) {
    $(el).addClass('loaded fallback');
}