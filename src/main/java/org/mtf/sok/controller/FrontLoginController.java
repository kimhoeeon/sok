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

    @Autowired
    private DirectSendService directSendService;

    @GetMapping("/login")
    public String loginMain() {
        return "member/login";
    }

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

    @PostMapping("/loginProc")
    public String loginProc(MemberDTO memberDTO, HttpSession session, RedirectAttributes rttr) {
        MemberDTO loginUser = memberMapper.selectMemberForLogin(memberDTO);

        if (loginUser != null) {
            session.setAttribute("userLogin", loginUser);
            return "redirect:/";
        } else {
            rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/login/basic";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/findPw")
    public String findPwForm() {
        return "member/findpw";
    }

    @PostMapping("/findPwProc")
    @ResponseBody
    public ResponseEntity<?> findPwProc(String authMethod, String phone, String email) {
        try {
            MemberDTO searchParam = new MemberDTO();

            if ("phone".equals(authMethod)) {
                searchParam.setPhone(phone);
            } else {
                searchParam.setEmail(email);
            }

            MemberDTO member = memberMapper.selectMemberForFindPw(searchParam);
            if (member == null) {
                return ResponseEntity.badRequest().body("입력하신 정보와 일치하는 일반 회원 내역이 없습니다.");
            }

            String tempPw = generateSecureTempPassword();

            member.setMbrPw(passwordEncoder.encode(tempPw));

            memberMapper.updatePassword(member);

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

    private String generateSecureTempPassword() {
        String upperCase = "ABCDEFGHJKMNPQRSTUVWXYZ";
        String lowerCase = "abcdefghjkmnpqrstuvwxyz";
        String numbers = "23456789";
        String specialChars = "!@#$%^&*";
        String combinedChars = upperCase + lowerCase + numbers + specialChars;

        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(10);

        // 보안 정책을 위해 각 유형별로 최소 1글자씩 무작위로 먼저 뽑아서 조합
        password.append(lowerCase.charAt(random.nextInt(lowerCase.length())));
        password.append(upperCase.charAt(random.nextInt(upperCase.length())));
        password.append(numbers.charAt(random.nextInt(numbers.length())));
        password.append(specialChars.charAt(random.nextInt(specialChars.length())));

        // 10자리 중 나머지 6자리를 전체 문자열에서 무작위로 채움
        for(int i = 4; i < 10; i++) {
            password.append(combinedChars.charAt(random.nextInt(combinedChars.length())));
        }

        // 특정 패턴이 유추되지 않도록 배열에 담아 순서를 무작위로 섞음 (Shuffle)
        char[] passwordArray = password.toString().toCharArray();
        for (int i = passwordArray.length - 1; i > 0; i--) {
            int j = random.nextInt(i + 1);
            char temp = passwordArray[i];
            passwordArray[i] = passwordArray[j];
            passwordArray[j] = temp;
        }

        return new String(passwordArray);
    }

    // =====================================================================
    // [신규 추가] 소셜 로그인 연동 시 연락처 누락 유저 추가 정보 입력 처리
    // =====================================================================

    // 1. 소셜 로그인 추가 정보 입력 폼 페이지 이동
    @GetMapping("/oauth2/extraForm")
    public String oauth2ExtraForm(HttpSession session) {
        // 로그인이 안 되어있으면 튕겨냄
        if (session.getAttribute("userLogin") == null) {
            return "redirect:/login";
        }
        return "member/oauth2_extra";
    }

    // 2. 추가 정보(연락처 및 마케팅 동의) DB 업데이트 처리
    @PostMapping("/oauth2/extraProc")
    @ResponseBody
    public ResponseEntity<?> oauth2ExtraProc(@RequestParam String phone,
                                             @RequestParam(required = false) String marketingYn,
                                             HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("세션이 만료되었습니다. 다시 로그인해 주세요.");
        }

        try {
            // 체크박스 해제 시 넘어오는 null 방어
            if(marketingYn == null) {
                marketingYn = "N";
            }

            // DTO에 받은 값 세팅
            loginUser.setPhone(phone);
            loginUser.setMarketingYn(marketingYn);

            // DB 업데이트 수행
            memberMapper.updateMemberProfile(loginUser);

            // 업데이트된 최신 정보로 세션 다시 갱신 (전화번호가 제대로 채워짐)
            MemberDTO updatedUser = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
            session.setAttribute("userLogin", updatedUser);

            return ResponseEntity.ok("정보 등록이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("정보 업데이트 중 오류가 발생했습니다.");
        }
    }
}