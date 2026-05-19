package org.mtf.sok.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.mtf.sok.domain.CertificateDTO;
import org.mtf.sok.domain.DevRequestDTO;
import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.MailRequestDTO;
import org.mtf.sok.domain.ResponseDTO;
import org.mtf.sok.domain.VolunteerDTO;
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
    private final String SENDER_NAME = "SOK 관리자";
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

            con.setConnectTimeout(5000);
            con.setReadTimeout(5000);

            con.setRequestProperty("Cache-Control", "no-cache");
            con.setRequestProperty("Content-Type", "application/json;charset=utf-8");
            con.setRequestProperty("Accept", "application/json");

            StringBuilder bodyBuilder = new StringBuilder(mailRequestDTO.getBody());
            List<FileDTO> files = mailRequestDTO.getFileUrl();
            if (files != null && !files.isEmpty()) {
                bodyBuilder.append("\n<br>\n<br>---------------------------------<br>\n");
                bodyBuilder.append("※ 시스템에 첨부파일이 ").append(files.size()).append("개 등록되어 있습니다. 관리자 페이지에서 확인해 주세요.");
            }
            String body = bodyBuilder.toString().replaceAll("\"", "'");

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

            System.setProperty("jsse.enableSNIExtension", "false");
            con.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), StandardCharsets.UTF_8);
            wr.write(urlParameters);
            wr.flush();
            wr.close();

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

    private List<String> getTargetEmails(String reqType) {
        return recipientMap.getOrDefault(reqType, Arrays.asList("kyj@meetingfan.com"));
    }

    public void sendRequestAlertEmail(DevRequestDTO request) {
        String reqType = request.getReqType() != null ? request.getReqType() : "유지보수";
        List<String> targetEmails = getTargetEmails(reqType);

        String urgencyTag = "Y".equals(request.getUrgency()) ? "(🚨긴급)" : "";
        String subject = "[SOK - " + reqType + urgencyTag + "] " + request.getTitle();

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

    // --------------------------------------------------------------------
    // 발주사 관리자(sokadmin)용 접수 알림 연동
    // --------------------------------------------------------------------

    public void sendVolunteerApplyAlert(VolunteerDTO volunteer) {
        List<String> targetEmails = Arrays.asList("sokorea@sokorea.or.kr");
        String subject = "[SOK] 새로운 자원봉사 신청이 접수되었습니다.";
        String body = String.format(
                "<div style='border:1px solid #ddd; padding:20px; border-radius:5px; font-family:sans-serif;'>" +
                        "<h3 style='color:#333;'>신규 자원봉사 신청 안내</h3>" +
                        "<ul style='line-height:1.8;'>" +
                        "<li><b>신청자(단체)명 :</b> %s</li>" +
                        "<li><b>지원 분야 :</b> %s</li>" +
                        "<li><b>참여 행사명 :</b> %s</li>" +
                        "<li><b>연락처 :</b> %s</li>" +
                        "</ul>" +
                        "<p>관리자 대시보드(자원봉사 관리)에서 상세 내용을 확인해 주세요.</p>" +
                        "</div>",
                volunteer.getApplyNm(), volunteer.getSupportArea(),
                volunteer.getEventNm() != null ? volunteer.getEventNm() : "미지정",
                volunteer.getPhone()
        );
        sendMailToMultipleReceivers(targetEmails, subject, body);
    }

    public void sendCertificateApplyAlert(CertificateDTO cert) {
        List<String> targetEmails = Arrays.asList("sokorea@sokorea.or.kr");
        String subject = "[SOK] 새로운 증명서 발급 신청이 접수되었습니다.";

        String typeStr = cert.getCertType() != null ? cert.getCertType() : "미지정";
        String belongToStr = cert.getBelongTo() != null && !cert.getBelongTo().isEmpty() ? cert.getBelongTo() : "소속 없음";

        String body = String.format(
                "<div style='border:1px solid #ddd; padding:20px; border-radius:5px; font-family:sans-serif;'>" +
                        "<h3 style='color:#333;'>신규 증명서 발급 신청 안내</h3>" +
                        "<ul style='line-height:1.8;'>" +
                        "<li><b>신청자명 :</b> %s</li>" +
                        "<li><b>소속 :</b> %s</li>" +
                        "<li><b>증명서 종류 :</b> %s</li>" +
                        "<li><b>발급 용도 :</b> %s</li>" +
                        "<li><b>연락처 :</b> %s</li>" +
                        "</ul>" +
                        "<p>관리자 대시보드(증명서 관리)에서 발급 처리를 진행해 주세요.</p>" +
                        "</div>",
                cert.getApplyNm(), belongToStr, typeStr, cert.getUsePurpose(), cert.getPhone()
        );
        sendMailToMultipleReceivers(targetEmails, subject, body);
    }

    private void sendMailToMultipleReceivers(List<String> emails, String subject, String body) {
        MailRequestDTO mailReq = new MailRequestDTO();
        mailReq.setSubject(subject);
        mailReq.setBody(body);

        List<MailRequestDTO.Receiver> receivers = new ArrayList<>();
        for (String email : emails) {
            receivers.add(new MailRequestDTO.Receiver("SOK 담당자", email));
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
    // 프론트엔드 비밀번호 찾기 (이메일 & SMS) 로직
    // --------------------------------------------------------------------

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
        sendMailToMultipleReceivers(Collections.singletonList(toEmail), subject, body);
    }

    public void sendTempPwSms(String toPhone, String tempPw) {
        String message = String.format("[스페셜올림픽코리아]\n요청하신 임시 비밀번호는 [%s] 입니다. 로그인 후 변경해 주세요.", tempPw);
        String cleanPhone = toPhone.replaceAll("-", "");
        processSmsSend(cleanPhone, message);
    }

    // --------------------------------------------------------------------
    // 증명서 처리 결과 신청자(사용자) 알림 (메일 + SMS)
    // --------------------------------------------------------------------
    public void sendCertificateResultAlert(CertificateDTO cert) {
        String statusStr = "DONE".equals(cert.getIssueStatus()) ? "발급 완료" : "발급 반려(거절)";
        String colorCode = "DONE".equals(cert.getIssueStatus()) ? "#198754" : "#dc3545"; // 성공:녹색, 반려:빨간색

        // 1. 이메일 알림
        if (cert.getEmail() != null && !cert.getEmail().trim().isEmpty()) {
            String subject = "[스페셜올림픽코리아] 요청하신 증명서의 처리 결과 안내 (" + statusStr + ")";

            StringBuilder bodyBuilder = new StringBuilder();
            bodyBuilder.append("<div style='border:1px solid #ddd; padding:20px; border-radius:5px; font-family:sans-serif;'>")
                    .append("<h3 style='color:#333;'>증명서 처리 결과 안내</h3>")
                    .append("<p><b>").append(cert.getApplyNm()).append("</b>님, 요청하신 증명서의 처리 상태가 변경되었습니다.</p>")
                    .append("<ul style='line-height:1.8;'>")
                    .append("<li><b>증명서 종류 :</b> ").append(cert.getCertType() != null ? cert.getCertType() : "미지정").append("</li>")
                    .append("<li><b>처리 상태 :</b> <span style='color:").append(colorCode).append("; font-weight:bold;'>").append(statusStr).append("</span></li>");

            // 반려 상태이고 반려 사유가 있을 경우 추가 노출
            if ("REJECT".equals(cert.getIssueStatus()) && cert.getRejectRsn() != null && !cert.getRejectRsn().isEmpty()) {
                bodyBuilder.append("<li><b>반려 사유 :</b> ").append(cert.getRejectRsn()).append("</li>");
            }

            bodyBuilder.append("</ul>")
                    .append("<p>자세한 사항은 홈페이지 '신청/참여 > 증명서 신청 > 발급상태 확인' 메뉴에서 조회하실 수 있습니다.</p>")
                    .append("</div>");

            sendMailToMultipleReceivers(Collections.singletonList(cert.getEmail()), subject, bodyBuilder.toString());
        }

        // 2. SMS 알림 동시 발송 (선택사항 - 연락처가 있는 경우)
        if (cert.getPhone() != null && !cert.getPhone().trim().isEmpty()) {
            String smsMsg = String.format("[SOK]\n%s님의 증명서 신청 건이 [%s] 처리되었습니다.\n홈페이지에서 확인해주세요.", cert.getApplyNm(), statusStr);
            String cleanPhone = cert.getPhone().replaceAll("-", "");
            processSmsSend(cleanPhone, smsMsg);
        }
    }

    // --------------------------------------------------------------------
    // 자원봉사 승인/반려 결과 신청자(사용자) 알림 (메일 + SMS)
    // --------------------------------------------------------------------
    public void sendVolunteerResultAlert(VolunteerDTO volunteer) {
        // VolunteerDTO의 상태값에 맞춰 승인/반려 문자열 및 테마 색상 지정
        String currentStatus = volunteer.getStatus() != null ? volunteer.getStatus() : "";
        String statusStr = ("DONE".equals(currentStatus) || "APPR".equals(currentStatus)) ? "승인 완료" : "반려(거절)";
        String colorCode = ("DONE".equals(currentStatus) || "APPR".equals(currentStatus)) ? "#198754" : "#dc3545";

        // 1. 이메일 알림 (이메일 정보가 있는 경우에만 발송)
        if (volunteer.getEmail() != null && !volunteer.getEmail().trim().isEmpty()) {
            String subject = "[스페셜올림픽코리아] 신청하신 자원봉사의 처리 결과 안내 (" + statusStr + ")";

            StringBuilder bodyBuilder = new StringBuilder();
            bodyBuilder.append("<div style='border:1px solid #ddd; padding:20px; border-radius:5px; font-family:sans-serif;'>")
                    .append("<h3 style='color:#333;'>자원봉사 신청 결과 안내</h3>")
                    .append("<p><b>").append(volunteer.getApplyNm()).append("</b>님, 신청하신 자원봉사의 처리 상태가 변경되었습니다.</p>")
                    .append("<ul style='line-height:1.8;'>")
                    .append("<li><b>지원 분야 :</b> ").append(volunteer.getSupportArea() != null ? volunteer.getSupportArea() : "미지정").append("</li>")
                    .append("<li><b>신청 행사명 :</b> ").append(volunteer.getEventNm() != null ? volunteer.getEventNm() : "미지정").append("</li>")
                    .append("<li><b>처리 상태 :</b> <span style='color:").append(colorCode).append("; font-weight:bold;'>").append(statusStr).append("</span></li>");

            // 반려 상태이고 반려 사유가 기재되어 있을 경우 추가 노출
            if ("REJECT".equals(currentStatus) && volunteer.getRejectRsn() != null && !volunteer.getRejectRsn().isEmpty()) {
                bodyBuilder.append("<li><b>반려 사유 :</b> ").append(volunteer.getRejectRsn()).append("</li>");
            }

            bodyBuilder.append("</ul>")
                    .append("<p>스페셜올림픽코리아에 보내주신 따뜻한 관심과 참여에 감사드립니다.</p>")
                    .append("</div>");

            sendMailToMultipleReceivers(Collections.singletonList(volunteer.getEmail()), subject, bodyBuilder.toString());
        }

        // 2. SMS 알림 동시 발송 (연락처 정보가 있는 경우에만 발송)
        if (volunteer.getPhone() != null && !volunteer.getPhone().trim().isEmpty()) {
            String smsMsg = String.format("[SOK]\n%s님의 자원봉사 신청 건이 [%s] 처리되었습니다.\n감사합니다.", volunteer.getApplyNm(), statusStr);
            String cleanPhone = volunteer.getPhone().replaceAll("-", "");
            processSmsSend(cleanPhone, smsMsg);
        }
    }

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

            System.setProperty("jsse.enableSNIExtension", "false");
            con.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), StandardCharsets.UTF_8);
            wr.write(urlParameters);
            wr.flush();
            wr.close();

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