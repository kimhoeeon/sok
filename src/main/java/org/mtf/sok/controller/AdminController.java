package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.mapper.DevMapper;
import org.mtf.sok.mapper.StatsMapper;
import org.mtf.sok.service.AdminService;
import org.mtf.sok.util.RequestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.lang.management.ManagementFactory;
import com.sun.management.OperatingSystemMXBean;

import java.lang.management.RuntimeMXBean;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private StatsMapper statsMapper;

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String loginForm(HttpSession session, HttpServletResponse response) {

        // 브라우저 캐시(BFCache) 완전 차단 헤더 설정
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // 이미 로그인된 상태면 메인으로 리다이렉트
        if (session.getAttribute("adminLogin") != null) {
            return "redirect:/admin/main";
        }
        return "admin/login";
    }

    // 로그인 및 허용 IP 체크 처리
    @PostMapping("/loginProc")
    public String loginProc(@RequestParam String mbrId,
                            @RequestParam String mbrPw,
                            HttpServletRequest request,
                            RedirectAttributes rttr) {

        // 고객님이 작성하신 RequestUtils를 통한 클라이언트 IP 추출
        String clientIp = RequestUtils.getClientIp(request);

        try {
            // IP 검증이 포함된 기존 서비스 로직 정상 호출
            AdminDTO admin = adminService.loginCheck(mbrId, mbrPw, clientIp);
            HttpSession session = request.getSession();
            session.setAttribute("adminLogin", admin);

            return "redirect:/admin/main";

        } catch (Exception e) {
            // 예외 발생 시 에러 메시지를 alert 등으로 띄우기 위해 rttr에 담아 반환
            rttr.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/login";
        }
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

        // 1. DB 실제 연결 상태 체크
        boolean dbStatus = false;
        try {
            if(statsMapper.checkDbConnection() == 1) dbStatus = true;
        } catch (Exception e) {
            dbStatus = false;
        }
        model.addAttribute("dbStatus", dbStatus);

        // 2. DB 실제 요약 통계 및 TOP 5 연동
        model.addAttribute("summary", statsMapper.selectSummaryStats());
        model.addAttribute("topPages", statsMapper.selectTopPages());

        // 3. JVM 메모리 상태
        Runtime runtime = Runtime.getRuntime();
        long totalMem = runtime.totalMemory();
        long freeMem = runtime.freeMemory();
        long usedMem = totalMem - freeMem;
        double memUsagePercent = ((double) usedMem / totalMem) * 100;

        model.addAttribute("jvmUsage", String.format("%.1f", memUsagePercent));
        model.addAttribute("jvmTotalMB", totalMem / (1024 * 1024));
        model.addAttribute("jvmUsedMB", usedMem / (1024 * 1024));

        // 4. 서버 가동 시간(Uptime) 및 Java 버전
        RuntimeMXBean runtimeBean = ManagementFactory.getRuntimeMXBean();
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