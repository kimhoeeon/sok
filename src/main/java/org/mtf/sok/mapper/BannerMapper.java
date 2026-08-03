package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.BannerDTO;
import java.util.List;

@Mapper
public interface BannerMapper {

    // 배너 목록 조회 (관리자용 페이징/검색, 프론트용 활성 배너 조회 공용)
    List<BannerDTO> selectBannerList(BannerDTO params);

    // 전체 데이터 개수 조회 (페이징용)
    int selectBannerCount(BannerDTO params);

    // 특정 배너 상세 조회
    BannerDTO selectBanner(Integer seq);

    // 신규 등록 시 가장 큰 노출 순서 번호 가져오기
    Integer getMaxDisplayOrder();

    // 배너 등록
    void insertBanner(BannerDTO params);

    // 배너 수정
    void updateBanner(BannerDTO params);

    // 배너 삭제
    void deleteBanner(Integer seq);

    // 삭제 또는 순서 변경 후 노출 순서(display_order) 10 단위 자동 재정렬
    void reorderDisplayOrder();
}