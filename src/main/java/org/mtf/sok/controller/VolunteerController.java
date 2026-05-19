package org.mtf.sok.controller;

import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.domain.VolunteerDTO;
import org.mtf.sok.mapper.VolunteerMapper;
import org.mtf.sok.service.DirectSendService; // ★ 알림 서비스 임포트
import org.mtf.sok.util.ExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/mng/volunteer")
public class VolunteerController {

    @Autowired
    private VolunteerMapper volunteerMapper;

    @Autowired
    private DirectSendService directSendService; // ★ 알림 서비스 주입

    @GetMapping("/list")
    public String list(@ModelAttribute VolunteerDTO params, Model model) {

        List<VolunteerDTO> list = volunteerMapper.selectVolunteerList(params);
        int total = volunteerMapper.selectVolunteerTotalCount(params);
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("params", params);

        return "mng/volunteer/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long volSeq,
                         @ModelAttribute("params") VolunteerDTO params,
                         Model model) {
        model.addAttribute("volunteer", volunteerMapper.selectVolunteer(volSeq));
        return "mng/volunteer/detail";
    }

    // 기존 수정 방식 유지 + 상태값이 완료/반려일 때 알림 발송 기능 통합
    @PostMapping("/update")
    public String update(VolunteerDTO volunteer, RedirectAttributes rttr) {
        volunteerMapper.updateVolunteer(volunteer);

        try {
            // 처리 상태가 승인(APPR, DONE)이거나 반려(REJECT)일 경우 알림 발송
            String status = volunteer.getStatus();
            if (status != null && ("DONE".equals(status) || "APPR".equals(status) || "REJECT".equals(status))) {
                VolunteerDTO updatedVol = volunteerMapper.selectVolunteer(volunteer.getVolSeq());
                directSendService.sendVolunteerResultAlert(updatedVol);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        rttr.addAttribute("volSeq", volunteer.getVolSeq());
        rttr.addAttribute("pageNum", volunteer.getPageNum());
        rttr.addAttribute("amount", volunteer.getAmount());
        rttr.addAttribute("searchSupportArea", volunteer.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", volunteer.getSearchKeyword());

        return "redirect:/mng/volunteer/detail";
    }

    // [신규 추가] 증명서 컨트롤러와 동일하게 모달이나 독립된 상태 변경 버튼을 사용할 경우를 대비한 메서드
    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam Long volSeq,
                               @RequestParam String status,
                               @RequestParam(required = false) String rejectReason,
                               @ModelAttribute("params") VolunteerDTO params,
                               RedirectAttributes rttr) {

        VolunteerDTO volunteer = new VolunteerDTO();
        volunteer.setVolSeq(volSeq);
        volunteer.setStatus(status);
        volunteer.setRejectRsn(rejectReason);

        // 1. DB 상태 업데이트 (기존 updateVolunteer 쿼리 재활용 또는 별도 쿼리)
        volunteerMapper.updateVolunteer(volunteer);

        // 2. 처리 완료 또는 반려 시 신청자에게 결과 알림 메일/SMS 발송
        try {
            if ("DONE".equals(status) || "APPR".equals(status) || "REJECT".equals(status)) {
                VolunteerDTO updatedVol = volunteerMapper.selectVolunteer(volSeq);
                directSendService.sendVolunteerResultAlert(updatedVol);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        rttr.addAttribute("volSeq", volSeq);
        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchSupportArea", params.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/mng/volunteer/detail";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long volSeq, @ModelAttribute VolunteerDTO params, RedirectAttributes rttr) {
        volunteerMapper.deleteVolunteer(volSeq);

        rttr.addAttribute("pageNum", params.getPageNum());
        rttr.addAttribute("amount", params.getAmount());
        rttr.addAttribute("searchSupportArea", params.getSearchSupportArea());
        rttr.addAttribute("searchKeyword", params.getSearchKeyword());

        return "redirect:/mng/volunteer/list";
    }

    // 엑셀 다운로드 (처리상태 내역 컬럼 추가)
    @GetMapping("/excel")
    public void downloadExcel(@ModelAttribute VolunteerDTO params, HttpServletResponse response) throws Exception {
        params.setPageNum(1);
        params.setAmount(1000000);

        List<VolunteerDTO> list = volunteerMapper.selectVolunteerList(params);

        List<String> headers = Arrays.asList("연번", "지원분야", "신청 행사명", "신청자(단체)명", "연락처", "참여인원", "참여빈도", "개인정보동의", "처리상태", "신청일시");
        List<List<Object>> data = new ArrayList<>();

        for (VolunteerDTO vol : list) {
            List<Object> row = new ArrayList<>();
            row.add(vol.getVolSeq());
            row.add(vol.getSupportArea());
            row.add(vol.getEventNm() != null ? vol.getEventNm() : "-");
            row.add(vol.getApplyNm());
            row.add(vol.getPhone());
            row.add(vol.getApplyCnt() + "명");
            row.add("ONCE".equals(vol.getFreqType()) ? "1회성" : "정기/수시");
            row.add(vol.getAgreeYn());

            // 상태값 번역
            String statusKr = "";
            if (vol.getStatus() != null) {
                if ("WAIT".equals(vol.getStatus())) statusKr = "접수 대기";
                else if ("APPR".equals(vol.getStatus()) || "DONE".equals(vol.getStatus())) statusKr = "승인 완료";
                else if ("REJECT".equals(vol.getStatus())) statusKr = "반려/거절";
                else statusKr = vol.getStatus();
            } else {
                statusKr = "-";
            }
            row.add(statusKr);

            row.add(vol.getRegDt());
            data.add(row);
        }
        ExcelUtils.download(response, "자원봉사_신청_내역", headers, data);
    }
}