package org.mtf.sok.controller;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.mtf.sok.service.DirectSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 이메일/알림톡 연동 서비스 주입
    @Autowired
    private DirectSendService directSendService;

    // 1. 로그인 수단 선택 메인 화면 (개인/단체 이원화)
    @GetMapping("/login")
    public String loginMain() {
        return "member/login";
    }

    // 2. 단체 회원(일반 로그인) 폼 화면 이동
    @GetMapping("/login/basic")
    public String loginBasic(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
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

    // 6. 비밀번호 인증 및 초기화 처리 (AJAX) - 실제 로직 완결
    @PostMapping("/findPwProc")
    @ResponseBody
    public ResponseEntity<?> findPwProc(String authMethod, String phone, String email) {
        try {
            MemberDTO searchParam = new MemberDTO();

            // 1. 선택한 인증 수단 세팅
            if ("phone".equals(authMethod)) {
                searchParam.setPhone(phone);
            } else {
                searchParam.setEmail(email);
            }

            // 2. 가입된 회원인지 (일반 로그인 유저인지) 조회
            MemberDTO member = memberMapper.selectMemberForFindPw(searchParam);
            if (member == null) {
                return ResponseEntity.badRequest().body("입력하신 정보와 일치하는 일반 회원 내역이 없습니다.");
            }

            // 3. 임시 비밀번호 생성 (UUID에서 대시를 제외하고 앞 8자리 영문/숫자 추출)
            String tempPw = java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 8);

            // 4. 발급된 임시 비밀번호 암호화 후 DB 업데이트 (Spring Security 호환)
            member.setMbrPw(passwordEncoder.encode(tempPw));
            memberMapper.updatePassword(member);

            // 5. 알림톡 또는 이메일로 전송 (DirectSendService 활용)
            if ("phone".equals(authMethod)) {
                directSendService.sendTempPwSms(member.getPhone(), tempPw);
            } else {
                directSendService.sendTempPwMail(member.getEmail(), tempPw);
            }

            return ResponseEntity.ok("입력하신 연락처/이메일로 임시 비밀번호가 발송되었습니다.\n로그인 후 반드시 비밀번호를 변경해 주세요.");

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("처리 중 오류가 발생했습니다.");
        }
    }

}