package org.mtf.sok.controller;

import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.CertificateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/certificate")
public class CertificateController {

    @Autowired
    private CertificateMapper certificateMapper;

    @GetMapping("/list")
    public String list(@ModelAttribute CertificateDTO params, Model model) {
        // ★ [페이징 추가]
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
    public String updateStatus(CertificateDTO cert, RedirectAttributes rttr) {

        certificateMapper.updateCertificateStatus(cert);

        // ★ [상태 유지] 업데이트 후 원래 보던 검색조건/페이지로 완벽 복귀
        rttr.addAttribute("certSeq", cert.getCertSeq());
        rttr.addAttribute("pageNum", cert.getPageNum());
        rttr.addAttribute("amount", cert.getAmount());
        rttr.addAttribute("searchType", cert.getSearchType()); // 증명서 종류 필터
        rttr.addAttribute("searchStatus", cert.getSearchStatus());
        rttr.addAttribute("searchKeyword", cert.getSearchKeyword());

        return "redirect:/admin/certificate/detail";
    }
}