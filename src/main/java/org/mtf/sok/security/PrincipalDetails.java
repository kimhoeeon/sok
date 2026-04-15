package org.mtf.sok.security;

import org.mtf.sok.domain.MemberDTO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

public class PrincipalDetails implements UserDetails, OAuth2User {
    private MemberDTO memberDTO;
    private Map<String, Object> attributes;

    public PrincipalDetails(MemberDTO memberDTO) {
        this.memberDTO = memberDTO;
    }

    public PrincipalDetails(MemberDTO memberDTO, Map<String, Object> attributes) {
        this.memberDTO = memberDTO;
        this.attributes = attributes;
    }

    public MemberDTO getMemberDTO() {
        return memberDTO;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    @Override
    public String getName() {
        return memberDTO.getMbrId();
    }

    @Override
    public String getPassword() {
        return memberDTO.getMbrPw();
    }

    @Override
    public String getUsername() {
        return memberDTO.getMbrId();
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
        return "N".equals(memberDTO.getWithdrawYn());
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
        collect.add(() -> "ROLE_" + memberDTO.getMbrRole());
        return collect;
    }
}