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
    private BoardMapper boardMapper; // 첨부파일(TB_FILE) 처리를 위해 의존성 주입

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String title, Model model) {
        PopupDTO params = new PopupDTO();
        params.setTitle(title);

        List<PopupDTO> list = popupMapper.selectPopupList(params);
        model.addAttribute("list", list);
        model.addAttribute("searchTitle", title);

        return "admin/popup/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long popSeq, Model model) {
        PopupDTO popup = new PopupDTO();

        if (popSeq != null) {
            popup = popupMapper.selectPopup(popSeq);

            // 기존 팝업 이미지가 있는지 TB_FILE에서 조회
            FileDTO fileParams = new FileDTO();
            fileParams.setRefTable("TB_POPUP");
            fileParams.setRefSeq(popSeq);
            List<FileDTO> files = boardMapper.selectFiles(fileParams);
            if(files != null && !files.isEmpty()) {
                popup.setPopupImage(files.get(0));
            }
        } else {
            popup.setUseYn("Y"); // 기본값 세팅
        }

        model.addAttribute("popup", popup);
        return "admin/popup/form";
    }

    @PostMapping("/save")
    public String save(PopupDTO popup, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        if (popup.getUseYn() == null) popup.setUseYn("N");

        // 1. 팝업 기본 정보 저장
        if (popup.getPopSeq() != null) {
            popup.setModId(admin != null ? admin.getMbrId() : "SYSTEM");
            popupMapper.updatePopup(popup);
        } else {
            popup.setRegId(admin != null ? admin.getMbrId() : "SYSTEM");
            popupMapper.insertPopup(popup); // popSeq 반환됨
        }

        // 2. 팝업 이미지 업로드 처리 (TB_FILE 연동)
        MultipartFile uploadFile = popup.getUploadFile();
        if (uploadFile != null && !uploadFile.isEmpty()) {
            try {
                String savePath = uploadDir + "popup/";
                File folder = new File(savePath);
                if (!folder.exists()) folder.mkdirs();

                String originalFileName = uploadFile.getOriginalFilename();
                String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                String savedFileName = UUID.randomUUID().toString() + ext;

                File targetFile = new File(savePath + savedFileName);
                uploadFile.transferTo(targetFile);

                FileDTO fileDTO = new FileDTO();
                fileDTO.setRefTable("TB_POPUP");
                fileDTO.setRefSeq(popup.getPopSeq());
                fileDTO.setOrgFileNm(originalFileName);
                fileDTO.setSaveFileNm(savedFileName);
                fileDTO.setFilePath("/upload/popup/" + savedFileName);
                fileDTO.setFileSize(uploadFile.getSize());
                fileDTO.setFileExt(ext);

                // 기존 이미지가 있다면 삭제 상태로 변경하는 로직이 필요하나, 우선 Insert 처리
                boardMapper.insertFile(fileDTO);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "redirect:/admin/popup/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long popSeq) {
        popupMapper.deletePopup(popSeq);
        return "redirect:/admin/popup/list";
    }
}