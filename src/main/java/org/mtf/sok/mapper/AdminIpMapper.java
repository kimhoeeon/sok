package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.AdminIpDTO;
import java.util.List;

@Mapper
public interface AdminIpMapper {
    // 전체 관리자 목록 조회 (IP 관리 페이지용)
    List<AdminDTO> selectAllAdmins();

    // 특정 관리자의 허용 IP 목록 조회
    List<AdminIpDTO> selectIpsByAdmSeq(Long admSeq);

    // IP 등록
    void insertAdminIp(AdminIpDTO adminIpDTO);

    // IP 삭제
    void deleteAdminIp(Long ipSeq);

    // 중복 IP 체크 (동일 관리자에게 같은 IP 등록 방지)
    int checkDuplicateIp(AdminIpDTO adminIpDTO);
}