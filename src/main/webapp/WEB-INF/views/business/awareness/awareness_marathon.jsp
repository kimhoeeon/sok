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
                    <span>주요사업</span><span>인식개선</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">인식개선</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/business/sports">스포츠</a></li>
                <li><a href="/business/culture">문화예술</a></li>
                <li><a href="/business/commu">커뮤니티</a></li>
                <li class="on"><a href="/business/awareness">인식개선</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/business/awareness">슈퍼블루 캠페인</a></li>
                    <li class="on"><a href="/business/awareness-marathon">슈퍼블루 마라톤</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    2024년 9주년을 맞이한 슈퍼블루마라톤은 스페셜올림픽코리아와 롯데그룹이 2014년부터 진행하고 있는 <br/>
                    장애인 인식개선 사업인 '슈퍼블루 캠페인'의 일환으로 장애인과 비장애인이 함께 달리며 장애에 대한 <br/>
                    우리 사회의 그릇된 인식과 편견의 벽을 낮추자는 취지에서 마련된 행사로 매년 8,000명 이상의 참가자와 함께 달리고 있습니다.
                </div>
                <div class="video">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/CH5LUHTTVtc?mute=1&controls=0&loop=1&playlist=CH5LUHTTVtc'
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
                        <div class="sub_top_tit" id="tts_sub_marathon_img">슈퍼블루마라톤 사진</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_marathon_img">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/marathon.jpg" alt="슈퍼블루마라톤 이미지">
                        </li>
                        <li>
                            <img src="/img/marathon2.jpg" alt="슈퍼블루마라톤 이미지">
                        </li>
                        <li>
                            <img src="/img/marathon3.jpg" alt="슈퍼블루마라톤 이미지">
                        </li>
                        <li>
                            <img src="/img/marathon4.jpg" alt="슈퍼블루마라톤 이미지">
                        </li>
                        <li>
                            <img src="/img/marathon5.jpg" alt="슈퍼블루마라톤 이미지">
                        </li>
                        <li>
                            <img src="/img/marathon6.jpg" alt="슈퍼블루마라톤 이미지">
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
                        <div class="sub_top_tit" id="tts_sub_commu_leadership">슈퍼블루 마라톤 대회일정 <br/>(매년 10월 경)</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_commu_leadership">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="marathon_features">
                    <ul>
                        <li>
                            <img src="/img/marathon01.png" alt="마라톤 아이콘">
                            <div class="tit">장소</div>
                            <div>상암 월드컵공원 <br/>평화의공원 평화광장</div>
                        </li>
                        <li>
                            <img src="/img/marathon02.png" alt="마라톤 아이콘">
                            <div class="tit">참가부문</div>
                            <div>10km, 5km <br/>슈퍼블루 5km, 걷기코스</div>
                        </li>
                        <li>
                            <img src="/img/marathon03.png" alt="마라톤 아이콘">
                            <div class="tit">참가대상</div>
                            <div>장애인, 비장애인 <br/>누구나 참가가능</div>
                        </li>
                        <li>
                            <img src="/img/marathon04.png" alt="마라톤 아이콘">
                            <div class="tit">대회문의</div>
                            <div>자세한 사항은 [공식 홈페이지]를 <br/>통해 확인 할 수 있습니다.</div>
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