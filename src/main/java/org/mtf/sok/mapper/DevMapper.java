package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.DevCommentDTO;
import org.mtf.sok.domain.DevRequestDTO;

import java.util.List;
import java.util.Map;

@Mapper
public interface DevMapper {
    // 요청글 관리
    List<DevRequestDTO> selectRequestList(DevRequestDTO params);

    DevRequestDTO selectRequest(Long reqSeq);

    void insertRequest(DevRequestDTO request);

    void updateRequestStatus(DevRequestDTO request); // 개발사 전용 (상태 및 예정일 변경)

    void deleteRequest(Long reqSeq);

    // 댓글 관리
    List<DevCommentDTO> selectCommentList(Long reqSeq);

    void insertComment(DevCommentDTO comment);

    void deleteComment(Long cmtSeq);

    // [고도화 추가] 상태별 티켓 개수 통계
    Map<String, Object> selectRequestStatusCount();
}