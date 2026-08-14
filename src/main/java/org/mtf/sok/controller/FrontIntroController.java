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

    @GetMapping("/member")
    public String member() { return "intro/member"; }

    @GetMapping("/map")
    public String map() { return "intro/map"; }

    @GetMapping("/rules")
    public String rules() { return "intro/rules"; }

    @GetMapping("/ci")
    public String ci() { return "intro/ci"; }

    @GetMapping("/way")
    public String way() { return "intro/way"; }

    @GetMapping("/commit_dev")
    public String commit_dev() { return "intro/commit_dev"; }

    @GetMapping("/dis_commit_tkw")
    public String dis_commit_tkw() { return "intro/dis_commit_tkw"; }

    @GetMapping("/commit_rec")
    public String commit_rec() { return "intro/commit_rec"; }

    @GetMapping("/commit_fair")
    public String commit_fair() { return "intro/commit_fair"; }

    @GetMapping("/commit_ath")
    public String commit_ath() { return "intro/commit_ath"; }

    @GetMapping("/commit_nat")
    public String commit_nat() { return "intro/commit_nat"; }

    @GetMapping("/commit_spt")
    public String commit_spt() { return "intro/commit_spt"; }

    @GetMapping("/none_commit_fam")
    public String none_commit_fam() { return "intro/none_commit_fam"; }

    @GetMapping("/none_commit_ath")
    public String none_commit_ath() { return "intro/none_commit_ath"; }

    @GetMapping("/none_commit_art")
    public String none_commit_art() { return "intro/none_commit_art"; }

    @GetMapping("/none_commit_coo")
    public String none_commit_coo() { return "intro/none_commit_coo"; }

    @GetMapping("/none_commit_vol")
    public String none_commit_vol() { return "intro/none_commit_vol"; }

    @GetMapping("/none_commit_tor")
    public String none_commit_tor() { return "intro/none_commit_tor"; }

    @GetMapping("/none_commit_spo")
    public String none_commit_spo() { return "intro/none_commit_spo"; }

}