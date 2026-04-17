package org.mtf.sok.security;

import org.mtf.sok.domain.MemberDTO;
import org.mtf.sok.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
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
        // 1. 소셜 로그인 API에서 유저 정보 가져오기
        OAuth2User oAuth2User = super.loadUser(userRequest);

        // 2. 소셜 제공자 확인 ("kakao")
        String provider = userRequest.getClientRegistration().getRegistrationId();

        String providerId = "";
        String email = "";
        String name = "";

        // 3. 카카오 로그인 데이터 파싱
        if (provider.equals("kakao")) {
            Map<String, Object> attributes = oAuth2User.getAttributes();
            providerId = String.valueOf(attributes.get("id"));

            // 카카오 계정 정보 (이메일 등)
            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            if (kakaoAccount != null) {
                if (kakaoAccount.get("email") != null) {
                    email = (String) kakaoAccount.get("email");
                }
                // 프로필 정보 (닉네임)
                Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
                if (profile != null && profile.get("nickname") != null) {
                    name = (String) profile.get("nickname");
                }
            }
        }

        // 4. 우리 사이트 DB용 아이디 생성 (예: kakao_123456789)
        String username = provider + "_" + providerId;

        // 소셜 로그인은 비밀번호가 필요 없지만, DB상 NOT NULL 방어 및 보안을 위해 임의 난수 암호화
        String password = passwordEncoder.encode(UUID.randomUUID().toString());

        // 5. DB에 해당 유저가 있는지 조회 (기존 등록된 MemberMapper 재사용)
        MemberDTO memberEntity = memberMapper.selectMemberById(username);

        // 6. 최초 로그인 (신규 가입) 처리
        if (memberEntity == null) {
            System.out.println("소셜 로그인이 최초입니다. 자동 회원가입을 진행합니다.");

            memberEntity = new MemberDTO();
            memberEntity.setMbrId(username);
            memberEntity.setMbrPw(password);
            memberEntity.setMbrNm(name.isEmpty() ? "소셜회원" : name);

            // [수정 핵심] 기존 DTO 및 DB 컬럼명에 완벽하게 일치하도록 세팅
            memberEntity.setEmail(email);
            memberEntity.setSnsType(provider.toUpperCase()); // "KAKAO"
            memberEntity.setSnsId(providerId);
            memberEntity.setLoginType("KAKAO"); // 관리자 페이지 회원 목록 필터링 연동용
            memberEntity.setMbrType("INDIVIDUAL"); // 소셜 가입자는 기본적으로 개인회원
            memberEntity.setMbrRole("ROLE_USER");
            memberEntity.setWithdrawYn("N"); // 탈퇴 여부 기본값 설정

            // DB에 인서트 (MemberMapper의 일반 회원가입 쿼리 재사용)
            memberMapper.insertMember(memberEntity);
        } else {
            System.out.println("이미 가입된 소셜 회원입니다. 로그인을 진행합니다.");

            // 만약 카카오 정책상 이메일이나 이름이 변경되었을 경우를 대비해 업데이트 로직을 추가하려면 이곳에 작성합니다.
            // 현재는 1차 로그인으로 세션만 생성합니다.
        }

        // 7. 세션에 저장될 PrincipalDetails 리턴
        return new PrincipalDetails(memberEntity, oAuth2User.getAttributes());
    }
}