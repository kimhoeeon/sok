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
                <li><a href="/intro/dis_commit_tkw">종목별위원회</a></li>
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
                <div class="name">
                    <div class="gu">위원장</div>
                    <div class="nae">나경원</div>
                </div>
                <div class="txt">
                    문화예술위원회는 발달장애 예술인의 활동을 지원하고 스페셜올림픽코리아 문화예술 사업의 활성화를 도모하는 위원회입니다. <br/>
                    SOK 주관 행사의 문화예술 공연과 국제 스페셜 뮤직&아트 페스티벌 개최, 국외 공연 파견에 관한 사항을 심의합니다. <br/>
                    외부 출연자·예술단체와 협력하고 분야별 분과위원회를 운영하여 전문적인 문화예술 사업의 기반을 마련합니다. <br/>
                    국제 스페셜 뮤직&아트 페스티벌, 연말음악회 등 주요 프로그램의 운영 방향과 세부 계획을 논의합니다. <br/>
                    다양한 공연과 교류 기회를 확대하여 발달장애 예술인의 역량을 높이고 문화예술을 통한 사회적 통합을 확산합니다.
                </div>
            </div>
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>