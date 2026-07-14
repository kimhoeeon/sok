package org.mtf.sok.util;

import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
@RequiredArgsConstructor
public class ImageFileUtils { // ← 오타: ImageFIleUtils → ImageFileUtils

    private final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36";
    private final Pattern EXT_PATTERN = Pattern.compile("\\.(png|gif|jpe?g|bmp|webp|avif)(?:\\?|#|$)", Pattern.CASE_INSENSITIVE);

    private final RestTemplate restTemplate;

    public String downloadImage(String imageUrl, String uploadPath, String referer) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.USER_AGENT, USER_AGENT);
        headers.set(HttpHeaders.ACCEPT, "image/avif,image/webp,image/apng,image/*,*/*;q=0.8");
        headers.set(HttpHeaders.ACCEPT_LANGUAGE, "ko");
        if (StringUtils.hasText(referer)) headers.set(HttpHeaders.REFERER, referer);
        headers.set(HttpHeaders.CONNECTION, "Keep-Alive");
        headers.set(HttpHeaders.CACHE_CONTROL, "no-cache");

        ResponseEntity<byte[]> resp = restTemplate.exchange(
                URI.create(imageUrl), HttpMethod.GET, new HttpEntity<>(headers), byte[].class);

        if (!resp.getStatusCode().is2xxSuccessful() || resp.getBody() == null || resp.getBody().length == 0) return null;

        byte[] body = resp.getBody();
        String contentType = resolveContentType(resp.getHeaders());
        String ext = decideExt(imageUrl, contentType, body);
        if (ext == null) ext = "png";

        Path dir = Paths.get(uploadPath);
        Files.createDirectories(dir);
        String filename = buildFilename(ext);
        Files.write(dir.resolve(filename), body,
                StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING, StandardOpenOption.WRITE);
        return filename;
    }

    private String resolveContentType(HttpHeaders headers) {
        MediaType mt = headers.getContentType();
        if (mt != null) return (mt.getType() + "/" + mt.getSubtype()).toLowerCase(Locale.ROOT);
        String raw = headers.getFirst(HttpHeaders.CONTENT_TYPE);
        return raw == null ? null : raw.split(";")[0].trim().toLowerCase(Locale.ROOT);
    }

    private String decideExt(String url, String ct, byte[] b) {
        String byCt = mapExtByContentType(ct);
        String byUrl = guessExtFromUrl(url);
        String bySig = sniffExtByMagic(b);
        if (bySig != null) return bySig;
        if (byCt != null) return byCt;
        return byUrl;
    }

    private String buildFilename(String ext) {
        String ts = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        String rand = UUID.randomUUID().toString().replace("-", "").substring(0, 6);
        return ts + "_" + rand + "." + ext.toLowerCase(Locale.ROOT);
    }

    private String mapExtByContentType(String ct) {
        if (ct == null) return null;
        switch (ct) {
            case "image/png":  return "png";
            case "image/gif":  return "gif";
            case "image/jpeg":
            case "image/jpg":  return "jpg";
            case "image/bmp":  return "bmp";
            case "image/webp": return "webp";
            case "image/avif": return "avif";
            default:           return null;
        }
    }

    private String guessExtFromUrl(String url) {
        if (!StringUtils.hasText(url)) return null;
        Matcher m = EXT_PATTERN.matcher(url);
        if (m.find()) return m.group(1).toLowerCase(Locale.ROOT).replace("jpeg", "jpg");
        return null;
    }

    private String sniffExtByMagic(byte[] b) {
        if (b == null || b.length < 12) return null;
        if (b.length >= 8 && (b[0] & 0xFF) == 0x89 && b[1] == 0x50 && b[2] == 0x4E && b[3] == 0x47
                && b[4] == 0x0D && b[5] == 0x0A && b[6] == 0x1A && b[7] == 0x0A) return "png";
        if (b.length >= 6 && b[0] == 'G' && b[1] == 'I' && b[2] == 'F' && b[3] == '8'
                && (b[4] == '7' || b[4] == '9') && b[5] == 'a') return "gif";
        if ((b[0] & 0xFF) == 0xFF && (b[1] & 0xFF) == 0xD8) return "jpg";
        if (b[0] == 'B' && b[1] == 'M') return "bmp";
        if (b.length >= 12 && b[0] == 'R' && b[1] == 'I' && b[2] == 'F' && b[3] == 'F'
                && b[8] == 'W' && b[9] == 'E' && b[10] == 'B' && b[11] == 'P') return "webp";
        if (b.length >= 12 && b[4] == 'f' && b[5] == 't' && b[6] == 'y' && b[7] == 'p'
                && b[8] == 'a' && b[9] == 'v' && b[10] == 'i' && b[11] == 'f') return "avif";
        return null;
    }
}