$.ajax({
    type: "POST",
    dataType: "json",
    cache: false,
    url: "/blog/list",
    beforeSend: function(xhr) {
        // 서버로 요청을 보내기 직전에 CSRF 토큰을 헤더에 장착
        xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
    },
    success: function (response) {
        // 기존 하드코딩된 li 제거 (혹시 남아있을 경우 대비)
        $('#naverblog_list').empty();

        if (response && response.length > 0) {
            // 최대 9개까지만 렌더링
            let limit = Math.min(response.length, 9);
            for (let i = 0; i < limit; i++) {
                let item = response[i];

                // 파일명이 없으면 기본 이미지 표시
                // 제목에 큰따옴표가 있을 경우 화면이 깨지는 것을 방지
                let safeTitle = item.title ? item.title.replace(/"/g, '&quot;') : '';

                // 파일명이 있으면 서버 로컬 이미지, 없으면 수집된 원본 URL 또는 샘플 이미지 사용
                let imageSrc = '/img/sns_img_sample.png';
                if (item.fileName) {
                    // /img 로 경로 맞춤 (FileController)
                    imageSrc = '/file/img?type=blog&filename=' + item.fileName;
                } else if (item.imageSrc) {
                    imageSrc = item.imageSrc;
                }

                let post = '<li>';
                post += '<a href="' + item.linkUrl + '" target="_blank" rel="noopener noreferrer" title="' + safeTitle + '">';
                post += '<img src="' + imageSrc + '" alt="' + safeTitle + '" style="width: 100%; height: 100%; object-fit: cover;">';
                post += '</a>';
                post += '</li>';

                $('#naverblog_list').append(post);
            }
        } else {
            $('#naverblog_list').append('<li style="width:100%; text-align:center; color:#777; padding:20px;">등록된 블로그 게시물이 없습니다.</li>');
        }
    },
    error: function (xhr, status, error) {
        console.error("블로그 데이터 로드 실패:", error);
    }
});

function show_fallback(el) {
    $(el).addClass('loaded fallback');
}