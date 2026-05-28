package org.mtf.sok.security;

import lombok.extern.slf4j.Slf4j;
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

@Slf4j
@Service
public class PrincipalDetailsService implements UserDetailsService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        // ★ 로그인 폼에서 넘어온 loginType (admin / member) 값을 가로채어 확인
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        String loginType = request.getParameter("loginType");

        // ==========================================
        // 1. [관리자 로그인] 폼에서 요청한 경우
        // ==========================================
        if ("admin".equals(loginType)) {
            AdminDTO admin = adminMapper.selectAdminById(username);

            if (admin != null) {
                // [보안 로직 유지] IP 목록 수동 조회 및 DTO 세팅
                List<String> allowedIps = adminMapper.selectAdminIps(admin.getAdmSeq());
                admin.setAllowedIpList(allowedIps);

                // 현재 접속한 클라이언트 IP 확인
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
                        log.warn("🚨 보안 차단: 등록되지 않은 IP({})에서 관리자 계정({}) 로그인을 시도했습니다.", clientIp, admin.getAdmId());
                        //throw new BadCredentialsException("접근이 허용되지 않은 IP입니다. (" + clientIp + ")");
                        throw new UsernameNotFoundException("접근이 허용되지 않은 IP입니다. (" + clientIp + ")");
                    }
                }

                // 검증 통과 시 로그인 시간 업데이트 및 객체 리턴
                adminMapper.updateLoginTime(admin.getAdmId());
                return new PrincipalDetails(admin);
            }
        }
        // ==========================================
        // 2. [사용자 프론트 로그인] 폼에서 요청한 경우
        // ==========================================
        else {
            MemberDTO member = memberMapper.selectMemberById(username);
            if (member != null) {
                return new PrincipalDetails(member);
            }
        }

        // 아이디가 없거나, 타입이 맞지 않으면 로그인 실패 처리
        throw new UsernameNotFoundException("가입되지 않은 아이디이거나, 잘못된 비밀번호입니다.");
    }
}