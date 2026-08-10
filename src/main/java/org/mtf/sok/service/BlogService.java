package org.mtf.sok.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.mtf.sok.domain.SaveBlog;
import org.mtf.sok.mapper.SnsMapper;
import org.mtf.sok.util.EmojiStripper;
import org.mtf.sok.util.ImageFileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Service
public class BlogService {

    private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36";
    private static final String BLOG_ID = "specialolympicskorea";
    private static final String LIST_URL = "https://blog.naver.com/PostTitleListAsync.naver";
    private static final String REFERRER = "https://blog.naver.com/PostList.naver?blogId=" + BLOG_ID + "&skinType=&skinId=&from=menu&userSelectMenu=true";

    private final RestTemplate restTemplate;
    private final SnsMapper snsMapper;
    private final ImageFileUtils imageFileUtils;
    private final String uploadDir;

    public BlogService(@Value("${file.upload.base-dir:/sokfan/tomcat/webapps/upload}") String baseDir, RestTemplate restTemplate, SnsMapper snsMapper, ImageFileUtils imageFileUtils) {
        try {
            this.restTemplate = restTemplate;
            this.snsMapper = snsMapper;
            this.imageFileUtils = imageFileUtils;
            this.uploadDir = ResourceUtils.getFile(String.join(File.separator, baseDir, "blog")).toPath().toString();
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public void saveBlogPosts() {
        List<SaveBlog> posts = getPosts(15);
        if (ObjectUtils.isEmpty(posts)){
            log.info("No Blog Posts Found");
            return;
        }
        String cutoff = LocalDateTime.now().minusDays(2).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        snsMapper.insertBlogList(posts);
        snsMapper.deleteBlog(cutoff);
        cleanupBlogFilesFromDb();
        //log.info("Blog Posts Saved: {}", posts.size());
    }

    /**
     * 네이버 블로그 메인(목록)에서 게시글을 최대 maxCnt개 수집
     *
     * @param maxCnt 최대 수집 개수
     * @return image_src="", title(디코딩), link_url 을 담은 리스트
     */
    private List<SaveBlog> getPosts(int maxCnt) { // 15
        try {
            List<SaveBlog> result = new ArrayList<>();

            String url = UriComponentsBuilder.fromHttpUrl(LIST_URL)
                    .queryParam("blogId", BLOG_ID)
                    .queryParam("viewdate", "")
                    .queryParam("currentPage", 1)
                    .queryParam("categoryNo", "")
                    .queryParam("parentCategoryNo", "")
                    .queryParam("countPerPage", maxCnt)
                    .build(true)
                    .toUriString();

            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.CONTENT_TYPE, "application/x-www-form-urlencoded; charset=utf-8");
            headers.set(HttpHeaders.USER_AGENT, USER_AGENT);
            headers.set(HttpHeaders.ACCEPT, "*/*");
            headers.set(HttpHeaders.ACCEPT_LANGUAGE, "ko");
            headers.set(HttpHeaders.CONNECTION, "Keep-Alive");
            headers.set(HttpHeaders.CACHE_CONTROL, "no-cache");
            headers.set("Referer", REFERRER);

            ResponseEntity<String> resp;
            try {
                resp = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(headers), String.class);
            } catch (Exception e) {
                return result;
            }

            if (!resp.getStatusCode().is2xxSuccessful() || resp.getBody() == null) {
                return result;
            }

            ObjectMapper om = new ObjectMapper();
            String cleaned = resp.getBody().replace("\\'", "'");
            Map<String, Object> map = om.readValue(cleaned, new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {
            });
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> postList = (List<Map<String, Object>>) map.get("postList");

            LocalDateTime now = LocalDateTime.now();
            for (int i = 0; i < Math.min(maxCnt, postList.size()); i++) {
                Map<String, Object> post = postList.get(i);

                SaveBlog blog = new SaveBlog();
                blog.setSeq(i + 1);
                String title = URLDecoder.decode(post.getOrDefault("title", "").toString(), StandardCharsets.UTF_8.name());
                blog.setTitle(EmojiStripper.stripEmoji(title));
                String logNo = post.getOrDefault("logNo", "").toString();
                String linkUrl = "https://blog.naver.com/PostView.naver?blogId=" + BLOG_ID + "&logNo=" + logNo
                        + "&categoryNo=0&parentCategoryNo=0&viewDate=&currentPage=1&postListTopCurrentPage=1&from=menu";
                blog.setLinkUrl(linkUrl);
                String html = loadPostHtml(linkUrl);
                String cover = findCoverImageUrlFromHtml(html, linkUrl);
                blog.setImageSrc(cover);
                String filename = null;
                if (cover != null) {
                    try {
                        filename = imageFileUtils.downloadImage(cover, uploadDir, linkUrl);
                    } catch (Exception ex) {
                        log.warn("downloadImage failed. url={}", cover, ex);
                    }
                }
                blog.setFileName(filename);
                blog.setRegDt(now);
                result.add(blog);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // ---------- 다운로드 + 저장 ----------

    /**
     * 블로그 글 URL에서 대표 이미지 찾아 저장하고, 저장된 파일 절대경로를 반환. 실패 시 null.
     * 선택 규칙:
     * - .se-main-container .se-component img
     * - 우선 data-lazy-src, 없으면 src
     * - '?type=w80_blur' 는 스킵
     * - '?type=w966' 붙은 걸 우선 선택
     * - 최대 50개만 훑음
     */
    // 1) 포스트 실제 본문 HTML 가져오기
    private String loadPostHtml(String postLink) {
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.USER_AGENT, USER_AGENT);
        headers.set(HttpHeaders.ACCEPT, "text/html, */*;q=0.8");
        headers.set(HttpHeaders.ACCEPT_LANGUAGE, "ko");
        headers.set(HttpHeaders.REFERER, postLink);
        ResponseEntity<String> resp = restTemplate.exchange(postLink, HttpMethod.GET, new HttpEntity<>(headers), String.class);
        if (!resp.getStatusCode().is2xxSuccessful() || resp.getBody() == null) return null;

        String html = resp.getBody();

        // 1-1) mainFrame이 있으면 그 src를 다시 받아온다
        org.jsoup.nodes.Document outer = org.jsoup.Jsoup.parse(html, postLink);
        org.jsoup.nodes.Element frame = outer.selectFirst("iframe#mainFrame, frame#mainFrame");
        if (frame != null) {
            String src = frame.absUrl("src");
            if (src == null || src.isEmpty()) src = frame.attr("src");
            if (src != null && !src.isEmpty()) {
                ResponseEntity<String> resp2 = restTemplate.exchange(src, HttpMethod.GET, new HttpEntity<>(headers), String.class);
                if (resp2.getStatusCode().is2xxSuccessful() && resp2.getBody() != null) {
                    return resp2.getBody();
                }
            }
        }

        // fallback: 프레임이 없으면 첫 응답을 그대로 사용
        return html;
    }

    // 2) 본문 HTML에서 대표 이미지 하나 고르기
    private String findCoverImageUrlFromHtml(String html, String baseUrl) {
        if (html == null) return null;
        org.jsoup.nodes.Document doc = org.jsoup.Jsoup.parse(html, baseUrl);

        // 대표 후보: 최신 에디터 .se-main-container 내부의 img
        // 과거 에디터/스킨까지 폭넓게: 여러 셀렉터 병행
        org.jsoup.select.Elements imgs = doc.select(
                ".se-main-container img, .se_component_wrap img, .post-view img, .se-image img, img.se-image-resource, img"
        );

        int limit = Math.min(imgs.size(), 50);
        String best = null;

        for (int i = 0; i < limit; i++) {
            org.jsoup.nodes.Element el = imgs.get(i);

            // 우선순위: data-lazy-src > data-src > data-original > data-origin > src
            String u = firstNonEmpty(
                    el.attr("data-lazy-src"),
                    el.attr("data-src"),
                    el.attr("data-original"),
                    el.attr("data-origin"),
                    el.attr("src")
            );
            if (u == null || u.isEmpty()) continue;
            if (u.startsWith("data:image/")) continue;

            // 스킵: 흐림 썸네일
            if (u.contains("type=w80_blur")) {
                // 큰 사이즈로 승격
                u = u.replace("type=w80_blur", "type=w966");
            }

            // 프로토콜 상대 //... 처리
            if (u.startsWith("//")) u = "https:" + u;

            // 네이버 썸네일 계열이면 큰 사이즈 파라미터 보정
            u = bumpNaverImageSize(u);

            best = u;

            // 이미 w=966 이상이면 이 정도를 대표로 채택하고 종료
            if (u.contains("type=w966") || u.contains("w=960") || u.contains("w=1080") || u.contains("original")) break;
        }

        return best;
    }

    /**
     * DB에 남아있는 blog file_name만 유지하고 uploadDir(blog) 폴더에서 나머지 파일 삭제
     */
    private void cleanupBlogFilesFromDb() {
        Path dir = Paths.get(uploadDir);

        if (!Files.exists(dir) || !Files.isDirectory(dir)) {
            log.info("cleanupBlogFilesFromDb skipped. uploadDir not exists or not directory: {}", uploadDir);
            return;
        }

        // 1) DB에 남아있는 파일명 조회
        List<String> keepList = null;
        try {
            keepList = snsMapper.selectBlogFileNames();
        } catch (Exception e) {
            log.warn("cleanupBlogFilesFromDb skipped. selectBlogFileNames failed: {}", e.getMessage(), e);
            return;
        }

        // keep 목록이 비면 "전부 삭제"가 되니까 위험. (안전장치)
        if (keepList == null || keepList.isEmpty()) {
            log.warn("cleanupBlogFilesFromDb skipped. keepList is empty (safety)");
            return;
        }

        Set<String> keep = new HashSet<>();
        for (String s : keepList) {
            if (s == null) continue;
            String trimmed = s.trim();
            if (!trimmed.isEmpty()) keep.add(trimmed);
        }
        if (keep.isEmpty()) {
            log.warn("cleanupBlogFilesFromDb skipped. keep set is empty (safety)");
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
            log.warn("cleanupBlogFilesFromDb error: {}", e.getMessage(), e);
        }

        //log.info("cleanupBlogFilesFromDb done. scanned={}, deleted={}, keep={}", scanned, deleted, keep.size());
    }

    private String firstNonEmpty(String... xs) {
        for (String x : xs) if (x != null && !x.isEmpty()) return x;
        return null;
    }

    private String bumpNaverImageSize(String url) {
        if (url == null) return null;
        // blur → 큰 사이즈
        url = url.replace("type=w80_blur", "type=w966");
        // type=w#### 통일
        url = url.replaceAll("([?&])type=w\\d+","$1type=w966");
        // w=#### 보정
        url = url.replaceAll("([?&])w=\\d+","$1w=966");
        // 모바일 mblogthumb → 원본 계열 승격 시도 (보수적으로 유지)
        return url;
    }

}