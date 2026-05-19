package org.mtf.sok.controller;

import org.mtf.sok.domain.FileDTO;
import org.mtf.sok.domain.PopupDTO;
import org.mtf.sok.mapper.BoardMapper;
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

    // 팝업 이미지를 조회하기 위해 BoardMapper 주입
    @Autowired
    private BoardMapper boardMapper;

    @GetMapping("/")
    public String index(Model model) {

        // 1. 현재 게시 기간에 해당하는 활성 팝업 목록 조회
        List<PopupDTO> popupList = popupMapper.selectActivePopupList();

        // 2. [핵심 추가] 각 팝업에 첨부된 이미지 파일 정보 매핑
        if (popupList != null && !popupList.isEmpty()) {
            for (PopupDTO popup : popupList) {
                FileDTO fileParams = new FileDTO();
                fileParams.setRefTable("TB_POPUP");
                fileParams.setRefSeq(popup.getPopSeq());

                List<FileDTO> files = boardMapper.selectFiles(fileParams);
                if (files != null && !files.isEmpty()) {
                    popup.setPopupImage(files.get(0)); // DTO에 이미지 정보 세팅
                }
            }
        }

        // 3. 모델에 담아서 index.jsp로 전달
        model.addAttribute("popupList", popupList);

        return "index";
    }
}