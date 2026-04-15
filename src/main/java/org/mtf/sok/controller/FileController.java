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
@RequestMapping("/admin/file")
public class FileController {

    @Value("${file.upload.dir}")
    private String uploadDir;

    // [1] 에디터 이미지 업로드 (로컬 저장)
    @PostMapping("/uploadImage")
    public ResponseEntity<?> uploadEditorImage(@RequestParam("file") MultipartFile file) {
        return saveLocalFile(file, "editor/");
    }

    // [2] 게시판 일반 첨부파일 업로드 (로컬 저장)
    @PostMapping("/uploadAttachment")
    public ResponseEntity<?> uploadAttachment(@RequestParam("file") MultipartFile file) {
        return saveLocalFile(file, "attachments/");
    }

    // [3] 로컬 첨부파일 다운로드 로직
    @GetMapping("/download")
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

            BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
            BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
            FileCopyUtils.copy(in, out);
            out.flush();
        }
    }

    private ResponseEntity<?> saveLocalFile(MultipartFile file, String subDir) {
        if (file.isEmpty()) return ResponseEntity.badRequest().body("파일이 없습니다.");
        try {
            String dirPath = uploadDir + subDir;
            File dir = new File(dirPath);
            if (!dir.exists()) dir.mkdirs();

            String originalName = file.getOriginalFilename();
            String extension = originalName.substring(originalName.lastIndexOf("."));
            String savedName = UUID.randomUUID().toString() + extension;

            file.transferTo(new File(dirPath + savedName));
            String fileUrl = "/upload/" + subDir + savedName;
            return ResponseEntity.ok(fileUrl);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("서버 오류 발생");
        }
    }
}