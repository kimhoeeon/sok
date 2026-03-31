package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.service.AdminService;
import org.mtf.sok.util.RequestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/login")
    public String loginForm() {
        return "admin/login";
    }

    @PostMapping("/loginProc")
    public String loginProc(@RequestParam String mbrId,
                            @RequestParam String mbrPw,
                            HttpServletRequest request,
                            RedirectAttributes rttr) {

        String clientIp = RequestUtils.getClientIp(request);

        try {
            AdminDTO admin = adminService.loginCheck(mbrId, mbrPw, clientIp);
            HttpSession session = request.getSession();
            session.setAttribute("adminLogin", admin);

            return "redirect:/admin/main";

        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/login";
        }
    }

    @GetMapping("/main")
    public String adminMain() {
        return "admin/main";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
}