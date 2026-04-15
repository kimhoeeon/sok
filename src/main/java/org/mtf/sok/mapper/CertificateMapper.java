package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.mtf.sok.domain.CertificateDTO;

import java.util.List;

@Mapper
public interface CertificateMapper {

    // [사용자] 이름과 연락처로 본인의 신청 내역 및 상태 조회
    List<CertificateDTO> selectMyCertificateStatus(@Param("applyNm") String applyNm, @Param("phone") String phone);

    List<CertificateDTO> selectCertificateList(CertificateDTO params);

    int selectCertificateTotalCount(CertificateDTO params);

    CertificateDTO selectCertificate(Long certSeq);

    void updateCertificateStatus(CertificateDTO certificate);

    void deleteCertificate(Long certSeq);

    // [프론트엔드용 추가] 증명서 신청 및 중복 체크
    void insertCertificate(CertificateDTO certificate);

    int checkDuplicateCertificate(CertificateDTO params);

    CertificateDTO findCertificateForStatusCheck(CertificateDTO params);
}