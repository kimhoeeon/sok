package org.mtf.sok.service;

import org.mtf.sok.domain.DevRequestDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.HashMap;
import java.util.Map;

@Service
public class BizppurioService {

    @Value("${bizppurio.api.url:https://api.bizppurio.com/v1/message}") // 실제 API URL로 변경 필요
    private String apiUrl;

    @Value("${bizppurio.account:your_account}")
    private String account;

    // 담당자 이메일 라우팅 로직
    private String getDeveloperEmailByType(String reqType) {
        if (reqType == null) return "dev_general@agency.com"; // 기본 담당자
        switch (reqType) {
            case "기능오류":
            case "서버/DB":
                return "backend_dev@agency.com"; // 백엔드 담당자
            case "디자인수정":
            case "퍼블리싱":
                return "frontend_dev@agency.com"; // 프론트엔드 담당자
            default:
                return "pm_manager@agency.com"; // 기획/PM 담당자
        }
    }

    // 새로운 요청글 등록 시 메일 발송
    public void sendRequestAlertEmail(DevRequestDTO request) {
        String targetEmail = getDeveloperEmailByType(request.getReqType());
        String subject = "[SOK 유지보수 요청] " + request.getTitle();
        String body = String.format("새로운 요청이 등록되었습니다.\n- 유형: %s\n- 긴급여부: %s\n- 내용: %s",
                request.getReqType(), request.getUrgency(), request.getContent());

        sendBizppurioMail(targetEmail, subject, body);
    }

    // 새로운 댓글 등록 시 메일 발송
    public void sendCommentAlertEmail(DevRequestDTO request, String commentContent, String writerId) {
        String targetEmail = getDeveloperEmailByType(request.getReqType());
        String subject = "[SOK 유지보수 댓글] " + request.getTitle() + " 에 새 댓글이 달렸습니다.";
        String body = String.format("작성자: %s\n내용: %s", writerId, commentContent);

        sendBizppurioMail(targetEmail, subject, body);
    }

    // 비즈뿌리오 API 실제 호출부 (JSON Payload 구성)
    private void sendBizppurioMail(String toEmail, String subject, String body) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer YOUR_ACCESS_TOKEN"); // 실제 토큰 로직 구현 필요

            Map<String, Object> payload = new HashMap<>();
            payload.put("account", account);
            payload.put("type", "EMAIL");
            payload.put("to", toEmail);
            payload.put("subject", subject);
            payload.put("content", body);

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(payload, headers);
            // 실제 운영 환경에서는 아래 주석을 해제하여 발송합니다.
            // ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, request, String.class);
            // System.out.println("비즈뿌리오 메일 전송 결과: " + response.getBody());
            System.out.println("비즈뿌리오 가상 전송 완료 -> To: " + toEmail + ", Subject: " + subject);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // [고도화 추가] 개발사가 상태/예정일을 변경했을 때 발주사(SOK)에게 알림 발송
    public void sendStatusChangeAlertEmail(DevRequestDTO request) {
        String targetEmail = "sok_admin@sokorea.or.kr"; // 발주사(SOK) 메인 담당자 이메일
        String subject = "[SOK 유지보수] '" + request.getTitle() + "' 티켓의 상태가 업데이트되었습니다.";

        String statusStr = convertStatusToKorean(request.getStatus());
        String dueDtStr = request.getDueDt() != null ? request.getDueDt().toString() : "미정";

        String body = String.format("요청하신 유지보수 티켓의 진행 상태가 업데이트되었습니다.\n\n- 현재 상태: %s\n- 완료 예정일: %s\n\n관리자 시스템에 접속하여 확인해 주세요.",
                statusStr, dueDtStr);

        sendBizppurioMail(targetEmail, subject, body);
    }

    private String convertStatusToKorean(String status) {
        if(status == null) return "상태 미상";
        switch(status) {
            case "WAITING": return "접수 대기";
            case "PROCESS": return "처리 진행중";
            case "DISCUSS": return "논의 필요";
            case "DONE": return "처리 완료";
            case "REJECT": return "처리 불가";
            default: return status;
        }
    }
}