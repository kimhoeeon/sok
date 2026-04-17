package org.mtf.sok.security;

import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.AdminMapper;
import org.mtf.sok.mapper.MemberMapper;
import org.mtf.sok.util.RequestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class PrincipalDetailsService implements UserDetailsService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        // 1. 관리자 테이블 먼저 조회
        AdminDTO admin = adminMapper.selectAdminById(username);

        if (admin != null) {
            // [추가된 로직] resultMap을 사용하지 않으므로 IP 목록을 수동으로 조회하여 DTO에 세팅
            List<String> allowedIps = adminMapper.selectAdminIps(admin.getAdmSeq());
            admin.setAllowedIpList(allowedIps);

            // [보안강화] 현재 접속한 클라이언트 IP 확인
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
            String clientIp = RequestUtils.getClientIp(request);

            // DB에 등록된 허용 IP가 1개 이상 존재하는 경우에만 검사 수행
            if (admin.getAllowedIpList() != null && !admin.getAllowedIpList().isEmpty() && admin.getAllowedIpList().get(0) != null) {
                boolean isAllowed = false;

                for (String allowedIp : admin.getAllowedIpList()) {
                    if (clientIp.equals(allowedIp)) {
                        isAllowed = true;
                        break;
                    }
                }

                if (!isAllowed) {
                    // 허용되지 않은 IP일 경우 즉시 예외 발생
                    System.out.println("❌ 관리자 IP 차단됨: " + clientIp);
                    throw new BadCredentialsException("접근이 허용되지 않은 IP입니다. (" + clientIp + ")");
                }
            }

            // 검증 통과 시 로그인 시간 업데이트 및 객체 리턴
            adminMapper.updateLoginTime(admin.getAdmId());
            return new PrincipalDetails(admin);
        }

        // 2. 관리자가 아니면 일반 회원 테이블 조회
        MemberDTO member = memberMapper.selectMemberById(username);
        if (member != null) {
            return new PrincipalDetails(member);
        }

        throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
    }
}