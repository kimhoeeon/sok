package org.mtf.sok.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.FileCopyUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.FileTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

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

        // [보안 1차 방어] 상위 디렉토리 이동 문자열 포함 여부 검사
        if (filePath == null || filePath.contains("..") || filePath.contains("%2e") || filePath.contains("%2E")) {
            sendAlertMessage(response, "잘못된 파일 경로 요청입니다.");
            return;
        }

        // 경로 구분자 문제 해결을 위해 Paths API 사용
        // "/upload/notice/..." 에서 앞의 "/upload/" 부분을 정규식으로 안전하게 제거
        String relativePath = filePath.replaceFirst("^/?upload/", "");
        File file = Paths.get(uploadDir, relativePath).toFile();

        // [보안 2차 방어] 정규화된 경로(CanonicalPath)를 통한 실제 위치 검증[cite: 68]
        // getCanonicalPath()는 '../'나 './' 기호들을 모두 계산한 후의 최종 실제 경로를 반환합니다.[cite: 68]
        String canonicalUploadDir = new File(uploadDir).getCanonicalPath();
        String canonicalFilePath = file.getCanonicalPath();

        // 요청한 파일의 최종 위치가 업로드 폴더 내부가 아니라면 접근 차단![cite: 68]
        if (!canonicalFilePath.startsWith(canonicalUploadDir)) {
            sendAlertMessage(response, "허용되지 않은 디렉토리 접근입니다.");
            return;
        }

        // 물리적 파일 존재 여부 최종 확인
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
                // 메모리 누수를 방지하기 위해 스트림을 안전하게 닫아줍니다.[cite: 68]
                if (in != null) in.close();
                if (out != null) out.close();
            }
        } else {
            // [UX 개선] 404 페이지 대신 알림창 띄우고 뒤로가기
            sendAlertMessage(response, "요청하신 파일이 서버에 존재하지 않습니다.");
        }
    }

    // 관리자 게시판에서 글 삭제 시 호출할 물리 파일 삭제 유틸리티
    public boolean deleteLocalFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) return false;
        try {
            // 삭제 시에도 안전한 경로 병합 적용
            String relativePath = filePath.replaceFirst("^/?upload/", "");
            File targetFile = Paths.get(uploadDir, relativePath).toFile();

            if (targetFile.exists()) {
                return targetFile.delete(); // 실제 파일 삭제[cite: 68]
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private ResponseEntity<?> saveLocalFile(MultipartFile file, String subDir) {
        if (file.isEmpty()) return ResponseEntity.badRequest().body("파일이 없습니다.");
        try {
            // 디렉토리 경로 결합 시에도 Paths 사용
            File dir = Paths.get(uploadDir, subDir).toFile();
            if (!dir.exists()) dir.mkdirs();

            String originalName = file.getOriginalFilename();
            String extension = "";

            // 확장자가 없는 파일이 올라왔을 때 에러(NullPointerException) 방지[cite: 68]
            if (originalName != null && originalName.contains(".")) {
                extension = originalName.substring(originalName.lastIndexOf("."));
            }

            String savedName = UUID.randomUUID().toString() + extension;

            // 운영체제(Win/Mac/Linux) 상관없이 무조건 절대 경로로 파일 생성[cite: 68]
            File targetFile = new File(dir.getAbsolutePath(), savedName);

            // 물리적 파일 저장[cite: 68]
            file.transferTo(targetFile);

            // 저장된 DB 상대 경로 반환 로직 보완
            String fileUrl = "/upload/";
            if (subDir != null && !subDir.isEmpty()) {
                fileUrl += subDir.endsWith("/") ? subDir : subDir + "/";
            }
            fileUrl += savedName;

            return ResponseEntity.ok(fileUrl);
        } catch (IOException e) {
            // 에러가 났을 때 원인을 정확히 볼 수 있도록 콘솔에 에러 출력[cite: 68]
            e.printStackTrace();
            return ResponseEntity.status(500).body("파일 저장 실패: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("서버 내부 오류: " + e.getMessage());
        }
    }

    @GetMapping(value = "/img")
    public ResponseEntity<Resource> getImageFile(@RequestParam("type") String type, @RequestParam(value = "filename") String filename, WebRequest webRequest) {
        try {
            Path uploadPath = Paths.get(uploadDir).toAbsolutePath().normalize();

            String subDir;
            switch (type) {
                case "blog":
                    subDir = "blog";
                    break;
                case "instagram":
                    subDir = "instagram";
                    break;
                case "promoter":
                    subDir = "promoter";
                    break;
                default:
                    return ResponseEntity.badRequest().build();
            }

            // 1. Path.resolve()를 이용한 깔끔한 경로 결합
            // 2. .normalize()를 반드시 호출하여 ../ 등의 상대경로 문자를 최종 절대경로로 평가 (보안 핵심)
            Path filePath = uploadPath.resolve(subDir).resolve(filename).normalize();

            // 3. 디렉토리 탐색 취약점 완벽 차단
            if (!filePath.startsWith(uploadPath)) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }

            if (!Files.isRegularFile(filePath) || !Files.isReadable(filePath)) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }

            FileTime lastModifiedTime = Files.getLastModifiedTime(filePath);
            long lastModifiedMillis = lastModifiedTime.toMillis();
            long size = Files.size(filePath);

            String etag = String.format("W/\"%d-%d\"", size, lastModifiedMillis);

            if (webRequest.checkNotModified(etag, lastModifiedMillis)) {
                return ResponseEntity.status(HttpStatus.NOT_MODIFIED).build();
            }

            // MIME 결정
            String mimeType = Files.probeContentType(filePath);
            MediaType mediaType = Optional.ofNullable(mimeType)
                    .map(MediaType::parseMediaType)
                    .orElse(MediaType.APPLICATION_OCTET_STREAM);

            UrlResource resource = new UrlResource(filePath.toUri());

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(mediaType);
            headers.setETag(etag);
            headers.setLastModified(lastModifiedMillis);

            // 캐시
            headers.setCacheControl(CacheControl.maxAge(7, TimeUnit.DAYS).cachePublic());

            return new ResponseEntity<>(resource, headers, HttpStatus.OK);
        } catch (MalformedURLException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 사용자 알림창 처리를 위한 유틸리티 메서드
    private void sendAlertMessage(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('" + message + "');");
        out.println("history.back();");
        out.println("</script>");
        out.flush();
    }
}