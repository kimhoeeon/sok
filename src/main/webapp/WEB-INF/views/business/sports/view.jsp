<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<!-- container -->
<div id="container">
    <div class="inner">

        <!-- section -->
        <div class="sub_top">
            <div class="sub_top_box">
                <div class="sub_top_badge">
                    <span>SO</span><span>US</span>
                </div>

                <div class="sub_top_tit" id="tts_sub_top">
                    ${not empty board.title ? board.title : '플로어하키'}
                </div>
                <div class="sound_btn">
                    <button type="button" class="play" data-target="tts_sub_top">
                        소리듣기 <img src="/img/ico_sound.png" alt="소리 듣기">
                    </button>
                </div>
                <div class="sport_info">
                    <div class="txt">
                        ${not empty board.content ? board.content : '-'}
                    </div>
                    <c:if test="${not empty board.fileList}">
                        <div class="down">
                            <a href="/mng/file/download?filePath=${board.fileList[0].filePath}&fileName=${board.fileList[0].orgFileNm}">
                                경기규정 다운로드
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

        </div>
        <!-- //section -->

        <!-- section -->
        <div class="sub_content">
            <div class="sports_wrap">
                <div class="sports_view">
                    <div class="tit">Photo</div>

                    <ul class="img_item">
                        <c:choose>
                            <c:when test="${not empty board.fileList}">
                                <c:forEach var="file" items="${board.fileList}">
                                    <c:if test="${file.fileExt == '.png' or file.fileExt == '.jpg' or file.fileExt == '.jpeg'}">
                                        <li>
                                            <img src="${file.filePath}" alt="${file.orgFileNm}">
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li><img src="/img/sport_img.png" alt="스포츠 이미지"></li>
                                <li><img src="/img/sport_img.png" alt="스포츠 이미지"></li>
                                <li><img src="/img/sport_img.png" alt="스포츠 이미지"></li>
                                <li><img src="/img/sport_img.png" alt="스포츠 이미지"></li>
                                <li><img src="/img/sport_img.png" alt="스포츠 이미지"></li>
                                <li><img src="/img/sport_img.png" alt="스포츠 이미지"></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>

                    <div class="btn">
                        <button type="button" onclick="location.href='/business/sports'">목록으로</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- //section -->

    </div>
</div>
<!-- //container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>