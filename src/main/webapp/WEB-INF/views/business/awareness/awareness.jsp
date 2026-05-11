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
                    <li class="on"><a href="/business/awareness">슈퍼블루 캠페인</a></li>
                    <li><a href="/business/awareness-marathon">슈퍼블루 마라톤</a></li>
                </ul>
            </div>
            <div class="super_blue_top">
                <div class="sub_top pt-0">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_super01">슈퍼블루 캠페인</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_super01">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="top_blue_content">
                    <div>슈퍼블루 캠페인은 캠페인의 상징인 <br/><span>파란색 운동화 끈을 묶고 달리며</span> 장애에 대한 인식을 개선하는 실천 캠페인입니다.</div>
                    <ul>
                        <li>
                            <img src="/img/super_blue_img01.png" alt="슈퍼블루 이미지">
                            <div class="tit">의미</div>
                            <div class="desc">장애인에 대한 인식 개선,자립 지원</div>
                        </li>
                        <li>
                            <img src="/img/super_blue_img02.png" alt="슈퍼블루 이미지">
                            <div class="tit">상징색</div>
                            <div class="desc">‘슈퍼블루' 밝고 희망적인 컬러</div>
                        </li>
                        <li>
                            <img src="/img/super_blue_img03.png" alt="슈퍼블루 이미지">
                            <div class="tit">상징물</div>
                            <div class="desc">'운동화끈' <br/>(스스로 운동화끈을 묶다 → 자립)</div>
                        </li>
                        <li>
                            <img src="/img/super_blue_img04.png" alt="슈퍼블루 이미지">
                            <div class="tit">참여방법</div>
                            <div class="desc">슈퍼블루 운동화끈 묶고 함께 달리기</div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="super_blue_sec01">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_super02">슈퍼블루와 함께 <br/><span
                                class="blue">장애가 장벽이 되지않는 세상</span>을 만들어 주세요.
                        </div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_super02">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="sec01_blue_content">
                    <div>슈퍼블루는 장애인에 대한 우리의 인식을 다시 돌아보고 궁극적으로는 장애인이 사회의 일원으로 당당하게 자리 잡을 수 있도록, <br/>배려하고 나아가 장애인과 비장애인이
                        더불어 사는 사회를 만들기 위한 캠페인입니다
                    </div>
                    <ul>
                        <li>
                            <div class="num">01</div>
                            <div class="tit">지금 신고 있는 운동화의 끈을 슈퍼블루로 바꾸어 보세요.</div>
                            <div class="desc">슈퍼블루 운동화끈 착용은 '우리는 장애인과 함께합니다' 라는 <br/>
                                의미를 내포하고 있습니다. <br/>
                                여러분의 슈퍼블루에 대한 지지를 주변으로 공유하고 확신해주세요. <br/>
                                우리가 파란 운동화끈을 묶고 한 발씩 내디딜 때 마다 장애인과 비장애인 사이의 <br/>
                                장벽은 낮아집니다.
                            </div>
                        </li>
                        <li>
                            <div class="num">02</div>
                            <div class="tit">슈퍼블루 5가지 약속을 실천해주세요.</div>
                            <div class="desc">인식의 틀을 바꾸는 것은 언어에서부터 시작할 수 있습니다. <br/>
                                일상에서 흔히 쓰는 잘못된 용어들부터 바꾸어주세요.
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="super_blue_sec03">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_super03">슈퍼블루 5가지 약속</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_super03">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="sec02_blue_content">
                    <div>슈퍼블루 5가지 약속은 일상에서 자주 쓰는 장애인 비하 용어와 흔히 저지르기 쉬운 장애인을 배려하지않는 행동 <br/>5가지를 뽑아 적절한 표현과 행동을 구체적으로
                        안내함으로써 생활 속 작은 실천을 이끌어 냅니다.
                    </div>
                    <ul>
                        <li>
                            <div class="num">01</div>
                            <div class="txt">
                                <div class="tit">장애인의 반대말은 정상인이 아니라 비장애인입니다!</div>
                                <div class="desc">장애가 없는 사람이 정상인이라면 장애가 있는 사람은 비정상인이라는 말이 되겠지요? <br/>'정상인 못지않게 잘한다'가 아니라
                                    '비장애인 못지않게 잘한다'라고 해주세요.
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="num">02</div>
                            <div class="txt">
                                <div class="tit">장애는 앓는 것이 아니라 '갖고있는' 것 입니다.</div>
                                <div class="desc">장애는 병이 아닌데 왜 앓는다고 표현할까요? <br/>'장애를 앓고있다'고 하지말고 '장애를 갖고있다'고 표현해 주세요.
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="num">03</div>
                            <div class="txt">
                                <div class="tit">장애인에게 도움을 주고 싶을 땐 상대가 원하는지 먼저 물어보세요.</div>
                                <div class="desc">장애인은 비장애인과 조금 다를 뿐 부족하거나 모자란존재가 아닙니다. <br/>도움을 주고 싶을 땐 먼저 상대의 의사부터 물어
                                    주세요. 힐끗거리거나 딱하다는 듯 혀를 차는 행동도 삼가주세요.
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="num">04</div>
                            <div class="txt">
                                <div class="tit">발달장애인에게 반말을 하지 말아 주세요.</div>
                                <div class="desc">발달장애인의 지능이 어린아이와 같다고 생각이나 행동도 어린 것은 아니랍니다. <br/>성인 장애인에게 어린 아이 대하듯 반말을
                                    하지 말아 주세요.
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="num">05</div>
                            <div class="txt">
                                <div class="tit">장애우가 아니라 '장애인'이라고 불러주세요.</div>
                                <div class="desc">장애인이 스스로를 지칭할 때 쓸 수 없는 '장애우'는 비주체적이고 의존적인 존재라는 전제를 담고 있는 말입니다. <br/>장애우가
                                    아니라 장애인이라고 불러주세요.
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="super_blue_sec04">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_super04">슈퍼블루 캠페인이 걸어온 길</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_super04">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="sec03_blue_content">
                    <div class="tit">2013년 7월 SOK 비전포럼에서 "블루캠페인"(지적장애인 용어 바르게 쓰기)을 선포한 이래로 <br/>2014년 슈퍼블루 캠페인으로 진화되어
                        대한민국 대표 장애인 인식개선 캠페인으로 자리잡게 되었으며 보다 많은 장애인과 비장애인이 <br/>함께 공감하고 전파하기 위해 2015년 부터 슈퍼블루마라톤대회를 창설하여
                        올해로 제9회 슈퍼블루마라톤을 개최하게 되었습니다.
                    </div>
                    <div class="history">
                        <div class="timeline">

                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2019</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left year2019"><img src="/img/timeline_img01.png" alt="블루캠페인 이미지">
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">10 .05</span><br>제 5회 슈퍼블루 마라톤 개최</div>
                                </div>
                            </div>
                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2018</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item l_line">
                                <div class="timeline_left">
                                    <div><span class="date">10 .13</span><br>제 4회 슈퍼블루 마라톤 개최</div>
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right year2020">
                                    <img src="/img/timeline_img02.png" alt="블루캠페인 이미지">
                                </div>
                            </div>
                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2017</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left"></div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">10 .14</span><br>제 3회 슈퍼블루 마라톤 개최</div>
                                </div>
                            </div>
                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2016</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item l_line">
                                <div class="timeline_left">
                                    <div><span class="date">10 .08</span><br>제 2회 슈퍼블루 마라톤 개최</div>
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right"></div>
                            </div>
                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2015</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left year2019"><img src="/img/timeline_img03.png" alt="블루캠페인 이미지">
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">10 .24</span><br>제 1회 슈퍼블루 마라톤 개최</div>
                                </div>
                            </div>
                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2014</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item l_line">
                                <div class="timeline_left">
                                    <div><span class="date">12 .20</span><br>슈퍼블루 크리스마스 가두 캠페인 (명동)</div>
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right"></div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left"></div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">11 .01 ~ 11 .30</span><br>11월 한달간 전국세븐일레븐 7,000여 매장에서 슈퍼블루끈
                                        배포
                                    </div>
                                </div>
                            </div>
                            <div class="timeline_item txt-item l_line">
                                <div class="timeline_left">
                                    <div><span class="date">11 .16</span><br>Together We Walk' 슈퍼블루홍보</div>
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right"></div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left"></div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">08 .22</span><br>SOK- 롯데그룹 슈퍼블루 캠페인 추진 합의</div>
                                </div>
                            </div>
                            <div class="timeline_item txt-item l_line">
                                <div class="timeline_left">
                                    <div><span class="date">04 .10</span><br>SOK-법제처 업무협약 체결 (장애인 비하 법률용어 개선)</div>
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right"></div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left"></div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">03 .24</span><br>SOK-빅앤트 슈퍼블루 컨셉 및 디자인 개발</div>
                                </div>
                            </div>
                            <div class="timeline_item txt-item l_line">
                                <div class="timeline_left">
                                    <div><span class="date">02 .01</span><br>블루캠페인 TV캠페인 (뉴스Y)</div>
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right"></div>
                            </div>
                            <div class="timeline_item">
                                <div class="timeline_center">
                                    <span class="year">2013</span>
                                </div>
                            </div>
                            <div class="timeline_item txt-item r_line">
                                <div class="timeline_left year2019"><img src="/img/timeline_img04.png" alt="블루캠페인 이미지">
                                </div>
                                <div class="timeline_center">
                                </div>
                                <div class="timeline_right">
                                    <div><span class="date">07 .10</span><br>SOK 비젼포럼에서 지적장애인 용어 바르게 쓰기 블루 캠페인 시작</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>