package org.mtf.sok.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.mtf.sok.domain.CertificateDTO;

import java.util.List;

@Mapper
public interface CertificateMapper {
    List<CertificateDTO> selectCertificateList(CertificateDTO params);

    CertificateDTO selectCertificate(Long certSeq);

    void updateCertificateStatus(CertificateDTO certificate);

    void deleteCertificate(Long certSeq);
}