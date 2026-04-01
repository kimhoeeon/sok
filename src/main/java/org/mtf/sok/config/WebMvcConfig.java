package org.mtf.sok.config;

import org.mtf.sok.interceptor.LoginInterceptor;
import org.mtf.sok.interceptor.VisitorInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private LoginInterceptor loginInterceptor;

    @Autowired
    private VisitorInterceptor visitorInterceptor;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        // 1. 관리자 로그인 인터셉터 (new 객체 생성이 아닌 주입받은 빈 객체 사용)
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/admin/login", "/admin/loginProc", "/css/**", "/js/**", "/images/**", "/img/**");

        // 2. 방문자 접속 로그 수집 인터셉터 (누락된 부분 추가)
        registry.addInterceptor(visitorInterceptor)
                .addPathPatterns("/**")
                // 관리자 페이지, API, 정적 파일(css, js, img 등)은 방문자 카운트에서 제외
                .excludePathPatterns("/admin/**", "/api/**", "/css/**", "/js/**", "/img/**", "/images/**", "/upload/**", "/favicon.ico", "/error");
    }

    // WAR 내부가 아닌 외부 폴더(/tomcat/webapps/upload/)를 정적 리소스 경로로 연결
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:///" + uploadDir);
    }
}