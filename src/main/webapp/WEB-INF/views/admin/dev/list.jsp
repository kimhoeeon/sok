<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="menuGroup" value="home" scope="request" />
<c:set var="currentMenu" value="dev" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">홈페이지 요청/문의 관리 <span class="badge bg-secondary ms-2" style="font-size: 13px;">유지보수 티켓</span></h3>
    <a href="/admin/dev/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 새 요청 등록</a>
</div>

<div class="row g-3 mb-4">
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.1);">
            <span class="text-muted d-block mb-1" style="font-size: 13px;">전체 누적 티켓</span>
            <h3 class="text-white fw-bold m-0">${statusCount.totalCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(255, 193, 7, 0.05); border: 1px solid rgba(255, 193, 7, 0.2);">
            <span class="text-warning d-block mb-1 fw-bold" style="font-size: 13px;"><i class="bi bi-hourglass-split me-1"></i>접수 / 대기중</span>
            <h3 class="text-white fw-bold m-0">${statusCount.waitCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(13, 110, 253, 0.05); border: 1px solid rgba(13, 110, 253, 0.2);">
            <span class="text-primary d-block mb-1 fw-bold" style="font-size: 13px;"><i class="bi bi-tools me-1"></i>처리 진행중</span>
            <h3 class="text-white fw-bold m-0">${statusCount.processCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(25, 135, 84, 0.05); border: 1px solid rgba(25, 135, 84, 0.2);">
            <span class="text-success d-block mb-1 fw-bold" style="font-size: 13px;"><i class="bi bi-check-circle-fill me-1"></i>처리 완료</span>
            <h3 class="text-white fw-bold m-0">${statusCount.doneCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
</div>

<div class="premium-dark-card p-4">
    <form action="/admin/dev/list" method="get" class="d-flex justify-content-end mb-4">
        <div class="input-group shadow-sm" style="max-width: 600px;">
            <select name="searchType" class="form-select dark-search-bar" style="max-width: 140px;">
                <option value="">전체 유형</option>
                <option value="기능오류" ${params.searchType eq '기능오류' ? 'selected' : ''}>기능오류</option>
                <option value="디자인수정" ${params.searchType eq '디자인수정' ? 'selected' : ''}>디자인수정</option>
                <option value="데이터수정" ${params.searchType eq '데이터수정' ? 'selected' : ''}>데이터수정</option>
                <option value="단순문의" ${params.searchType eq '단순문의' ? 'selected' : ''}>단순문의</option>
            </select>
            <select name="searchStatus" class="form-select dark-search-bar border-start-0" style="max-width: 130px;">
                <option value="">전체 상태</option>
                <option value="WAITING" ${params.searchStatus eq 'WAITING' ? 'selected' : ''}>접수/대기</option>
                <option value="PROCESS" ${params.searchStatus eq 'PROCESS' ? 'selected' : ''}>처리 진행중</option>
                <option value="DISCUSS" ${params.searchStatus eq 'DISCUSS' ? 'selected' : ''}>논의 필요</option>
                <option value="DONE" ${params.searchStatus eq 'DONE' ? 'selected' : ''}>처리 완료</option>
                <option value="REJECT" ${params.searchStatus eq 'REJECT' ? 'selected' : ''}>처리 불가</option>
            </select>
            <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="제목 검색" value="${params.searchKeyword}">
            <button class="btn btn-secondary border-start-0" type="submit" style="border: 1px solid #474761;"><i class="bi bi-search"></i> 검색</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle text-center">
            <thead>
                <tr>
                    <th width="6%" class="text-white border-bottom border-secondary">티켓번호</th>
                    <th width="10%" class="text-white border-bottom border-secondary">유형</th>
                    <th width="8%" class="text-white border-bottom border-secondary">긴급</th>
                    <th class="text-white border-bottom border-secondary">요청 제목</th>
                    <th width="12%" class="text-white border-bottom border-secondary">처리 상태</th>
                    <th width="12%" class="text-white border-bottom border-secondary">작성자</th>
                    <th width="12%" class="text-white border-bottom border-secondary">등록일시</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr><td colspan="7" class="py-5 text-muted border-secondary">등록된 유지보수 요청 내역이 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${list}">
                            <tr>
                                <td class="border-secondary text-muted">#${item.reqSeq}</td>
                                <td class="border-secondary"><span class="badge bg-secondary">${item.reqType}</span></td>
                                <td class="border-secondary">
                                    <c:if test="${item.urgency eq 'Y'}">
                                        <i class="bi bi-exclamation-triangle-fill text-danger fs-5" title="긴급 요청"></i>
                                    </c:if>
                                </td>
                                <td class="text-start border-secondary">
                                    <a href="/admin/dev/detail?reqSeq=${item.reqSeq}" class="text-white text-decoration-none fw-bold hover-glow">
                                        ${item.title}
                                    </a>
                                    <c:if test="${item.commentCnt > 0}">
                                        <span class="badge bg-info text-dark ms-2 rounded-pill"><i class="bi bi-chat-dots-fill me-1"></i>${item.commentCnt}</span>
                                    </c:if>
                                </td>
                                <td class="border-secondary">
                                    <c:choose>
                                        <c:when test="${item.status eq 'WAITING'}"><span class="badge bg-warning text-dark">접수대기</span></c:when>
                                        <c:when test="${item.status eq 'PROCESS'}"><span class="badge bg-primary">진행중</span></c:when>
                                        <c:when test="${item.status eq 'DISCUSS'}"><span class="badge" style="background-color: #ff99e2; color: #000;">논의필요</span></c:when>
                                        <c:when test="${item.status eq 'DONE'}"><span class="badge bg-success">처리완료</span></c:when>
                                        <c:when test="${item.status eq 'REJECT'}"><span class="badge bg-danger">처리불가</span></c:when>
                                    </c:choose>
                                </td>
                                <td class="border-secondary text-muted">${item.regId}</td>
                                <td class="border-secondary"><fmt:formatDate value="${item.regDt}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>