package org.mtf.sok.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@Service
public class TossPaymentService {

    @Value("${toss.secret.key}")
    private String secretKey;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    // 토스페이먼츠 최종 결제 승인 API 호출
    public JsonNode confirmPayment(String paymentKey, String orderId, Long amount) throws Exception {
        String url = "https://api.tosspayments.com/v1/payments/confirm";

        // 1. 시크릿 키를 Base64로 인코딩 (토스 규격: secretKey + ":")
        String authKey = Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

        // 2. HTTP 헤더 세팅
        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth(authKey); // Base64 인코딩된 키로 Basic Auth 설정
        headers.setContentType(MediaType.APPLICATION_JSON);

        // 3. 요청 바디 세팅
        Map<String, Object> params = new HashMap<>();
        params.put("paymentKey", paymentKey);
        params.put("orderId", orderId);
        params.put("amount", amount);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        // 4. 토스 서버로 승인 요청
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        // 5. 결과 JSON 파싱
        return objectMapper.readTree(response.getBody());
    }
}