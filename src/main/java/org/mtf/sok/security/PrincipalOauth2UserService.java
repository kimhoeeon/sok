package org.mtf.sok.security;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        try {
            String provider = userRequest.getClientRegistration().getRegistrationId();
            String providerId = "";
            String email = "";
            String name = "";

            if (provider.equals("kakao")) {
                Map<String, Object> attributes = oAuth2User.getAttributes();
                providerId = String.valueOf(attributes.get("id"));

                Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
                if (kakaoAccount != null) {
                    if (kakaoAccount.get("email") != null) {
                        email = (String) kakaoAccount.get("email");
                    }
                    Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
                    if (profile != null && profile.get("nickname") != null) {
                        name = (String) profile.get("nickname");
                    }
                }
            }

            // DB에 매핑될 고유 ID
            String username = provider + "_" + providerId;
            MemberDTO memberEntity = memberMapper.selectMemberById(username);

            // [수정 포인트] 신규 가입일 때만 처리하도록 분리
            if (memberEntity == null) {
                // 1. 이메일 제공 동의를 한 경우에만 중복 검사
                if (email != null && !email.isEmpty()) {
                    int emailCount = memberMapper.checkDuplicateEmail(email, null);
                    if (emailCount > 0) {
                        throw new InternalAuthenticationServiceException("해당 카카오 계정의 이메일(" + email + ")은 이미 일반 회원으로 가입되어 있습니다. 일반 로그인을 이용해 주세요.");
                    }
                }

                String password = passwordEncoder.encode(UUID.randomUUID().toString());

                memberEntity = new MemberDTO();
                memberEntity.setMbrId(username);
                memberEntity.setMbrPw(password);
                memberEntity.setMbrNm(name == null || name.isEmpty() ? "카카오회원" : name);
                memberEntity.setEmail(email);
                memberEntity.setSnsType(provider.toUpperCase());
                memberEntity.setSnsId(providerId);
                memberEntity.setLoginType("KAKAO");
                memberEntity.setMbrType("INDIVIDUAL");
                memberEntity.setMbrRole("USER");
                memberEntity.setAgreeAgeYn("N");
                memberEntity.setAgreeServiceYn("N");
                memberEntity.setAgreePrivacyYn("N");

                memberMapper.insertMember(memberEntity);

                // 가입 직후 DB에서 조회하여 MBR_SEQ(회원번호)를 획득
                memberEntity = memberMapper.selectMemberById(username);
            }
            // else: 이미 DB에 있는 회원(memberEntity != null)이라면 별다른 로직 없이 그대로 로그인 통과!

            return new PrincipalDetails(memberEntity, oAuth2User.getAttributes());

        } catch (InternalAuthenticationServiceException e) {
            throw e; // 우리가 의도한 에러(이메일 중복 등)는 그대로 던짐
        } catch (Exception e) {
            e.printStackTrace();
            throw new InternalAuthenticationServiceException("소셜 로그인 처리 중 시스템 오류가 발생했습니다.", e);
        }
    }
}