package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.PromoterDTO;

import java.util.List;

@Mapper
public interface PromoterMapper {
    List<PromoterDTO> selectPromoterList(PromoterDTO params);

    int selectPromoterCount(PromoterDTO params);

    PromoterDTO selectPromoter(Integer seq);

    int checkDuplicateName(PromoterDTO params);

    Integer getMaxDisplayOrder();

    void insertPromoter(PromoterDTO params);

    void updatePromoter(PromoterDTO params);

    void deletePromoter(Integer seq);

    void reorderDisplayOrder();
}