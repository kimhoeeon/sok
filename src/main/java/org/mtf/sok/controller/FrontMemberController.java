package org.mtf.sok.controller;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FrontMemberController {

    @Autowired
    private MemberMapper memberMapper;

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
            // 아이디 중복 체크 방어 로직 (프론트에서도 하지만 서버에서도 한 번 더 체크)
            if (memberMapper.checkDuplicateId(memberDTO.getMbrId()) > 0) {
                return ResponseEntity.badRequest().body("이미 사용중인 아이디입니다.");
            }

            // TODO: bizFile(사업자등록증)이 존재할 경우 파일 스토리지 업로드 로직 추가 필요
            // if (bizFile != null && !bizFile.isEmpty()) { ... }

            memberMapper.insertMember(memberDTO);
            return ResponseEntity.ok("회원가입이 성공적으로 완료되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("가입 처리 중 오류가 발생했습니다.");
        }
    }
}