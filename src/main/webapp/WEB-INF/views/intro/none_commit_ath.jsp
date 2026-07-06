<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>선수건강증진 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">선수건강증진 위원회</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/intro/commit_dev">스포츠 위원회</a></li>
                <li class="on"><a href="/intro/none_commit_fam">비스포츠 위원회</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li><a href="/intro/none_commit_fam">가족 위원회</a></li>
                    <li class="on"><a href="/intro/none_commit_ath">선수건강증진 위원회</a></li>
                    <li><a href="/intro/none_commit_art">문화예술 위원회</a></li>
                    <li><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <ul class="commit_list">
                    <li>
                        <img src="/img/ico_commit12.png" alt="아이콘">
                        <div>선수건강증진프로그램 운영</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit13.png" alt="아이콘">
                        <div>전문의료인 양성</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit14.png" alt="아이콘">
                        <div>건강관리</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit15.png" alt="아이콘">
                        <div>해결 방안 모색</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit16.png" alt="아이콘">
                        <div>발전계획 및 추진</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit17.png" alt="아이콘">
                        <div>위원회 운영</div>
                    </li>
                </ul>
            </div>

            <div class="sub_top">
                <div class="sub_top_box">
                    <!--

                    --소리듣기 재사용--
                    id=tts_2
                    data-taret=tts_2

                    -->
                    <div class="sub_top_tit" id="tts_sub_healthy">선수건강증진프로그램(Healthy Athletes)이란?</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_healthy">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
                <div class="commit_info mt-60">
                    <div class="txt">
                        발달장애를 가진 스페셜올림픽 선수들에게 맞춤형 건강검진을 통해 신체적응력 및 경기능력을 향상시키는 프로그램입니다. 발달장애인들은 본인의 질병을 적절한 시기에 인지하지 못해 제대로 된 의료지원을 받지 못하는 경우가 많은데, 이러한 상황들은 질병을 악화시키거나 합병증을 동반하기도 합니다. 이처럼 의료 사각지대에 놓여있는 발달장애인들에게 수준 높은 의료서비스를 제공해서 발달장애인들의 삶의 질을 향상시키고자 스페셜올림픽 대회에서 선수건강증진프로그램을 함께 진행합니다.
                    </div>
                </div>
            </div>

            <div class="sub_top">
                <div class="sub_top_box">
                    <!--

                    --소리듣기 재사용--
                    id=tts_2
                    data-taret=tts_2

                    -->
                    <div class="sub_top_tit" id="tts_sub_hap">현 HAP 위원 명단 및 소속 리스트</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_hap">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
                <div class="executive_table hap_table mt-60">
                    <table>
                        <colgroup>
                            <col width="10%">
                            <col width="20%">
                            <col width="15%">
                            <col width="15%">
                            <col width="40%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>연번</th>
                            <th>구분</th>
                            <th>성명</th>
                            <th>직책</th>
                            <th>소속</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>01</td>
                            <td rowspan="3">Fit Feet</td>
                            <td>우봉식</td>
                            <td>위원장</td>
                            <td>대한회복기재활학회/이사장</td>
                        </tr>
                        <tr>
                            <td>02</td>
                            <td>김원빈</td>
                            <td>위원</td>
                            <td>서울대학교병원/전임의</td>
                        </tr>
                        <tr>
                            <td>03</td>
                            <td>이정은</td>
                            <td>위원</td>
                            <td>서송병원/전문의</td>
                        </tr>
                        <tr>
                            <td>04</td>
                            <td rowspan="5">FUNfitness</td>
                            <td>최원호</td>
                            <td>부위원장</td>
                            <td>가천대학교 물리치료학과/교수</td>
                        </tr>
                        <tr>
                            <td>05</td>
                            <td>조성래</td>
                            <td>부위원장</td>
                            <td>세브란스병원/교수</td>
                        </tr>
                        <tr>
                            <td>06</td>
                            <td>이창렬</td>
                            <td>위원</td>
                            <td>나사렛대학교 물리치료학과/학과장</td>
                        </tr>
                        <tr>
                            <td>07</td>
                            <td>안종찬</td>
                            <td>위원</td>
                            <td>가천대학교 물리치료학과/교수</td>
                        </tr>
                        <tr>
                            <td>08</td>
                            <td>이하늘</td>
                            <td>위원</td>
                            <td>가천대학교 물리치료학과/교수</td>
                        </tr>
                        <tr>
                            <td>09</td>
                            <td rowspan="4">Special Smile</td>
                            <td>김성조</td>
                            <td>위원</td>
                            <td>김성조치과/병원장</td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td>유경자</td>
                            <td>위원</td>
                            <td>대전보건대학교 치위생과/교수</td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td>김영재</td>
                            <td>위원</td>
                            <td>서울대학교 치의학대학원/교수</td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td>한상학</td>
                            <td>위원</td>
                            <td>대한치과의원/원장</td>
                        </tr>
                        <tr>
                            <td>13</td>
                            <td>Healthy Hearing</td>
                            <td>한우재</td>
                            <td>위원</td>
                            <td>한림대학교 청각학전공/교수</td>
                        </tr>
                        <tr>
                            <td rowspan="2">14</td>
                            <td>Health Promotion</td>
                            <td rowspan="2">김현주</td>
                            <td rowspan="2">위원</td>
                            <td rowspan="2">대전보건대학교 식품영양학과/교수</td>
                        </tr>
                        <tr>
                            <td class="border">Strong Minds</td>
                        </tr>
                        <tr>
                            <td>15</td>
                            <td>Opening Eyes</td>
                            <td>홍기룡</td>
                            <td>위원</td>
                            <td>한빛안과의원</td>
                        </tr>
                        <tr>
                            <td>16</td>
                            <td>대외협력위원</td>
                            <td>김수철</td>
                            <td>위원</td>
                            <td>대한의사협회/대외협력이사</td>
                        </tr>
                        <tr>
                            <td>17</td>
                            <td>-</td>
                            <td>박경원</td>
                            <td>위원</td>
                            <td>젬마의원</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="sub_content p-0">
            <div class="sub_top">
                <div class="sub_top_box">
                    <!--

                    --소리듣기 재사용--
                    id=tts_2
                    data-taret=tts_2

                    -->
                    <div class="sub_top_tit" id="tts_sub_int_health">선수건강증진프로그램 사진</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_int_health">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="sports_view">
                <ul class="img_item">
                    <li>
                        <img src="/img/commit_health01.png" alt="선수건강증진프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/commit_health02.png" alt="선수건강증진프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/commit_health03.png" alt="선수건강증진프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/commit_health04.png" alt="선수건강증진프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/commit_health05.png" alt="선수건강증진프로그램 이미지">
                    </li>
                    <li>
                        <img src="/img/commit_health06.png" alt="선수건강증진프로그램 이미지">
                    </li>
                </ul>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>