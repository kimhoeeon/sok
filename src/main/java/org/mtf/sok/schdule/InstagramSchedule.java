package org.mtf.sok.schdule;

import lombok.RequiredArgsConstructor;
import org.mtf.sok.service.InstagramService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class InstagramSchedule {

    private final InstagramService instagramService;

    // 인스타그램 게시물 수집: 매시간 40분마다 동작
    @Scheduled(cron = "0 40 * * * *")
    public void instagramSchedule() {
        instagramService.saveInstagramPosts();
    }

    // 인스타그램 토큰 자동 갱신: 매주 일요일 새벽 3시에 동작
    @Scheduled(cron = "0 0 3 * * SUN")
    public void instagramTokenRefreshSchedule() {
        instagramService.refreshInstagramToken();
    }
}