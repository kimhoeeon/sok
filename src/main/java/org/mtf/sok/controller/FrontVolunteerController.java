package org.mtf.sok.controller;

import org.mtf.sok.domain.VolunteerDTO;
import org.mtf.sok.mapper.VolunteerMapper;
import org.mtf.sok.service.DirectSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/volunteer")
public class FrontVolunteerController {

    @Autowired
    private VolunteerMapper volunteerMapper;

    @Autowired
    private DirectSendService directSendService;

    // 1. 자원봉사 신청 화면 (GET)
    @GetMapping("/apply")
    public String applyForm() {
        return "volunteer/apply";
    }

    // 2. 자원봉사 신청 처리 (POST - AJAX)
    @PostMapping("/applyProc")
    @ResponseBody
    public ResponseEntity<?> applyProc(VolunteerDTO volunteerDTO,
                                       @RequestParam(value = "captchaText", required = false) String captchaText,
                                       HttpSession session) {
        try {
            // 세션 캡차 일치 여부 검증
            String sessionCaptcha = (String) session.getAttribute("captcha");
            if (sessionCaptcha == null || captchaText == null || !sessionCaptcha.equals(captchaText)) {
                return ResponseEntity.badRequest().body("자동입력방지 숫자가 일치하지 않습니다.");
            }

            // 화면 폼에 참여 인원(applyCnt) 입력란이 없으므로 기본값 1명으로 세팅
            if (volunteerDTO.getApplyCnt() == null) {
                volunteerDTO.setApplyCnt(1);
            }

            if (!"Y".equals(volunteerDTO.getAgreeYn())) {
                return ResponseEntity.badRequest().body("개인정보 수집·이용에 동의해 주세요.");
            }

            // DB 저장
            volunteerMapper.insertVolunteer(volunteerDTO);

            // 2. 발주사 관리자에게 신규 접수 알림 메일 즉시 발송
            directSendService.sendVolunteerApplyAlert(volunteerDTO);

            //검증 성공 시 세션에서 캡차 데이터 제거 (재사용 방지)
            session.removeAttribute("captcha");

            return ResponseEntity.ok("자원봉사 신청이 성공적으로 접수되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("신청 처리 중 서버 오류가 발생했습니다.");
        }
    }
}