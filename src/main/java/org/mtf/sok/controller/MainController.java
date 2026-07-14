package org.mtf.sok.controller;

import org.mtf.sok.domain.*;
import org.mtf.sok.mapper.BoardMapper;
import org.mtf.sok.mapper.PopupMapper;
import org.mtf.sok.mapper.SnsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MainController {

    @Autowired
    private PopupMapper popupMapper;

    @Autowired
    private BoardMapper boardMapper; // 팝업 이미지 조회

    @Autowired
    private SnsMapper snsMapper; // SNS blog , insta

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

        // ========================================================
        // 2. 메인 화면 하단 뉴스/공지사항/채용/입찰 데이터 세팅
        // ========================================================

        // 2-1. SOK 소식 (최신 1건)
        BoardDTO newsParam = new BoardDTO();
        newsParam.setBrdType("NEWS");
        newsParam.setPageNum(1);
        newsParam.setAmount(1);
        List<BoardDTO> mainNewsList = boardMapper.selectBoardList(newsParam);
        if (!mainNewsList.isEmpty()) {
            model.addAttribute("mainNews", mainNewsList.get(0));
        }

        // 2-2. 공지사항 (최신 6건)
        BoardDTO noticeParam = new BoardDTO();
        noticeParam.setBrdType("NOTICE");
        noticeParam.setPageNum(1);
        noticeParam.setAmount(6);
        model.addAttribute("noticeList", boardMapper.selectBoardList(noticeParam));

        // 2-3. 채용정보 (최신 6건)
        BoardDTO careersParam = new BoardDTO();
        careersParam.setBrdType("CAREERS");
        careersParam.setPageNum(1);
        careersParam.setAmount(6);
        model.addAttribute("careersList", boardMapper.selectBoardList(careersParam));

        // 2-4. 입찰정보 (최신 6건, 자료실의 '입찰' 카테고리)
        BoardDTO bidParam = new BoardDTO();
        bidParam.setBrdType("BIDDING");
        bidParam.setPageNum(1);
        bidParam.setAmount(6);
        model.addAttribute("bidList", boardMapper.selectBoardList(bidParam));

        return "index";
    }

    @ResponseBody
    @RequestMapping(value = "/blog/list", method = RequestMethod.POST)
    public ResponseEntity<List<BlogDTO>> main_blog_list() {
        List<BlogDTO> resultList = snsMapper.selectBlogList();
        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    @ResponseBody
    @RequestMapping(value = "/instagram/list", method = RequestMethod.POST)
    public ResponseEntity<List<InstagramDTO>> main_instagram_list() {
        List<InstagramDTO> resultList = snsMapper.selectInstagramList();
        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }
}