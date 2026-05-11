<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>주요사업</span><span>커뮤니티</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">커뮤니티</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/business/sports">스포츠</a></li>
                <li><a href="/business/culture">문화예술</a></li>
                <li class="on"><a href="/business/commu">커뮤니티</a></li>
                <li><a href="/business/awareness">인식개선</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/business/commu">유아체육프로그램</a></li>
                    <li class="on"><a href="/business/commu-academy">선수아카데미</a></li>
                    <li><a href="/business/commu-volunteer">가족/자원봉사 위원회</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    선수아카데미는 스페셜올림픽의 발달장애인과 비장애인 청소년, 성인멘토가 함께 리더십 이론교육, 실기, 통합스포츠를 체험하고 <br/>
                    공감대를 형성, 소속학교와 지역사회에서 리더십을 발휘하여 장애인 인식개선과 통합사회 구현을 할 수 있는 <br/>
                    역량 강화와 기술향상을 위한 활동입니다. <br/>
                    선수아카데미는 크게 스페셜올림픽 선수위원회, 국내외 선수리더십 회의, 유스이노베이션 프로젝트 지원금 사업으로 나누어져 있으며, <br/>
                    스페셜올림픽 선수로 활동하는 모든 발달장애인과 비장애인 청소년, 그리고 성인멘토가 함께 참가할 수 있습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/W8hV2_WR15I?mute=1&controls=0&loop=1&playlist=W8hV2_WR15I'
                                frameborder='0' allowfullscreen></iframe>
                    </div>
                </div>
            </div>
            <div class="academy_info">
                <div class="academy_box">
                    <div class="tit">스페셜올림픽 선수위원회</div>
                    <ul>
                        <li>
                            스페셜올림픽코리아 선수위원회 <br/>
                            Korea Athlete Leadership Council
                        </li>
                        <li>
                            스페셜올림픽 글로벌 선수위원회 <br/>
                            Global Athlete Leadership Council
                        </li>
                        <li>
                            스페셜올림픽 동아시아 선수위원회 <br/>
                            Regional Athlete Leadership Council
                        </li>
                        <li>
                            스페셜올림픽 청소년참여위원회 <br/>
                            Youth Engagement Committee
                        </li>
                    </ul>
                </div>
                <div class="academy_box">
                    <div class="tit">국내외 선수리더십 회의</div>
                    <ul>
                        <li>
                            Global Youth Leadership Summit <br/>
                            (2023 독일 베를린, 2025 이탈리아 토리노)
                        </li>
                        <li>
                            Global Athlete Leadership Training <br/>
                            (2025 미국 워싱턴D.C)
                        </li>
                        <li>
                            SOEA Youth Leadership Summit <br/>
                            (2024 중국 베이징)
                        </li>
                        <li>
                            SOEA Athlete Leadership Training <br/>
                            (2024 중국 베이징)
                        </li>
                    </ul>
                </div>
                <div class="academy_box">
                    <div class="tit">유스이노베이션프로젝트 <br/>Youth Innovation Project</div>
                </div>
            </div>
            <div class="cult_img">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_academy_img">선수아카데미 사진</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_academy_img">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/img_leadership1.jpg" alt="선수아카데미 이미지">
                        </li>
                        <li>
                            <img src="/img/img_leadership2.jpg" alt="선수아카데미 이미지">
                        </li>
                        <li>
                            <img src="/img/img_leadership3.png" alt="선수아카데미 이미지">
                        </li>
                        <li>
                            <img src="/img/img_leadership4.jpg" alt="선수아카데미 이미지">
                        </li>
                        <li>
                            <img src="/img/img_leadership5.jpg" alt="선수아카데미 이미지">
                        </li>
                        <li>
                            <img src="/img/img_leadership6.jpg" alt="선수아카데미 이미지">
                        </li>
                    </ul>
                </div>
            </div>

            <div class="commu_leadership">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_commu_leadership">선수리더십교육</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_commu_leadership">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="leader_features">
                    <ul>
                        <li>
                            <img src="/img/commu_reader01.png" alt="리더십교육 아이콘">
                            <div>스페셜올림픽에 대한 <br/>기본지식 습득</div>
                        </li>
                        <li>
                            <img src="/img/commu_reader02.png" alt="리더십교육 아이콘">
                            <div>스페셜올림픽 선수로서의 <br/>리더십 배양</div>
                        </li>
                        <li>
                            <img src="/img/commu_reader03.png" alt="리더십교육 아이콘">
                            <div>커뮤니케이션 <br/>능력 함양</div>
                        </li>
                        <li>
                            <img src="/img/commu_reader04.png" alt="리더십교육 아이콘">
                            <div>각 선수의 <br/>소질 및 적성 계발</div>
                        </li>
                        <li>
                            <img src="/img/commu_reader05.png" alt="리더십교육 아이콘">
                            <div>통합 뉴스포츠 체험</div>
                        </li>
                        <li>
                            <img src="/img/commu_reader06.png" alt="리더십교육 아이콘">
                            <div>국제 역량 강화</div>
                        </li>
                    </ul>
                </div>
                <div class="leader_txt">
                    <div class="big">국내 청소년 회의 참가자 신서중학교 유준열 학생 후기 중</div>
                    <div class="small">장애인에 대한 차별적인 시선을 갖고 있었는데, <br/>청소년회의 참가 후 그들과 오랜 시간을 함께하며 그들을 이해할 수 있었다.</div>
                    <div class="txt">“ 나의 파트너 근석아! 잘지내줘서 너무 고맙고 우리 돌아가서도 인사하며 자주 만나자..! <br/>너로 인해 더 즐겁게 3일이 흘러간 것 같아~
                        고맙고 사랑한다. “
                    </div>
                </div>
            </div>
        </div>

        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>