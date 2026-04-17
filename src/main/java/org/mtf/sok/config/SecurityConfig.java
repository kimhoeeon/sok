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
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf().disable() // 현재 AJAX 폼 구조 유지를 위해 비활성화
                .authorizeRequests()
                .antMatchers("/admin/login").permitAll() // 관리자 로그인 화면은 누구나 접근 가능
                .antMatchers("/admin/**").hasRole("ADMIN") // 핵심: 관리자 폴더 하위는 ADMIN 권한 필수
                .antMatchers("/mypage/**").authenticated() // 마이페이지는 일반 로그인 이상
                .anyRequest().permitAll()
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

    // 권한별 로그인 성공 핸들러 (사용자와 관리자 분기 처리)
    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();
            MemberDTO member = principal.getMemberDTO();

            // JSP에서 기존처럼 ${sessionScope.userLogin} 을 사용할 수 있도록 세션에 담기
            request.getSession().setAttribute("userLogin", member);

            // 현재 로그인한 사용자가 'ADMIN' 권한을 가지고 있는지 확인
            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

            if (isAdmin) {
                // LoginInterceptor 및 AdminController가 요구하는 adminLogin 세션 객체 생성 및 주입
                AdminDTO admin = new AdminDTO();
                admin.setMbrSeq(member.getMbrSeq());
                admin.setMbrId(member.getMbrId());
                admin.setMbrPw(member.getMbrPw());
                admin.setMbrNm(member.getMbrNm());
                admin.setMbrRole(member.getMbrRole());

                request.getSession().setAttribute("adminLogin", admin);

                // 관리자 계정이면 관리자 메인 페이지로 이동
                response.sendRedirect("/admin/main");
            } else {
                // 일반 사용자면 프론트 메인 페이지로 이동
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

            // 한글 에러 메시지가 깨지지 않도록 URL 인코딩
            String encodedMsg = URLEncoder.encode(errorMessage, "UTF-8");

            // 요청이 들어온 이전 페이지(Referer)를 분석하여 어디로 돌려보낼지 결정
            if (referer != null && referer.contains("/admin/login")) {
                // 관리자 페이지에서 시도했다면 관리자 로그인 페이지로 반환
                response.sendRedirect("/admin/login?error=true&exception=" + encodedMsg);
            } else {
                // 일반 사용자 페이지에서 시도했다면 프론트 로그인 페이지로 반환
                response.sendRedirect("/login/basic?error=true&exception=" + encodedMsg);
            }
        };
    }
}