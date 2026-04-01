package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PopupDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.mapper.PopupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin/popup")
public class PopupController {

    @Autowired
    private PopupMapper popupMapper;

    @Autowired
    private BoardMapper boardMapper;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String title, Model model) {
        PopupDTO params = new PopupDTO();
        params.setTitle(title);

        List<PopupDTO> list = popupMapper.selectPopupList(params);

        // 고도화: 목록에서 썸네일을 보여주기 위해 각 팝업별 파일 정보 매칭
        for (PopupDTO popup : list) {
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_POPUP");
            fileParams.setRefSeq(popup.getPopSeq());
            List<FileDTO> files = boardMapper.selectFiles(fileParams);
            if (files != null && !files.isEmpty()) {
                popup.setPopupImage(files.get(0));
            }
        }

        model.addAttribute("list", list);
        model.addAttribute("searchTitle", title);
        return "admin/popup/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long popSeq, Model model) {
        PopupDTO popup = new PopupDTO();
        if (popSeq != null) {
            popup = popupMapper.selectPopup(popSeq);
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_POPUP");
            fileParams.setRefSeq(popSeq);
            List<FileDTO> files = boardMapper.selectFiles(fileParams);
            if (files != null && !files.isEmpty()) {
                popup.setPopupImage(files.get(0));
            }
        } else {
            popup.setUseYn("Y");
        }
        model.addAttribute("popup", popup);
        return "admin/popup/form";
    }

    @PostMapping("/save")
    public String save(PopupDTO popup, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        if (popup.getUseYn() == null) popup.setUseYn("N");

        if (popup.getPopSeq() != null) {
            popup.setModId(admin.getMbrId());
            popupMapper.updatePopup(popup);
        } else {
            popup.setRegId(admin.getMbrId());
            popupMapper.insertPopup(popup);
        }

        // 이미지 처리
        MultipartFile file = popup.getUploadFile();
        if (file != null && !file.isEmpty()) {
            try {
                String savePath = uploadDir + "popup/";
                File folder = new File(savePath);
                if (!folder.exists()) folder.mkdirs();

                String orgName = file.getOriginalFilename();
                String ext = orgName.substring(orgName.lastIndexOf("."));
                String saveName = UUID.randomUUID().toString() + ext;

                file.transferTo(new File(savePath + saveName));

                FileDTO fileDTO = new FileDTO();
                fileDTO.setRefTable("TB_POPUP");
                fileDTO.setRefSeq(popup.getPopSeq());
                fileDTO.setOrgFileNm(orgName);
                fileDTO.setSaveFileNm(saveName);
                fileDTO.setFilePath("/upload/popup/" + saveName);
                fileDTO.setFileSize(file.getSize());
                fileDTO.setFileExt(ext);

                boardMapper.insertFile(fileDTO);
            } catch (Exception e) { e.printStackTrace(); }
        }
        return "redirect:/admin/popup/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long popSeq) {
        popupMapper.deletePopup(popSeq);
        return "redirect:/admin/popup/list";
    }
}