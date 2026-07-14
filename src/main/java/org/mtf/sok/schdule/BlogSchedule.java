package org.mtf.sok.schdule;

import lombok.RequiredArgsConstructor;
import org.mtf.sok.service.BlogService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class BlogSchedule {

    private final BlogService blogService;

    @Scheduled(cron = "0 40 * * * *")
    public void blogSchedule() {
        blogService.saveBlogPosts();
    }
}