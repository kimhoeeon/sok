<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="currentMenu" value="promoter" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">후원사 관리</h3>
    <button type="button" class="btn btn-primary px-4 fw-bold shadow-sm" onclick="openModal()">
        <i class="bi bi-plus-lg me-1"></i> 새 후원사 등록
    </button>
</div>

<div class="premium-card p-4">
    <form id="searchForm" action="/mng/promoter/list" method="get"
          class="d-flex justify-content-between align-items-center mb-4">
        <input type="hidden" name="pageNum" value="${params.pageNum}">

        <!-- 좌측 안내 문구 -->
        <div class="text-muted" style="font-size: 0.95rem;">
            <i class="bi bi-info-circle-fill text-primary me-1"></i> 후원사는 <strong>'노출 순서'</strong> 값이 작은 순서대로 목록에 표시됩니다.
        </div>

        <!-- 우측 검색 바 -->
        <div class="input-group shadow-sm" style="max-width: 450px;">
            <select name="amount" class="form-select search-bar" style="max-width: 100px;" onchange="searchData()">
                <option value="10" ${params.amount == 10 ? 'selected' : ''}>10개</option>
                <option value="20" ${params.amount == 20 ? 'selected' : ''}>20개</option>
                <option value="50" ${params.amount == 50 ? 'selected' : ''}>50개</option>
            </select>

            <input type="text" name="keyword" class="form-control search-bar border-start-0" placeholder="후원사 이름 검색" value="${params.keyword}">
            <button class="btn btn-secondary border-start-0" type="button" onclick="searchData()" style="border: 1px solid #474761;">
                <i class="bi bi-search"></i> 검색
            </button>
        </div>
    </form>

    <!-- 목록 테이블 -->
    <div class="table-responsive">
        <table class="table table-hover align-middle text-center mb-0"
               style="--bs-table-bg: #ffffff; --bs-table-color: #212529; --bs-table-hover-bg: rgba(0,0,0,0.02); border-top: 1px solid #dee2e6;">
            <thead style="background-color: #f8f9fa;">
            <tr>
                <th width="8%" class="text-dark border-bottom py-3">순번</th>
                <th width="15%" class="text-dark border-bottom py-3">
                    노출 순서 <i class="bi bi-question-circle text-muted ms-1" title="숫자가 낮을수록 목록 상단에 표시됩니다."></i>
                </th>
                <th class="text-dark border-bottom py-3">후원사 이름</th>
                <th width="25%" class="text-dark border-bottom py-3">후원사 이미지</th>
                <th width="15%" class="text-dark border-bottom py-3">관리</th>
            </tr>
            </thead>
            <tbody style="border-top: 2px solid #dee2e6;">
            <c:choose>
                <c:when test="${empty promoterList}">
                    <tr>
                        <td colspan="5" class="py-5 text-muted">
                            <c:choose>
                                <c:when test="${not empty params.keyword}">조회된 후원사가 없습니다.</c:when>
                                <c:otherwise>등록된 후원사가 없습니다.</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${promoterList}" varStatus="st">
                        <!-- 역순 순번 계산 -->
                        <c:set var="listNum" value="${totalCount - ((params.pageNum - 1) * params.amount) - st.index}"/>
                        <tr>
                            <td>${listNum}</td>
                            <td>
                                <span class="badge bg-light text-dark border border-secondary px-3 py-2 fs-6 shadow-sm">${item.displayOrder}</span>
                            </td>
                            <td class="text-start fw-bold text-dark px-4">${item.promoterName}</td>
                            <td>
                                <div class="border rounded bg-white d-inline-flex align-items-center justify-content-center"
                                     style="height: 50px; width: 140px; padding: 5px;">
                                    <img src="/file/img?type=promoter&filename=${item.fileName}"
                                         alt="${item.promoterName} 로고"
                                         style="max-height: 100%; max-width: 100%; object-fit: contain;">
                                </div>
                            </td>
                            <td>
                                <button type="button" class="btn btn-sm btn-outline-secondary me-1" onclick="openModal(${item.seq})">수정</button>
                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="deletePromoter(${item.seq})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <!-- 커스텀 페이지네이션 연산 및 출력 -->
    <c:if test="${totalCount > 0}">
        <c:set var="pageCount" value="${totalCount / params.amount}"/>
        <c:if test="${totalCount % params.amount > 0}"><c:set var="pageCount" value="${pageCount + 1}"/></c:if>
        <fmt:parseNumber var="pageCountInt" value="${pageCount}" integerOnly="true"/>
        <fmt:parseNumber var="startBlock" value="${(params.pageNum - 1) / 10}" integerOnly="true"/>
        <c:set var="startPage" value="${(startBlock * 10) + 1}"/>
        <c:set var="endPage" value="${startPage + 9}"/>
        <c:if test="${endPage > pageCountInt}"><c:set var="endPage" value="${pageCountInt}"/></c:if>

        <div class="d-flex justify-content-center mt-5">
            <ul class="pagination pagination-custom m-0 shadow-sm">
                <c:if test="${startPage > 1}">
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${startPage - 1})"><i
                            class="bi bi-chevron-left"></i></a></li>
                </c:if>
                <c:forEach var="num" begin="${startPage}" end="${endPage}">
                    <li class="page-item ${params.pageNum == num ? 'active' : ''}">
                        <a class="page-link" href="javascript:goPage(${num})">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${endPage < pageCountInt}">
                    <li class="page-item"><a class="page-link" href="javascript:goPage(${endPage + 1})"><i
                            class="bi bi-chevron-right"></i></a></li>
                </c:if>
            </ul>
        </div>
    </c:if>
</div>

<!-- Bootstrap 기반 등록/수정 모달 팝업 -->
<div class="modal fade" id="promoterModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true"
     data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-dark" id="modalTitle">새 후원사 등록</h5>
                <button type="button" class="btn-close" onclick="closeModal()" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <form id="promoterForm">
                    <input type="hidden" id="seq" name="seq">

                    <div class="mb-4">
                        <label for="promoterName" class="form-label fw-bold text-dark">후원사 이름 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="promoterName" name="promoterName" maxlength="50"
                               placeholder="후원사 이름을 입력하세요.">
                    </div>

                    <div class="mb-4">
                        <label for="displayOrder" class="form-label fw-bold text-dark">노출 순서</label>
                        <input type="number" class="form-control" id="displayOrder" name="displayOrder"
                               placeholder="숫자를 입력하세요. (미입력 시 마지막 순서 등록)">
                        <div class="form-text text-muted mt-2"><i class="bi bi-exclamation-circle"></i> 숫자가 낮을수록 목록 상단에
                            표시됩니다.
                        </div>
                    </div>

                    <div class="mb-2">
                        <label for="uploadFile" class="form-label fw-bold text-dark">후원사 이미지 <span id="imgReqMark"
                                                                                                   class="text-danger">*</span></label>
                        <input type="file" class="form-control" id="uploadFile" name="uploadFile"
                               accept=".jpg, .jpeg, .png" onchange="previewImage(this)">

                        <div class="bg-light p-3 rounded mt-2 border" style="font-size: 0.85rem; color: #555;">
                            <ul class="mb-0 ps-3">
                                <li><strong>권장 사이즈:</strong> 600 x 200px</li>
                                <li><strong>지원 형식:</strong> JPG, PNG</li>
                                <li><strong>최대 파일 크기:</strong> 2MB</li>
                            </ul>
                        </div>

                        <!-- 이미지 미리보기 영역 -->
                        <div id="previewWrapper" class="mt-3 text-center border rounded bg-white"
                             style="height: 100px; display: none; padding: 10px;">
                            <img id="preview" src="" alt="미리보기"
                                 style="max-height: 100%; max-width: 100%; object-fit: contain;">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer bg-light justify-content-center border-top-0 py-3">
                <button type="button" class="btn btn-secondary px-4 fw-bold" onclick="closeModal()">취소</button>
                <button type="button" class="btn btn-primary px-4 fw-bold" id="saveBtn" onclick="savePromoter()">등록
                </button>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    let isFormChanged = false;

    // 입력값 변경 감지
    $('#promoterForm input').on('change keyup', function () {
        isFormChanged = true;
    });

    // 검색 함수
    function goPage(pageNum) {
        document.getElementById('searchForm').pageNum.value = pageNum;
        document.getElementById('searchForm').submit();
    }

    function searchData() {
        document.getElementById('searchForm').pageNum.value = 1;
        document.getElementById('searchForm').submit();
    }

    // 모달 팝업 열기
    function openModal(seq) {
        isFormChanged = false;
        $('#promoterForm')[0].reset();
        $('#seq').val('');
        $('#previewWrapper').hide();
        $('#preview').attr('src', '');

        if (seq) {
            $('#modalTitle').text('후원사 수정');
            $('#imgReqMark').hide();
            $('#saveBtn').text('수정');

            $.ajax({
                url: '/mng/promoter/detail',
                type: 'GET',
                data: {seq: seq},
                success: function (res) {
                    $('#seq').val(res.seq);
                    $('#promoterName').val(res.promoterName);
                    $('#displayOrder').val(res.displayOrder);
                    if (res.fileName) {
                        $('#previewWrapper').show();
                        $('#preview').attr('src', '/file/img?type=promoter&filename=' + res.fileName);
                    }
                    $('#promoterModal').modal('show');
                }
            });
        } else {
            $('#modalTitle').text('새 후원사 등록');
            $('#imgReqMark').show();
            $('#saveBtn').text('등록');
            $('#promoterModal').modal('show');
        }
    }

    // 모달 팝업 닫기
    function closeModal() {
        if (isFormChanged) {
            if (!confirm("입력한 내용이 저장되지 않습니다. 정말 닫으시겠습니까?")) return;
        }
        $('#promoterModal').modal('hide');
    }

    // 이미지 파일 유효성 검사 및 미리보기
    function previewImage(target) {
        const file = target.files[0];
        if (!file) {
            $('#previewWrapper').hide();
            return;
        }

        const ext = file.name.split('.').pop().toLowerCase();
        if ($.inArray(ext, ['jpg', 'jpeg', 'png']) == -1) {
            alert("후원사 이미지는 JPG, JPEG, PNG 형식만 등록 가능합니다.");
            $(target).val('');
            $('#previewWrapper').hide();
            return;
        }

        const maxSize = 2 * 1024 * 1024;
        if (file.size > maxSize) {
            alert("최대 업로드 가능한 파일 용량을 초과했습니다. (2MB 이하)");
            $(target).val('');
            $('#previewWrapper').hide();
            return;
        }

        const reader = new FileReader();
        reader.onload = function (e) {
            $('#previewWrapper').show();
            $('#preview').attr('src', e.target.result);
        };
        reader.readAsDataURL(file);
    }

    // 저장(등록/수정) 처리
    function savePromoter() {
        const seq = $('#seq').val();
        const promoterName = $('#promoterName').val().trim();
        const file = $('#uploadFile')[0].files[0];

        if (!promoterName) {
            alert("후원사 이름을 입력해 주세요.");
            $('#promoterName').focus();
            return;
        }

        if (!seq && !file) {
            alert("후원사 이미지를 첨부해 주세요.");
            return;
        }

        const formData = new FormData($('#promoterForm')[0]);

        $.ajax({
            url: '/mng/promoter/save',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.result === 'success') {
                    alert("저장되었습니다.");
                    location.reload();
                } else {
                    alert(res.message);
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }

    // 삭제 처리
    function deletePromoter(seq) {
        if (confirm("해당 후원사를 삭제하시겠습니까? 삭제 후 순번이 자동 재정렬됩니다.")) {
            $.ajax({
                url: '/mng/promoter/delete',
                type: 'POST',
                data: {seq: seq},
                success: function (res) {
                    if (res.result === 'success') {
                        alert("삭제되었습니다.");
                        location.reload();
                    }
                }
            });
        }
    }
</script>