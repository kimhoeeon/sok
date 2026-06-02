<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>조직구성</span>
                </div>
                <!--

                --소리듣기 재사용--
                id=tts_2
                data-taret=tts_2

                -->
                <div class="sub_top_tit" id="tts_sub_top">조직구성</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="organization_img">
                <img src="/img/organization.png" alt="조직도">
            </div>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sub_top">
                <div class="sub_top_box">
                    <!--

                    --소리듣기 재사용--
                    id=tts_2
                    data-taret=tts_2

                    -->
                    <div class="sub_top_tit" id="tts_sub_executive">임원 현황</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_executive">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
            <div class="executive_table">
                <table>
                    <colgroup>
                        <col width="33%">
                        <col width="33%">
                        <col width="33%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>구분</th>
                        <th>성명</th>
                        <th>비고</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>회장</td>
                        <td>정양석</td>
                        <td>제20대, 제8대 국회의원</td>
                    </tr>
                    <tr>
                        <td>수석부회장</td>
                        <td>박성근</td>
                        <td>법무법인 바른 변호사</td>
                    </tr>
                    <tr>
                        <td rowspan="10">이사</td>
                        <td>김용직</td>
                        <td>(사)한국자폐인사랑협회 회장</td>
                    </tr>
                    <tr>
                        <td>서창우</td>
                        <td>서울SOK 고문, 한국파파존스(주) 회장</td>
                    </tr>
                    <tr>
                        <td>곽재선</td>
                        <td>KG그룹 회장</td>
                    </tr>
                    <tr>
                        <td>김대진</td>
                        <td>한국예술종합학교 총장</td>
                    </tr>
                    <tr>
                        <td>박노준</td>
                        <td>우석대학교 총장</td>
                    </tr>
                    <tr>
                        <td>양문술</td>
                        <td>세림병원 원장</td>
                    </tr>
                    <tr>
                        <td>박순관</td>
                        <td>법무법인 바른 변호사</td>
                    </tr>
                    <tr>
                        <td>차정훈</td>
                        <td>한국체육대학교 교수</td>
                    </tr>
                    <tr>
                        <td>김영훈</td>
                        <td>부경대학교 교수</td>
                    </tr>
                    <tr>
                        <td>송재형</td>
                        <td>전 서울시의회 의원</td>
                    </tr>
                    <tr>
                        <td rowspan="5">당연직이사</td>
                        <td>홍덕호</td>
                        <td>문체부 장애인체육과 과장</td>
                    </tr>
                    <tr>
                        <td>박민서</td>
                        <td>인천SOK 회장</td>
                    </tr>
                    <tr>
                        <td>오응환</td>
                        <td>경기SOK 회장</td>
                    </tr>
                    <tr>
                        <td>유승주</td>
                        <td>SOK 선수위원장</td>
                    </tr>
                    <tr>
                        <td>김수호</td>
                        <td>SOK 메신저</td>
                    </tr>
                    <tr>
                        <td rowspan="1">감사</td>
                        <td>김광일</td>
                        <td>MBK파트너스 대표</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>