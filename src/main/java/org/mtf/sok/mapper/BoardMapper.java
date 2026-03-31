package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.BoardDTO;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<BoardDTO> selectBoardList(BoardDTO params);

    BoardDTO selectBoard(Long brdSeq);

    void insertBoard(BoardDTO board);

    void updateBoard(BoardDTO board);

    void deleteBoard(Long brdSeq);

    void updateViewCnt(Long brdSeq);
}