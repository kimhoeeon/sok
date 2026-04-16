package org.mtf.sok.controller;

import org.mtf.sok.mapper.StatsMapper;
import org.mtf.sok.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StatsMapper statsMapper;

    // 관리자 로그인 화면 이동
    @GetMapping("/login")
    public String login(HttpSession session,
                        @RequestParam(value = "error", required = false) String error,
                        @RequestParam(value = "exception", required = false) String exception,
                        Model model) {

        if (session.getAttribute("adminLogin") != null) {
            return "redirect:/admin/main";
        }

        // 실패 시 전달된 메시지를 화면으로 전달
        if (error != null && exception != null) {
            model.addAttribute("errorMessage", exception);
        }
        return "admin/login";
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("adminLogin");
        session.invalidate();
        return "redirect:/admin/login";
    }

    // =========================================================
    // 관리자 대시보드 (방문 통계 및 요약 위젯 데이터 세팅)
    // =========================================================
    @GetMapping({"", "/", "/main"})
    public String main(HttpSession session, Model model) {
        if (session.getAttribute("adminLogin") == null) {
            return "redirect:/admin/login";
        }

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

        return "admin/main";
    }

    // =========================================================
    // 차트용 데이터 API (Base64 인코딩 깨짐 완벽 해결)
    // =========================================================
    @GetMapping("/api/stats/visitor")
    @ResponseBody
    public List<Map<String, Object>> getVisitorStats(@RequestParam String period) {
        List<Map<String, Object>> list = statsMapper.selectVisitorTrend(period);
        return fixBase64Label(list);
    }

    @GetMapping("/api/stats/apply")
    @ResponseBody
    public List<Map<String, Object>> getApplyStats(@RequestParam String period) {
        List<Map<String, Object>> list = statsMapper.selectApplyTrend(period);
        return fixBase64Label(list);
    }

    // [핵심 해결 로직] Key 대소문자 상관없이 Map 안에 있는 모든 byte[]를 String으로 강제 변환
    private List<Map<String, Object>> fixBase64Label(List<Map<String, Object>> list) {
        for (Map<String, Object> map : list) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                // MyBatis가 어떤 Key 이름으로 반환하든 값이 byte[] (이진 데이터)이면 문자열로 덮어씀
                if (entry.getValue() instanceof byte[]) {
                    map.put(entry.getKey(), new String((byte[]) entry.getValue()));
                }
            }
        }
        return list;
    }
}