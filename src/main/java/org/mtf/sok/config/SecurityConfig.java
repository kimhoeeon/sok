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
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.net.URLEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/admin/login").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/mypage/**").authenticated()
                .anyRequest().permitAll()
                .and()
                .formLogin()
                .loginPage("/login/basic") // 기본 로그인 페이지 설정
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

    // [성공 처리] 권한에 따른 세션 생성 및 리다이렉트 분기
    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();
            MemberDTO member = principal.getMemberDTO();

            // 1. 공통 사용자 세션 생성 (JSP에서 사용)
            request.getSession().setAttribute("userLogin", member);

            // 2. 관리자 권한 여부 확인
            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

            if (isAdmin) {
                // 관리자 전용 DTO 생성 및 세션 저장 (인터셉터 통과용)
                AdminDTO admin = new AdminDTO();
                admin.setMbrSeq(member.getMbrSeq());
                admin.setMbrId(member.getMbrId());
                admin.setMbrNm(member.getMbrNm());
                admin.setMbrRole(member.getMbrRole());

                request.getSession().setAttribute("adminLogin", admin);
                response.sendRedirect("/admin/main");
            } else {
                // 일반 사용자라면 메인으로 이동
                response.sendRedirect("/");
            }
        };
    }

    // [실패 처리] Referer 기반 로그인 페이지 분기
    @Bean
    public AuthenticationFailureHandler customFailureHandler() {
        return (request, response, exception) -> {
            String referer = request.getHeader("Referer");
            String errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";
            String encodedMsg = URLEncoder.encode(errorMessage, "UTF-8");

            // 관리자 로그인 페이지에서 온 경우
            if (referer != null && referer.contains("/admin/login")) {
                response.sendRedirect("/admin/login?error=true&exception=" + encodedMsg);
            }
            // 그 외 일반 사용자 로그인 페이지에서 온 경우
            else {
                response.sendRedirect("/login/basic?error=true&exception=" + encodedMsg);
            }
        };
    }
}