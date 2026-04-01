package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
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

}