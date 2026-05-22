package org.mtf.sok.controller;

import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.mapper.CertificateMapper;
import org.mtf.sok.service.DirectSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.List;

@Controller
@RequestMapping("/certificate")
public class FrontCertificateController {

    @Autowired
    private CertificateMapper certificateMapper;

    @Autowired
    private DirectSendService directSendService;

    // 1. 증명서 신청 화면 (GET)
    @GetMapping("/apply")
    public String applyForm() {
        return "certificate/apply";
    }

    // [추가] 캡차(자동입력방지) 동적 이미지 생성 엔드포인트
    @GetMapping("/captchaImg")
    public void getCaptchaImg(HttpServletResponse response, HttpSession session) throws Exception {
        // 1. 5자리 랜덤 숫자 생성
        String captchaStr = String.valueOf((int)(Math.random() * 90000) + 10000);

        // 2. 생성된 숫자를 세션에 저장 (나중에 검증 시 사용)
        session.setAttribute("captcha", captchaStr);

        // 3. 이미지 바탕(Canvas) 생성
        int width = 150;
        int height = 50;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();

        // 4. 배경색 설정
        g.setColor(new Color(240, 240, 240));
        g.fillRect(0, 0, width, height);

        // 5. 텍스트 그리기
        g.setColor(new Color(50, 50, 50));
        g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 32));
        g.drawString(captchaStr, 30, 36);

        // 6. 노이즈(방해 선) 추가
        g.setColor(Color.LIGHT_GRAY);
        for (int i = 0; i < 15; i++) {
            int x1 = (int)(Math.random() * width);
            int y1 = (int)(Math.random() * height);
            int x2 = (int)(Math.random() * width);
            int y2 = (int)(Math.random() * height);
            g.drawLine(x1, y1, x2, y2);
        }
        g.dispose();

        // 7. JPEG 형식으로 브라우저에 즉시 출력
        response.setContentType("image/jpeg");
        // 캐시 방지 헤더 설정
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        ImageIO.write(image, "jpeg", response.getOutputStream());
    }

    // 2. 증명서 신청 처리 (POST - AJAX)
    @PostMapping("/applyProc")
    @ResponseBody
    public ResponseEntity<?> applyProc(CertificateDTO certDTO,
                                       @RequestParam(value = "captchaText", required = false) String captchaText,
                                       HttpSession session) {
        try {

            String sessionCaptcha = (String) session.getAttribute("captcha");
            if (sessionCaptcha == null || captchaText == null || !sessionCaptcha.equals(captchaText)) {
                return ResponseEntity.badRequest().body("자동입력방지 숫자가 일치하지 않습니다.");
            }

            // 중복 검증 로직 실행
            int duplicateCount = certificateMapper.checkDuplicateCertificate(certDTO);

            if (duplicateCount > 0) {
                return ResponseEntity.badRequest().body("동일한 행사에 대해 이미 신청 중이거나 발급된 내역이 존재합니다.");
            }

            // 1. DB에 접수 내역 저장
            certificateMapper.insertCertificate(certDTO);

            // 2. 발주사 관리자에게 신규 발급 요청 알림 메일 즉시 발송
            directSendService.sendCertificateApplyAlert(certDTO);

            // 검증에 성공하여 처리가 끝났으므로 세션에서 캡차 삭제 (재사용 방지)
            session.removeAttribute("captcha");

            return ResponseEntity.ok("증명서 신청이 성공적으로 접수되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("신청 처리 중 서버 오류가 발생했습니다.");
        }
    }

    // 3. 발급상태 확인 화면 (GET)
    @GetMapping("/status")
    public String statusForm() {
        return "certificate/status";
    }

    // 4. 발급상태 조회 처리 및 결과 화면 (POST)
    @PostMapping("/statusResult")
    public String statusResult(CertificateDTO certDTO, org.springframework.ui.Model model) {
        CertificateDTO result = certificateMapper.findCertificateForStatusCheck(certDTO);

        model.addAttribute("result", result);
        return "certificate/status_result";
    }

}