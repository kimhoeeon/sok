package org.mtf.sok.config;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.security.CustomLogoutSuccessHandler; // 핸들러 임포트 추가
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
import org.springframework.security.web.util.matcher.AntPathRequestMatcher; // 매처 임포트 추가
import org.springframework.security.web.util.matcher.OrRequestMatcher;      // 매처 임포트 추가

import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    @Autowired
    private CustomLogoutSuccessHandler customLogoutSuccessHandler;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                .and()
                .authorizeRequests()
                .antMatchers("/mng/login", "/common/loginProc", "/css/**", "/js/**", "/images/**", "/img/**").permitAll()
                .antMatchers("/mng/**").hasAnyRole("ADMIN", "DEVELOPER")
                .antMatchers("/mypage/**").authenticated()
                .anyRequest().permitAll()
                .and()
                .formLogin()
                .loginPage("/mng/login")
                .loginProcessingUrl("/common/loginProc")
                .successHandler(customSuccessHandler())
                .failureHandler(customFailureHandler())
                .and()
                .oauth2Login()
                .loginPage("/login/basic")
                .successHandler(customSuccessHandler())
                .userInfoEndpoint()
                .userService(principalOauth2UserService);

        // 다중 로그아웃 엔드포인트를 완벽하게 지원하는 시큐리티 로그아웃 설정 체인
        http.logout()
                .logoutRequestMatcher(new OrRequestMatcher(
                        new AntPathRequestMatcher("/logout", "POST"),     // 사용자 로그아웃 가로채기
                        new AntPathRequestMatcher("/mng/logout", "POST") // 관리자 로그아웃 가로채기
                ))
                .logoutSuccessHandler(customLogoutSuccessHandler) // 위에서 판별 후 각각 리다이렉트 실행
                .invalidateHttpSession(true)                      // 세션 무효화 기본 수행
                .clearAuthentication(true)                       // 인증 컨텍스트 휘발
                .deleteCookies("JSESSIONID");                    // 톰캣 세션 쿠키 삭제

        http.exceptionHandling()
                .authenticationEntryPoint(customAuthenticationEntryPoint())
                .accessDeniedHandler(customAccessDeniedHandler());

        return http.build();
    }

    @Bean
    public AuthenticationEntryPoint customAuthenticationEntryPoint() {
        return (request, response, authException) -> {
            // AJAX 요청 여부 판별 (jQuery 등 대부분의 비동기 통신 라이브러리가 헤더에 포함)
            String ajaxHeader = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

            if (isAjax) {
                // 비동기 요청일 경우 401 에러 반환
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
            } else {
                // 일반 요청일 경우 기존처럼 스크립트 알럿 처리 (단, location.replace 사용)
                String requestURI = request.getRequestURI();
                response.setContentType("text/html; charset=UTF-8");
                if (requestURI != null && requestURI.startsWith("/mng")) {
                    response.getWriter().println("<script>alert('관리자 로그인이 필요한 서비스입니다.'); location.replace('/mng/login');</script>");
                } else {
                    response.getWriter().println("<script>alert('로그인이 필요한 서비스입니다.'); location.replace('/login/basic?redirect=" + requestURI + "');</script>");
                }
                response.getWriter().flush();
            }
        };
    }

    @Bean
    public AccessDeniedHandler customAccessDeniedHandler() {
        return (request, response, accessDeniedException) -> {
            // AJAX 요청 여부 판별
            String ajaxHeader = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

            if (isAjax) {
                // 비동기 요청일 경우 403 에러 반환
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "접근 권한이 없습니다.");
            } else {
                response.setContentType("text/html; charset=UTF-8");
                String requestURI = request.getRequestURI();

                // 접근하려던 목적지가 관리자(/mng) 경로인 경우 관리자 로그인으로 쫓아냄
                if (requestURI != null && requestURI.startsWith("/mng")) {
                    response.getWriter().println("<script>alert('관리자 권한이 필요한 페이지입니다.'); location.replace('/mng/login');</script>");
                } else {
                    // 그 외 사용자 프론트 페이지 내에서의 권한 부족인 경우 프론트 메인으로 쫓아냄
                    response.getWriter().println("<script>alert('해당 페이지에 대한 접근 권한이 없습니다.'); location.replace('/');</script>");
                }
                response.getWriter().flush();
            }
        };
    }

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();

            if (principal.getAdminDTO() != null) {
                AdminDTO admin = principal.getAdminDTO();
                request.getSession().setAttribute("adminLogin", admin);
                response.sendRedirect("/mng/main");
            } else {
                MemberDTO member = principal.getMemberDTO();
                request.getSession().setAttribute("userLogin", member);

                if (member.getPhone() == null || member.getPhone().trim().isEmpty()) {
                    response.sendRedirect("/oauth2/extraForm");
                    return;
                }

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