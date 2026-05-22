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
        if (value == null) {
            return null;
        }
        // Safelist.relaxed()는 에디터에 필요한 텍스트 포맷팅과 이미지 태그 등을 허용하는 최적의 화이트리스트입니다.
        return Jsoup.clean(value, Safelist.relaxed());
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