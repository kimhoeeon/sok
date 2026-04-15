package org.mtf.sok.controller;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class FrontLoginController {

    @Autowired
    private MemberMapper memberMapper;

    // 1. 로그인 수단 선택 메인 화면 (개인/단체 이원화)
    @GetMapping("/login")
    public String loginMain() {
        return "member/login";
    }

    // 2. 단체 회원(일반 로그인) 폼 화면 이동
    @GetMapping("/login/basic")
    public String loginBasic(@RequestParam(value = "error", required = false) String error, Model model) {
        if(error != null) {
            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
        }
        return "member/login_basic";
    }

    // 3. 일반 로그인 DB 검증 및 세션 처리
    @PostMapping("/loginProc")
    public String loginProc(MemberDTO memberDTO, HttpSession session, RedirectAttributes rttr) {
        // 아이디, 비밀번호로 DB 조회
        MemberDTO loginUser = memberMapper.selectMemberForLogin(memberDTO);

        if (loginUser != null) {
            // 로그인 성공: 세션에 유저 정보 저장 후 메인 페이지로 이동
            session.setAttribute("userLogin", loginUser);
            return "redirect:/";
        } else {
            // 로그인 실패: 에러 메시지와 함께 다시 로그인 페이지로 이동
            rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/login/basic";
        }
    }

    // 4. 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션 정보 초기화
        session.invalidate();
        return "redirect:/";
    }

    // 5. 비밀번호 찾기 화면 이동
    @GetMapping("/findPw")
    public String findPwForm() {
        return "member/findpw";
    }

    // 6. 비밀번호 인증 및 초기화 처리 (AJAX 용)
    @PostMapping("/findPwProc")
    @ResponseBody
    public org.springframework.http.ResponseEntity<?> findPwProc(String authMethod, String phone, String email) {
        try {
            // TODO: 실제 프로젝트 환경에 맞추어 아래 로직을 구현해야 합니다.
            // 1. authMethod("phone" 또는 "email")에 따라 회원 DB 조회
            // 2. 일치하는 회원이 있으면 임시 비밀번호 생성 및 DB 업데이트
            // 3. 해당 연락처나 이메일로 알림톡/메일 발송

            System.out.println("인증방식: " + authMethod);
            System.out.println("휴대전화: " + phone);
            System.out.println("이메일: " + email);

            return org.springframework.http.ResponseEntity.ok("입력하신 연락처/이메일로 임시 비밀번호가 발송되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return org.springframework.http.ResponseEntity.internalServerError().body("처리 중 오류가 발생했습니다.");
        }
    }

}