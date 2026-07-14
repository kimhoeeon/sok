package org.mtf.sok.util;

import java.util.stream.IntStream;

public class EmojiStripper {
    public static String stripEmoji(String s) {
        if (s == null || s.isEmpty()) return s;

        StringBuilder sb = new StringBuilder(s.length());
        IntStream codePoints = s.codePoints();

        codePoints.forEach(cp -> {
            if (!isEmojiOrEmojiCombiner(cp)) {
                sb.appendCodePoint(cp);
            }
        });
        return sb.toString();
    }

    // 이모지/조합용 문자인지 판별
    private static boolean isEmojiOrEmojiCombiner(int cp) {
        // 기본 이모지 블록들 (완전 포괄은 아니지만 실무에 충분)
        if (
                (cp >= 0x1F300 && cp <= 0x1F5FF) || // Misc Symbols and Pictographs
                        (cp >= 0x1F600 && cp <= 0x1F64F) || // Emoticons
                        (cp >= 0x1F680 && cp <= 0x1F6FF) || // Transport & Map
                        (cp >= 0x1F700 && cp <= 0x1F77F) || // Alchemical Symbols
                        (cp >= 0x1F780 && cp <= 0x1F7FF) || // Geometric Shapes Extended
                        (cp >= 0x1F800 && cp <= 0x1F8FF) || // Supplemental Arrows-C (드묾)
                        (cp >= 0x1F900 && cp <= 0x1F9FF) || // Supplemental Symbols and Pictographs
                        (cp >= 0x1FA00 && cp <= 0x1FAFF) || // Symbols & Pictographs Extended-A (사물·사람 추가)
                        (cp >= 0x2600  && cp <= 0x26FF ) || // Misc Symbols (☀☂♿ 등)
                        (cp >= 0x2700  && cp <= 0x27BF )    // Dingbats (✂✈✔ 등)
        ) return true;

        // 지역 표시자(국기)
        if (cp >= 0x1F1E6 && cp <= 0x1F1FF) return true;

        // 피부색 모디파이어
        if (cp >= 0x1F3FB && cp <= 0x1F3FF) return true;

        // 키캡 결합 문자 (0-9#* + 20E3)
        if (cp == 0x20E3) return true;

        // ZWJ로 조합되는 이모지 시퀀스(걍 제거해 끊어버림)
        if (cp == 0x200D) return true;

        // Variation Selector-16 (텍스트→이모지 표현 강제)
        if (cp == 0xFE0F || cp == 0xFE0E) return true;

        // 태그 시퀀스(서브태그 깃발 등)
        if (cp >= 0xE0020 && cp <= 0xE007F) return true;

        // 기타 기호(So)로 분류된 것도 이모지로 쓰이는 경우가 많음 (너무 과감하면 일반 기호까지 날아가니 비활성)
        // int type = Character.getType(cp);
        // if (type == Character.OTHER_SYMBOL) return true;

        return false;
    }
}