package org.mtf.sok.controller;

import org.mtf.sok.domain.DonationDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.DonationMapper;
import org.mtf.sok.mapper.MemberMapper;
import org.mtf.sok.security.PrincipalDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        if (loginUser == null) {
            return "redirect:/login/basic";
        }

        MemberDTO memberInfo = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
        model.addAttribute("member", memberInfo);

        return "mypage/info";
    }

    // 2. 프로필 수정 처리 (info.jsp의 AJAX URL '/mypage/updateProc'와 일치)
    @PostMapping("/updateProc")
    @ResponseBody
    public ResponseEntity<String> updateProc(MemberDTO updateDto, HttpSession session) {

        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }

        try {
            // 이메일 및 전화번호 중복 체크 (본인 제외)
            if (memberMapper.checkDuplicateEmail(updateDto.getEmail(), loginUser.getMbrSeq()) > 0) {
                return ResponseEntity.badRequest().body("이미 가입된 이메일 입니다. 관리자에게 문의해 주세요.");
            }
            if (memberMapper.checkDuplicatePhone(updateDto.getPhone(), loginUser.getMbrSeq()) > 0) {
                return ResponseEntity.badRequest().body("이미 가입된 연락처 입니다. 관리자에게 문의해 주세요.");
            }

            // 보안: 클라이언트 조작 방지용 PK 세팅
            updateDto.setMbrSeq(loginUser.getMbrSeq());

            // DB 업데이트 실행
            memberMapper.updateMemberProfile(updateDto);

            // 세션 갱신 (info.jsp에서 sessionScope 기반으로 화면을 그리므로 필수)
            MemberDTO refreshedUser = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
            session.setAttribute("userLogin", refreshedUser);

            return ResponseEntity.ok("프로필이 성공적으로 수정되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("프로필 수정 중 오류가 발생했습니다.");
        }
    }

    // 3. 마이페이지 (기부현황 화면 - donate.jsp 와 DonationMapper 완벽 일치)
    @GetMapping("/donate")
    public String mypageDonate(HttpSession session, Model model) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) {
            return "redirect:/login/basic"; // 권한 필터가 있더라도 안전장치
        }

        // DonationMapper.xml 에 정의된 파라미터(mbrSeq)와 정확히 일치하는 메서드 호출
        DonationDTO summary = donationMapper.selectDonationSummary(loginUser.getMbrSeq());
        List<DonationDTO> list = donationMapper.selectDonationList(loginUser.getMbrSeq());

        // donate.jsp 가 요구하는 ${summary} 와 ${list} 변수 바인딩
        model.addAttribute("summary", summary);
        model.addAttribute("list", list);

        return "mypage/donate";
    }

    // 4. 마이페이지 (회원 탈퇴 화면)
    @GetMapping("/leave")
    public String leaveForm(HttpSession session, Model model) {
        if (session.getAttribute("userLogin") == null) {
            return "redirect:/login/basic";
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
            // DB 탈퇴 처리
            memberMapper.updateWithdrawal(loginUser.getMbrSeq());
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
            return "redirect:/login/basic";
        }
        return "mypage/personal_terms";
    }

    // 7. 개인정보 제3자 제공 동의 처리 (AJAX)
    @PostMapping("/terms/personalProc")
    @ResponseBody
    public ResponseEntity<?> personalTermsProc(MemberDTO memberDTO, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) return ResponseEntity.status(401).body("로그인이 필요합니다.");

        try {
            memberDTO.setMbrSeq(loginUser.getMbrSeq());
            if(memberDTO.getAgreeOptionalYn() == null) memberDTO.setAgreeOptionalYn("N");

            memberMapper.updateOptionalAgreement(memberDTO);

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
            return "redirect:/login/basic";
        }
        return "mypage/service_terms";
    }

    // 9. 서비스 이용 동의 처리 (AJAX)
    @PostMapping("/terms/serviceProc")
    @ResponseBody
    public ResponseEntity<?> serviceTermsProc(MemberDTO memberDTO, HttpSession session) {
        MemberDTO loginUser = (MemberDTO) session.getAttribute("userLogin");
        if (loginUser == null) return ResponseEntity.status(401).body("로그인이 필요합니다.");

        try {
            memberDTO.setMbrSeq(loginUser.getMbrSeq());
            if(memberDTO.getMarketingYn() == null) memberDTO.setMarketingYn("N");

            memberMapper.updateMarketingAgreement(memberDTO);

            MemberDTO updatedUser = memberMapper.selectMemberBySeq(loginUser.getMbrSeq());
            session.setAttribute("userLogin", updatedUser);

            return ResponseEntity.ok("서비스 이용 동의 설정이 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("동의 처리 중 오류가 발생했습니다.");
        }
    }

    @PostMapping("/mypage/updateMarketing")
    @ResponseBody
    public ResponseEntity<?> updateMarketing(@RequestParam String marketingYn, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        try {
            MemberDTO memberDTO = new MemberDTO();
            // 현재 로그인된 사용자의 시퀀스 번호와 변경할 Y/N 값을 세팅
            memberDTO.setMbrSeq(principalDetails.getMemberDTO().getMbrSeq());
            memberDTO.setMarketingYn(marketingYn);

            // 기존에 만들어두신 Mapper 실행
            memberMapper.updateMarketingAgreement(memberDTO);

            // 시큐리티 세션 내의 정보도 동기화 (새로고침 시 풀림 방지)
            principalDetails.getMemberDTO().setMarketingYn(marketingYn);

            return ResponseEntity.ok("변경 완료");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("변경 실패");
        }
    }
}