<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK</span><span>인사말</span>
                </div>
                <!--

                --소리듣기 재사용--
                id=tts_2
                data-taret=tts_2

                -->
                <div class="sub_top_tit" id="tts_sub_top">발달장애인이 주인이 되는 <br/>스페셜올림픽코리아로 만들겠습니다.</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content greeting">
            <div class="greeting_wrap">
                <div class="txt">
                    스페셜올림픽코리아 가족 여러분! <br/>반갑습니다. <br/><br/>
                    스페셜올림픽코리아는 우리나라 발달장애인들의 건강증진과 스포츠 및 문화·예술 사업을 펼쳐오고 있습니다. <br/><br/>
                    우리는 2013년 평창 스페셜올림픽 세계동계대회 이후 발달장애인들에 대해 더 많은 관심을 가지게 되었고, 목소리에 더욱 귀를 기울이게 되었습니다. <br/>
                    더불어 앞서 스페셜올림픽코리아를 이끌어주신 네 분의 회장님께서 많은 노력과 헌신을 기울여 주신 덕분에 규모와 사업의 다양성 등 지속적인 발전을 이루어 왔습니다. <br/><br/>
                    지난해 열린 VIRTUS GLOBAL GAMES, 세계하계대회를 통해서도 대한민국 발달장애인 스포츠의 무한한 성장 가능성과 앞으로 나아가야 할 지향점을 생각해 볼 수 있는 시간을
                    가졌습니다. <br/><br/>
                    매년 성황리에 개최되고 있는 국제 스페셜 뮤직 앤 아트 페스티벌을 통해 전 세계에서 모인 발달장애인들의 예술적인 능력이 얼마나 탁월한지 깨달을 수 있습니다. <br/><br/>
                    저는 회장에 당선된 이후 첫인사를 드리면서 발달장애인이 주인이 되는 스페셜올림픽코리아로 만들겠다고 말씀드린 바 있습니다. <br/>국민체육진흥법 개정, 정부 보조금 증액, 시도지부
                    행정 및 재정 운영의 독립성 강화 등 <br/>
                    발달장애인들에게 실질적인 혜택이 이루어질 수 있도록 힘쓰겠습니다. <br/><br/>감사합니다. 사랑합니다.
                </div>
                <div class="profile_img">
                    <img src="/img/greet_profile_img.png" alt="프로필 이미지">
                    <div>제 5대 회장 <span>정양석</span></div>
                </div>
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
                    <div class="sub_top_tit" id="tts_sub_organization">사무국 조직도</div>
                    <div class="sound_btn">
                        <button type="button" class="play" data-target="tts_sub_organization">
                            소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                        </button>
                    </div>
                </div>
            </div>
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
                        <td rowspan="5">이사</td>
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
                    </tbody>
                </table>
            </div>
        </div>
        <!-- //section -->
    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>