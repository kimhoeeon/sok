<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentMenu" type="java.lang.String"--%>

<!-- 시스템/대시보드 설정이므로 사이드바의 '방문 통계 대시보드' 활성화를 유지합니다. -->
<c:set var="currentMenu" value="main" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">인스타그램 토큰 관리</h3>
</div>

<div class="premium-card p-4 shadow-sm border-0">
    <form id="tokenForm">
        <div class="mb-4">
            <label for="token" class="form-label fw-bold text-dark">
                인스타그램 액세스 토큰 (Access Token) <span class="text-danger">*</span>
            </label>
            <textarea class="form-control" id="token" name="token" rows="6" placeholder="발급받은 인스타그램 토큰값을 입력하세요."
                      style="font-family: monospace;">${tokenInfo.token}</textarea>
            <div class="form-text text-muted mt-2">
                <i class="bi bi-info-circle me-1"></i> 토큰 값이 올바르지 않거나 만료될 경우, 프론트 메인 페이지에 인스타그램 피드가 정상적으로 노출되지 않습니다.
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6">
                <label class="form-label fw-bold text-dark">최초 등록 일시</label>
                <input type="text" class="form-control bg-light"
                       value="<fmt:formatDate value='${tokenInfo.initRegiDttm}' pattern='yyyy-MM-dd HH:mm:ss' />"
                       readonly>
            </div>
            <div class="col-md-6">
                <label class="form-label fw-bold text-dark">최종 수정 일시</label>
                <input type="text" class="form-control bg-light"
                       value="<fmt:formatDate value='${tokenInfo.finalRegiDttm}' pattern='yyyy-MM-dd HH:mm:ss' />"
                       readonly>
            </div>
        </div>

        <div class="d-flex justify-content-center mt-5 pt-4 border-top" style="border-color: rgba(0,0,0,0.05) !important;">
            <button type="button" class="btn btn-secondary px-4 fw-bold me-2 shadow-sm" onclick="location.href='/mng/main'">취소</button>
            <button type="button" class="btn btn-primary px-4 fw-bold shadow-sm" onclick="saveToken()">저장</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    function saveToken() {
        var tokenVal = $.trim($('#token').val());

        if (!tokenVal) {
            alert('인스타그램 토큰 값을 입력해 주세요.');
            $('#token').focus();
            return;
        }

        if (confirm('토큰 정보를 수정하시겠습니까?')) {
            $.ajax({
                url: '/mng/insta/saveToken',
                type: "POST",
                data: {token: tokenVal},
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
                },
                success: function (res) {
                    if (res.result === 'success') {
                        alert('정상적으로 저장되었습니다.');
                        location.reload(); // 저장 후 날짜 업데이트를 위해 새로고침
                    } else {
                        alert(res.message || '저장에 실패했습니다.');
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", error);
                    alert('서버 오류가 발생했습니다. 관리자에게 문의하세요.');
                }
            });
        }
    }
</script>