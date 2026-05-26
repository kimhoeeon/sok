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

    // [1] 파일 업로드 용량 초과 에러 처리
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxSizeException(MaxUploadSizeExceededException exc, HttpServletRequest request, RedirectAttributes rttr) {
        // 사용자에게 보여줄 친절한 에러 메시지
        rttr.addFlashAttribute("errorMessage", "업로드 파일 용량이 너무 큽니다. 더 작은 파일을 첨부해 주세요.");

        // 에러가 발생한 이전 페이지의 URL을 가져와서 되돌려 보냄
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/mng/main");
    }

    // [2] 통신 단절 등 Multipart 변환 에러 처리
    @ExceptionHandler(org.springframework.web.multipart.MultipartException.class)
    public String handleMultipartException(Exception e) {
        log.warn("🚨 사용자 업로드 취소 또는 네트워크 단절: {}", e.getMessage());
        return "redirect:/error"; // 빈 에러페이지나 이전페이지로 리다이렉트
    }

    // [3] 그 외 모든 예상치 못한 시스템(500) 예외 처리
    @ExceptionHandler(Exception.class)
    public String handleAllException(Exception e, HttpServletRequest request, RedirectAttributes rttr) {
        // 긴 스택 트레이스 대신 핵심 에러 메시지와 발생 경로만 깔끔하게 에러 로그로 남김
        log.error("🚨 시스템 오류 발생 [{}]: {}", request.getRequestURI(), e.getMessage());

        // 사용자에게는 친절한 알림을 띄우고 이전 페이지나 메인으로 돌려보냄 (Whitelabel Error Page 노출 방지)
        rttr.addFlashAttribute("errorMessage", "시스템 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
        String referer = request.getHeader("Referer");

        return "redirect:" + (referer != null ? referer : "/");
    }

}