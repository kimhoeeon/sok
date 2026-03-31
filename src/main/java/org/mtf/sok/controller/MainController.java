package org.mtf.sok.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String index() {
        // /WEB-INF/views/index.jsp 로 연결됩니다.
        return "index";
    }
}