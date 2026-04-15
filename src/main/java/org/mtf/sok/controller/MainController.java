package org.mtf.sok.controller;

import org.mtf.sok.domain.PopupDTO;
import org.mtf.sok.mapper.PopupMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MainController {

    @Autowired
    private PopupMapper popupMapper;

    @GetMapping("/")
    public String index(Model model) {

        // 1. 현재 게시 기간에 해당하는 활성 팝업 목록 조회
        List<PopupDTO> popupList = popupMapper.selectActivePopupList();

        // 2. 모델에 담아서 index.jsp로 전달
        model.addAttribute("popupList", popupList);

        return "index";
    }
}