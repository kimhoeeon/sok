<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" value="banner" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">메인 배너 <c:out value="${empty banner ? '등록' : '수정'}" /></h3>
</div>

<div class="premium-card p-4">
    <form action="/mng/banner/save" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <c:if test="${not empty banner}">
            <input type="hidden" name="seq" value="${banner.seq}">
        </c:if>

        <!-- 페이징 유지용 파라미터 (저장 후 목록 복귀 시 사용) -->
        <input type="hidden" name="pageNum" value="${params.pageNum != null ? params.pageNum : 1}">
        <input type="hidden" name="amount" value="${params.amount != null ? params.amount : 10}">
        <input type="hidden" name="keyword" value="${params.keyword}">

        <div class="row mb-4">
            <div class="col-md-8">
                <label class="form-label fw-bold text-dark">배너 제목 (관리용) <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="title" id="title" value="${banner.title}" placeholder="배너 제목을 입력하세요." maxlength="100" required>
            </div>
            <div class="col-md-4">
                <label class="form-label fw-bold text-dark">상태 (노출 여부) <span class="text-danger">*</span></label>
                <select class="form-select" name="isActive">
                    <option value="Y" ${banner.isActive eq 'Y' ? 'selected' : ''}>활성 (노출)</option>
                    <option value="N" ${banner.isActive eq 'N' ? 'selected' : ''}>비활성 (숨김)</option>
                </select>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-8">
                <label class="form-label fw-bold text-dark">클릭 시 이동할 링크 URL</label>
                <input type="text" class="form-control" name="linkUrl" id="linkUrl" value="${banner.linkUrl}" placeholder="예: https://www.example.com (클릭 없음 선택 시 비활성화됩니다.)">
            </div>
            <div class="col-md-4">
                <label class="form-label fw-bold text-dark">링크 열기 방식</label>
                <select class="form-select" name="targetType" id="targetType" onchange="toggleLinkState()">
                    <option value="_self" ${banner.targetType eq '_self' ? 'selected' : ''}>현재 창에서 열기 (_self)</option>
                    <option value="_blank" ${banner.targetType eq '_blank' ? 'selected' : ''}>새 창에서 열기 (_blank)</option>
                    <option value="none" ${banner.targetType eq 'none' ? 'selected' : ''}>클릭 없음 (단순 이미지)</option>
                </select>
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold text-dark">배너 이미지 <span class="text-danger">*</span></label>
            <input class="form-control mb-2" type="file" id="uploadFile" name="uploadFile" accept="image/*" onchange="previewImage(this);" ${empty banner ? 'required' : ''}>
            <div class="form-text text-muted mb-3">
                <i class="bi bi-info-circle me-1"></i> 권장 해상도: 1920x600 픽셀 / 최대 10MB 이하의 이미지 파일(JPG, PNG 등)만 첨부 가능합니다.
            </div>

            <!-- 이미지 미리보기 영역 -->
            <div class="card bg-light border" style="max-width: 800px;">
                <div class="card-body text-center p-2">
                    <c:choose>
                        <c:when test="${not empty banner.fileName}">
                            <img id="imgPreview" src="/file/img?type=banner&filename=${banner.fileName}" style="max-width: 100%; height: auto; border-radius: 4px;" alt="미리보기">
                        </c:when>
                        <c:otherwise>
                            <img id="imgPreview" src="" style="max-width: 100%; height: auto; border-radius: 4px; display: none;" alt="미리보기">
                            <span id="noImgText" class="text-muted"><i class="bi bi-image me-1"></i> 이미지를 첨부하면 미리보기가 표시됩니다.</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <c:if test="${not empty banner}">
            <div class="row mb-4">
                <div class="col-md-4">
                    <label class="form-label fw-bold text-dark">노출 순서</label>
                    <input type="number" class="form-control" name="displayOrder" value="${banner.displayOrder}">
                    <div class="form-text text-muted">숫자를 변경하여 강제로 순서를 지정할 수 있습니다.</div>
                </div>
            </div>
        </c:if>

        <div class="d-flex justify-content-center mt-5 pt-4 border-top" style="border-color: rgba(0,0,0,0.05) !important;">
            <button type="button" class="btn btn-secondary px-4 fw-bold me-2 shadow-sm" onclick="history.back();">취소</button>
            <button type="submit" class="btn btn-primary px-4 fw-bold shadow-sm">저장</button>
        </div>
    </form>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    // 문서가 준비되면 초기 링크 입력창 상태 세팅
    $(document).ready(function() {
        toggleLinkState();
    });

    // 타겟 타입 변경 시 링크 URL 입력창 활성화/비활성화 제어
    function toggleLinkState() {
        var targetType = $('#targetType').val();
        if (targetType === 'none') {
            $('#linkUrl').val('').prop('disabled', true); // 입력값 지우고 비활성화
        } else {
            $('#linkUrl').prop('disabled', false); // 활성화
        }
    }

    // 이미지 첨부 시 즉시 미리보기 기능
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('#imgPreview').attr('src', e.target.result).show();
                $('#noImgText').hide();
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            $('#imgPreview').hide();
            $('#noImgText').show();
        }
    }

    // 폼 전송 전 유효성 검사
    function validateForm() {
        var title = $('#title').val().trim();
        if (!title) {
            alert('배너 제목을 입력해 주세요.');
            $('#title').focus();
            return false;
        }

        // 비활성화된 input(disabled)은 form 전송 시 값이 넘어가지 않으므로
        // 전송 직전에 disabled 속성을 풀어주어 백엔드에서 null 이나 빈 값으로 처리되게 돕습니다.
        $('#linkUrl').prop('disabled', false);

        return true;
    }
</script>