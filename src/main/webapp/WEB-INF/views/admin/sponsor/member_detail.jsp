<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="join" scope="request" />
<c:set var="subMenuGroup" value="sponsor" scope="request" />
<c:set var="currentMenu" value="sponsor_member" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">가입자 상세 정보</h3>
    <a href="/admin/sponsor/member/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<c:if test="${member.withdrawYn eq 'Y'}">
    <div class="alert alert-danger d-flex align-items-center mb-4" style="background: rgba(230, 25, 56, 0.1); border: 1px solid #e61938; color: #ff6b81;">
        <i class="bi bi-exclamation-triangle-fill fs-4 me-3"></i>
        <div>
            <strong>주의: 탈퇴 처리된 회원입니다.</strong><br>
            탈퇴 일시: <fmt:formatDate value="${member.withdrawDt}" pattern="yyyy-MM-dd HH:mm:ss" />
        </div>
    </div>
</c:if>

<div class="row g-4">
    <div class="col-xl-5">
        <div class="premium-dark-card p-4 h-100">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-person-lines-fill me-2 text-info"></i> 기본 정보</h5>
            <form action="/admin/sponsor/member/update" method="post">
                <input type="hidden" name="mbrSeq" value="${member.mbrSeq}">

                <div class="mb-3">
                    <label class="form-label text-muted">가입 계정 유형</label>
                    <div class="mt-1">
                        <c:choose>
                            <c:when test="${member.loginType eq 'KAKAO'}">
                                <span class="badge px-3 py-2 text-dark fw-bold" style="background-color: #FEE500;"><i class="bi bi-chat-fill me-1"></i> 카카오 연동 가입</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary px-3 py-2"><i class="bi bi-envelope-fill me-1"></i> 일반 이메일 가입</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted">이름 (기업명) <span class="badge bg-secondary ms-2">${member.mbrType eq 'INDIVIDUAL' ? '개인' : '단체/기업'}</span></label>
                    <input type="text" class="form-control dark-search-bar" value="${member.mbrNm}" readonly style="background-color: rgba(0,0,0,0.2) !important;">
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted">아이디 (이메일 고유ID)</label>
                    <input type="text" class="form-control dark-search-bar" value="${member.mbrId}" readonly style="background-color: rgba(0,0,0,0.2) !important;">
                </div>

                <c:if test="${member.mbrType eq 'CORP'}">
                    <div class="mb-3">
                        <label class="form-label text-muted">사업자등록번호</label>
                        <input type="text" class="form-control dark-search-bar text-info" value="${not empty member.bizNo ? member.bizNo : '미등록'}" readonly style="background-color: rgba(0,0,0,0.2) !important;">
                    </div>
                </c:if>

                <div class="mb-3">
                    <label class="form-label text-muted">가입일시</label>
                    <input type="text" class="form-control dark-search-bar" value="<fmt:formatDate value='${member.joinDt}' pattern='yyyy-MM-dd HH:mm:ss' />" readonly style="background-color: rgba(0,0,0,0.2) !important;">
                </div>

                <hr class="border-secondary my-4">
                <h6 class="fw-bold text-white mb-3">연락처 정보 (수정 가능)</h6>

                <div class="mb-3">
                    <label class="form-label text-white">휴대전화 (연락처)</label>
                    <input type="text" name="phone" class="form-control dark-search-bar" value="${member.phone}">
                </div>
                <div class="mb-3">
                    <label class="form-label text-white">수신 이메일</label>
                    <input type="email" name="email" class="form-control dark-search-bar" value="${member.email}">
                </div>

                <c:if test="${member.mbrType eq 'CORP'}">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label text-white">담당자명</label>
                            <input type="text" name="managerNm" class="form-control dark-search-bar" value="${member.managerNm}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label text-white">담당자 직함</label>
                            <input type="text" name="managerPos" class="form-control dark-search-bar" value="${member.managerPos}">
                        </div>
                    </div>
                </c:if>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-neon w-100 py-2">연락처 정보 수정하기</button>
                </div>
            </form>
        </div>
    </div>

    <div class="col-xl-7">
        <div class="premium-dark-card p-4 h-100 glassmorphism-box border-0">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-credit-card-fill me-2 text-warning"></i> 기부 결제 이력 및 통계</h5>

            <c:set var="doneCnt" value="0" />
            <c:set var="doneAmt" value="0" />
            <c:forEach var="d" items="${member.donationList}">
                <c:if test="${d.payStatus eq 'DONE'}">
                    <c:set var="doneCnt" value="${doneCnt + 1}" />
                    <c:set var="doneAmt" value="${doneAmt + d.payAmt}" />
                </c:if>
            </c:forEach>

            <div class="row g-3 mb-4">
                <div class="col-sm-6">
                    <div class="p-3 rounded" style="background: rgba(57, 255, 20, 0.05); border: 1px solid rgba(57, 255, 20, 0.2);">
                        <span class="d-block text-muted mb-1" style="font-size: 13px;">실제 결제 완료 건수</span>
                        <h3 class="text-white fw-bold mb-0">${doneCnt} <small class="fs-6 text-muted">건</small></h3>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="p-3 rounded" style="background: rgba(255, 153, 226, 0.05); border: 1px solid rgba(255, 153, 226, 0.2);">
                        <span class="d-block text-muted mb-1" style="font-size: 13px;">실제 결제 완료 누적액</span>
                        <h3 class="fw-bold mb-0" style="color: #ff99e2;"><fmt:formatNumber value="${doneAmt}" pattern="#,###"/> <small class="fs-6 text-muted">원</small></h3>
                    </div>
                </div>
            </div>

            <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                <table class="table table-hover align-middle text-center mb-0">
                    <thead class="position-sticky top-0" style="background-color: #1e1e2d; z-index: 1;">
                        <tr>
                            <th class="text-white border-bottom border-secondary">DB등록일</th>
                            <th class="text-white border-bottom border-secondary">유형</th>
                            <th class="text-white border-bottom border-secondary">결제금액</th>
                            <th class="text-white border-bottom border-secondary">상태</th>
                            <th class="text-white border-bottom border-secondary">상세</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty member.donationList}">
                                <tr><td colspan="5" class="py-5 text-muted border-secondary">결제(기부) 이력이 없습니다.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="donate" items="${member.donationList}">
                                    <tr>
                                        <td class="border-secondary"><fmt:formatDate value="${donate.regDt}" pattern="yyyy-MM-dd" /></td>
                                        <td class="border-secondary">
                                            ${donate.payType eq 'REGULAR' ? '<span class="badge bg-primary">정기</span>' : '<span class="badge bg-secondary">일시</span>'}
                                            <c:if test="${donate.payType eq 'REGULAR'}"><br><small class="text-muted">${donate.regularRound}회차</small></c:if>
                                        </td>
                                        <td class="border-secondary fw-bold text-white"><fmt:formatNumber value="${donate.payAmt}" pattern="#,###"/> 원</td>
                                        <td class="border-secondary">
                                            <c:choose>
                                                <c:when test="${donate.payStatus eq 'DONE'}"><span class="text-success fw-bold">결제완료</span></c:when>
                                                <c:when test="${donate.payStatus eq 'WAIT'}"><span class="text-warning">대기중</span></c:when>
                                                <c:when test="${donate.payStatus eq 'REFUND'}"><span class="text-danger">환불됨</span></c:when>
                                                <c:when test="${donate.payStatus eq 'CANCEL'}"><span class="text-muted">취소됨</span></c:when>
                                                <c:otherwise><span class="text-secondary">기타</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="border-secondary">
                                            <a href="/admin/sponsor/donate/detail?paySeq=${donate.paySeq}" class="btn btn-sm btn-outline-light" style="font-size: 11px;">보기</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>