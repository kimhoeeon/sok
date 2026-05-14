package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.mtf.sok.domain.PopupDTO;

import java.util.List;

@Mapper
public interface PopupMapper {
    List<PopupDTO> selectPopupList(PopupDTO params);

    int selectPopupTotalCount(PopupDTO params);

    PopupDTO selectPopup(Long popSeq);

    void insertPopup(PopupDTO popup);

    void updatePopup(PopupDTO popup);

    void deletePopup(Long popSeq);

    List<PopupDTO> selectActivePopupList();

    // 팝업 삭제 시 관련 파일 논리적 삭제
    void deleteFilesByRefTarget(@Param("refTable") String refTable, @Param("refSeq") Long refSeq);

}