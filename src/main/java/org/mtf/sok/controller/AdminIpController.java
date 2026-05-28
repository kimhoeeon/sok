package org.mtf.sok.controller;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.AdminIpDTO;
import org.mtf.sok.mapper.AdminIpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/mng/admin/ip")
public class AdminIpController {

    @Autowired
    private AdminIpMapper adminIpMapper;

    // 1. 관리자 및 IP 관리 페이지 이동
    @GetMapping("/list")
    public String ipList(Model model) {
        List<AdminDTO> adminList = adminIpMapper.selectAllAdmins();
        model.addAttribute("adminList", adminList);
        return "mng/admin/ip_list";
    }

    // 2. [AJAX] 특정 관리자의 IP 목록 불러오기
    @GetMapping("/api/list")
    @ResponseBody
    public ResponseEntity<List<AdminIpDTO>> getIps(@RequestParam Long admSeq) {
        List<AdminIpDTO> ipList = adminIpMapper.selectIpsByAdmSeq(admSeq);
        return ResponseEntity.ok(ipList);
    }

    // 3. [AJAX] IP 추가
    @PostMapping("/api/add")
    @ResponseBody
    public ResponseEntity<?> addIp(AdminIpDTO adminIpDTO) {
        try {
            // 중복 체크
            if (adminIpMapper.checkDuplicateIp(adminIpDTO) > 0) {
                return ResponseEntity.badRequest().body("이미 등록된 IP입니다.");
            }
            adminIpMapper.insertAdminIp(adminIpDTO);
            return ResponseEntity.ok("IP가 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("IP 등록 중 오류가 발생했습니다.");
        }
    }

    // 4. [AJAX] IP 삭제
    @PostMapping("/api/delete")
    @ResponseBody
    public ResponseEntity<?> deleteIp(@RequestParam Long ipSeq) {
        try {
            adminIpMapper.deleteAdminIp(ipSeq);
            return ResponseEntity.ok("IP가 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("IP 삭제 중 오류가 발생했습니다.");
        }
    }
}