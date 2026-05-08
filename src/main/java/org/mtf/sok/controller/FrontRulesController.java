package org.mtf.sok.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/rules")
public class FrontRulesController {

    @GetMapping("/privacy")
    public String privacy() { return "rules/privacy"; }

    @GetMapping("/terms")
    public String terms() { return "rules/terms"; }

    @GetMapping("/policy")
    public String policy() { return "rules/policy"; }

}