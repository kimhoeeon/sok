package org.mtf.sok.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.FileCopyUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
public class FileController {

    @Value("${file.upload.dir}")
    private String uploadDir;

    // [1] 에디터 이미지 업로드 (관리자 전용 - /mng/ 경로 명시)
    @PostMapping("/mng/file/uploadImage")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadEditorImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> responseData = new HashMap<>();

        // 기존 공통 로직을 그대로 재활용하여 파일 저장 수행
        ResponseEntity<?> result = saveLocalFile(file, "editor/");

        // 저장 성공 시 (200 OK) JSON 규격에 맞게 포장
        if (result.getStatusCode().is2xxSuccessful()) {
            responseData.put("responseCode", "success");
            responseData.put("url", result.getBody()); // saveLocalFile이 반환한 String URL
            return ResponseEntity.ok(responseData);
        }
        // 저장 실패 시 에러 메시지 포장
        else {
            responseData.put("responseCode", "error");
            responseData.put("message", result.getBody());
            return ResponseEntity.status(result.getStatusCode()).body(responseData);
        }
    }

    // [2] 게시판 일반 첨부파일 업로드 (관리자 전용 - /mng/ 경로 명시)
    @PostMapping("/mng/file/uploadAttachment")
    public ResponseEntity<?> uploadAttachment(@RequestParam("file") MultipartFile file) {
        return saveLocalFile(file, "attachments/");
    }

    // [3] 로컬 첨부파일 다운로드 로직 (일반 사용자 접근 가능 - /file/download 로 분리)
    @GetMapping("/file/download")
    public void downloadFile(@RequestParam("filePath") String filePath,
                             @RequestParam("fileName") String fileName,
                             HttpServletResponse response) throws IOException {

        // ★ [보안 1차 방어] 상위 디렉토리 이동 문자열 포함 여부 검사
        if (filePath == null || filePath.contains("..") || filePath.contains("%2e") || filePath.contains("%2E")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 파일 경로 요청입니다.");
            return;
        }

        // filePath는 "/upload/attachments/uuid.ext" 형태이므로 실제 물리 경로로 변환
        String realPath = uploadDir + filePath.replace("/upload/", "");
        File file = new File(realPath);

        // ★ [보안 2차 방어] 정규화된 경로(CanonicalPath)를 통한 실제 위치 검증
        // getCanonicalPath()는 '../'나 './' 기호들을 모두 계산한 후의 최종 실제 경로를 반환합니다.
        String canonicalUploadDir = new File(uploadDir).getCanonicalPath();
        String canonicalFilePath = file.getCanonicalPath();

        // 요청한 파일의 최종 위치가 업로드 폴더 내부가 아니라면 접근 차단!
        if (!canonicalFilePath.startsWith(canonicalUploadDir)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "허용되지 않은 디렉토리 접근입니다.");
            return;
        }

        if (file.exists()) {
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
            response.setContentLength((int) file.length());

            BufferedInputStream in = null;
            BufferedOutputStream out = null;
            try {
                in = new BufferedInputStream(new FileInputStream(file));
                out = new BufferedOutputStream(response.getOutputStream());
                FileCopyUtils.copy(in, out);
                out.flush();
            } finally {
                // 메모리 누수를 방지하기 위해 스트림을 안전하게 닫아줍니다.
                if (in != null) in.close();
                if (out != null) out.close();
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
        }
    }

    // 관리자 게시판에서 글 삭제 시 호출할 물리 파일 삭제 유틸리티
    public boolean deleteLocalFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) return false;
        try {
            // DB에 저장된 "/upload/notice/xxx.png" 경로를 실제 서버의 물리 경로로 변환
            String realPath = uploadDir + filePath.replace("/upload/", "");
            File targetFile = new File(realPath);

            if (targetFile.exists()) {
                return targetFile.delete(); // 실제 파일 삭제
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private ResponseEntity<?> saveLocalFile(MultipartFile file, String subDir) {
        if (file.isEmpty()) return ResponseEntity.badRequest().body("파일이 없습니다.");
        try {
            String dirPath = uploadDir + subDir;
            File dir = new File(dirPath);
            if (!dir.exists()) dir.mkdirs();

            String originalName = file.getOriginalFilename();
            String extension = "";

            // [핵심 수정 3] 확장자가 없는 파일이 올라왔을 때 에러(NullPointerException) 방지
            if (originalName != null && originalName.contains(".")) {
                extension = originalName.substring(originalName.lastIndexOf("."));
            }

            String savedName = UUID.randomUUID().toString() + extension;

            // 운영체제(Win/Mac/Linux) 상관없이 무조건 절대 경로로 파일 생성
            File targetFile = new File(dir.getAbsolutePath(), savedName);

            // 물리적 파일 저장
            file.transferTo(targetFile);
            String fileUrl = "/upload/" + subDir + savedName;
            return ResponseEntity.ok(fileUrl);
        } catch (IOException e) {
            // 에러가 났을 때 원인을 정확히 볼 수 있도록 콘솔에 에러 출력
            e.printStackTrace();
            return ResponseEntity.status(500).body("파일 저장 실패: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("서버 내부 오류: " + e.getMessage());
        }
    }
}