package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.AdminDTO;
import java.util.List;

@Mapper
public interface AdminMapper {
    // 1. 관리자 기본 정보 조회 (DTO 자동 매핑)
    AdminDTO findAdminById(String mbrId);

    // 2. 관리자 MBR_SEQ를 통해 허용 IP 목록 조회
    List<String> findAllowedIps(Long mbrSeq);
}