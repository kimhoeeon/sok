package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.CampaignDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.CampaignMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/mng/campaign")
public class CampaignController {

    @Autowired
    private CampaignMapper campaignMapper;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@ModelAttribute CampaignDTO params, Model model) {
        List<CampaignDTO> list = campaignMapper.selectCampaignList(params);
        int total = campaignMapper.selectCampaignTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "mng/campaign/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long campSeq, @ModelAttribute("params") CampaignDTO params, Model model) {
        CampaignDTO campaign = new CampaignDTO();
        if (campSeq != null) {
            campaign = campaignMapper.selectCampaign(campSeq);
        } else {
            campaign.setUseYn("Y"); // 기본값 세팅
        }
        model.addAttribute("campaign", campaign);
        return "mng/campaign/form";
    }

    @PostMapping("/save")
    public String save(CampaignDTO campaign, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        boolean isUpdate = (campaign.getCampSeq() != null);

        // 1. 썸네일 이미지 처리
        if (campaign.getThumbFile() != null && !campaign.getThumbFile().isEmpty()) {
            String thumbSavePath = uploadDir + "campaign/thumb/";
            File folder = new File(thumbSavePath);
            if (!folder.exists()) folder.mkdirs();

            try {
                MultipartFile tFile = campaign.getThumbFile();
                String originalFileName = tFile.getOriginalFilename();
                String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                String savedFileName = UUID.randomUUID().toString() + "_thumb" + ext;

                tFile.transferTo(new File(thumbSavePath + savedFileName));
                campaign.setThumbPath("/upload/campaign/thumb/" + savedFileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 2. DB 저장
        if (isUpdate) {
            campaign.setModId(admin != null ? admin.getAdmId() : "SYSTEM");
            campaignMapper.updateCampaign(campaign);
        } else {
            campaign.setRegId(admin != null ? admin.getAdmId() : "SYSTEM");
            campaignMapper.insertCampaign(campaign);
        }

        rttr.addAttribute("pageNum", isUpdate ? campaign.getPageNum() : 1);
        rttr.addAttribute("amount", campaign.getAmount());
        return "redirect:/mng/campaign/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long campSeq, @ModelAttribute CampaignDTO params, RedirectAttributes rttr) {
        campaignMapper.deleteCampaign(campSeq);
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        return "redirect:/mng/campaign/list";
    }
}