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
                .antMatchers("/mypage/**").authenticated() // 마이페이지 보안
                .anyRequest().permitAll()
                .and()
                .formLogin()
                .loginPage("/login/basic")
                .loginProcessingUrl("/loginProc") // 시큐리티가 가로챔
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

    // ★ 성공 시 기존 JSP와의 호환을 위해 세션에 userLogin 주입
    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return (request, response, authentication) -> {
            PrincipalDetails principal = (PrincipalDetails) authentication.getPrincipal();
            request.getSession().setAttribute("userLogin", principal.getMemberDTO());
            response.sendRedirect("/");
        };
    }
}