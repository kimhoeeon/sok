<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="dev" scope="request" />
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-white">홈페이지 요청/문의 관리 <span class="badge bg-secondary ms-2" style="font-size: 13px;">유지보수 티켓</span></h3>
    <div>
        <button type="button" class="btn btn-success px-4 fw-bold me-2" onclick="downloadExcel()">
            <i class="bi bi-file-earmark-excel me-1"></i> 엑셀 다운로드
        </button>
        <a href="/admin/dev/form" class="btn btn-neon px-4"><i class="bi bi-pencil-square"></i> 새 요청 등록</a>
    </div>
</div>

<div class="row g-3 mb-4">
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.1);">
            <span class="text-muted d-block mb-1" style="font-size: 13px;">전체 누적 티켓</span>
            <h3 class="text-white fw-bold m-0">${empty statusCount.totalCnt ? 0 : statusCount.totalCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(255, 193, 7, 0.05); border: 1px solid rgba(255, 193, 7, 0.2);">
            <span class="text-warning d-block mb-1 fw-bold" style="font-size: 13px;"><i class="bi bi-hourglass-split me-1"></i>접수 / 대기중</span>
            <h3 class="text-white fw-bold m-0">${empty statusCount.waitCnt ? 0 : statusCount.waitCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(13, 110, 253, 0.05); border: 1px solid rgba(13, 110, 253, 0.2);">
            <span class="text-primary d-block mb-1 fw-bold" style="font-size: 13px;"><i class="bi bi-tools me-1"></i>처리 진행중</span>
            <h3 class="text-white fw-bold m-0">${empty statusCount.processCnt ? 0 : statusCount.processCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
    <div class="col-md-3">
        <div class="p-3 rounded text-center" style="background: rgba(25, 135, 84, 0.05); border: 1px solid rgba(25, 135, 84, 0.2);">
            <span class="text-success d-block mb-1 fw-bold" style="font-size: 13px;"><i class="bi bi-check-circle-fill me-1"></i>처리 완료</span>
            <h3 class="text-white fw-bold m-0">${empty statusCount.doneCnt ? 0 : statusCount.doneCnt} <small class="fs-6 text-muted">건</small></h3>
        </div>
    </div>
</div>

<div class="premium-dark-card p-4">

    <div class="d-flex align-items-center justify-content-between bg-dark p-3 rounded mb-4 border border-secondary shadow-sm flex-wrap gap-3">
        <div class="d-flex align-items-center flex-wrap gap-2">
            <span class="text-white fw-bold"><i class="bi bi-check2-square text-info me-1"></i>선택 일괄 변경:</span>
            <select id="batchStatus" class="form-select dark-search-bar form-select-sm" style="max-width: 140px;">
                <option value="WAITING">접수대기</option>
                <option value="PROCESS">진행중</option>
                <option value="DISCUSS">논의필요</option>
                <option value="DONE">처리완료</option>
                <option value="REJECT">처리불가</option>
            </select>
            <div class="input-group input-group-sm" style="max-width: 200px;">
                <span class="input-group-text dark-search-bar text-muted border-end-0">예정일</span>
                <input type="date" id="batchDueDt" class="form-control dark-search-bar border-start-0">
            </div>
            <button type="button" class="btn btn-sm btn-outline-warning fw-bold px-3" onclick="executeBatchUpdate()">적용</button>
        </div>

        <form id="searchForm" action="/admin/dev/list" method="get" class="d-flex m-0">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <div class="input-group shadow-sm input-group-sm">
                <select name="amount" class="form-select dark-search-bar" style="max-width: 80px;" onchange="searchData()">
                    <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개</option>
                    <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개</option>
                    <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개</option>
                </select>

                <select name="searchType" class="form-select dark-search-bar border-start-0" style="max-width: 110px;">
                    <option value="">전체 유형</option>
                    <option value="유지보수" ${params.searchType eq '유지보수' ? 'selected' : ''}>유지보수</option>
                    <option value="단순문의" ${params.searchType eq '단순문의' ? 'selected' : ''}>단순문의</option>
                    <option value="기능오류" ${params.searchType eq '기능오류' ? 'selected' : ''}>기능오류</option>
                </select>

                <select name="searchStatus" class="form-select dark-search-bar border-start-0" style="max-width: 110px;">
                    <option value="">전체 상태</option>
                    <option value="WAITING" ${params.searchStatus eq 'WAITING' ? 'selected' : ''}>접수대기</option>
                    <option value="PROCESS" ${params.searchStatus eq 'PROCESS' ? 'selected' : ''}>진행중</option>
                    <option value="DISCUSS" ${params.searchStatus eq 'DISCUSS' ? 'selected' : ''}>논의필요</option>
                    <option value="DONE" ${params.searchStatus eq 'DONE' ? 'selected' : ''}>처리완료</option>
                    <option value="REJECT" ${params.searchStatus eq 'REJECT' ? 'selected' : ''}>처리불가</option>
                </select>
                <input type="text" name="searchKeyword" class="form-control dark-search-bar border-start-0" placeholder="제목 검색" value="${params.searchKeyword}" style="width: 150px;">
                <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;"><i class="bi bi-search"></i></button>
            </div>
        </form>
    </div>

    <form id="batchForm" action="/admin/dev/batchUpdate" method="post">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        <input type="hidden" name="searchType" value="${params.searchType}">
        <input type="hidden" name="searchStatus" value="${params.searchStatus}">
        <input type="hidden" name="searchKeyword" value="${params.searchKeyword}">

        <input type="hidden" id="submitStatus" name="status">
        <input type="hidden" id="submitDueDt" name="dueDt">

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th width="4%" class="text-white border-bottom border-secondary">
                            <input class="form-check-input" type="checkbox" id="checkAll" onclick="toggleAll(this)">
                        </th>
                        <th width="6%" class="text-white border-bottom border-secondary">No.</th>
                        <th width="9%" class="text-white border-bottom border-secondary">유형</th>
                        <th width="6%" class="text-white border-bottom border-secondary">긴급</th>
                        <th class="text-white border-bottom border-secondary">요청 제목</th>
                        <th width="10%" class="text-white border-bottom border-secondary">상태</th>
                        <th width="10%" class="text-white border-bottom border-secondary">예정일</th>
                        <th width="10%" class="text-white border-bottom border-secondary">작성자</th>
                        <th width="10%" class="text-white border-bottom border-secondary">등록일시</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr><td colspan="9" class="py-5 text-muted border-secondary">등록된 유지보수 요청 내역이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${list}">
                                <tr>
                                    <td class="border-secondary">
                                        <input class="form-check-input chk-item" type="checkbox" name="reqSeqs" value="${item.reqSeq}">
                                    </td>
                                    <td class="border-secondary text-muted">#${item.reqSeq}</td>
                                    <td class="border-secondary"><span class="badge bg-secondary">${item.reqType}</span></td>
                                    <td class="border-secondary">
                                        <c:if test="${item.urgency eq 'Y'}">
                                            <i class="bi bi-exclamation-triangle-fill text-danger fs-5" title="긴급 요청"></i>
                                        </c:if>
                                    </td>
                                    <td class="text-start border-secondary">
                                        <a href="/admin/dev/detail?reqSeq=${item.reqSeq}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&searchType=${params.searchType}&searchStatus=${params.searchStatus}&searchKeyword=${params.searchKeyword}" class="text-white text-decoration-none fw-bold hover-glow">
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
                                    <td class="border-secondary text-info" style="font-size: 13px;">
                                        ${not empty item.dueDt ? '<fmt:formatDate value="' += item.dueDt += '" pattern="yyyy-MM-dd" />' : '-'}
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
    </form>

    <c:if test="${pageMaker.total > 0}">
        <div class="d-flex justify-content-center mt-5">
            <ul class="pagination pagination-dark m-0">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item">
                        <a class="page-link" href="javascript:goPage(${pageMaker.startPage - 1})"><i class="bi bi-chevron-left"></i></a>
                    </li>
                </c:if>
                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                        <a class="page-link" href="javascript:goPage(${num})">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link" href="javascript:goPage(${pageMaker.endPage + 1})"><i class="bi bi-chevron-right"></i></a>
                    </li>
                </c:if>
            </ul>
        </div>
    </c:if>
</div>

<style>
    .pagination-dark .page-link { background-color: #1e1e2d; border-color: #474761; color: #a1a5b7; border-radius: 4px; margin: 0 3px;}
    .pagination-dark .page-link:hover { background-color: #2b2b40; color: #fff; }
    .pagination-dark .page-item.active .page-link { background-color: #39ff14; border-color: #39ff14; color: #000; font-weight: bold; }
</style>

<script>
    function goPage(pageNum) {
        document.getElementById('searchForm').pageNum.value = pageNum;
        document.getElementById('searchForm').submit();
    }
    function searchData() {
        document.getElementById('searchForm').pageNum.value = 1;
        document.getElementById('searchForm').submit();
    }
    function downloadExcel() {
        var form = document.getElementById('searchForm');
        var originalAction = form.action;
        form.action = '/admin/dev/excel';
        form.submit();
        form.action = originalAction;
    }
    function toggleAll(source) {
        var checkboxes = document.querySelectorAll('.chk-item');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }
    function executeBatchUpdate() {
        var checkboxes = document.querySelectorAll('.chk-item:checked');
        if (checkboxes.length === 0) {
            alert('일괄 처리할 티켓을 하나 이상 선택해주세요.');
            return;
        }
        var selectedStatus = document.getElementById('batchStatus').value;
        var dueDt = document.getElementById('batchDueDt').value;

        if(selectedStatus === 'PROCESS' && !dueDt) {
            if(!confirm('처리 예정일이 지정되지 않았습니다. 그래도 진행하시겠습니까?')) return;
        }
        if (confirm('선택한 ' + checkboxes.length + '개의 티켓 상태를 일괄 변경하시겠습니까?')) {
            document.getElementById('submitStatus').value = selectedStatus;
            document.getElementById('submitDueDt').value = dueDt;
            document.getElementById('batchForm').submit();
        }
    }
</script>

<%@ include file="../layout/footer.jsp" %>