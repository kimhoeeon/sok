package org.mtf.sok.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SslVerificationController {

    // 도메인 소유권 인증 전용 컨트롤러 (물리 파일이 없어도 URL 요청 시 텍스트 내용 즉시 응답)
    @GetMapping("/.well-known/pki-validation/DE7E38C024766D67047D6C2C75C64ED0.txt")
    @ResponseBody
    public String sslTextVerification() {
        return "6A887A35550BF31128759C8862278525F500CC8AEBA7645D5869098111F7923B\n" +
                "comodoca.com";
    }
}