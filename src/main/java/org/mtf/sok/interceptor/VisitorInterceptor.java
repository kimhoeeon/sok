package org.mtf.sok.interceptor;

import org.mtf.sok.mapper.StatsMapper;
import org.mtf.sok.util.RequestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class VisitorInterceptor implements HandlerInterceptor {

    @Autowired
    private StatsMapper statsMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String userAgent = request.getHeader("User-Agent");

        // 1. 봇(Bot) 필터링: 검색 엔진 봇이나 스캐너 등의 접근은 DB 로그를 남기지 않음
        if (userAgent != null) {
            String agentLower = userAgent.toLowerCase();
            if (agentLower.contains("bot") || agentLower.contains("spider") ||
                    agentLower.contains("crawl") || agentLower.contains("yeti") ||
                    agentLower.contains("google") || agentLower.contains("bing") ||
                    agentLower.contains("jira") || agentLower.contains("slurp")) {
                return true; // 봇이면 로그 수집 로직을 건너뛰고 바로 요청 처리
            }
        }

        HttpSession session = request.getSession();

        // 2. 세션에 'hasVisited' 플래그가 없으면 (새로운 실제 사용자면) DB에 로그를 남김
        if (session.getAttribute("hasVisited") == null) {
            String clientIp = RequestUtils.getClientIp(request);

            // User-Agent 값이 DB 컬럼 크기를 초과하지 않도록 자르기
            if (userAgent != null && userAgent.length() > 250) {
                userAgent = userAgent.substring(0, 250);
            }

            try {
                statsMapper.insertVisitLog(clientIp, userAgent);
            } catch (Exception e) {
                // DB 인서트에 실패하더라도 사용자의 페이지 접속 자체를 막으면 안 되므로 예외만 출력
                e.printStackTrace();
            }

            // 로그를 남겼으므로 세션에 플래그 설정 (중복 카운트 방지)
            session.setAttribute("hasVisited", true);
        }

        return true;
    }
}