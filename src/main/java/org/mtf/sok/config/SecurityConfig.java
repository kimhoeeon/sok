package org.mtf.sok.config;

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
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.annotation.PostConstruct;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    // 비밀번호 암호화 인코더 빈 등록
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // 서버가 시작될 때 진짜 BCrypt 해시값을 콘솔에 출력해줍니다.
    /*@PostConstruct
    public void generateRealPasswords() {
        PasswordEncoder encoder = new BCryptPasswordEncoder();
        System.out.println("\n========================================================");
        System.out.println("🔑 [sokadmin] 진짜 해시값: " + encoder.encode("fan2sok12!@"));
        System.out.println("🔑 [meetingfan] 진짜 해시값: " + encoder.encode("fan2web12!@"));
        System.out.println("========================================================\n");
    }*/

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
                .failureUrl("/login/basic?error=true")
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

            // JSP에서 기존처럼 ${sessionScope.userLogin} 을 사용할 수 있도록 세션에 담기
            request.getSession().setAttribute("userLogin", principal.getMemberDTO());

            // 현재 로그인한 사용자가 'ADMIN' 권한을 가지고 있는지 확인
            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

            if (isAdmin) {
                // 관리자 계정이면 관리자 메인 페이지로 이동
                response.sendRedirect("/admin/main");
            } else {
                // 일반 사용자면 프론트 메인 페이지로 이동
                response.sendRedirect("/");
            }
        };
    }
}