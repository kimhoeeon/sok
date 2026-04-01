package org.mtf.sok.controller;

import org.mtf.sok.domain.*;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.mapper.DevMapper;
import org.mtf.sok.service.BizppurioService;
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
@RequestMapping("/admin/dev")
public class DevController {

    @Autowired
    private DevMapper devMapper;

    @Autowired
    private BoardMapper boardMapper; // TB_FILE 활용용

    @Autowired
    private BizppurioService bizppurioService; // 비즈뿌리오 메일 서비스

    @Value("${file.upload.dir}")
    private String uploadDir;

    // 현재 관리자가 개발사인지 발주사인지 체크하는 내부 헬퍼
    private boolean isDeveloper(HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        return admin != null && "meetingfan".equals(admin.getMbrId());
    }

    @GetMapping("/list")
    public String list(@ModelAttribute DevRequestDTO params, Model model) {
        // 1. 페이징 처리 및 데이터 조회
        List<DevRequestDTO> list = devMapper.selectRequestList(params);
        int total = devMapper.selectRequestTotalCount(params);

        // 2. 화면에 그려줄 페이지 버튼 계산 객체 생성
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        // 기존 대시보드 통계 데이터 유지
        model.addAttribute("statusCount", devMapper.selectRequestStatusCount());

        return "admin/dev/list";
    }

    @GetMapping("/form")
    public String form(Model model) {
        model.addAttribute("request", new DevRequestDTO());
        return "admin/dev/form";
    }

    @PostMapping("/saveRequest")
    public String saveRequest(DevRequestDTO request, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        request.setRegId(admin != null ? admin.getMbrId() : "sokadmin");
        if (request.getUrgency() == null) request.setUrgency("N");

        devMapper.insertRequest(request);

        // 첨부파일 처리 (TB_FILE 연동 - REF_TABLE: TB_DEV_REQUEST)
        uploadFiles(request.getUploadFiles(), "TB_DEV_REQUEST", request.getReqSeq());

        // ★ [메일 연동] 발주사가 글을 썼으므로 개발사 담당자에게 비즈뿌리오 메일 발송 ★
        if (!isDeveloper(session)) {
            bizppurioService.sendRequestAlertEmail(request);
        }

        return "redirect:/admin/dev/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long reqSeq, @ModelAttribute("params") DevRequestDTO params, Model model, HttpSession session) {
        DevRequestDTO request = devMapper.selectRequest(reqSeq);

        FileDTO reqFileParams = new FileDTO();
        reqFileParams.setRefTable("TB_DEV_REQUEST");
        reqFileParams.setRefSeq(reqSeq);
        request.setFileList(boardMapper.selectFiles(reqFileParams));

        List<DevCommentDTO> comments = devMapper.selectCommentList(reqSeq);
        for(DevCommentDTO comment : comments) {
            FileDTO cmtFileParams = new FileDTO();
            cmtFileParams.setRefTable("TB_DEV_COMMENT");
            cmtFileParams.setRefSeq(comment.getCmtSeq());
            comment.setFileList(boardMapper.selectFiles(cmtFileParams));
        }

        model.addAttribute("request", request);
        model.addAttribute("comments", comments);
        model.addAttribute("isDeveloper", isDeveloper(session));

        return "admin/dev/detail";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(DevRequestDTO request, HttpSession session, RedirectAttributes rttr) {
        if (isDeveloper(session)) {
            AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
            request.setModId(admin.getMbrId());
            devMapper.updateRequestStatus(request);

            DevRequestDTO updatedReq = devMapper.selectRequest(request.getReqSeq());
            bizppurioService.sendStatusChangeAlertEmail(updatedReq);
        }

        // ★ [수정됨] 처리 후 돌아갈 때 파라미터를 달고 가도록 세팅
        rttr.addAttribute("reqSeq", request.getReqSeq());
        rttr.addAttribute("pageNum", request.getPageNum());
        rttr.addAttribute("amount", request.getAmount());
        rttr.addAttribute("searchType", request.getSearchType());
        rttr.addAttribute("searchStatus", request.getSearchStatus());
        rttr.addAttribute("searchKeyword", request.getSearchKeyword());

        return "redirect:/admin/dev/detail";
    }

    @PostMapping("/saveComment")
    public String saveComment(DevCommentDTO comment, @ModelAttribute DevRequestDTO params, HttpSession session, RedirectAttributes rttr) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        String writerId = admin != null ? admin.getMbrId() : "sokadmin";
        comment.setRegId(writerId);

        devMapper.insertComment(comment);
        uploadFiles(comment.getUploadFiles(), "TB_DEV_COMMENT", comment.getCmtSeq());

        if (!isDeveloper(session)) {
            DevRequestDTO parentRequest = devMapper.selectRequest(comment.getReqSeq());
            bizppurioService.sendCommentAlertEmail(parentRequest, comment.getContent(), writerId);
        }

        // ★ [수정됨] 처리 후 돌아갈 때 파라미터를 달고 가도록 세팅
        rttr.addAttribute("reqSeq", comment.getReqSeq());
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchType", params.getSearchType());
        rttr.addAttribute("searchStatus", params.getSearchStatus());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/admin/dev/detail";
    }

    // 파일 업로드 공통 내부 헬퍼
    private void uploadFiles(List<MultipartFile> files, String refTable, Long refSeq) {
        if (files != null && !files.isEmpty()) {
            String savePath = uploadDir + "dev/";
            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    try {
                        String orgName = file.getOriginalFilename();
                        String ext = orgName.substring(orgName.lastIndexOf("."));
                        String saveName = UUID.randomUUID().toString() + ext;

                        file.transferTo(new File(savePath + saveName));

                        FileDTO fileDTO = new FileDTO();
                        fileDTO.setRefTable(refTable);
                        fileDTO.setRefSeq(refSeq);
                        fileDTO.setOrgFileNm(orgName);
                        fileDTO.setSaveFileNm(saveName);
                        fileDTO.setFilePath("/upload/dev/" + saveName);
                        fileDTO.setFileSize(file.getSize());
                        fileDTO.setFileExt(ext);

                        boardMapper.insertFile(fileDTO);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}