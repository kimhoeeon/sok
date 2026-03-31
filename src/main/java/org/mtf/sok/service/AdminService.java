package org.mtf.sok.service;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private AdminMapper adminMapper;

    public AdminDTO loginCheck(String mbrId, String mbrPw, String clientIp) throws Exception {

        // 1. DTO 매핑 방식으로 관리자 정보 단건 조회
        AdminDTO admin = adminMapper.findAdminById(mbrId);

        if (admin == null) {
            throw new Exception("존재하지 않는 관리자 계정입니다.");
        }

        if (!admin.getMbrPw().equals(mbrPw)) {
            throw new Exception("비밀번호가 일치하지 않습니다.");
        }

        // 2. 관리자 MBR_SEQ를 이용하여 허용 IP 목록을 별도 조회 후 DTO에 주입
        List<String> ipList = adminMapper.findAllowedIps(admin.getMbrSeq());
        admin.setAllowedIpList(ipList);

        // 3. IP 다중 검증 로직
        // DB에 등록된 허용 IP가 있을 경우에만 일치 여부를 검사하도록 처리
        if (ipList != null && !ipList.isEmpty()) {
            boolean isAllowed = false;
            for (String allowedIp : ipList) {
                if (clientIp.equals(allowedIp)) {
                    isAllowed = true;
                    break;
                }
            }
            if (!isAllowed) {
                throw new Exception("허용되지 않은 IP에서의 접근입니다. (접속 IP: " + clientIp + ")");
            }
        }

        return admin;
    }
}