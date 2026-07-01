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
                    <span>사업소개</span><span>문화예술</span><span>SOK 앙상블</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">SOK 앙상블</div>
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
                    <li><a href="/business/culture">국제 스페셜 뮤직&아트 페스티벌</a></li>
                    <li class="on"><a href="/business/culture-ensemble">SOK 앙상블</a></li>
                    <li><a href="/business/culture-concert">SOK 연말음악회</a></li>
                    <li><a href="/business/culture-dodream">두드림 페스티벌</a></li>
                    <li><a href="/business/culture-support-act">국내외 문화예술 활동 지원</a></li>
                </ul>
            </div>
            <div class="art_info">
                <div class="txt">
                    국제 스페셜 뮤직&아트 페스티벌을 통해 성장한 발달장애 아티스트들이 음악으로 만들어가는 특별한 하모니
                </div>
                <div class="ensemble_top">
                    <ul>
                        <li>
                            <div class="txt">현악 앙상블</div>
                            <div>
                                <img src="/img/ensemble_top_img01.png" alt="앙상블 인물 이미지">
                            </div>
                        </li>
                        <li>
                            <div class="txt">클라리넷 앙상블</div>
                            <div>
                                <img src="/img/ensemble_top_img02.png" alt="앙상블 인물 이미지">
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="ensemble_list">
                    <ul class="col_4">
                        <li>
                            <div class="txt">운영감독</div>
                            <div>
                                <img src="/img/ensemble_list01.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>성악</span> 서혜연</div>
                                <p>서울대학교 음악대학 교수</p>
                            </div>
                        </li>
                        <li>
                            <div class="txt">멘토</div>
                            <div>
                                <img src="/img/ensemble_list02.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>바이올린</span> 기주희</div>
                                <p>덕성여자 대학교 교수</p>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list03.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>첼로</span> 이재은</div>
                                <p>덕성여자 대학교 교수</p>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list04.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 송정민</div>
                                <p>코리안챔버오케스트라 수석</p>
                            </div>
                        </li>
                    </ul>
                    <ul class="col_5">
                        <li>
                            <div class="txt">현악 앙상블 단원</div>
                            <div>
                                <img src="/img/ensemble_list05.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>바이올린</span> 공민배</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list06.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>바이올린</span> 권현태</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list07.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>바이올린</span> 이예림</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list08.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>바이올린</span> 조윤성</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list09.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>비올라</span> 김윤세</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list10.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>비올라</span> 김태훈</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list11.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>비올라</span> 이지웅</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list12.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>첼로</span> 손정환</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list13.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>첼로</span> 조한범</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list14.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>첼로</span> 차지우</div>
                            </div>
                        </li>
                    </ul>
                    <ul class="col_5">
                        <li>
                            <div class="txt">클라리넷 앙상블 단원</div>
                            <div>
                                <img src="/img/ensemble_list15.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 권오빈</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list16.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 김경주</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list17.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 김범순</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list18.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 김유경</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list19.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 김인영</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list20.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 민경호</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list21.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>클라리넷</span> 유승엽</div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <img src="/img/ensemble_list22.png" alt="앙상블 인물 이미지">
                            </div>
                            <div class="name">
                                <div><span>첼로</span> 최지원</div>
                            </div>
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