package org.mtf.sok.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException {

        String requestURI = request.getRequestURI();

        // 요청된 로그아웃 주소가 관리자 로그아웃(/mng/logout)인 경우
        if (requestURI != null && requestURI.contains("/mng/logout")) {
            response.sendRedirect("/mng/login");
        }
        // 요청된 로그아웃 주소가 일반 사용자 로그아웃(/logout)인 경우
        else {
            response.sendRedirect("/");
        }
    }
}