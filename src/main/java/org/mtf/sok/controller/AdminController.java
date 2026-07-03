package org.mtf.sok.controller;

import org.mtf.sok.mapper.StatsMapper;
import org.mtf.sok.security.PrincipalDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/mng")
public class AdminController {

    @Autowired
    private StatsMapper statsMapper;

    // 관리자 로그인 화면 이동
    public String login(@AuthenticationPrincipal PrincipalDetails principalDetails,
                        @RequestParam(value = "error", required = false) String error,
                        @RequestParam(value = "exception", required = false) String exception,
                        Model model) {

        // 시큐리티 컨텍스트에 관리자 정보가 이미 존재하면 메인으로 튕겨냄
        if (principalDetails != null && principalDetails.getAdminDTO() != null) {
            return "redirect:/mng/main";
        }

        // 실패 시 전달된 메시지를 화면으로 전달
        if (error != null && exception != null) {
            model.addAttribute("errorMessage", exception);
        }
        return "mng/login";
    }

    // =========================================================
    // 관리자 대시보드 (방문 통계 및 요약 위젯 데이터 세팅)
    // =========================================================
    @GetMapping({"", "/", "/main"})
    public String main(Model model) {
        boolean dbStatus = false;
        try {
            // 1. DB 핑(Ping) 테스트
            if (statsMapper.checkDbConnection() == 1) {
                dbStatus = true;

                // DB가 정상일 때만 통계 데이터를 조회하여 담음
                model.addAttribute("summary", statsMapper.selectSummaryStats());
                model.addAttribute("topPages", statsMapper.selectTopPages());
            }
        } catch (Exception e) {
            // DB가 다운되었을 경우, 에러를 삼키고 빈 데이터를 넘겨 화면 렌더링을 보호함 (500 에러 방지)
            dbStatus = false;
            model.addAttribute("summary", new java.util.HashMap<>());
            model.addAttribute("topPages", new java.util.ArrayList<>());
            System.err.println("대시보드 로딩 중 DB 연결 실패: " + e.getMessage());
        }

        model.addAttribute("dbStatus", dbStatus);

        // 3. JVM 메모리 상태 (DB가 죽어도 웹 서버가 살아있으면 정상 출력됨)
        Runtime runtime = Runtime.getRuntime();
        long totalMem = runtime.totalMemory();
        long freeMem = runtime.freeMemory();
        long usedMem = totalMem - freeMem;
        double memUsagePercent = ((double) usedMem / totalMem) * 100;

        model.addAttribute("jvmUsage", String.format("%.1f", memUsagePercent));
        model.addAttribute("jvmTotalMB", totalMem / (1024 * 1024));
        model.addAttribute("jvmUsedMB", usedMem / (1024 * 1024));

        // 4. 서버 가동 시간(Uptime) 및 Java 버전
        java.lang.management.RuntimeMXBean runtimeBean = java.lang.management.ManagementFactory.getRuntimeMXBean();
        long uptimeHours = runtimeBean.getUptime() / (1000 * 60 * 60);
        long uptimeDays = uptimeHours / 24;
        String uptimeStr = uptimeDays > 0 ? uptimeDays + "일 " + (uptimeHours % 24) + "시간" : uptimeHours + "시간";

        model.addAttribute("jvmUptime", uptimeStr);
        model.addAttribute("javaVersion", System.getProperty("java.version"));

        return "mng/main";
    }

}