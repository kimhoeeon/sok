package org.mtf.sok.security;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.UUID;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oauth2User = super.loadUser(userRequest);
        Map<String, Object> attributes = oauth2User.getAttributes();

        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");

        String username = "kakao_" + attributes.get("id");
        MemberDTO member = memberMapper.selectMemberById(username);

        // 첫 로그인일 경우 자동 회원가입
        if (member == null) {
            member = new MemberDTO();
            member.setMbrId(username);
            member.setMbrPw(new BCryptPasswordEncoder().encode(UUID.randomUUID().toString())); // 소셜은 PW 불필요하여 난수처리
            member.setMbrNm((String) profile.get("nickname"));
            member.setEmail((String) kakaoAccount.get("email"));
            memberMapper.insertKakaoMember(member);
            member = memberMapper.selectMemberById(username); // 가입 후 다시 조회
        }
        return new PrincipalDetails(member, attributes);
    }
}