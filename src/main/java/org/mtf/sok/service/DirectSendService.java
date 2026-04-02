package org.mtf.sok.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.mtf.sok.domain.DevRequestDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.MailRequestDTO;
import org.mtf.sok.domain.ResponseDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class DirectSendService {

    // [설정] DirectSend 계정 정보
    private final String SENDER_EMAIL = "business@meetingfan.com";
    private final String SENDER_NAME = "SOK 관리자"; // 발신자명
    private final String USERNAME = "meetingfan";
    private final String API_KEY = "L7QNsEQIyrAzNHO";
    private final String API_URL = "https://directsend.co.kr/index.php/api_v2/mail_change_word";

    private final ObjectMapper objectMapper = new ObjectMapper();

    // --------------------------------------------------------------------
    // 1. DirectSend API 실제 통신부 (Jackson JSON 고도화)
    // --------------------------------------------------------------------
    public ResponseDTO processMailSend(MailRequestDTO mailRequestDTO) {
        log.info("DirectSend 메일 발송 시작: {}", mailRequestDTO.getSubject());
        ResponseDTO responseDto = new ResponseDTO();

        try {
            URL obj = new URL(API_URL);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestProperty("Cache-Control", "no-cache");
            con.setRequestProperty("Content-Type", "application/json;charset=utf-8");
            con.setRequestProperty("Accept", "application/json");

            // 1-1. 본문 구성 및 첨부파일 내역 추가
            String subject = mailRequestDTO.getSubject();
            StringBuilder bodyBuilder = new StringBuilder(mailRequestDTO.getBody());

            List<FileDTO> files = mailRequestDTO.getFileUrl();
            if (files != null && !files.isEmpty()) {
                bodyBuilder.append("\n<br>\n<br>---------------------------------<br>\n");
                bodyBuilder.append("※ 첨부파일: ").append(files.size()).append("개");
            }
            String body = bodyBuilder.toString().replaceAll("\"", "'");

            // 1-2. JSON 파라미터 조립 (안전한 ObjectMapper 사용)
            ObjectNode rootNode = objectMapper.createObjectNode();
            rootNode.put("subject", subject);
            rootNode.put("body", body);
            rootNode.put("sender", SENDER_EMAIL);
            rootNode.put("sender_name", SENDER_NAME);
            rootNode.put("username", USERNAME);
            rootNode.put("key", API_KEY);

            if (mailRequestDTO.getTemplate() != null && !mailRequestDTO.getTemplate().isEmpty()) {
                rootNode.put("template", mailRequestDTO.getTemplate());
            }

            ArrayNode receiverArray = objectMapper.createArrayNode();
            if (mailRequestDTO.getReceiver() != null) {
                for (MailRequestDTO.Receiver r : mailRequestDTO.getReceiver()) {
                    ObjectNode receiverNode = objectMapper.createObjectNode();
                    receiverNode.put("email", r.getEmail());
                    receiverNode.put("name", r.getName());
                    receiverArray.add(receiverNode);
                }
            }
            rootNode.set("receiver", receiverArray);

            String urlParameters = objectMapper.writeValueAsString(rootNode);

            // 1-3. 전송 실행
            System.setProperty("jsse.enableSNIExtension", "false");
            con.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), StandardCharsets.UTF_8);
            wr.write(urlParameters);
            wr.flush();
            wr.close();

            // 1-4. 결과 파싱
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            JsonNode responseObj = objectMapper.readTree(response.toString());
            if (responseObj.has("status")) {
                String mailResponseCode = responseObj.get("status").asText();
                if ("0".equals(mailResponseCode)) {
                    responseDto.setResultCode("SUCCESS");
                    responseDto.setResultMessage("성공");
                    log.info("DirectSend 메일 발송 성공");
                } else {
                    responseDto.setResultCode("FAIL");
                    responseDto.setResultMessage("[" + mailResponseCode + "] " + (responseObj.has("msg") ? responseObj.get("msg").asText() : ""));
                    log.warn("DirectSend 메일 발송 실패: {}", responseDto.getResultMessage());
                }
            } else {
                responseDto.setResultCode("FAIL");
                responseDto.setResultMessage("응답 형식 오류");
            }

        } catch (Exception e) {
            log.error("Mail Send Error", e);
            responseDto.setResultCode("FAIL");
            responseDto.setResultMessage(e.getMessage());
        }

        return responseDto;
    }

    // --------------------------------------------------------------------
    // 2. 비즈니스 로직부
    // --------------------------------------------------------------------
    private String getDeveloperEmailByType(String reqType) {
        if (reqType == null) return "sokorea@sokorea.or.kr";
        switch (reqType) {
            case "기능오류":
            case "서버/DB":
                return "backend_dev@agency.com";
            case "디자인수정":
            case "퍼블리싱":
                return "frontend_dev@agency.com";
            default:
                return "pm_manager@agency.com";
        }
    }

    public void sendRequestAlertEmail(DevRequestDTO request) {
        String targetEmail = getDeveloperEmailByType(request.getReqType());
        String subject = "[SOK 유지보수 요청] " + request.getTitle();
        String body = String.format("새로운 요청이 등록되었습니다.<br><br>- 유형: %s<br>- 긴급여부: %s<br>- 내용: %s",
                request.getReqType(), request.getUrgency(), request.getContent());

        sendMailWrapper(targetEmail, subject, body);
    }

    public void sendCommentAlertEmail(DevRequestDTO request, String commentContent, String writerId) {
        String targetEmail = getDeveloperEmailByType(request.getReqType());
        String subject = "[SOK 유지보수 댓글] " + request.getTitle() + " 에 새 댓글이 달렸습니다.";
        String body = String.format("작성자: %s<br><br>내용: %s", writerId, commentContent);

        sendMailWrapper(targetEmail, subject, body);
    }

    public void sendStatusChangeAlertEmail(DevRequestDTO request) {
        String targetEmail = "sok_admin@sokorea.or.kr";
        String subject = "[SOK 유지보수] '" + request.getTitle() + "' 티켓의 상태가 업데이트되었습니다.";
        String statusStr = convertStatusToKorean(request.getStatus());
        String dueDtStr = request.getDueDt() != null ? request.getDueDt().toString() : "미정";

        String body = String.format("요청하신 유지보수 티켓의 진행 상태가 업데이트되었습니다.<br><br>- 현재 상태: %s<br>- 완료 예정일: %s<br><br>관리자 시스템에 접속하여 확인해 주세요.",
                statusStr, dueDtStr);

        sendMailWrapper(targetEmail, subject, body);
    }

    private void sendMailWrapper(String toEmail, String subject, String body) {
        MailRequestDTO mailReq = new MailRequestDTO();
        mailReq.setSubject(subject);
        mailReq.setBody(body);

        List<MailRequestDTO.Receiver> receivers = new ArrayList<>();
        receivers.add(new MailRequestDTO.Receiver("유지보수 담당자", toEmail));
        mailReq.setReceiver(receivers);

        processMailSend(mailReq);
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