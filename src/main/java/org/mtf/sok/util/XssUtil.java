package org.mtf.sok.util;

public class XssUtil {

    /**
     * 에디터(Quill) 등에서 넘어오는 HTML 본문 중 악의적인 스크립트 태그 및 이벤트만 정밀 제거
     */
    public static String cleanXss(String value) {
        if (value == null || value.trim().isEmpty()) {
            return value;
        }

        // 1. <script> 태그 자체를 무효화
        value = value.replaceAll("(?i)<script.*?>.*?</script.*?>", "");
        value = value.replaceAll("(?i)<script.*?>", "");
        value = value.replaceAll("(?i)</script.*?>", "");

        // 2. javascript: 실행 방어
        value = value.replaceAll("(?i)javascript:", "x-javascript:");

        // 3. HTML 태그 내의 악의적 이벤트 핸들러(on~~) 속성 제거
        value = value.replaceAll("(?i)onload(\\s*)=", "x-onload=");
        value = value.replaceAll("(?i)onerror(\\s*)=", "x-onerror=");
        value = value.replaceAll("(?i)onclick(\\s*)=", "x-onclick=");
        value = value.replaceAll("(?i)onmouseover(\\s*)=", "x-onmouseover=");

        return value;
    }
}