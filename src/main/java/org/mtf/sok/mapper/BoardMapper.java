package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.BoardDTO;
import org.mtf.sok.domain.FileDTO;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<BoardDTO> selectBoardList(BoardDTO params);

    int selectBoardTotalCount(BoardDTO params);

    BoardDTO selectBoard(Long brdSeq);

    void insertBoard(BoardDTO board);

    void updateBoard(BoardDTO board);

    void deleteBoard(Long brdSeq);

    void updateViewCnt(Long brdSeq);

    // 첨부파일 저장 및 조회
    void insertFile(FileDTO file);

    List<FileDTO> selectFiles(FileDTO params);

}