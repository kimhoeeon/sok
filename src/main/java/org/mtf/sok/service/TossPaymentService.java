package org.mtf.sok.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@Service
public class TossPaymentService {

    @Value("${toss.secret.key}")
    private String secretKey;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();

    // ★ 신규 추가: 생성자를 통해 RestTemplate 초기화 시 UTF-8 인코딩 강제 적용
    public TossPaymentService() {
        this.restTemplate = new RestTemplate();
        this.restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    }

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

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            return objectMapper.readTree(response.getBody());
        } catch (HttpStatusCodeException e) {
            // [핵심] 토스 측에서 반환한 4xx, 5xx 에러 본문을 파싱하여 정확한 실패 사유를 추출
            JsonNode errorNode = objectMapper.readTree(e.getResponseBodyAsString());
            throw new Exception(errorNode.has("message") ? errorNode.get("message").asText() : "결제 승인 중 오류가 발생했습니다.");
        }
    }

    // 토스페이먼츠 결제 취소 API 호출
    public JsonNode cancelPayment(String paymentKey, String cancelReason) throws Exception {
        String url = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";

        String authKey = Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth(authKey);
        headers.setContentType(MediaType.APPLICATION_JSON);

        // 취소 사유를 담아서 전송
        Map<String, Object> params = new HashMap<>();
        params.put("cancelReason", cancelReason);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            return objectMapper.readTree(response.getBody());
        } catch (HttpStatusCodeException e) {
            JsonNode errorNode = objectMapper.readTree(e.getResponseBodyAsString());
            throw new Exception(errorNode.has("message") ? errorNode.get("message").asText() : "결제 취소 중 오류가 발생했습니다.");
        }
    }

    // ==========================================
    // 정기기부: 1. 빌링키 발급 API 호출
    // ==========================================
    public JsonNode issueBillingKey(String authKey, String customerKey) throws Exception {
        String url = "https://api.tosspayments.com/v1/billing/authorizations/issue";
        String authHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth(authHeader);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> params = new HashMap<>();
        params.put("authKey", authKey);
        params.put("customerKey", customerKey);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            return objectMapper.readTree(response.getBody());
        } catch (HttpStatusCodeException e) {
            JsonNode errorNode = objectMapper.readTree(e.getResponseBodyAsString());
            throw new Exception(errorNode.has("message") ? errorNode.get("message").asText() : "빌링키 발급 중 오류가 발생했습니다.");
        }
    }

    // ==========================================
    // 정기기부: 2. 빌링키를 이용한 결제 승인 API 호출
    // ==========================================
    public JsonNode confirmBilling(String billingKey, String customerKey, String orderId, Long amount) throws Exception {
        String url = "https://api.tosspayments.com/v1/billing/" + billingKey;
        String authHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth(authHeader);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> params = new HashMap<>();
        params.put("customerKey", customerKey);
        params.put("orderId", orderId);
        params.put("amount", amount);
        params.put("orderName", "스페셜올림픽코리아 정기후원금");

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            return objectMapper.readTree(response.getBody());
        } catch (HttpStatusCodeException e) {
            JsonNode errorNode = objectMapper.readTree(e.getResponseBodyAsString());
            throw new Exception(errorNode.has("message") ? errorNode.get("message").asText() : "정기결제 승인 중 오류가 발생했습니다.");
        }
    }

    // ==========================================
    // 정기기부: 3. 정기결제 취소(빌링키 해지) API 호출
    // ==========================================
    public void expireBillingKey(String billingKey) throws Exception {
        // [주의] 토스페이먼츠 최신 API 규격: POST /v1/billing/{billingKey}/expire
        String url = "https://api.tosspayments.com/v1/billing/" + billingKey + "/expire";
        String authHeader = Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

        HttpHeaders headers = new HttpHeaders();
        headers.setBasicAuth(authHeader);
        headers.setContentType(MediaType.APPLICATION_JSON);

        // expire API는 별도의 body 파라미터가 필요 없습니다.
        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        } catch (HttpStatusCodeException e) {
            JsonNode errorNode = objectMapper.readTree(e.getResponseBodyAsString());
            throw new Exception(errorNode.has("message") ? errorNode.get("message").asText() : "빌링키(정기결제) 해지 중 오류가 발생했습니다.");
        }
    }

}