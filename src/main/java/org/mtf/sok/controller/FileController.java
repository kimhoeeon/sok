package org.mtf.sok.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/admin/file")
public class FileController {

    @Value("${file.upload.dir}")
    private String uploadDir;

    @PostMapping("/uploadSummernoteImage")
    public ResponseEntity<?> uploadSummernoteImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            String originalFileName = file.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String savedFileName = UUID.randomUUID().toString() + extension;

            // 저장 폴더: /tomcat/webapps/upload/summernote/
            String savePath = uploadDir + "summernote/";
            File folder = new File(savePath);
            if (!folder.exists()) folder.mkdirs();

            File targetFile = new File(savePath + savedFileName);
            file.transferTo(targetFile);

            // 클라이언트(에디터)가 이미지를 띄울 수 있도록 브라우저 접근 URL 반환
            String imageUrl = "/upload/summernote/" + savedFileName;
            resultMap.put("url", imageUrl);
            resultMap.put("responseCode", "success");

        } catch (Exception e) {
            resultMap.put("responseCode", "error");
            e.printStackTrace();
        }

        return ResponseEntity.ok(resultMap);
    }
}