package org.mtf.sok.controller;

import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.CertificateMapper;
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
@RequestMapping("/admin/certificate")
public class CertificateController {

    @Autowired
    private CertificateMapper certificateMapper;

    @GetMapping("/list")
    public String list(@ModelAttribute CertificateDTO params, Model model) {
        List<CertificateDTO> list = certificateMapper.selectCertificateList(params);
        int total = certificateMapper.selectCertificateTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "admin/certificate/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long certSeq,
                         @ModelAttribute("params") CertificateDTO params,
                         Model model) {
        CertificateDTO certificate = certificateMapper.selectCertificate(certSeq);
        model.addAttribute("certificate", certificate);
        return "admin/certificate/detail";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam Long certSeq,
                               @RequestParam String status,
                               @RequestParam(required = false) String rejectReason, // ★ 추가
                               @ModelAttribute("params") CertificateDTO params,
                               RedirectAttributes rttr) {

        // Mapper 호출 시 rejectReason을 함께 전달하도록 수정
        CertificateDTO certificate = new CertificateDTO();
        certificate.setCertSeq(certSeq);
        certificate.setIssueStatus(status);
        certificate.setRejectRsn(rejectReason);
        certificateMapper.updateCertificateStatus(certificate);

        rttr.addAttribute("certSeq", certSeq);
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchType", params.getSearchType());
        rttr.addAttribute("searchStatus", params.getSearchStatus());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/admin/certificate/detail";
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