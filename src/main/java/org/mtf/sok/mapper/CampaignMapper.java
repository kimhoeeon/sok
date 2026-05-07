package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.mtf.sok.domain.CampaignDTO;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface CampaignMapper {
    // 관리자용 목록 및 페이징
    List<CampaignDTO> selectCampaignList(CampaignDTO params);

    int selectCampaignTotalCount(CampaignDTO params);

    // 캠페인 상세 조회
    CampaignDTO selectCampaign(Long campSeq);

    // [프론트엔드용] 현재 진행 중인 1개의 캠페인만 단건 조회
    CampaignDTO selectActiveCampaign();

    // 관리자 CRUD
    void insertCampaign(CampaignDTO campaign);

    void updateCampaign(CampaignDTO campaign);

    void deleteCampaign(Long campSeq);

    // [핵심] 결제 완료 시 해당 캠페인의 현재 모금액(CURRENT_AMT) 누적 업데이트
    void addCurrentAmount(@Param("campSeq") Long campSeq, @Param("amount") BigDecimal amount);
}