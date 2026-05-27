<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top depth_2">
            <div class="sub_top_box">
                <div class="sub_top_nav">
                    <span>SOK 소개</span><span>운영자료</span>
                </div>
                <!--

                --소리듣기 재사용--
                id=tts_2
                data-taret=tts_2

                -->
                <div class="sub_top_tit" id="tts_sub_top">경영공시</div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
            </div>
            <ul class="sub_top_tab">
                <li class="on"><a href="/management/list">경영공시</a></li>
                <li><a href="/intro/rules">관련규정</a></li>
                <li><a href="/intro/ci">CI</a></li>
            </ul>
        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content board_wrap">
            <div class="board_top">
                <div class="total">총 <span>1266</span>건</div>
                <div class="search_box">
                    <form class="search_box">
                        <div class="select">
                            <select>
                                <option value="">전체</option>
                                <option value="">글제목</option>
                                <option value="">내용</option>
                                <option value="">글제목+내용</option>
                            </select>
                        </div>
                        <div class="input">
                            <input type="text" id="" name="" value="" placeholder="검색어를 입력하세요.">
                            <a href="" class="search_btn"></a>
                        </div>
                        <input type="hidden" name="page" value="1">
                    </form>
                </div>
            </div>

            <div class="board_list">
                <ul>
                    <!-- 중요 체크시, import 추가 -->
                    <li class="import">
                        <!-- 파일 추가시, file 추가 -->
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                    <li>
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                    <li>
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                    <li class="import">
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과 리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                    <li class="import">
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                    <li class="import">
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                    <li class="import">
                        <div class="tit file">2025 스페셜올림픽코리아 전국동계대회(설상) 경기 결과</div>
                        <div class="date">2026-03-09</div>
                    </li>
                </ul>
            </div>

            <!-- paging -->
            <div class="paging">
                <a href="" class="first"><img src="/img/btn_first.gif"></a>
                <a href="" class="prev"><img src="/img/btn_prev.gif"></a>
                <ol>
                    <li><a href="" class="this">1</a></li>
                    <li><a href="" class="other">2</a></li>
                    <li><a href="" class="other">3</a></li>
                    <li><a href="" class="other">4</a></li>
                    <li><a href="" class="other">5</a></li>
                </ol>
                <a href="" class="next"><img src="/img/btn_next.gif"></a>
                <a href="" class="last"><img src="/img/btn_last.gif"></a>
            </div>
            <!-- //paging -->
        </div>
        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>