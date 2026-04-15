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
import java.util.*;

@Slf4j
@Service
public class DirectSendService {

    // [설정] DirectSend 계정 정보
    private final String SENDER_EMAIL = "business@meetingfan.com";
    private final String SENDER_NAME = "SOK 관리자"; // 발신자명
    private final String USERNAME = "meetingfan";
    private final String API_KEY = "L7QNsEQIyrAzNHO";
    private final String API_URL = "https://directsend.co.kr/index.php/api_v2/mail_change_word";

    private final String SMS_API_URL = "https://directsend.co.kr/index.php/api_v2/sms_send";
    private final String SENDER_PHONE = "024471179";

    private final ObjectMapper objectMapper = new ObjectMapper();

    // 문의 유형별 다중 수신자 맵핑
    private final Map<String, List<String>> recipientMap = new HashMap<String, List<String>>() {{
        put("유지보수", Arrays.asList("kyj@meetingfan.com"));
        put("단순문의", Arrays.asList("kyj@meetingfan.com"));
        put("기능오류", Arrays.asList("khe@meetingfan.com"));
    }};

    // --------------------------------------------------------------------
    // 1. DirectSend API 실제 통신부
    // --------------------------------------------------------------------
    public ResponseDTO processMailSend(MailRequestDTO mailRequestDTO) {
        log.info("DirectSend 메일 발송 시작: {}", mailRequestDTO.getSubject());
        ResponseDTO responseDto = new ResponseDTO();

        try {
            URL obj = new URL(API_URL);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            // 외부 서버 장애 시 우리 서버를 보호하기 위한 타임아웃 설정 (5초)
            con.setConnectTimeout(5000); // 연결 대기 시간 5초
            con.setReadTimeout(5000);    // 응답 대기 시간 5초

            con.setRequestProperty("Cache-Control", "no-cache");
            con.setRequestProperty("Content-Type", "application/json;charset=utf-8");
            con.setRequestProperty("Accept", "application/json");

            // 본문 구성 (첨부파일 내역 추가)
            StringBuilder bodyBuilder = new StringBuilder(mailRequestDTO.getBody());
            List<FileDTO> files = mailRequestDTO.getFileUrl();
            if (files != null && !files.isEmpty()) {
                bodyBuilder.append("\n<br>\n<br>---------------------------------<br>\n");
                bodyBuilder.append("※ 시스템에 첨부파일이 ").append(files.size()).append("개 등록되어 있습니다. 관리자 페이지에서 확인해 주세요.");
            }
            String body = bodyBuilder.toString().replaceAll("\"", "'");

            // JSON 파라미터 조립
            ObjectNode rootNode = objectMapper.createObjectNode();
            rootNode.put("subject", mailRequestDTO.getSubject());
            rootNode.put("body", body);
            rootNode.put("sender", SENDER_EMAIL);
            rootNode.put("sender_name", SENDER_NAME);
            rootNode.put("username", USERNAME);
            rootNode.put("key", API_KEY);

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

            // 전송 실행
            System.setProperty("jsse.enableSNIExtension", "false");
            con.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), StandardCharsets.UTF_8);
            wr.write(urlParameters);
            wr.flush();
            wr.close();

            // 결과 파싱
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            JsonNode responseObj = objectMapper.readTree(response.toString());
            if (responseObj.has("status") && "0".equals(responseObj.get("status").asText())) {
                responseDto.setResultCode("SUCCESS");
                responseDto.setResultMessage("성공");
                log.info("DirectSend 메일 발송 성공");
            } else {
                responseDto.setResultCode("FAIL");
                responseDto.setResultMessage("실패");
                log.warn("DirectSend 메일 발송 실패: {}", response.toString());
            }
        } catch (Exception e) {
            log.error("Mail Send Error", e);
            responseDto.setResultCode("FAIL");
            responseDto.setResultMessage(e.getMessage());
        }

        return responseDto;
    }

    // --------------------------------------------------------------------
    // 2. 비즈니스 로직부 (라우팅 및 메세지 조립)
    // --------------------------------------------------------------------

    // 수신자 리스트 추출
    private List<String> getTargetEmails(String reqType) {
        return recipientMap.getOrDefault(reqType, Arrays.asList("kyj@meetingfan.com")); // 매칭 안될 경우 기본값
    }

    // [1] 새 요청 등록 알림
    public void sendRequestAlertEmail(DevRequestDTO request) {
        String reqType = request.getReqType() != null ? request.getReqType() : "유지보수";
        List<String> targetEmails = getTargetEmails(reqType);

        String urgencyTag = "Y".equals(request.getUrgency()) ? "(🚨긴급)" : "";
        String subject = "[SOK - " + reqType + urgencyTag + "] " + request.getTitle();

        // [핵심] 내용이 Null일 경우를 대비한 Null-Safe 처리 (NPE 방지)
        String safeContent = (request.getContent() != null) ? request.getContent().replaceAll("\n", "<br>") : "내용 없음";

        String body = String.format(
                "<div style='border:1px solid #ddd; padding:20px; border-radius:5px; font-family:sans-serif;'>" +
                        "<h3 style='color:#333;'>새로운 티켓이 등록되었습니다.</h3>" +
                        "<ul style='line-height:1.8;'>" +
                        "<li><b>요청 유형 :</b> <span style='color:#0d6efd; font-weight:bold;'>%s</span></li>" +
                        "<li><b>긴급 여부 :</b> %s</li>" +
                        "<li><b>요청 담당 :</b> %s</li>" +
                        "</ul>" +
                        "<hr style='border:0; border-top:1px dashed #ccc; margin:20px 0;'>" +
                        "<b>[요청 내용]</b><br><br>%s" +
                        "</div>",
                reqType,
                "Y".equals(request.getUrgency()) ? "<span style='color:red; font-weight:bold;'>긴급 처리 요망</span>" : "일반",
                request.getRegId(),
                safeContent
        );

        sendMailToMultipleReceivers(targetEmails, subject, body);
    }

    // [2] 새 댓글(코멘트) 알림
    public void sendCommentAlertEmail(DevRequestDTO request, String commentContent, String writerId) {
        String reqType = request.getReqType() != null ? request.getReqType() : "유지보수";
        List<String> targetEmails = getTargetEmails(reqType);

        String subject = "[SOK - " + reqType + " 피드백] '" + request.getTitle() + "' 티켓에 새 댓글이 달렸습니다.";

        String body = String.format(
                "<div style='background-color:#f8f9fa; padding:20px; border-radius:5px; font-family:sans-serif;'>" +
                        "<p><b>%s</b> 님이 아래와 같은 코멘트를 남겼습니다.</p>" +
                        "<div style='background-color:#fff; padding:15px; border:1px solid #ddd; border-radius:3px;'>" +
                        "%s</div>" +
                        "</div>",
                writerId, commentContent
        );

        sendMailToMultipleReceivers(targetEmails, subject, body);
    }

    // [3] 상태 변경 알림 (관리자에게 발송)
    public void sendStatusChangeAlertEmail(DevRequestDTO request) {
        List<String> targetEmails = Arrays.asList("sokorea@sokorea.or.kr");

        String reqType = request.getReqType() != null ? request.getReqType() : "유지보수";
        String subject = "[SOK - " + reqType + " 업데이트] '" + request.getTitle() + "' 티켓의 상태가 변경되었습니다.";

        String statusStr = convertStatusToKorean(request.getStatus());
        String dueDtStr = request.getDueDt() != null ? request.getDueDt().toString() : "미정";

        String body = String.format(
                "<div style='border:1px solid #ddd; padding:20px; border-radius:5px; font-family:sans-serif;'>" +
                        "<h3 style='color:#333;'>티켓 진행 상태 업데이트 안내</h3>" +
                        "<p>요청하신 유지보수 티켓의 처리 상태가 아래와 같이 변경되었습니다.</p>" +
                        "<ul style='line-height:1.8;'>" +
                        "<li><b>현재 상태 :</b> <span style='color:#198754; font-weight:bold;'>%s</span></li>" +
                        "<li><b>완료 예정일 :</b> %s</li>" +
                        "</ul>" +
                        "<p>관리자 시스템에 접속하여 상세 내역을 확인해 주세요.</p>" +
                        "</div>",
                statusStr, dueDtStr
        );

        sendMailToMultipleReceivers(targetEmails, subject, body);
    }

    // 다중 수신자 발송 래퍼
    private void sendMailToMultipleReceivers(List<String> emails, String subject, String body) {
        MailRequestDTO mailReq = new MailRequestDTO();
        mailReq.setSubject(subject);
        mailReq.setBody(body);

        List<MailRequestDTO.Receiver> receivers = new ArrayList<>();
        for (String email : emails) {
            receivers.add(new MailRequestDTO.Receiver("담당자", email));
        }
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
            case "REJECT": return "처리 불가(반려)";
            default: return status;
        }
    }

    // --------------------------------------------------------------------
    // 3. [신규 추가] 프론트엔드 비밀번호 찾기 (이메일 & SMS) 로직
    // --------------------------------------------------------------------

    // 임시 비밀번호 이메일 발송
    public void sendTempPwMail(String toEmail, String tempPw) {
        String subject = "[스페셜올림픽코리아] 임시 비밀번호 발급 안내";
        String body = String.format(
                "<div style='margin:30px; border:1px solid #ddd; padding:30px; font-family:sans-serif;'>"
                        + "<h2 style='color:#e41b13;'>임시 비밀번호 발급 안내</h2>"
                        + "<p>안녕하세요. 스페셜올림픽코리아입니다.</p>"
                        + "<p>요청하신 임시 비밀번호가 아래와 같이 발급되었습니다.</p>"
                        + "<div style='background:#f9f9f9; padding:20px; margin:20px 0; text-align:center;'>"
                        + "임시 비밀번호: <strong style='color:#333; font-size:24px; letter-spacing:2px;'>%s</strong>"
                        + "</div>"
                        + "<p>보안을 위해 로그인 후 마이페이지에서 <strong>반드시 비밀번호를 변경</strong>해 주시기 바랍니다.</p>"
                        + "<p style='color:#888; font-size:12px; margin-top:30px;'>본 메일은 발신 전용이므로 회신되지 않습니다.</p>"
                        + "</div>",
                tempPw
        );
        // 기존에 만들어져 있는 다중 수신자 래퍼 메서드를 재활용합니다.
        sendMailToMultipleReceivers(Collections.singletonList(toEmail), subject, body);
    }

    // 임시 비밀번호 SMS 발송
    public void sendTempPwSms(String toPhone, String tempPw) {
        String message = String.format("[스페셜올림픽코리아]\n요청하신 임시 비밀번호는 [%s] 입니다. 로그인 후 변경해 주세요.", tempPw);
        String cleanPhone = toPhone.replaceAll("-", "");
        processSmsSend(cleanPhone, message);
    }

    // DirectSend API 실제 통신부 (SMS 전용)
    public ResponseDTO processSmsSend(String receiver, String message) {
        log.info("DirectSend SMS 발송 시작: 수신자 {}", receiver);
        ResponseDTO responseDto = new ResponseDTO();

        try {
            URL obj = new URL(SMS_API_URL);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            con.setConnectTimeout(5000);
            con.setReadTimeout(5000);
            con.setRequestProperty("Cache-Control", "no-cache");
            con.setRequestProperty("Content-Type", "application/json;charset=utf-8");
            con.setRequestProperty("Accept", "application/json");

            // JSON 파라미터 조립 (DirectSend SMS 규격)
            ObjectNode rootNode = objectMapper.createObjectNode();
            rootNode.put("message", message);
            rootNode.put("sender", SENDER_PHONE);
            rootNode.put("username", USERNAME);
            rootNode.put("key", API_KEY);

            ArrayNode receiverArray = objectMapper.createArrayNode();
            ObjectNode receiverNode = objectMapper.createObjectNode();
            receiverNode.put("mobile", receiver);
            receiverArray.add(receiverNode);

            rootNode.set("receiver", receiverArray);

            String urlParameters = objectMapper.writeValueAsString(rootNode);

            // 전송 실행
            System.setProperty("jsse.enableSNIExtension", "false");
            con.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), StandardCharsets.UTF_8);
            wr.write(urlParameters);
            wr.flush();
            wr.close();

            // 결과 파싱
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            JsonNode responseObj = objectMapper.readTree(response.toString());
            if (responseObj.has("status") && "0".equals(responseObj.get("status").asText())) {
                responseDto.setResultCode("SUCCESS");
                responseDto.setResultMessage("성공");
                log.info("DirectSend SMS 발송 성공");
            } else {
                responseDto.setResultCode("FAIL");
                responseDto.setResultMessage("실패");
                log.warn("DirectSend SMS 발송 실패: {}", response.toString());
            }
        } catch (Exception e) {
            log.error("SMS Send Error", e);
            responseDto.setResultCode("FAIL");
            responseDto.setResultMessage(e.getMessage());
        }

        return responseDto;
    }
}