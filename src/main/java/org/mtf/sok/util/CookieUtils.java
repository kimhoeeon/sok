package org.mtf.sok.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtils {

    /**
     * 조회수 중복 증가 방지를 위한 쿠키 검사 및 생성
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param prefix 게시판 구분자 (예: board_notice)
     * @param seq 게시글 시퀀스 (Long)
     * @return true: 이미 조회함 (업데이트 건너뜀), false: 처음 조회함 (업데이트 실행)
     */
    public static boolean checkAndViewCookie(HttpServletRequest request, HttpServletResponse response, String prefix, Long seq) {
        String cookieName = prefix + "_" + seq;
        Cookie[] cookies = request.getCookies();
        boolean isViewed = false;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    isViewed = true;
                    break;
                }
            }
        }

        if (!isViewed) {
            Cookie newCookie = new Cookie(cookieName, "Y");
            newCookie.setMaxAge(60 * 60 * 24); // 24시간 유지
            newCookie.setPath("/");
            response.addCookie(newCookie);
            return false;
        }

        return true;
    }
}