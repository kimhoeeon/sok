package org.mtf.sok.controller;

import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.mapper.CertificateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/certificate")
public class FrontCertificateController {

    @Autowired
    private CertificateMapper certificateMapper;

    // 1. 증명서 신청 화면 (GET)
    @GetMapping("/apply")
    public String applyForm() {
        return "certificate/apply";
    }

    // 2. 증명서 신청 처리 (POST - AJAX)
    @PostMapping("/applyProc")
    @ResponseBody
    public ResponseEntity<?> applyProc(CertificateDTO certDTO) {
        try {
            // 중복 검증 로직 실행
            int duplicateCount = certificateMapper.checkDuplicateCertificate(certDTO);

            if (duplicateCount > 0) {
                return ResponseEntity.badRequest().body("동일한 행사에 대해 이미 신청 중이거나 발급된 내역이 존재합니다.");
            }

            // 이상 없으면 DB Insert
            certificateMapper.insertCertificate(certDTO);
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