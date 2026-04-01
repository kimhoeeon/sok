package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.DevCommentDTO;
import org.mtf.sok.domain.DevRequestDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.mapper.DevMapper;
import org.mtf.sok.service.BizppurioService;
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

    // 현재 관리자가 개발사인지 발주사인지 체크하는 내부 헬퍼 (아이디나 Role을 기준으로 분기)
    private boolean isDeveloper(HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        if (admin != null && "agency_dev".equals(admin.getMbrId())) {
            return true; // 예: 개발사 전용 계정일 경우 true
        }
        return false;
    }

    @GetMapping("/list")
    public String list(@ModelAttribute DevRequestDTO params, Model model) {
        model.addAttribute("list", devMapper.selectRequestList(params));
        model.addAttribute("params", params);
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
        request.setRegId(admin != null ? admin.getMbrId() : "SOK_ADMIN");
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
    public String detail(@RequestParam Long reqSeq, Model model, HttpSession session) {
        DevRequestDTO request = devMapper.selectRequest(reqSeq);

        // 1. 요청글 첨부파일 조회
        FileDTO reqFileParams = new FileDTO();
        reqFileParams.setRefTable("TB_DEV_REQUEST");
        reqFileParams.setRefSeq(reqSeq);
        request.setFileList(boardMapper.selectFiles(reqFileParams));

        // 2. 댓글 리스트 및 댓글별 첨부파일 조회
        List<DevCommentDTO> comments = devMapper.selectCommentList(reqSeq);
        for(DevCommentDTO comment : comments) {
            FileDTO cmtFileParams = new FileDTO();
            cmtFileParams.setRefTable("TB_DEV_COMMENT");
            cmtFileParams.setRefSeq(comment.getCmtSeq());
            comment.setFileList(boardMapper.selectFiles(cmtFileParams));
        }

        model.addAttribute("request", request);
        model.addAttribute("comments", comments);
        model.addAttribute("isDeveloper", isDeveloper(session)); // JSP 뷰 제어용 플래그

        return "admin/dev/detail";
    }

    @PostMapping("/updateStatus")
    public String updateStatus(DevRequestDTO request, HttpSession session) {
        // 개발사만 상태 변경 가능
        if (isDeveloper(session)) {
            AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
            request.setModId(admin.getMbrId());
            devMapper.updateRequestStatus(request);

            // 상태가 변경되었으므로 최신화된 데이터를 다시 조회하여 발주사(SOK)에 알림 메일 발송
            DevRequestDTO updatedReq = devMapper.selectRequest(request.getReqSeq());
            bizppurioService.sendStatusChangeAlertEmail(updatedReq);
        }
        return "redirect:/admin/dev/detail?reqSeq=" + request.getReqSeq();
    }

    @PostMapping("/saveComment")
    public String saveComment(DevCommentDTO comment, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminLogin");
        String writerId = admin != null ? admin.getMbrId() : "SOK_ADMIN";
        comment.setRegId(writerId);

        devMapper.insertComment(comment);

        // 댓글 첨부파일 처리 (TB_FILE 연동 - REF_TABLE: TB_DEV_COMMENT)
        uploadFiles(comment.getUploadFiles(), "TB_DEV_COMMENT", comment.getCmtSeq());

        // ★ [메일 연동] 발주사가 댓글을 작성했을 경우 개발사 담당자에게 메일 발송 ★
        if (!isDeveloper(session)) {
            DevRequestDTO parentRequest = devMapper.selectRequest(comment.getReqSeq());
            bizppurioService.sendCommentAlertEmail(parentRequest, comment.getContent(), writerId);
        }

        return "redirect:/admin/dev/detail?reqSeq=" + comment.getReqSeq();
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