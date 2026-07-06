<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>위원회</span><span>비스포츠 위원회</span><span>문화예술 위원회</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">문화예술 위원회</div>
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
                    <li><a href="/intro/none_commit_ath">선수건강증진 위원회</a></li>
                    <li class="on"><a href="/intro/none_commit_art">문화예술 위원회</a></li>
                    <li><a href="/intro/none_commit_coo">대외협력 위원회</a></li>
                    <li><a href="/intro/none_commit_vol">자원봉사 위원회</a></li>
                    <li><a href="/intro/none_commit_tor">성화봉송 위원회</a></li>
                    <li><a href="/intro/none_commit_spo">후원 위원회</a></li>
                </ul>
            </div>

            <div class="commit_info">
                <ul class="commit_list">
                    <li>
                        <img src="/img/ico_commit18.png" alt="아이콘">
                        <div>경제발전계획</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit19.png" alt="아이콘">
                        <div>관리 및 운영</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit20.png" alt="아이콘">
                        <div>경기 자문 및 건의</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit21.png" alt="아이콘">
                        <div>국내·외 경기대회 개최</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit22.png" alt="아이콘">
                        <div>선수 및 지도자 선발</div>
                    </li>
                    <li>
                        <img src="/img/ico_commit23.png" alt="아이콘">
                        <div>기타사항</div>
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
                    <div class="sub_top_tit" id="tts_sub_category">종목별분과위원회</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_category">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
                <div class="executive_table hap_table mt-60">
                    <table>
                        <colgroup>
                            <col width="10%">
                            <col width="20%">
                            <col width="20%">
                            <col width="40%">
                            <col width="10%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>연번</th>
                            <th>직책</th>
                            <th>성명</th>
                            <th>소속</th>
                            <th>비고</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>01</td>
                            <td>위원장</td>
                            <td>나경원</td>
                            <td>SOK 명예회장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>02</td>
                            <td>원장</td>
                            <td>김대진</td>
                            <td>한국종합예술학교 총장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>03</td>
                            <td>원장</td>
                            <td>서혜연</td>
                            <td>서울대학교 음악대학 교수</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>04</td>
                            <td>원장</td>
                            <td>곽재선</td>
                            <td>KG그룹/이데일리 회장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>05</td>
                            <td>원장</td>
                            <td>소진세</td>
                            <td>교촌에프앤비㈜ 회장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>06</td>
                            <td>원장</td>
                            <td>강효상</td>
                            <td>한국고용복지연금연구원 이사장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>07</td>
                            <td>원장</td>
                            <td>문홍성</td>
                            <td>㈜두산 사장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>08</td>
                            <td>원장</td>
                            <td>방귀희</td>
                            <td>사단법인 한국장애예술인협회 회장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>09</td>
                            <td>원장</td>
                            <td>신종호</td>
                            <td>전 한국장애인문화예술원 이사장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td>원장</td>
                            <td>이석원</td>
                            <td>전 서울대학교 행정대학원 교수</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td>원장</td>
                            <td>이순종</td>
                            <td>서울대학교 디자인대학 학장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td>원장</td>
                            <td>나경원</td>
                            <td>그린프레임 대표/사진작가</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>13</td>
                            <td>원장</td>
                            <td>신언식</td>
                            <td>한주홀딩스코리아 회장</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>14</td>
                            <td>원장</td>
                            <td>이은정</td>
                            <td>한국맥널티 주식회사 대표이사</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>15</td>
                            <td>원장</td>
                            <td>이티나</td>
                            <td>전 다남 코퍼레이션 상무</td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>