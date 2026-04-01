package org.mtf.sok.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import javax.annotation.PostConstruct;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    // 비밀번호 암호화 인코더 빈 등록
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // ★ [임시 추가] 서버가 시작될 때 진짜 BCrypt 해시값을 콘솔에 출력해줍니다.
    /*@PostConstruct
    public void generateRealPasswords() {
        PasswordEncoder encoder = new BCryptPasswordEncoder();
        System.out.println("\n========================================================");
        System.out.println("🔑 [sokadmin] 진짜 해시값: " + encoder.encode("fan2sok12!@"));
        System.out.println("🔑 [meetingfan] 진짜 해시값: " + encoder.encode("fan2web12!@"));
        System.out.println("========================================================\n");
    }*/

    // 기존 Interceptor 구조 보존을 위해 Security 웹 필터 무력화
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf().disable() // 기존 개발 환경 유지를 위해 CSRF 비활성화
                .authorizeRequests()
                .anyRequest().permitAll() // 모든 요청 통과 (권한 제어는 기존 Interceptor가 수행)
                .and()
                .formLogin().disable() // Security 기본 로그인 창 끄기
                .headers().frameOptions().sameOrigin(); // iframe 허용 (에디터 등에서 사용될 수 있음)

        return http.build();
    }
}