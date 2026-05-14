package org.mtf.sok.config;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.security.PrincipalDetails;
import org.mtf.sok.security.PrincipalOauth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.net.URLEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf().disable() // 현재 AJAX 폼 구조 유지를 위해 비활성화
                .authorizeRequests()
                .antMatchers("/mng/login").permitAll() // 관리자 로그인 화면은 누구나 접근 가능
                .antMatchers("/mng/**").hasRole("ADMIN") // 핵심: 관리자 폴더 하위는 ADMIN 권한 필수
                .antMatchers("/mypage/**").authenticated() // 마이페이지는 일반 로그인 이상
                .anyRequest().permitAll()
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(customAuthenticationEntryPoint())
                .accessDeniedHandler(customAccessDeniedHandler())
                .and()
                .formLogin()
                // Spring Security가 가로챌 공통 로그인 처리 URL
                .loginPage("/login/basic")
                .loginProcessingUrl("/loginProc")
                .usernameParameter("mbrId")
                .passwordParameter("mbrPw")
                .successHandler(customSuccessHandler())
                .failureHandler(customFailureHandler()) // 권한별 에러 페이지 분기 처리 핸들러
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

    // [핵심 추가 1] 세션이 끊기거나 로그인이 안 된 상태에서의 접근 통제
    @Bean
    public AuthenticationEntryPoint customAuthenticationEntryPoint() {
        return (request, response, authException) -> {
            String uri = request.getRequestURI();
            response.setContentType("text/html; charset=UTF-8");

            // 관리자 경로 접근 중 세션 만료 시
            if (uri.startsWith("/mng")) {
                response.getWriter().write("<script>alert('로그인이 필요한 페이지입니다.'); location.href='/mng/login';</script>");
            } else {
                // 일반 사용자 경로 접근 중 세션 만료 시
                response.getWriter().write("<script>alert('로그인이 필요한 페이지입니다.'); location.href='/login/basic';</script>");
            }
            response.getWriter().flush();
        };
    }

    // [핵심 추가 2] 로그인은 되어 있으나 권한이 없을 때 (예: 일반 회원이 관리자 페이지 접근 시)
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
    // 권한별 로그인 성공 핸들러 (사용자와 관리자 분기 처리)
    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();

            // 관리자 로그인인 경우
            if (principal.getAdminDTO() != null) {
                AdminDTO admin = principal.getAdminDTO();
                request.getSession().setAttribute("adminLogin", admin);

                // [보완] 기존 JSP 호환을 위해 userLogin 세션에도 필수 데이터를 모두 채워줌
                MemberDTO dummyMember = new MemberDTO();
                dummyMember.setMbrSeq(admin.getAdmSeq()); // 추가: PK 매핑
                dummyMember.setMbrId(admin.getAdmId());
                dummyMember.setMbrNm(admin.getAdmNm());
                dummyMember.setMbrRole(admin.getAdmRole()); // 추가: 권한 매핑
                request.getSession().setAttribute("userLogin", dummyMember);

                response.sendRedirect("/mng/main");
            }
            // 일반 회원 로그인인 경우
            else {
                request.getSession().setAttribute("userLogin", principal.getMemberDTO());
                response.sendRedirect("/");
            }
        };
    }

    // 권한별 로그인 실패 핸들러
    @Bean
    public AuthenticationFailureHandler customFailureHandler() {
        return (request, response, exception) -> {
            String referer = request.getHeader("Referer");
            String errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";

            // IP 차단 예외일 경우 해당 메시지로 덮어씌움
            if (exception.getMessage() != null && exception.getMessage().contains("허용되지 않은 IP")) {
                errorMessage = exception.getMessage();
            }

            // 한글 에러 메시지가 깨지지 않도록 URL 인코딩
            String encodedMsg = URLEncoder.encode(errorMessage, "UTF-8");

            // 요청이 들어온 이전 페이지(Referer)를 분석하여 어디로 돌려보낼지 결정
            if (referer != null && referer.contains("/mng/login")) {
                // 관리자 페이지에서 시도했다면 관리자 로그인 페이지로 반환
                response.sendRedirect("/mng/login?error=true&exception=" + encodedMsg);
            } else {
                // 일반 사용자 페이지에서 시도했다면 프론트 로그인 페이지로 반환
                response.sendRedirect("/login/basic?error=true&exception=" + encodedMsg);
            }
        };
    }
}