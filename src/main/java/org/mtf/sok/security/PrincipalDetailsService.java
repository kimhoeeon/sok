package org.mtf.sok.security;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class PrincipalDetailsService implements UserDetailsService {
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberDTO member = memberMapper.selectMemberById(username);
        if (member != null) return new PrincipalDetails(member);
        throw new UsernameNotFoundException("해당 사용자를 찾을 수 없습니다.");
    }
}