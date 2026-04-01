package org.mtf.sok.service;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private PasswordEncoder passwordEncoder; // ★ BCrypt 인코더 의존성 주입

    public AdminDTO loginCheck(String mbrId, String mbrPw, String clientIp) throws Exception {

        AdminDTO admin = adminMapper.findAdminById(mbrId);

        if (admin == null) {
            throw new Exception("존재하지 않는 관리자 계정입니다.");
        }

        // ★ [보안 고도화] 평문 비교 대신 BCrypt 해시 매칭 검증 사용
        if (!passwordEncoder.matches(mbrPw, admin.getMbrPw())) {
            throw new Exception("비밀번호가 일치하지 않습니다.");
        }

        // IP 검증 로직 (기존과 동일하게 100% 보존)
        List<String> ipList = adminMapper.findAllowedIps(admin.getMbrSeq());
        admin.setAllowedIpList(ipList);

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