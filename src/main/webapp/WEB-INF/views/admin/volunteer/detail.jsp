<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="currentMenu" value="volunteer" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">자원봉사 신청 상세정보</h3>
    <a href="/admin/volunteer/list?pageNum=${params.pageNum}&amount=${params.amount}&searchSupportArea=${params.searchSupportArea}&searchKeyword=${params.searchKeyword}" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row g-4">
    <div class="col-xl-5">
        <div class="premium-dark-card p-4 mb-4" style="background: linear-gradient(145deg, rgba(30,30,45,0.9) 0%, rgba(21,21,33,0.95) 100%);">
            <span class="badge ${volunteer.supportArea eq '스포츠' ? 'bg-primary' : (volunteer.supportArea eq '문화예술' ? 'bg-info text-dark' : 'bg-secondary')} mb-2 px-3 py-2">
                ${volunteer.supportArea} 지원
            </span>
            <h4 class="text-white fw-bold mb-3">${volunteer.eventNm}</h4>

            <div class="d-flex align-items-center mt-4">
                <i class="bi bi-shield-check fs-2 ${volunteer.agreeYn eq 'Y' ? 'text-success' : 'text-danger'} me-3"></i>
                <div>
                    <span class="d-block text-muted" style="font-size: 13px;">개인정보 수집 및 이용 동의</span>
                    <span class="fw-bold ${volunteer.agreeYn eq 'Y' ? 'text-white' : 'text-danger'}">
                        ${volunteer.agreeYn eq 'Y' ? '동의 완료' : '미동의 (확인 필요)'}
                    </span>
                </div>
            </div>
        </div>

        <div class="premium-dark-card p-4 h-50 glassmorphism-box border-0">
            <h6 class="text-white fw-bold border-bottom border-secondary pb-2 mb-4"><i class="bi bi-clock-history me-2"></i>접수 타임라인</h6>
            <div class="position-relative ms-2 ps-3" style="border-left: 2px solid #474761;">
                <div class="mb-4 position-relative">
                    <i class="bi bi-circle-fill position-absolute text-success" style="left: -21px; top: 3px; font-size: 10px; text-shadow: 0 0 5px #39ff14;"></i>
                    <span class="d-block text-muted" style="font-size: 12px;">홈페이지 자원봉사 신청 접수</span>
                    <span class="text-white fw-bold"><fmt:formatDate value="${volunteer.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                </div>
                <div class="position-relative">
                    <i class="bi bi-circle-fill position-absolute text-warning" style="left: -21px; top: 3px; font-size: 10px;"></i>
                    <span class="d-block text-warning" style="font-size: 12px;">현재 관리자 확인 및 배정 대기중</span>
                </div>
            </div>

            <div class="mt-5 text-end border-top border-secondary pt-3">
                <form action="/admin/volunteer/delete" method="post" onsubmit="return confirm('해당 자원봉사 신청 내역을 삭제(취소)하시겠습니까?');">
                    <input type="hidden" name="volSeq" value="${volunteer.volSeq}">
                    <input type="hidden" name="pageNum" value="${params.pageNum}">
                    <input type="hidden" name="amount" value="${params.amount}">
                    <input type="hidden" name="searchSupportArea" value="${params.searchSupportArea}">
                    <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">
                    <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash3 me-1"></i> 신청 내역 삭제</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-xl-7">
        <div class="premium-dark-card p-4 h-100">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-person-badge me-2 text-info"></i> 신청자 상세 정보 (수정 가능)</h5>

            <form action="/admin/volunteer/update" method="post">
                <input type="hidden" name="volSeq" value="${volunteer.volSeq}">
                <input type="hidden" name="pageNum" value="${params.pageNum}">
                <input type="hidden" name="amount" value="${params.amount}">
                <input type="hidden" name="searchSupportArea" value="${params.searchSupportArea}">
                <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

                <div class="row g-3">
                    <div class="col-md-6 mb-3">
                        <label class="form-label text-white">신청자명 (또는 단체명)</label>
                        <input type="text" name="applyNm" class="form-control dark-search-bar fw-bold text-white" value="${volunteer.applyNm}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label text-white">연락처 (휴대전화)</label>
                        <input type="text" name="phone" class="form-control dark-search-bar" value="${volunteer.phone}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label text-white">참여 인원 (명)</label>
                        <div class="input-group">
                            <input type="number" name="applyCnt" class="form-control dark-search-bar text-end" value="${volunteer.applyCnt}" min="1" required>
                            <span class="input-group-text dark-search-bar text-muted">명</span>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label text-white">봉사 희망 빈도</label>
                        <select name="freqType" class="form-select dark-search-bar">
                            <option value="ONCE" ${volunteer.freqType eq 'ONCE' ? 'selected' : ''}>1회 참여 희망</option>
                            <option value="OFTEN" ${volunteer.freqType eq 'OFTEN' ? 'selected' : ''}>정기/수시 참여 희망</option>
                        </select>
                    </div>
                </div>

                <div class="alert mt-4 p-3" style="background: rgba(255,255,255,0.03); border: 1px dashed rgba(255,255,255,0.2);">
                    <i class="bi bi-info-circle text-info me-2"></i> <span class="text-muted" style="font-size: 13px;">신청자가 기입한 연락처 오류 시, 관리자가 올바른 정보로 수정하여 저장할 수 있습니다.</span>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-neon px-5 py-2">정보 업데이트</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>