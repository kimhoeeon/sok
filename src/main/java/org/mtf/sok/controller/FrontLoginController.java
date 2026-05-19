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
import java.security.SecureRandom;

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
    public String loginBasic(HttpSession session,
                             @RequestParam(value = "error", required = false) String error,
                             @RequestParam(value = "exception", required = false) String exception,
                             Model model) {

        if (session.getAttribute("userLogin") != null) {
            return "redirect:/";
        }

        if (error != null && exception != null) {
            model.addAttribute("errorMessage", exception);
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

            String tempPw = generateSecureTempPassword();

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

    // 보안 규칙에 맞는 10자리 복합 임시 비밀번호 생성 헬퍼
    private String generateSecureTempPassword() {
        String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCase = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String specialChars = "!@#$%^&*";
        String combinedChars = upperCase + lowerCase + numbers + specialChars;

        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(10);

        // 정규식 통과를 보장하기 위해 각 문자열 세트에서 최소 1자씩 추출
        password.append(lowerCase.charAt(random.nextInt(lowerCase.length())));
        password.append(upperCase.charAt(random.nextInt(upperCase.length())));
        password.append(numbers.charAt(random.nextInt(numbers.length())));
        password.append(specialChars.charAt(random.nextInt(specialChars.length())));

        // 나머지 6자리는 섞어서 추출
        for(int i = 4; i < 10; i++) {
            password.append(combinedChars.charAt(random.nextInt(combinedChars.length())));
        }

        // 특정 패턴을 피하기 위해 단순 배열 섞기(셔플링)
        char[] passwordArray = password.toString().toCharArray();
        for (int i = passwordArray.length - 1; i > 0; i--) {
            int j = random.nextInt(i + 1);
            char temp = passwordArray[i];
            passwordArray[i] = passwordArray[j];
            passwordArray[j] = temp;
        }

        return new String(passwordArray);
    }

}