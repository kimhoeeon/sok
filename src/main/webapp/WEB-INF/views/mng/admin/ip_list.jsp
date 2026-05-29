<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="adminIp" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">관리자 접근 IP 관리</h3>
</div>

<div class="card shadow-sm border-0">
    <div class="card-body">
        <table class="table table-hover align-middle text-center">
            <thead class="table-light">
            <tr>
                <th>NO</th>
                <th>아이디</th>
                <th>이름</th>
                <th>권한</th>
                <th>등록일시</th>
                <th>최종 로그인</th>
                <th>IP 관리</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty adminList}">
                    <tr>
                        <td colspan="7" class="py-5 text-muted">등록된 관리자가 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="admin" items="${adminList}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td class="fw-bold">${admin.admId}</td>
                            <td>${admin.admNm}</td>
                            <td><span class="badge bg-primary">${admin.admRole}</span></td>
                            <td><fmt:formatDate value="${admin.regDt}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty admin.lastLoginDt}">-</c:when>
                                    <c:otherwise><fmt:formatDate value="${admin.lastLoginDt}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-dark"
                                        onclick="openIpModal(${admin.admSeq}, '${admin.admId}')">
                                    <i class="bi bi-shield-lock"></i> IP 관리
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="ipModal" tabindex="-1" aria-labelledby="ipModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title" id="ipModalLabel"><span id="modalAdmId" class="text-warning"></span> 접근 허용 IP</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <input type="hidden" id="targetAdmSeq">

                <div class="row g-2 mb-4 align-items-center bg-light p-3 rounded border">
                    <div class="col-md-5">
                        <label class="form-label small text-muted mb-1">허용할 IP 주소</label>
                        <input type="text" id="newIpInput" class="form-control" placeholder="예: 192.168.0.1">
                    </div>
                    <div class="col-md-5">
                        <label class="form-label small text-muted mb-1">비고 (선택)</label>
                        <input type="text" id="newDescInput" class="form-control" placeholder="예: 관리자 자택, 메인 노트북"
                               onkeypress="if(event.keyCode==13) addIp();">
                    </div>
                    <div class="col-md-2 d-flex align-items-end mt-4">
                        <button class="btn btn-primary w-100" type="button" onclick="addIp()">
                            <i class="bi bi-plus-lg"></i> 추가
                        </button>
                    </div>
                </div>

                <h6 class="fw-bold mb-3"><i class="bi bi-list-check"></i> 등록된 IP 목록</h6>
                <div class="list-group" id="ipListContainer">
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>

<script>
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");

    // 1. 모달 열기 및 초기화
    function openIpModal(admSeq, admId) {
        $('#targetAdmSeq').val(admSeq);
        $('#modalAdmId').text(admId);
        $('#newIpInput').val('');
        $('#newDescInput').val(''); // 비고 초기화

        loadIpList(admSeq);

        var modal = new bootstrap.Modal(document.getElementById('ipModal'));
        modal.show();
    }

    // 2. IP 목록 불러오기 (AJAX) - 비고란 추가
    function loadIpList(admSeq) {
        $.ajax({
            url: '/mng/admin/ip/api/list',
            type: 'GET',
            data: {admSeq: admSeq},
            success: function (list) {
                var html = '';
                if (list.length === 0) {
                    html = '<div class="text-center text-muted py-5 border rounded bg-light">등록된 허용 IP가 없습니다.<br><small class="text-danger mt-1 d-block">※ 등록된 IP가 없으면 모든 위치에서 접근이 차단될 수 있습니다.</small></div>';
                } else {
                    $.each(list, function (index, ip) {
                        // 비고가 null이거나 비어있으면 '-' 표시
                        var descText = (ip.description && ip.description.trim() !== '') ? ip.description : '<span class="text-muted">-</span>';

                        html += '<div class="list-group-item d-flex justify-content-between align-items-center py-3">';
                        html += '  <div>';
                        html += '    <h5 class="mb-1 text-primary fw-bold font-monospace">' + ip.allowIp + '</h5>';
                        html += '    <small class="text-muted d-block"><i class="bi bi-tag-fill me-1"></i>비고: ' + descText + '</small>';
                        html += '  </div>';
                        html += '  <button class="btn btn-sm btn-outline-danger" onclick="deleteIp(' + ip.ipSeq + ', ' + admSeq + ')"><i class="bi bi-trash3"></i> 삭제</button>';
                        html += '</div>';
                    });
                }
                $('#ipListContainer').html(html);
            },
            error: function () {
                alert("IP 목록을 불러오는데 실패했습니다.");
            }
        });
    }

    // 3. IP 추가하기 (AJAX) - 데이터에 비고 포함
    function addIp() {
        var admSeq = $('#targetAdmSeq').val();
        var allowIp = $.trim($('#newIpInput').val());
        var description = $.trim($('#newDescInput').val());

        if (allowIp === '') {
            alert('추가할 IP 주소를 입력해주세요.');
            $('#newIpInput').focus();
            return;
        }

        // 간단한 IP 정규식 검증 (선택적용)
        var ipPattern = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
        if (!ipPattern.test(allowIp) && allowIp !== '127.0.0.1' && allowIp !== '0:0:0:0:0:0:0:1') {
            if (!confirm('표준 IPv4 형식이 아닙니다. 그래도 등록하시겠습니까?')) {
                return;
            }
        }

        $.ajax({
            url: '/mng/admin/ip/api/add',
            type: 'POST',
            beforeSend: function (xhr) {
                if (csrfHeader && csrfToken) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            },
            // 비고(description) 데이터 함께 전송
            data: {admSeq: admSeq, allowIp: allowIp, description: description},
            success: function (res) {
                $('#newIpInput').val('');
                $('#newDescInput').val('');
                loadIpList(admSeq);
            },
            error: function (xhr) {
                alert(xhr.responseText || "IP 등록 중 오류가 발생했습니다.");
            }
        });
    }

    // 4. IP 삭제하기 (AJAX)
    function deleteIp(ipSeq, admSeq) {
        if (confirm('해당 IP의 접근을 차단(삭제)하시겠습니까?')) {
            $.ajax({
                url: '/mng/admin/ip/api/delete',
                type: 'POST',
                beforeSend: function (xhr) {
                    if (csrfHeader && csrfToken) {
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    }
                },
                data: {ipSeq: ipSeq},
                success: function (res) {
                    loadIpList(admSeq);
                },
                error: function () {
                    alert("IP 삭제 중 오류가 발생했습니다.");
                }
            });
        }
    }
</script>