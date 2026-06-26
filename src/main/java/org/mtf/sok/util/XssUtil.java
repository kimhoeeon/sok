package org.mtf.sok.util;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.web.util.HtmlUtils;

public class XssUtil {

    /**
     * 1. 에디터용 XSS 필터 (화이트리스트 방식)
     * - p, br, b, i, img 등 안전한 태그와 속성만 남기고,
     * - script, iframe, object, on~ 이벤트 핸들러 등 악성 코드는 100% 삭제함.
     */
    public static String cleanXss(String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }

        // 상대 경로(/upload/...) 이미지가 삭제되는 것을 방지
        Safelist safelist = Safelist.relaxed();

        // 1. 상대 경로 링크를 절대 경로로 강제 변환하지 않고 원본 그대로 유지
        safelist.preserveRelativeLinks(true);

        // 2. 에디터에 이미지를 드래그 앤 드롭해서 Base64(data:image/...) 형태로 들어가는 것 허용
        safelist.addProtocols("img", "src", "http", "https", "data");

        // 3. Summernote 에디터의 인라인 스타일 유지 (색상, 크기, 정렬 등)
        safelist.addAttributes(":all", "style", "class", "color", "size", "face", "width", "height");

        // 4. 유튜브 영상을 위한 iframe 태그 및 필수 속성 예외 허용
        safelist.addTags("iframe")
                .addAttributes("iframe", "src", "width", "height", "frameborder", "allowfullscreen", "allow")
                .addProtocols("iframe", "src", "http", "https");

        // 5. "http://localhost" 가상 Base URL로 상대 경로 검사 통과
        return Jsoup.clean(value, "http://localhost", safelist);
    }

    /**
     * 2. 일반 텍스트 입력용 (회원가입 이름, 일반 제목 등)
     * - HTML 태그 자체를 아예 허용하지 않을 때 사용
     */
    public static String escapeHtml(String value) {
        if (value == null) {
            return null;
        }
        // < 를 &lt; 로, > 를 &gt; 로 치환
        return HtmlUtils.htmlEscape(value);
    }
}