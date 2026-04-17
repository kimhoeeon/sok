package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.AdminDTO;
import java.util.List;

@Mapper
public interface AdminMapper {
    // 관리자 정보 조회
    AdminDTO selectAdminById(String admId);

    // 관리자 허용 IP 목록 조회 (추가)
    List<String> selectAdminIps(Long admSeq);

    // 로그인 시간 업데이트
    void updateLoginTime(String admId);
}