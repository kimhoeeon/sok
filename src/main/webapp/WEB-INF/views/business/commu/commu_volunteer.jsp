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
                    <li><a href="/business/commu-academy">선수아카데미</a></li>
                    <li class="on"><a href="/business/commu-volunteer">가족/자원봉사 위원회</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt mb-0">
                    가족위원회는 스페셜올림픽 선수가족 관련 협력 업무들을 효율적으로 추진하여 <br/>
                    선수와 가족, 스페셜올림픽코리아의 발전을 도모하기 위한 위원회이며, <br/>
                    자원봉사위원회는 스페셜올림픽코리아의 다양한 사업들에 봉사하는 자원봉사자들이 사업 전후에도 <br/>
                    서로 교류하고 네트워크를 형성할 수 있도록 지원하는 위원회입니다.
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
                        <div class="sub_top_tit" id="tts_sub_vounteer_img">가족,자원봉사 위원회 사진</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_vounteer_img">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/family.jpg" alt="가족,자원봉사 위원회 이미지">
                        </li>
                        <li>
                            <img src="/img/family2.jpg" alt="가족,자원봉사 위원회 이미지">
                        </li>
                        <li>
                            <img src="/img/family3.jpg" alt="가족,자원봉사 위원회 이미지">
                        </li>
                        <li>
                            <img src="/img/family4.jpg" alt="가족,자원봉사 위원회 이미지">
                        </li>
                        <li>
                            <img src="/img/family5.jpg" alt="가족,자원봉사 위원회 이미지">
                        </li>
                        <li>
                            <img src="/img/family6.jpg" alt="가족,자원봉사 위원회 이미지">
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