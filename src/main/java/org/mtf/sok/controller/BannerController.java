package org.mtf.sok.controller;

import org.mtf.sok.domain.BannerDTO;
import org.mtf.sok.domain.PageDTO;
import org.mtf.sok.mapper.BannerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/mng/banner")
public class BannerController {

    @Autowired
    private BannerMapper bannerMapper;

    // 배너 이미지가 저장될 물리적 경로 설정
    @Value("${file.upload.banner.dir:/tomcat/webapps/upload/banner}")
    private String uploadDir;

    // 1. 배너 목록 페이지
    @GetMapping("/list")
    public String list(@ModelAttribute("params") BannerDTO params, Model model) {
        // 페이징 오프셋 계산
        params.calcOffset();

        List<BannerDTO> list = bannerMapper.selectBannerList(params);
        int total = bannerMapper.selectBannerCount(params);

        // 페이징 객체 생성 및 모델 전달
        PageDTO pageMaker = new PageDTO(params, total);

        model.addAttribute("list", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("total", total);

        return "mng/banner/list";
    }

    // 2. 배너 등록 및 수정 폼 페이지
    @GetMapping("/form")
    public String form(@RequestParam(value = "seq", required = false) Integer seq,
                       @ModelAttribute("params") BannerDTO params,
                       Model model) {
        // seq 가 넘어오면 수정 모드, 없으면 신규 등록 모드
        if (seq != null) {
            BannerDTO banner = bannerMapper.selectBanner(seq);
            model.addAttribute("banner", banner);
        }
        return "mng/banner/form";
    }

    // 3. 배너 데이터 및 파일 저장
    @PostMapping("/save")
    public String save(BannerDTO params,
                       @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
                       RedirectAttributes rttr) {
        try {
            // 파일 업로드 처리
            if (uploadFile != null && !uploadFile.isEmpty()) {
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs(); // 디렉토리가 없으면 생성
                }

                String originalFileName = uploadFile.getOriginalFilename();
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String savedFileName = UUID.randomUUID().toString() + extension;

                File serverFile = new File(dir, savedFileName);
                uploadFile.transferTo(serverFile);

                params.setOriginalFileName(originalFileName);
                params.setFileName(savedFileName);
            }

            if (params.getSeq() == null) {
                // 신규 등록 시 가장 마지막 순번 + 10 으로 세팅
                Integer maxOrder = bannerMapper.getMaxDisplayOrder();
                params.setDisplayOrder(maxOrder != null ? maxOrder + 10 : 10);
                bannerMapper.insertBanner(params);
                rttr.addFlashAttribute("successMessage", "배너가 성공적으로 등록되었습니다.");
            } else {
                // 수정
                bannerMapper.updateBanner(params);
                rttr.addFlashAttribute("successMessage", "배너 정보가 성공적으로 수정되었습니다.");
            }

            // 등록/수정 완료 후 노출 순서 10 단위로 자동 재정렬
            bannerMapper.reorderDisplayOrder();

        } catch (IOException e) {
            e.printStackTrace();
            rttr.addFlashAttribute("errorMessage", "파일 처리 중 시스템 오류가 발생했습니다.");
        }

        return "redirect:/mng/banner/list";
    }

    // 4. 배너 삭제
    @PostMapping("/delete")
    public String delete(@RequestParam("seq") Integer seq, RedirectAttributes rttr) {
        BannerDTO banner = bannerMapper.selectBanner(seq);

        // 물리적 이미지 파일도 함께 삭제
        if (banner != null && banner.getFileName() != null) {
            File file = new File(uploadDir, banner.getFileName());
            if (file.exists()) {
                file.delete();
            }
        }

        bannerMapper.deleteBanner(seq);
        bannerMapper.reorderDisplayOrder(); // 삭제 후 순서 재정렬

        rttr.addFlashAttribute("successMessage", "배너가 안전하게 삭제되었습니다.");
        return "redirect:/mng/banner/list";
    }
}