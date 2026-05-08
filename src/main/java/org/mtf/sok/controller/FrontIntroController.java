package org.mtf.sok.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/intro")
public class FrontIntroController {

    @GetMapping("/about")
    public String about() { return "intro/about"; }

    @GetMapping("/greeting")
    public String greeting() { return "intro/greeting"; }

    @GetMapping("/ci")
    public String ci() { return "intro/ci"; }

    @GetMapping("/way")
    public String way() { return "intro/way"; }
}