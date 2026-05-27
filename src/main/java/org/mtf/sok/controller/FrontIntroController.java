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

    @GetMapping("/org")
    public String org() { return "intro/org"; }

    @GetMapping("/disclosure")
    public String disclosure() { return "intro/disclosure"; }

    @GetMapping("/rules")
    public String rules() { return "intro/rules"; }

    @GetMapping("/ci")
    public String ci() { return "intro/ci"; }

    @GetMapping("/way")
    public String way() { return "intro/way"; }
}