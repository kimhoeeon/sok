// src/main/java/org/mtf/sok/exception/GlobalExceptionHandler.java (신규 생성)
package org.mtf.sok.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxSizeException(MaxUploadSizeExceededException exc, HttpServletRequest request, RedirectAttributes rttr) {
        // 사용자에게 보여줄 친절한 에러 메시지
        rttr.addFlashAttribute("errorMessage", "업로드 파일 용량이 너무 큽니다. 더 작은 파일을 첨부해 주세요.");

        // 에러가 발생한 이전 페이지의 URL을 가져와서 되돌려 보냄
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/mng/main");
    }

    @ExceptionHandler(org.springframework.web.multipart.MultipartException.class)
    public String handleMultipartException(Exception e) {
        log.warn("사용자 업로드 취소 또는 네트워크 단절: " + e.getMessage());
        return "redirect:/error"; // 빈 에러페이지나 이전페이지로 리다이렉트
    }
}