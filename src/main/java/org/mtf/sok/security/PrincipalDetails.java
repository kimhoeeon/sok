package org.mtf.sok.security;

import lombok.Getter;
import org.mtf.sok.domain.AdminDTO;
import org.mtf.sok.domain.MemberDTO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Getter
public class PrincipalDetails implements UserDetails, OAuth2User {

    private MemberDTO memberDTO; // 일반 회원
    private AdminDTO adminDTO;   // 관리자 (추가)
    private Map<String, Object> attributes;

    // 일반 회원 생성자
    public PrincipalDetails(MemberDTO memberDTO) {
        this.memberDTO = memberDTO;
    }

    // 관리자 생성자 (추가)
    public PrincipalDetails(AdminDTO adminDTO) {
        this.adminDTO = adminDTO;
    }

    // 소셜 로그인 생성자
    public PrincipalDetails(MemberDTO memberDTO, Map<String, Object> attributes) {
        this.memberDTO = memberDTO;
        this.attributes = attributes;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
        if (adminDTO != null) {
            collect.add(new SimpleGrantedAuthority(adminDTO.getAdmRole()));
        } else {
            collect.add(new SimpleGrantedAuthority("ROLE_" + memberDTO.getMbrRole()));
        }
        return collect;
    }

    @Override
    public String getPassword() {
        return adminDTO != null ? adminDTO.getAdmPw() : memberDTO.getMbrPw();
    }

    @Override
    public String getUsername() {
        return adminDTO != null ? adminDTO.getAdmId() : memberDTO.getMbrId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    @Override
    public String getName() {
        return null;
    }
}