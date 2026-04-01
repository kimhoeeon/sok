<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="home" scope="request" />
<c:set var="currentMenu" value="dev" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">유지보수 티켓 상세</h3>
    <a href="/admin/dev/list" class="btn btn-outline-light"><i class="bi bi-list"></i> 목록으로</a>
</div>

<div class="row g-4 mb-4">
    <div class="col-xl-8">
        <div class="premium-dark-card p-5 h-100">
            <div class="d-flex justify-content-between align-items-start border-bottom border-secondary pb-4 mb-4">
                <div>
                    <span class="badge bg-secondary mb-2 fs-6 px-3 py-2">${request.reqType}</span>
                    <c:if test="${request.urgency eq 'Y'}"><span class="badge bg-danger ms-2 fs-6 px-3 py-2"><i class="bi bi-exclamation-triangle-fill"></i> 긴급</span></c:if>
                    <h3 class="text-white fw-bold mt-2 mb-0">${request.title}</h3>
                </div>
                <div class="text-end">
                    <span class="d-block text-muted" style="font-size: 12px;">작성자: <span class="text-white fw-bold">${request.regId}</span></span>
                    <span class="d-block text-muted" style="font-size: 12px;">등록일: <fmt:formatDate value="${request.regDt}" pattern="yyyy-MM-dd HH:mm" /></span>
                </div>
            </div>

            <div class="text-white lh-lg mb-5" style="font-size: 15px;">
                ${request.content}
            </div>

            <c:if test="${not empty request.fileList}">
                <div class="p-3 rounded" style="background: rgba(255,255,255,0.05); border: 1px solid #474761;">
                    <h6 class="text-white fw-bold mb-3"><i class="bi bi-paperclip me-2"></i>요청 첨부파일</h6>
                    <ul class="list-unstyled mb-0">
                        <c:forEach var="file" items="${request.fileList}">
                            <li class="mb-2">
                                <a href="${file.filePath}" target="_blank" class="text-info text-decoration-none hover-glow">
                                    <i class="bi bi-file-earmark-arrow-down me-1"></i> ${file.orgFileNm}
                                </a>
                                <span class="text-muted ms-2" style="font-size: 11px;">(${file.fileSize} byte)</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>

    <div class="col-xl-4">
        <div class="premium-dark-card p-4 h-100 glassmorphism-box border-0">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-gear-fill me-2 text-warning"></i> 티켓 진행 상태</h5>

            <div class="p-4 rounded text-center mb-4 border border-secondary" style="background-color: #151521;">
                <span class="d-block text-muted mb-2">현재 처리 상태</span>
                <c:choose>
                    <c:when test="${request.status eq 'WAITING'}"><h2 class="text-warning fw-bold m-0">접수 / 대기중</h2></c:when>
                    <c:when test="${request.status eq 'PROCESS'}"><h2 class="text-primary fw-bold m-0">처리 진행중</h2></c:when>
                    <c:when test="${request.status eq 'DISCUSS'}"><h2 class="fw-bold m-0" style="color: #ff99e2;">논의 필요</h2></c:when>
                    <c:when test="${request.status eq 'DONE'}"><h2 class="text-success fw-bold m-0">처리 완료</h2></c:when>
                    <c:when test="${request.status eq 'REJECT'}"><h2 class="text-danger fw-bold m-0">처리 불가</h2></c:when>
                </c:choose>
            </div>

            <div class="d-flex justify-content-between align-items-center p-3 rounded mb-4" style="background: rgba(255,255,255,0.03); border: 1px dashed #474761;">
                <span class="text-muted"><i class="bi bi-calendar-check me-2"></i>완료 예정일</span>
                <span class="${not empty request.dueDt ? 'text-white fw-bold fs-5' : 'text-muted'}">
                    ${not empty request.dueDt ? '<fmt:formatDate value="' += request.dueDt += '" pattern="yyyy-MM-dd" />' : '미정'}
                </span>
            </div>

            <c:if test="${isDeveloper}">
                <hr class="border-secondary my-4">
                <h6 class="text-danger fw-bold mb-3"><i class="bi bi-tools me-1"></i> [개발사 전용] 진행 상태 업데이트</h6>
                <form action="/admin/dev/updateStatus" method="post">
                    <input type="hidden" name="reqSeq" value="${request.reqSeq}">
                    <div class="mb-3">
                        <label class="text-white mb-2" style="font-size: 13px;">상태 변경</label>
                        <select name="status" class="form-select dark-search-bar border-danger">
                            <option value="WAITING" ${request.status eq 'WAITING' ? 'selected' : ''}>접수 대기</option>
                            <option value="PROCESS" ${request.status eq 'PROCESS' ? 'selected' : ''}>처리 진행중</option>
                            <option value="DISCUSS" ${request.status eq 'DISCUSS' ? 'selected' : ''}>논의 필요</option>
                            <option value="DONE" ${request.status eq 'DONE' ? 'selected' : ''}>처리 완료</option>
                            <option value="REJECT" ${request.status eq 'REJECT' ? 'selected' : ''}>처리 불가 (반려)</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="text-white mb-2" style="font-size: 13px;">완료 예정일 셋팅</label>
                        <input type="date" name="dueDt" class="form-control dark-search-bar" value="<fmt:formatDate value='${request.dueDt}' pattern='yyyy-MM-dd' />">
                    </div>
                    <button type="submit" class="btn btn-outline-danger w-100">티켓 정보 업데이트</button>
                </form>
            </c:if>
            <c:if test="${not isDeveloper}">
                <div class="alert mt-4 p-3 text-center" style="background: rgba(255,255,255,0.03); border: 1px dashed rgba(255,255,255,0.2);">
                    <span class="text-muted" style="font-size: 13px;"><i class="bi bi-info-circle me-1"></i> 상태 및 완료 예정일은 개발사 담당자가 셋팅합니다.</span>
                </div>
            </c:if>
        </div>
    </div>
</div>

<div class="premium-dark-card p-5">
    <h5 class="fw-bold text-white mb-4 border-bottom border-secondary pb-3"><i class="bi bi-chat-dots-fill me-2 text-info"></i> 피드백 및 진행 상황 코멘트</h5>

    <div class="mb-5">
        <c:choose>
            <c:when test="${empty comments}">
                <div class="text-center py-4 text-muted">아직 등록된 코멘트가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="cmt" items="${comments}">
                    <div class="p-4 rounded mb-3" style="background: rgba(255,255,255,0.03); border: 1px solid #474761;">
                        <div class="d-flex justify-content-between mb-3">
                            <span class="fw-bold ${cmt.regId eq 'meetingfan' ? 'text-primary' : 'text-success'}">
                                <i class="bi ${cmt.regId eq 'meetingfan' ? 'bi-braces-asterisk' : 'bi-person-circle'} me-1"></i> ${cmt.regId}
                            </span>
                            <span class="text-muted" style="font-size: 12px;"><fmt:formatDate value="${cmt.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                        </div>
                        <div class="text-white lh-base mb-3" style="white-space: pre-wrap;">${cmt.content}</div>

                        <c:if test="${not empty cmt.fileList}">
                            <div class="pt-2 border-top border-secondary">
                                <c:forEach var="cFile" items="${cmt.fileList}">
                                    <a href="${cFile.filePath}" target="_blank" class="badge bg-secondary text-decoration-none me-2 p-2 fw-normal">
                                        <i class="bi bi-paperclip"></i> ${cFile.orgFileNm}
                                    </a>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="p-4 rounded" style="background-color: #1e1e2d; border: 1px solid #39ff14;">
        <h6 class="text-white fw-bold mb-3">새 코멘트 남기기 (알림 메일 발송)</h6>
        <form action="/admin/dev/saveComment" method="post" enctype="multipart/form-data">
            <input type="hidden" name="reqSeq" value="${request.reqSeq}">
            <textarea name="content" class="form-control dark-search-bar mb-3" rows="4" required placeholder="진행 상황 피드백이나 추가 요청 사항을 작성해 주세요."></textarea>

            <div class="d-flex justify-content-between align-items-center">
                <div class="w-50">
                    <input type="file" name="uploadFiles" class="form-control dark-search-bar form-control-sm" multiple>
                    <small class="text-muted mt-1 d-block">추가 참고 파일 (선택사항)</small>
                </div>
                <button type="submit" class="btn btn-neon px-4 py-2">코멘트 등록</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>