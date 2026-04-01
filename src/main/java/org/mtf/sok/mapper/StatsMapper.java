package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface StatsMapper {
    // 상단 요약 통계 (누적 후원자, 누적 금액, 미처리 티켓)
    Map<String, Object> selectSummaryStats();

    // 상위 조회 페이지 TOP 5
    List<Map<String, Object>> selectTopPages();

    // 방문자 추이 데이터 (기간별)
    List<Map<String, Object>> selectVisitorTrend(@Param("periodType") String periodType);

    // 신청/참여 현황 데이터 (후원 vs 봉사)
    List<Map<String, Object>> selectApplyTrend(@Param("periodType") String periodType);

    // 실제 DB 통신 상태 체크용
    int checkDbConnection();

    // 프론트엔드 사용자 방문 로그 인서트
    void insertVisitLog(@Param("visitIp") String visitIp, @Param("userAgent") String userAgent);
}