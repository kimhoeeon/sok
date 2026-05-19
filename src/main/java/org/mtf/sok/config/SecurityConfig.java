package org.mtf.sok.config;

import org.mtf.sok.domain.AdminDTO;
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
        // CSRF 방어를 활성화하되, AJAX 통신에서 JS가 쿠키로 토큰을 읽을 수 있도록 설정 (JSP/JS 환경 최적화)
        http.csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                .and()
                .authorizeRequests()
                .antMatchers("/mng/login").permitAll()
                .antMatchers("/mng/**").hasRole("ADMIN")
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
                response.getWriter().write("<script>alert('관리자 권한이 없습니다.'); location.href='/';</script>");
            } else {
                response.getWriter().write("<script>alert('접근 권한이 없습니다.'); location.href='/';</script>");
            }
            response.getWriter().flush();
        };
    }

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();

            if (principal.getAdminDTO() != null) {
                AdminDTO admin = principal.getAdminDTO();
                request.getSession().setAttribute("adminLogin", admin);

                // 데이터 무결성을 위해 일반 회원 권한(userLogin) 더미 세션을 주입하던 로직 전면 제거

                response.sendRedirect("/mng/main");
            }
            else {
                request.getSession().setAttribute("userLogin", principal.getMemberDTO());
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