package org.mtf.sok.controller;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.mtf.sok.service.NaverStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FrontMemberController {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private NaverStorageService naverStorageService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 1. 단체 회원가입 페이지 이동
    @GetMapping("/join")
    public String joinForm() {
        return "member/join";
    }

    // 2. 회원가입 처리 (AJAX)
    @PostMapping("/joinProc")
    @ResponseBody
    public ResponseEntity<?> joinProc(MemberDTO memberDTO, MultipartFile bizFile) {
        try {
            // 1) 아이디 중복 체크 방어 로직
            if (memberMapper.checkDuplicateId(memberDTO.getMbrId()) > 0) {
                return ResponseEntity.badRequest().body("이미 사용중인 아이디입니다.");
            }

            if (memberMapper.checkDuplicateEmail(memberDTO.getEmail(), null) > 0) {
                return ResponseEntity.badRequest().body("이미 가입된 이메일 입니다. 본인이 가입한 경우가 아닐 경우, 관리자에게 문의해 주세요.");
            }

            if (memberMapper.checkDuplicatePhone(memberDTO.getPhone(), null) > 0) {
                return ResponseEntity.badRequest().body("이미 가입된 연락처 입니다. 본인이 가입한 경우가 아닐 경우, 관리자에게 문의해 주세요.");
            }

            // 2) 사업자등록증 파일이 존재할 경우 네이버 클라우드 스토리지에 업로드
            if (bizFile != null && !bizFile.isEmpty()) {
                // "member/biz" 폴더 하위에 저장하고 생성된 URL 반환
                String fileUrl = naverStorageService.uploadFile(bizFile, "member/biz");
                memberDTO.setBizFilePath(fileUrl);
            }

            // 3) 비밀번호 안전하게 암호화 (Spring Security)
            memberDTO.setMbrPw(passwordEncoder.encode(memberDTO.getMbrPw()));

            // 4) DB 저장
            memberMapper.insertMember(memberDTO);

            return ResponseEntity.ok("회원가입이 성공적으로 완료되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("가입 처리 중 오류가 발생했습니다.");
        }
    }
}