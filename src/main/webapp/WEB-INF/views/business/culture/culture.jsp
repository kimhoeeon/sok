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
                    <span>사업소개</span><span>문화예술</span><span>국제 스페셜 뮤직&아트 페스티벌</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">국제 스페셜 뮤직&아트 페스티벌</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li><a href="/business/sports">스포츠</a></li>
                <li class="on"><a href="/business/culture">문화예술</a></li>
                <li><a href="/business/commu">커뮤니티</a></li>
                <li><a href="/business/awareness">인식개선</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->

        <div class="sub_content">
            <div class="sub_tab">
                <ul class="board_tab colum2">
                    <li class="on"><a href="/business/culture">국제 스페셜 뮤직&아트 페스티벌</a></li>
                    <li><a href="/business/culture-ensemble">SOK 앙상블</a></li>
                    <li><a href="/business/culture-concert">SOK 연말음악회</a></li>
                    <li><a href="/business/culture-dodream">두드림 페스티벌</a></li>
                    <li><a href="/business/culture-support-act">국내외 문화예술 활동 지원</a></li>
                </ul>
            </div>
            <div class="cult_bi">
                <div class="bi">
                    BI <span>(Brand Identity)</span>
                </div>
                <div class="bi_txt">
                    <div class="txt">
                        m (music) n (and) a (art) 이니셜로 표현된 심볼마크는 <br/>
                        <span>나비의 꿈을 품은 애벌레</span>처럼 꿈과 열정을 품은 <br/>
                        모든 참가자들을 응원하는 스페셜올림픽코리아의 마음을 담고 있습니다. <br/><br/>
                        우측 상단의 별표는 <span class="black">발달장애 아티스트들의 특별함(Special)</span>을 상징합니다.
                    </div>
                    <img src="/img/bi.png" alt="bi_logo">
                    <div class="poster_box">
                        <img src="/img/poster.png" alt="포스터">
                        <div class="txt">
                            2013 평창 세계 스페셜올림픽의 유산사업으로 시작한전 세계 유일의 국제 발달장애인 문화축제인 국제 스페셜 뮤직&아트 페스티벌 <br/><br/>세계 각국에서 모인 발달장애인 아티스트들과 비장애인들이 음악과 미술, 스포츠를 즐기며 발달장애인들의 사회적 포용을 지향하는 국제적인 축제입니다.
                        </div>
                    </div>
                </div>

            </div>
            <div class="cult_features">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_cult_features">국제 스페셜 뮤직&아트 페스티벌 특징</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_features">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <ul class="cult_features_list">
                    <li>
                        <img src="/img/culture_guide01.png" alt="특징 아이콘">
                        <div class="tit">특별함</div>
                        <div class="txt">다름을 넘어 화합을 이야기하는 전 세계 유일의 국제 문화 축제</div>
                    </li>
                    <li>
                        <img src="/img/culture_guide02.png" alt="특징 아이콘">
                        <div class="tit">기회</div>
                        <div class="txt">국내외 발달장애 아티스트에게 더욱 다양한 무대 경험을 제공하는 축제의 장</div>
                    </li>
                    <li>
                        <img src="/img/culture_guide03.png" alt="특징 아이콘">
                        <div class="tit">영감</div>
                        <div class="txt">감동적인 공연과, 신나는 활동을 통해 전하는 통합사회 구현의 메세지</div>
                    </li>
                    <li>
                        <img src="/img/culture_guide04.png" alt="특징 아이콘">
                        <div class="tit">통합</div>
                        <div class="txt">장애인과 비장애인이 함께 무대를 만들고 즐기며 실현하는 “Together We Can!”의 가치</div>
                    </li>
                </ul>
            </div>
            <div class="cult_mento">
                <div class="sub_top">
                    <div class="sub_top_box">
                        <!--

                        --소리듣기 재사용--
                        id=tts_2
                        data-taret=tts_2

                        -->
                        <div class="sub_top_tit" id="tts_sub_cult_mento">2025 국제 스페셜 뮤직&아트 페스티벌 멘토단</div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_mento">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="executive_table">
                    <h2>- 클래식</h2>
                    <table>
                        <colgroup>
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>전공</th>
                            <th>성명</th>
                            <th>소속 및 직위</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td rowspan="17">클래식</td>
                            <td>바이올린</td>
                            <td>기주희</td>
                            <td>덕성여자대학교 교수</td>
                        </tr>
                        <tr>
                            <td>바이올린</td>
                            <td>김현아</td>
                            <td>연세대학교 교수</td>
                        </tr>
                        <tr>
                            <td>바이올린</td>
                            <td>한경진</td>
                            <td>경북대학교 교수</td>
                        </tr>
                        <tr>
                            <td>비올라</td>
                            <td>문명환</td>
                            <td>충남대학교 출강</td>
                        </tr>
                        <tr>
                            <td>첼로</td>
                            <td>박상민</td>
                            <td>한국예술종합학교 교수</td>
                        </tr>
                        <tr>
                            <td>첼로</td>
                            <td>이재은</td>
                            <td>백석대학교 교수</td>
                        </tr>
                        <tr>
                            <td>오보에</td>
                            <td>김수지</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>클라리넷</td>
                            <td>송정민</td>
                            <td>코리안챔버오케스트라 수석</td>
                        </tr>
                        <tr>
                            <td>플루트</td>
                            <td>김동수</td>
                            <td>성신여자대학교 교수</td>
                        </tr>
                        <tr>
                            <td>트럼펫</td>
                            <td>강석진</td>
                            <td>원주시립교향악단 수석</td>
                        </tr>
                        <tr>
                            <td>트럼본</td>
                            <td>장현배</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>호른</td>
                            <td>김정기</td>
                            <td>원주시립교향악단 수석단원</td>
                        </tr>
                        <tr>
                            <td>성악</td>
                            <td>백승헌</td>
                            <td>성악가</td>
                        </tr>
                        <tr>
                            <td>피아노</td>
                            <td>박지원</td>
                            <td>상명대학교 교수</td>
                        </tr>
                        <tr>
                            <td>피아노</td>
                            <td>김헌재</td>
                            <td>한국예술종합학교 예술영재교육원 출강</td>
                        </tr>
                        <tr>
                            <td>마림바</td>
                            <td>장애령</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>지휘</td>
                            <td>김지환</td>
                            <td>백석대학교 교수</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="executive_table">
                    <h2>- 팝</h2>
                    <table>
                        <colgroup>
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>전공</th>
                            <th>성명</th>
                            <th>소속 및 직위</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td rowspan="7">클래식</td>
                            <td>베이스</td>
                            <td>황호규</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>기타</td>
                            <td>정수욱</td>
                            <td>기타리스트</td>
                        </tr>
                        <tr>
                            <td>건반</td>
                            <td>조윤성</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>색소폰</td>
                            <td>손성제</td>
                            <td>호원대학교 교수</td>
                        </tr>
                        <tr>
                            <td>드럼</td>
                            <td>신동진</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>드럼</td>
                            <td>한웅원</td>
                            <td>전문연주가</td>
                        </tr>
                        <tr>
                            <td>보컬</td>
                            <td>김숙영</td>
                            <td>성신여자대학교 교수</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="executive_table">
                    <h2>- 아트</h2>
                    <table>
                        <colgroup>
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                            <col width="25%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>전공</th>
                            <th>성명</th>
                            <th>소속 및 직위</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>미술</td>
                            <td>미술</td>
                            <td>손인종</td>
                            <td>하얀사자 미술학원 대표</td>
                        </tr>
                        <tr>
                            <td>사진</td>
                            <td>사진</td>
                            <td>조세현</td>
                            <td>사진작가</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="video mt-60">
                    <div class="embed-container">
                        <iframe src='https://www.youtube.com/embed/zBA34QmcVik?mute=1&controls=0&loop=1&playlist=zBA34QmcVik' frameborder='0' allowfullscreen></iframe>
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
                        <div class="flex">
                            <div class="sub_top_tit" id="tts_sub_cult_mento">국제 스페셜 뮤직&아트 페스티벌 사진</div>
                            <a class="go_link" href="https://www.dropbox.com/scl/fo/bskx01g4vmlppkkyqk87t/AJy5qtrx7LqfzXea51PyuOk?rlkey=h2o0p8o3nbvxl0sojwhb72059&e=2&dl=0" target="_blank">더 보기</a>
                        </div>
                        <div class="sound_btn">
                            <button type="button" class="play" data-target="tts_sub_cult_mento">
                                소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                            </button>
                        </div>
                    </div>
                </div>
                <div class="img_view">
                    <ul class="img_item">
                        <li>
                            <img src="/img/contest_img.png" alt="스포츠 이미지">
                        </li>
                        <li>
                            <img src="/img/contest_img.png" alt="스포츠 이미지">
                        </li>
                        <li>
                            <img src="/img/contest_img.png" alt="스포츠 이미지">
                        </li>
                        <li>
                            <img src="/img/contest_img.png" alt="스포츠 이미지">
                        </li>
                        <li>
                            <img src="/img/contest_img.png" alt="스포츠 이미지">
                        </li>
                        <li>
                            <img src="/img/contest_img.png" alt="스포츠 이미지">
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