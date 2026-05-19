package org.mtf.sok.config;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.MemberDTO; // ★ 누락 방지 임포트
import org.mtf.sok.security.PrincipalDetails;
import org.mtf.sok.security.PrincipalOauth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

import java.net.URLEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                .and()
                .authorizeRequests()
                .antMatchers("/mng/login").permitAll()
                .antMatchers("/mng/**").hasAnyRole("ADMIN", "DEVELOPER")
                .antMatchers("/mypage/**").authenticated()
                .anyRequest().permitAll()
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(customAuthenticationEntryPoint())
                .accessDeniedHandler(customAccessDeniedHandler())
                .and()
                .formLogin()
                .loginPage("/login/basic")
                .loginProcessingUrl("/loginProc")
                .usernameParameter("mbrId")
                .passwordParameter("mbrPw")
                .successHandler(customSuccessHandler())
                .failureHandler(customFailureHandler())
                .and()
                .oauth2Login()
                .loginPage("/login")
                .userInfoEndpoint().userService(principalOauth2UserService)
                .and()
                .successHandler(customSuccessHandler())
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true);
        return http.build();
    }

    @Bean
    public AuthenticationEntryPoint customAuthenticationEntryPoint() {
        return (request, response, authException) -> {
            String uri = request.getRequestURI();
            response.setContentType("text/html; charset=UTF-8");

            if (uri.startsWith("/mng")) {
                response.getWriter().write("<script>alert('로그인이 필요한 페이지입니다.'); location.href='/mng/login';</script>");
            } else {
                response.getWriter().write("<script>alert('로그인이 필요한 페이지입니다.'); location.href='/login/basic';</script>");
            }
            response.getWriter().flush();
        };
    }

    @Bean
    public AccessDeniedHandler customAccessDeniedHandler() {
        return (request, response, accessDeniedException) -> {
            String uri = request.getRequestURI();
            response.setContentType("text/html; charset=UTF-8");

            if (uri.startsWith("/mng")) {
                response.getWriter().write("<script>alert('접근 권한이 없습니다.'); location.href='/mng/main';</script>");
            } else {
                response.getWriter().write("<script>alert('접근 권한이 없습니다.'); location.href='/';</script>");
            }
            response.getWriter().flush();
        };
    }

    // =========================================================================
    // [핵심 변경] 로그인 성공 핸들러 - 소셜 유저 연락처 누락 검증 로직 추가
    // =========================================================================
    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();

            // 1. 관리자 로그인인 경우
            if (principal.getAdminDTO() != null) {
                AdminDTO admin = principal.getAdminDTO();
                request.getSession().setAttribute("adminLogin", admin);
                response.sendRedirect("/mng/main");
            }
            // 2. 일반 회원(소셜 로그인 포함) 로그인인 경우
            else {
                MemberDTO member = principal.getMemberDTO();
                request.getSession().setAttribute("userLogin", member);

                // [추가된 낚아채기 로직] 전화번호가 DB에 없는 유저(최초 소셜 가입자)라면 추가 정보 창으로 강제 이동
                if (member.getPhone() == null || member.getPhone().trim().isEmpty()) {
                    response.sendRedirect("/oauth2/extraForm");
                    return; // 리다이렉트 후 바로 종료
                }

                // 기존 정상 유저라면 메인 페이지로 이동
                response.sendRedirect("/");
            }
        };
    }

    @Bean
    public AuthenticationFailureHandler customFailureHandler() {
        return (request, response, exception) -> {
            String referer = request.getHeader("Referer");
            String errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";

            if (exception.getMessage() != null && exception.getMessage().contains("허용되지 않은 IP")) {
                errorMessage = exception.getMessage();
            }

            String encodedMsg = URLEncoder.encode(errorMessage, "UTF-8");

            if (referer != null && referer.contains("/mng/login")) {
                response.sendRedirect("/mng/login?error=true&exception=" + encodedMsg);
            } else {
                response.sendRedirect("/login/basic?error=true&exception=" + encodedMsg);
            }
        };
    }
}