package org.mtf.sok.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.FileCopyUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.UUID;

@RestController
public class FileController {

    @Value("${file.upload.dir}")
    private String uploadDir;

    // [1] 에디터 이미지 업로드 (관리자 전용 - /mng/ 경로 명시)
    @PostMapping("/mng/file/uploadImage")
    public ResponseEntity<?> uploadEditorImage(@RequestParam("file") MultipartFile file) {
        return saveLocalFile(file, "editor/");
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

        // filePath는 "/upload/attachments/uuid.ext" 형태이므로 실제 물리 경로로 변환
        String realPath = uploadDir + filePath.replace("/upload/", "");
        File file = new File(realPath);

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
                // [핵심 수정 2] 메모리 누수를 방지하기 위해 스트림을 안전하게 닫아줍니다.
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

            file.transferTo(new File(dirPath + savedName));
            String fileUrl = "/upload/" + subDir + savedName;
            return ResponseEntity.ok(fileUrl);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("서버 오류 발생");
        }
    }
}