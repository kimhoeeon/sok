package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.domain.PopupDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.mapper.PopupMapper;
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
@RequestMapping("/mng/popup")
public class PopupController {

    @Autowired
    private PopupMapper popupMapper;

    @Autowired
    private BoardMapper boardMapper;

    @Value("${file.upload.dir}")
    private String uploadDir;

    @GetMapping("/list")
    public String list(@ModelAttribute PopupDTO params, Model model) {

        List<PopupDTO> list = popupMapper.selectPopupList(params);
        int total = popupMapper.selectPopupTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

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
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params); // 파라미터 상태 유지
        return "mng/popup/list";
    }

    @GetMapping("/form")
    public String form(@RequestParam(required = false) Long popSeq,
                       @ModelAttribute("params") PopupDTO params,
                       Model model) {
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
        return "mng/popup/form";
    }

    @PostMapping("/save")
    public String save(PopupDTO popup, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");

        // [보안/안정성] 세션 만료 체크
        if (admin == null) {
            throw new IllegalStateException("관리자 세션이 만료되었습니다. 다시 로그인해주세요.");
        }

        if (popup.getUseYn() == null) popup.setUseYn("N");

        boolean isUpdate = (popup.getPopSeq() != null); // 신규/수정 여부 판별

        if (isUpdate) {
            popup.setModId(admin.getAdmId());
            popupMapper.updatePopup(popup);
        } else {
            popup.setRegId(admin.getAdmId());
            popupMapper.insertPopup(popup);

            // [검증] INSERT 직후 PK가 제대로 DTO에 바인딩되었는지 확인
            if (popup.getPopSeq() == null) {
                throw new RuntimeException("팝업 등록 중 오류가 발생했습니다. (PK 반환 실패)");
            }
        }

        // 파일 업로드 처리
        if (popup.getUploadFile() != null && !popup.getUploadFile().isEmpty()) {
            try {
                // 수정(Update) 시 새 파일을 올렸다면, 기존 파일은 논리적 삭제 처리
                if (isUpdate) {
                    boardMapper.deleteFilesByRefTarget("TB_POPUP", popup.getPopSeq());
                }

                MultipartFile file = popup.getUploadFile();
                String orgName = file.getOriginalFilename();
                String ext = "";
                if (orgName != null && orgName.contains(".")) {
                    ext = orgName.substring(orgName.lastIndexOf("."));
                }
                String saveName = UUID.randomUUID().toString() + ext;

                File dest = new File(uploadDir + "popup/" + saveName);
                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }
                file.transferTo(dest);

                FileDTO fileDTO = new FileDTO();
                fileDTO.setRefTable("TB_POPUP");
                // 새로 생성된 popSeq 또는 기존 popSeq 매핑
                fileDTO.setRefSeq(popup.getPopSeq());
                fileDTO.setOrgFileNm(orgName);
                fileDTO.setSaveFileNm(saveName);
                fileDTO.setFilePath("/upload/popup/" + saveName);
                fileDTO.setFileSize(file.getSize());
                fileDTO.setFileExt(ext);

                boardMapper.insertFile(fileDTO);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (isUpdate) {
            rttr.addAttribute("pageNum", popup.getPageNum());
            rttr.addAttribute("amount", popup.getAmount());
            rttr.addAttribute("searchKeyword", popup.getSearchKeyword());
            rttr.addAttribute("searchUseYnOnly", popup.getSearchUseYnOnly());
        } else {
            rttr.addAttribute("pageNum", 1);
            rttr.addAttribute("amount", popup.getAmount());
        }

        return "redirect:/mng/popup/list";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long popSeq, @ModelAttribute PopupDTO params, RedirectAttributes rttr) {
        // 1. 팝업 테이블 논리적 삭제 (TB_POPUP의 DEL_YN = 'Y')
        popupMapper.deletePopup(popSeq);

        // 2. 해당 팝업에 연결된 이미지 파일 논리적 삭제 (TB_FILE의 DEL_YN = 'Y')
        boardMapper.deleteFilesByRefTarget("TB_POPUP", popSeq);

        // 검색 및 페이징 파라미터 유지
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());
        rttr.addAttribute("searchUseYnOnly", params.getSearchUseYnOnly());

        return "redirect:/mng/popup/list";
    }
}