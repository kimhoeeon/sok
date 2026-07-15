package org.mtf.sok.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mtf.sok.domain.PromoterDTO;
import org.mtf.sok.mapper.PromoterMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class PromoterService {

    private final PromoterMapper promoterMapper;

    @Value("${file.upload.dir}")
    private String uploadDir;

    public Map<String, Object> getPromoterList(PromoterDTO params) {
        params.calcOffset();
        Map<String, Object> result = new HashMap<>();
        result.put("list", promoterMapper.selectPromoterList(params));
        result.put("totalCount", promoterMapper.selectPromoterCount(params));
        result.put("params", params);
        return result;
    }

    public PromoterDTO getPromoter(Integer seq) {
        return promoterMapper.selectPromoter(seq);
    }

    @Transactional
    public Map<String, Object> savePromoter(PromoterDTO params) {
        Map<String, Object> response = new HashMap<>();

        // 1. 이름 중복 검사
        if (promoterMapper.checkDuplicateName(params) > 0) {
            response.put("result", "fail");
            response.put("message", "이미 등록된 후원사입니다.");
            return response;
        }

        // 2. 노출 순서 처리 (빈 값일 경우 가장 마지막 순번 + 10)
        if (params.getDisplayOrder() == null) {
            Integer maxOrder = promoterMapper.getMaxDisplayOrder();
            params.setDisplayOrder(maxOrder == null ? 10 : (Math.floorDiv(maxOrder, 10) * 10) + 10);
        }

        // 3. 파일 물리 저장
        MultipartFile file = params.getUploadFile();
        if (file != null && !file.isEmpty()) {
            try {

                // 수정(Update) 시 새로운 파일이 들어왔다면, 기존 물리 파일을 찾아 삭제합니다.
                if (params.getSeq() != null) {
                    PromoterDTO oldData = promoterMapper.selectPromoter(params.getSeq());
                    if (oldData != null && oldData.getFileName() != null) {
                        File oldFile = Paths.get(uploadDir, "promoter", oldData.getFileName()).toFile();
                        if (oldFile.exists()) oldFile.delete(); // 과거 파일 청소
                    }
                }

                File dir = Paths.get(uploadDir, "promoter").toFile();
                if (!dir.exists()) dir.mkdirs();

                String originalName = file.getOriginalFilename();
                String extension = originalName != null && originalName.contains(".") ? originalName.substring(originalName.lastIndexOf(".")) : "";
                String savedName = UUID.randomUUID().toString() + extension;
                File targetFile = new File(dir.getAbsolutePath(), savedName);

                file.transferTo(targetFile);

                params.setOriginalFileName(originalName);
                params.setFileName(savedName);
            } catch (Exception e) {
                log.error("Promoter image upload failed", e);
                response.put("result", "fail");
                response.put("message", "이미지 업로드에 실패했습니다.");
                return response;
            }
        }

        // 4. DB Insert 또는 Update
        if (params.getSeq() == null) {
            promoterMapper.insertPromoter(params);
        } else {
            promoterMapper.updatePromoter(params);
        }

        response.put("result", "success");
        return response;
    }

    @Transactional
    public Map<String, Object> deletePromoter(Integer seq) {
        Map<String, Object> response = new HashMap<>();

        // 1. 물리 파일 삭제
        PromoterDTO promoter = promoterMapper.selectPromoter(seq);
        if (promoter != null && promoter.getFileName() != null) {
            File targetFile = Paths.get(uploadDir, "promoter", promoter.getFileName()).toFile();
            if (targetFile.exists()) {
                targetFile.delete();
            }
        }

        // 2. DB 삭제
        promoterMapper.deletePromoter(seq);

        // 3. 10 단위 재정렬 로직 호출
        promoterMapper.reorderDisplayOrder();

        response.put("result", "success");
        return response;
    }
}