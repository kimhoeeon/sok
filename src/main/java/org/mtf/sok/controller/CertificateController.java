package org.mtf.sok.controller;

import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.mapper.CertificateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/certificate")
public class CertificateController {

    @Autowired
    private CertificateMapper certificateMapper;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String searchType,
                       @RequestParam(required = false) String searchStatus,
                       @RequestParam(required = false) String searchKeyword, Model model) {
        CertificateDTO params = new CertificateDTO();
        params.setSearchType(searchType);
        params.setSearchStatus(searchStatus);
        params.setSearchKeyword(searchKeyword);

        List<CertificateDTO> list = certificateMapper.selectCertificateList(params);
        model.addAttribute("list", list);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchStatus", searchStatus);
        model.addAttribute("searchKeyword", searchKeyword);

        return "admin/certificate/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long certSeq, Model model) {
        model.addAttribute("certificate", certificateMapper.selectCertificate(certSeq));
        return "admin/certificate/detail";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(CertificateDTO certificate) {
        certificateMapper.updateCertificateStatus(certificate);
        return "redirect:/admin/certificate/detail?certSeq=" + certificate.getCertSeq();
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long certSeq) {
        certificateMapper.deleteCertificate(certSeq);
        return "redirect:/admin/certificate/list";
    }
}