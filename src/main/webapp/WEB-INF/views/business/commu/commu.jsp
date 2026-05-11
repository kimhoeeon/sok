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
                    <li class="on"><a href="/business/commu">유아체육프로그램</a></li>
                    <li><a href="/business/commu-academy">선수아카데미</a></li>
                    <li><a href="/business/commu-volunteer">가족/자원봉사 위원회</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    스페셜올림픽코리아가 제작한 ‘유아체육프로그램 지도서’를 근간으로 전국의 발달장애인 지도자 세미나를 개최하여 <br/>
                    발달장애인 유아체육 전문 지도자를 양성하고, 공모를 통해 전국 각 지역에서 유아체육 클럽을 운영케 함으로써 <br/>
                    발달장애 유아의 신체․인지 능력의 향상과 사회성을 함양시키는 프로그램입니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/N3FYmiNimTw?mute=1&controls=0&loop=1&playlist=N3FYmiNimTw'
                                frameborder='0' allowfullscreen></iframe>
                    </div>
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
                        <div class="sub_top_tit" id="tts_sub_commu_img">유아체육 프로그램 사진</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_commu_img">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/child.jpg" alt="유아체육 이미지">
                        </li>
                        <li>
                            <img src="/img/child2.jpg" alt="유아체육 이미지">
                        </li>
                        <li>
                            <img src="/img/child3.jpg" alt="유아체육 이미지">
                        </li>
                        <li>
                            <img src="/img/child4.jpg" alt="유아체육 이미지">
                        </li>
                        <li>
                            <img src="/img/child5.jpg" alt="유아체육 이미지">
                        </li>
                        <li>
                            <img src="/img/child6.jpg" alt="유아체육 이미지">
                        </li>
                    </ul>
                </div>
            </div>

            <div class="commu_purpose">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_commu_purpose">유아체육 프로그램 목적</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_commu_purpose">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="commu_txt">
                    <ul>
                        <li>
                            <div class="num">01</div>
                            <div class="tit">운동수준향상</div>
                            <div class="nae">유아들의 운동 수준 향상으로 이 활동을 통해 유아의 신체와 인지 그리고 사회적인 면에서 긍정적인 개선을 가져다주는데 있습니다.
                            </div>
                        </li>
                        <li>
                            <div class="num">02</div>
                            <div class="tit">교육의 통로</div>
                            <div class="nae">본 프로그램이 교육의 통로로써 발달장애 유아들의 다양한 능력에 대한 대중들의 이해를 높이고자 합니다.</div>
                        </li>
                        <li>
                            <div class="num">03</div>
                            <div class="tit">가족 간 교류 장</div>
                            <div class="nae">스페셜올림픽을 알지 못하던 가족에게 스페셜올림픽 활동에 대해 소개하고 지속적인 지원과 가족 간 교류의 장을 마련할 것입니다.</div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>