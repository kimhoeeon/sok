<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="container text-center" style="padding: 150px 0;">
    <h1 style="font-size: 80px; font-weight: 900; color: #005baa; margin-bottom: 20px;">404</h1>
    <h3 style="font-size: 24px; font-weight: bold; margin-bottom: 15px;">페이지를 찾을 수 없습니다.</h3>
    <p style="color: #666; margin-bottom: 40px;">
        요청하신 페이지가 사라졌거나, 잘못된 경로로 접근하셨습니다.<br>
        입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.
    </p>
    <a href="/" class="btn"
       style="background-color: #005baa; color: #fff; padding: 12px 30px; border-radius: 5px; text-decoration: none; font-weight: bold;">메인으로
        돌아가기</a>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>