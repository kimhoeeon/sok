package org.mtf.sok.controller;

import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.DonationMapper;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/mypage")
public class FrontMypageController {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private DonationMapper donationMapper;

    // 1. 마이페이지 (프로필 수정 화면)
    @GetMapping("/info")
    public String mypageInfo(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");

        // 로그인 체크
        if (loginUser == null) {
            return "redirect:/login";
        }

        return "mypage/info";
    }

    // 2. 프로필 수정 처리 (AJAX)
    @PostMapping("/updateProc")
    @ResponseBody
    public ResponseEntity<?> updateProc(MemberDTO memberDTO, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            // 현재 로그인된 회원의 시퀀스 세팅
            memberDTO.setMbrSeq(loginUser.getMbrSeq());

            // DB 업데이트 실행
            memberMapper.updateMemberProfile(memberDTO);

            // 업데이트된 최신 정보로 세션 갱신
            MemberDTO updatedUser = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
            session.setAttribute("userLogin", updatedUser);

            return ResponseEntity.ok("프로필이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("프로필 수정 중 오류가 발생했습니다.");
        }
    }

    // 3. 마이페이지 (기부현황 화면)
    @GetMapping("/donate")
    public String mypageDonate(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");

        // 로그인 체크
        if (loginUser == null) {
            return "redirect:/login";
        }

        // 회원의 누적 통계 및 내역 리스트 가져오기
        DonationDTO summary = donationMapper.selectDonationSummary(loginUser.getMbrSeq());
        List<DonationDTO> list = donationMapper.selectDonationList(loginUser.getMbrSeq());

        model.addAttribute("summary", summary);
        model.addAttribute("list", list);

        return "mypage/donate";
    }

    // 4. 마이페이지 (회원 탈퇴 화면)
    @GetMapping("/leave")
    public String leaveForm(HttpSession session, Model model) {
        if (session.getAttribute("userLogin") == null) {
            return "redirect:/login";
        }
        return "mypage/leave";
    }

    // 5. 회원 탈퇴 처리 (AJAX)
    @PostMapping("/leaveProc")
    @ResponseBody
    public ResponseEntity<?> leaveProc(HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            // DB에 탈퇴 상태 업데이트
            memberMapper.updateWithdrawal(loginUser.getMbrSeq());

            // 처리 완료 후 로그인 세션 파기
            session.invalidate();

            return ResponseEntity.ok("스페셜올림픽코리아 회원 탈퇴가 완료되었습니다.\n그동안 이용해 주셔서 감사합니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("탈퇴 처리 중 오류가 발생했습니다.");
        }
    }

    // 6. 마이페이지 (개인정보 제3자 제공 동의 화면)
    @GetMapping("/terms/personal")
    public String personalTermsForm(HttpSession session, Model model) {
        if (session.getAttribute("userLogin") == null) {
            return "redirect:/login";
        }
        return "mypage/personal_terms";
    }

    // 7. 개인정보 제3자 제공 동의 처리 (AJAX)
    @PostMapping("/terms/personalProc")
    @ResponseBody
    public ResponseEntity<?> personalTermsProc(MemberDTO memberDTO, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            // 현재 로그인된 회원의 시퀀스 세팅
            memberDTO.setMbrSeq(loginUser.getMbrSeq());

            // DB 업데이트 실행 (체크박스 해제 시 넘어오는 null 방어)
            if(memberDTO.getAgreeOptionalYn() == null) {
                memberDTO.setAgreeOptionalYn("N");
            }

            memberMapper.updateOptionalAgreement(memberDTO);

            // 업데이트된 최신 정보로 세션 갱신
            MemberDTO updatedUser = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
            session.setAttribute("userLogin", updatedUser);

            return ResponseEntity.ok("개인정보 제3자 제공 동의 설정이 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("동의 처리 중 오류가 발생했습니다.");
        }
    }

    // 8. 마이페이지 (서비스 이용 동의 화면)
    @GetMapping("/terms/service")
    public String serviceTermsForm(HttpSession session, Model model) {
        if (session.getAttribute("userLogin") == null) {
            return "redirect:/login";
        }
        return "mypage/service_terms";
    }

    // 9. 서비스 이용 동의 처리 (AJAX)
    @PostMapping("/terms/serviceProc")
    @ResponseBody
    public ResponseEntity<?> serviceTermsProc(MemberDTO memberDTO, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            // 현재 로그인된 회원의 시퀀스 세팅
            memberDTO.setMbrSeq(loginUser.getMbrSeq());

            // 체크박스 해제 시 넘어오는 null 방어
            if(memberDTO.getMarketingYn() == null) {
                memberDTO.setMarketingYn("N");
            }

            memberMapper.updateMarketingAgreement(memberDTO);

            // 업데이트된 최신 정보로 세션 갱신
            MemberDTO updatedUser = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
            session.setAttribute("userLogin", updatedUser);

            return ResponseEntity.ok("서비스 이용 동의 설정이 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("동의 처리 중 오류가 발생했습니다.");
        }
    }
}