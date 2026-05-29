package org.mtf.sok.controller;

import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.CertificateMapper;
import org.mtf.sok.service.DirectSendService;
import org.mtf.sok.util.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/mng/certificate")
public class CertificateController {

    @Autowired
    private CertificateMapper certificateMapper;

    @Autowired
    private DirectSendService directSendService;

    @GetMapping("/list")
    public String list(@ModelAttribute CertificateDTO params, Model model) {
        List<CertificateDTO> list = certificateMapper.selectCertificateList(params);
        int total = certificateMapper.selectCertificateTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "mng/certificate/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long certSeq,
                         @ModelAttribute("params") CertificateDTO params,
                         Model model) {
        CertificateDTO certificate = certificateMapper.selectCertificate(certSeq);
        model.addAttribute("certificate", certificate);
        return "mng/certificate/detail";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam Long certSeq,
                               @RequestParam String issueStatus,
                               @RequestParam(required = false) String rejectRsn,
                               @ModelAttribute("params") CertificateDTO params,
                               RedirectAttributes rttr) {

        CertificateDTO certificate = new CertificateDTO();
        certificate.setCertSeq(certSeq);
        certificate.setIssueStatus(issueStatus);
        certificate.setRejectRsn(rejectRsn);

        // 1. DB 상태 업데이트
        certificateMapper.updateCertificateStatus(certificate);

        // 2. [핵심 추가] 처리 완료 또는 반려 시 신청자에게 결과 알림 메일/SMS 발송
        try {
            if ("DONE".equals(issueStatus) || "REJECT".equals(issueStatus)) {
                // 알림을 보내기 위해 업데이트된 증명서의 전체 정보(이메일, 연락처 등)를 다시 조회
                CertificateDTO updatedCert = certificateMapper.selectCertificate(certSeq);
                directSendService.sendCertificateResultAlert(updatedCert);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 메일 전송 실패가 전체 트랜잭션을 멈추지 않도록 예외만 로깅하고 넘어갑니다.
        }

        rttr.addAttribute("certSeq", certSeq);
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchType", params.getSearchType());
        rttr.addAttribute("searchStatus", params.getSearchStatus());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/mng/certificate/detail";
    }

    // 엑셀 다운로드 (Date 객체 그대로 넘김)
    @GetMapping("/excel")
    public void downloadExcel(@ModelAttribute CertificateDTO params, HttpServletResponse response) throws Exception {

        params.setPageNum(1);
        params.setAmount(1000000); // 전체 데이터를 가져오기 위한 설정

        List<CertificateDTO> list = certificateMapper.selectCertificateList(params);

        List<String> headers = Arrays.asList("신청번호", "증명서 종류", "신청자명", "연락처", "이메일", "소속", "처리상태", "신청일시");

        List<List<Object>> data = new ArrayList<>();

        for (CertificateDTO cert : list) {
            List<Object> row = new ArrayList<>();
            row.add(cert.getCertSeq());
            row.add(cert.getCertType());
            row.add(cert.getApplyNm());
            row.add(cert.getPhone());
            row.add(cert.getEmail());
            row.add(cert.getBelongTo() != null ? cert.getBelongTo() : "-");

            String statusKr = "";
            if ("WAIT".equals(cert.getIssueStatus())) statusKr = "접수 대기";
            else if ("ING".equals(cert.getIssueStatus())) statusKr = "발급 진행중";
            else if ("DONE".equals(cert.getIssueStatus())) statusKr = "발급 완료";
            else if ("REJECT".equals(cert.getIssueStatus())) statusKr = "반려/거절";
            row.add(statusKr);

            row.add(cert.getRegDt());

            data.add(row);
        }

        ExcelUtils.download(response, "증명서_신청_내역", headers, data);
    }
}