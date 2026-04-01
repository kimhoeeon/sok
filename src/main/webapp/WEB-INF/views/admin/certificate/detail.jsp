<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="currentMenu" value="certificate" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">증명서 신청 처리</h3>
    <a href="/admin/certificate/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row g-4">
    <div class="col-xl-7">
        <div class="premium-dark-card p-4 h-100">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-3">
                <h5 class="fw-bold text-white m-0"><i class="bi bi-file-earmark-text me-2 text-info"></i> 신청서 원본 내용</h5>
                <span class="badge bg-secondary fs-6 px-3 py-2">${certificate.certType} 증명서</span>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <label class="text-muted d-block mb-1" style="font-size: 12px;">신청자 성명</label>
                    <div class="text-white fw-bold fs-5">${certificate.applyNm}</div>
                </div>
                <div class="col-md-6">
                    <label class="text-muted d-block mb-1" style="font-size: 12px;">소속 기관/팀</label>
                    <div class="text-white fw-bold fs-5">${certificate.belongTo}</div>
                </div>
                <div class="col-md-6">
                    <label class="text-muted d-block mb-1" style="font-size: 12px;">휴대전화</label>
                    <div class="text-white">${certificate.phone}</div>
                </div>
                <div class="col-md-6">
                    <label class="text-muted d-block mb-1" style="font-size: 12px;">이메일 (증명서 수신용)</label>
                    <div class="text-info">${certificate.email}</div>
                </div>

                <div class="col-12 mt-4">
                    <label class="text-muted d-block mb-2" style="font-size: 12px;">발급 용도 (사용처)</label>
                    <div class="p-3 rounded text-white" style="background: rgba(255,255,255,0.05); border: 1px solid #474761;">
                        ${certificate.usePurpose}
                    </div>
                </div>

                <div class="col-12 mt-3">
                    <label class="text-muted d-block mb-2" style="font-size: 12px;">사용자 남긴 말 / 비고</label>
                    <div class="p-3 rounded text-white" style="background: rgba(255,255,255,0.02); border: 1px dashed #474761; min-height: 80px;">
                        ${not empty certificate.remark ? certificate.remark : '<span class="text-muted">내용 없음</span>'}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xl-5">
        <div class="premium-dark-card p-4 h-100 glassmorphism-box border-0">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-gear-fill me-2 text-warning"></i> 발급 상태 처리</h5>

            <div class="mb-4 p-3 rounded" style="background-color: #151521; border: 1px solid #474761;">
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted" style="font-size: 12px;">신청 일시</span>
                    <span class="text-white"><fmt:formatDate value="${certificate.regDt}" pattern="yyyy-MM-dd HH:mm" /></span>
                </div>
                <div class="d-flex justify-content-between">
                    <span class="text-muted" style="font-size: 12px;">발급(완료) 일시</span>
                    <span class="${not empty certificate.issueDt ? 'text-success fw-bold' : 'text-muted'}">
                        ${not empty certificate.issueDt ? '<fmt:formatDate value="' += certificate.issueDt += '" pattern="yyyy-MM-dd HH:mm" />' : '진행중 / 미발급'}
                    </span>
                </div>
            </div>

            <form action="/admin/certificate/updateStatus" method="post" id="certForm">
                <input type="hidden" name="certSeq" value="${certificate.certSeq}">

                <div class="mb-4">
                    <label class="form-label text-white">현재 진행 상태 변경</label>
                    <select name="issueStatus" id="issueStatus" class="form-select dark-search-bar" style="height: 50px; font-size: 16px;">
                        <option value="WAIT" ${certificate.issueStatus eq 'WAIT' ? 'selected' : ''}>🟡 접수 확인 대기중</option>
                        <option value="ING" ${certificate.issueStatus eq 'ING' ? 'selected' : ''}>🔵 서류 검토 및 발급중</option>
                        <option value="DONE" ${certificate.issueStatus eq 'DONE' ? 'selected' : ''}>🟢 발급 완료 (이메일 발송 완료 등)</option>
                        <option value="REJECT" ${certificate.issueStatus eq 'REJECT' ? 'selected' : ''}>🔴 거절 / 반려 (조건 미달)</option>
                    </select>
                </div>

                <div id="rejectReasonDiv" style="display: none;" class="mb-4 p-3 rounded border border-danger" style="background: rgba(230, 25, 56, 0.05);">
                    <label class="form-label text-danger fw-bold"><i class="bi bi-exclamation-circle me-1"></i> 발급 거절(반려) 사유 입력</label>
                    <textarea name="rejectRsn" id="rejectRsn" class="form-control dark-search-bar mt-2" rows="3" placeholder="사용자에게 안내될 거절 사유를 명확히 작성해주세요. (필수 입력)">${certificate.rejectRsn}</textarea>
                </div>

                <div class="text-end mt-4">
                    <button type="submit" class="btn btn-neon w-100 py-3 fs-5">상태 업데이트 적용</button>
                </div>
            </form>

            <hr class="border-secondary my-4">

            <div class="text-end">
                <form action="/admin/certificate/delete" method="post" onsubmit="return confirm('이 신청 건을 목록에서 완전히 삭제하시겠습니까?');">
                    <input type="hidden" name="certSeq" value="${certificate.certSeq}">
                    <button type="submit" class="btn btn-link text-danger p-0" style="text-decoration: none; font-size: 13px;">
                        <i class="bi bi-trash3"></i> 불량/테스트 데이터 삭제
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        toggleRejectDiv(); // 최초 로드 시 체크

        $('#issueStatus').change(function() {
            toggleRejectDiv();
        });

        function toggleRejectDiv() {
            var status = $('#issueStatus').val();
            if (status === 'REJECT') {
                $('#rejectReasonDiv').slideDown();
                $('#rejectRsn').prop('required', true);
            } else {
                $('#rejectReasonDiv').slideUp();
                $('#rejectRsn').prop('required', false);
            }
        }
    });
</script>

<%@ include file="../layout/footer.jsp" %>