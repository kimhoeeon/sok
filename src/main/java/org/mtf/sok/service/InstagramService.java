package org.mtf.sok.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.mtf.sok.domain.SaveInstagram;
import org.mtf.sok.mapper.SnsMapper;
import org.mtf.sok.util.ImageFileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.File;
import java.io.FileNotFoundException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Service
public class InstagramService {

    private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36";

    private static final String GRAPH_ME_MEDIA = "https://graph.instagram.com/me/media";

    private static final String GRAPH_REFRESH_TOKEN = "https://graph.instagram.com/refresh_access_token";

    private final SnsMapper snsMapper;
    private final RestTemplate restTemplate;
    private final ImageFileUtils imageFileUtils;
    private final String uploadDir; // baseDir/instagram

    public InstagramService(
            SnsMapper snsMapper, @Value("${file.upload.base-dir:/sokfan/tomcat/webapps/upload}") String baseDir,
            RestTemplate restTemplate, ImageFileUtils imageFileUtils
    ) {
        this.snsMapper = snsMapper;
        this.restTemplate = restTemplate;
        try {
            this.imageFileUtils = imageFileUtils;
            this.uploadDir = ResourceUtils
                    .getFile(String.join(File.separator, baseDir, "instagram"))
                    .toPath().toString();
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 외부 호출: 인스타 게시물 수집 후 테이블 저장
     */
    public void saveInstagramPosts() {
        String token = snsMapper.selectInstaToken();
        if (!StringUtils.hasText(token)) {
            log.info("Instagram token is blank.");
            return;
        }
        List<SaveInstagram> rows = fetchInstagramRows(token, 15);
        if (rows.isEmpty()) {
            log.info("Instagram rows is empty.");
            return;
        }
        String cutoff = LocalDateTime.now().minusDays(2).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        snsMapper.insertInstagramList(rows);
        snsMapper.deleteInstagram(cutoff);
        cleanupInstagramFilesFromDb();
        //log.info("Instagram rows saved: {}", rows.size());
    }

    /**
     * 외부 호출: 인스타그램 장기 토큰 자동 갱신
     */
    public void refreshInstagramToken() {
        String token = snsMapper.selectInstaToken();
        if (!StringUtils.hasText(token)) {
            log.warn("Instagram token is blank. Cannot refresh.");
            return;
        }

        try {
            String url = UriComponentsBuilder.fromHttpUrl(GRAPH_REFRESH_TOKEN)
                    .queryParam("grant_type", "ig_refresh_token")
                    .queryParam("access_token", token)
                    .build(true)
                    .toUriString();

            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.USER_AGENT, USER_AGENT);

            ResponseEntity<String> resp = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(headers), String.class);
            if (!resp.getStatusCode().is2xxSuccessful() || resp.getBody() == null) {
                log.error("Failed to refresh Instagram token. Status: {}", resp.getStatusCode());
                return;
            }

            ObjectMapper om = new ObjectMapper();
            Map<String, Object> map = om.readValue(resp.getBody(), new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {});
            String newToken = (String) map.get("access_token");

            if (StringUtils.hasText(newToken)) {
                snsMapper.updateInstaToken(newToken);
                log.info("Instagram Token successfully refreshed and updated in DB.");
            } else {
                log.error("New token is empty from Instagram API response.");
            }
        } catch (Exception e) {
            log.error("Error occurred while refreshing Instagram token", e);
        }
    }

    /**
     * Graph API 호출 → 테이블 스키마에 맞춘 Row 리스트 생성
     */
    private List<SaveInstagram> fetchInstagramRows(String accessToken, int maxCnt) {
        List<SaveInstagram> result = new ArrayList<>();
        if (!StringUtils.hasText(accessToken) || maxCnt <= 0) return result;

        try {
            String fields = "id,caption,media_type,media_url,thumbnail_url,permalink,timestamp";
            String url = UriComponentsBuilder.fromHttpUrl(GRAPH_ME_MEDIA)
                    .queryParam("fields", fields)
                    .queryParam("access_token", accessToken)
//                    .queryParam("limit", Math.max(5, maxCnt)) // TODO: limit 되는지 확인
                    .build(true)
                    .toUriString();

            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.USER_AGENT, USER_AGENT);
            headers.set(HttpHeaders.ACCEPT, "*/*");
            headers.set(HttpHeaders.ACCEPT_LANGUAGE, "ko");
            headers.set(HttpHeaders.CONNECTION, "Keep-Alive");
            headers.set(HttpHeaders.CACHE_CONTROL, "no-cache");

            //log.info("fetchInstagramRows url={}", url);

            ResponseEntity<String> resp = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(headers), String.class);
            if (!resp.getStatusCode().is2xxSuccessful() || resp.getBody() == null) return result;

            ObjectMapper om = new ObjectMapper();
            Map<String, Object> map = om.readValue(resp.getBody(), new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {
            });
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> items = (List<Map<String, Object>>) map.get("data");
            if (items == null || items.isEmpty()) return result;

            LocalDateTime now = LocalDateTime.now(); // reg_dtm
            int count = 0;

            for (Map<String, Object> item : items) {
                if (count >= maxCnt) break;

                String caption = item.getOrDefault("caption", "").toString();
                String mediaType = item.getOrDefault("media_type", "").toString(); // IMAGE/VIDEO/CAROUSEL_ALBUM
                String mediaUrl = item.getOrDefault("media_url", "").toString();
                String thumbnailUrl = item.getOrDefault("thumbnail_url", "").toString();
                String permalink = item.getOrDefault("permalink", "").toString();

                String[] td = splitTitleDesc(caption);
                String title = td[0];
                String description = td[1];

                // 썸네일 URL: VIDEO면 thumbnail_url, 아니면 media_url
                String imageUrl = "VIDEO".equalsIgnoreCase(mediaType) && StringUtils.hasText(thumbnailUrl)
                        ? thumbnailUrl : mediaUrl;

                // 이미지 다운로드(실패 시 fileName은 빈 문자열로)
                String fileName = "";
                if (StringUtils.hasText(imageUrl)) {
                    try {
                        fileName = imageFileUtils.downloadImage(imageUrl, uploadDir, permalink);
                    } catch (Exception e) {
                        log.warn("downloadImage failed. url={}", imageUrl, e);
                    }
                }

                SaveInstagram row = new SaveInstagram();
                row.setRegDt(now);
                row.setSeq(count + 1);
                row.setLinkUrl(permalink);
                row.setTitle(title);
                row.setDescription(description);
                row.setImageSrc(imageUrl == null ? "" : imageUrl);
                row.setFileName(fileName == null ? "" : fileName);

                result.add(row);
                count++;
            }
        } catch (Exception e) {
            log.error("fetchInstagramRows error", e);
        }
        return result;
    }

    /**
     * DB에 남아있는 instagram file_name만 유지하고 uploadDir(instagram) 폴더에서 나머지 파일 삭제
     */
    private void cleanupInstagramFilesFromDb() {
        Path dir = Paths.get(uploadDir);

        if (!Files.exists(dir) || !Files.isDirectory(dir)) {
            log.info("cleanupInstagramFilesFromDb skipped. uploadDir not exists or not directory: {}", uploadDir);
            return;
        }

        // 1) DB에 남아있는 파일명 조회
        List<String> keepList = null;
        try {
            keepList = snsMapper.selectInstaFileNames();
        } catch (Exception e) {
            log.warn("cleanupInstagramFilesFromDb skipped. selectBlogFileNames failed: {}", e.getMessage(), e);
            return;
        }

        // keep 목록이 비면 "전부 삭제"가 되니까 위험. (안전장치)
        if (keepList == null || keepList.isEmpty()) {
            log.warn("cleanupInstagramFilesFromDb skipped. keepList is empty (safety)");
            return;
        }

        Set<String> keep = new HashSet<>();
        for (String s : keepList) {
            if (s == null) continue;
            String trimmed = s.trim();
            if (!trimmed.isEmpty()) keep.add(trimmed);
        }
        if (keep.isEmpty()) {
            log.warn("cleanupInstagramFilesFromDb skipped. keep set is empty (safety)");
            return;
        }

        // 2) 폴더 스캔 후 keep에 없는 파일 삭제
        int scanned = 0;
        int deleted = 0;

        try (java.util.stream.Stream<Path> walk = Files.walk(dir)) {
            Iterator<Path> it = walk.iterator();
            while (it.hasNext()) {
                Path p = it.next();
                if (!Files.isRegularFile(p)) continue;

                scanned++;

                String fileName = p.getFileName().toString();

                // keep에 없으면 삭제
                if (!keep.contains(fileName)) {
                    try {
                        Files.deleteIfExists(p);
                        deleted++;
                    } catch (Exception ex) {
                        log.warn("Failed to delete file: {}, cause={}", p, ex.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            log.warn("cleanupInstagramFilesFromDb error: {}", e.getMessage(), e);
        }

        //log.info("cleanupInstagramFilesFromDb done. scanned={}, deleted={}, keep={}", scanned, deleted, keep.size());
    }

    private String[] splitTitleDesc(String captionRaw) {
        if (!StringUtils.hasText(captionRaw)) return new String[]{"", ""};
        String caption = org.springframework.web.util.HtmlUtils.htmlUnescape(captionRaw).trim();
        String[] parts = caption.split("\\R", 2);
        String title = parts.length > 0 ? parts[0].trim() : "";
        String desc = parts.length > 1 ? parts[1].trim() : "";
        if (title.length() > 500) { // 테이블 title varchar(500) 보호
            desc = (title.substring(500).trim() + (desc.isEmpty() ? "" : "\n" + desc)).trim();
            title = title.substring(0, 500).trim();
        }
        if (desc.length() > 2000) { // 테이블 description varchar(2000) 보호
            desc = desc.substring(0, 2000).trim();
        }
        return new String[]{title, desc};
    }

}