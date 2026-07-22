package org.mtf.sok.controller;

import lombok.RequiredArgsConstructor;
import org.mtf.sok.domain.InstaTokenDTO;
import org.mtf.sok.mapper.SnsMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/mng/insta")
@RequiredArgsConstructor
public class InstaController {

    private final SnsMapper snsMapper;

    // 인스타그램 토큰 관리 페이지 렌더링
    @GetMapping("/token")
    public String tokenForm(Model model) {
        // 테이블에 저장된 토큰 상세 정보 조회
        InstaTokenDTO tokenInfo = snsMapper.selectInstaTokenInfo();
        model.addAttribute("tokenInfo", tokenInfo);

        return "mng/insta/token";
    }

    // 인스타그램 토큰 저장/수정 (AJAX 처리)
    @ResponseBody
    @PostMapping("/saveToken")
    public Map<String, Object> saveToken(@RequestParam("token") String token) {
        Map<String, Object> response = new HashMap<>();

        try {
            // SnsMapper.xml에 이미 구현된 updateInstaToken 호출
            snsMapper.updateInstaToken(token);
            response.put("result", "success");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("result", "fail");
            response.put("message", "토큰 저장 중 오류가 발생했습니다.");
        }

        return response;
    }
}