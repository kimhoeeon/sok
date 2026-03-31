<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="main" scope="request" />
<%@ include file="layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-5">
    <div>
        <h3 class="fw-bold text-white mb-1">대시보드</h3>
        <span class="text-muted">SOK 홈페이지 통합 통계 현황</span>
    </div>
</div>

<div class="row g-4 mb-5">
    <div class="col-md-3">
        <div class="premium-dark-card p-4 h-100 d-flex flex-column justify-content-center position-relative overflow-hidden">
            <div class="position-absolute opacity-25" style="right: -10px; bottom: -15px;">
                <i class="bi bi-person-check-fill" style="font-size: 6rem; color: #444;"></i>
            </div>
            <span class="text-muted fw-bold mb-2">당일 순 방문자 (명)</span>
            <h2 class="text-white fw-bolder m-0 neon-text">2,136</h2>
        </div>
    </div>
    <div class="col-md-3">
        <div class="premium-dark-card p-4 h-100 d-flex flex-column justify-content-center position-relative overflow-hidden">
            <div class="position-absolute opacity-25" style="right: -10px; bottom: -15px;">
                <i class="bi bi-people-fill" style="font-size: 6rem; color: #444;"></i>
            </div>
            <span class="text-muted fw-bold mb-2">당일 총 방문자 (명)</span>
            <h2 class="text-white fw-bolder m-0">4,565</h2>
        </div>
    </div>
    <div class="col-md-3">
        <div class="premium-dark-card p-4 h-100 d-flex flex-column justify-content-center position-relative overflow-hidden">
            <div class="position-absolute opacity-25" style="right: -10px; bottom: -15px;">
                <i class="bi bi-heart-fill" style="font-size: 6rem; color: #ff99e2;"></i>
            </div>
            <span class="text-muted fw-bold mb-2">누적 후원자 (명)</span>
            <h2 class="fw-bolder m-0" style="color: #ff99e2;">125</h2>
        </div>
    </div>
    <div class="col-md-3">
        <div class="premium-dark-card p-4 h-100 d-flex flex-column justify-content-center position-relative overflow-hidden">
            <div class="position-absolute opacity-25" style="right: -10px; bottom: -15px;">
                <i class="bi bi-piggy-bank-fill" style="font-size: 6rem; color: #e61938;"></i>
            </div>
            <span class="text-muted fw-bold mb-2">누적 후원액 (원)</span>
            <h2 class="fw-bolder m-0" style="color: #e61938;">125,000,000</h2>
        </div>
    </div>
</div>

<div class="row g-4">
    <div class="col-md-6">
        <div class="premium-dark-card p-5 h-100">
            <h5 class="fw-bold mb-4 text-white"><i class="bi bi-graph-up-arrow me-2 text-success"></i> 상위 조회 페이지 TOP 5</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th width="15%" class="text-white border-bottom border-secondary">순위</th>
                            <th class="text-white border-bottom border-secondary">페이지명</th>
                            <th width="20%" class="text-white border-bottom border-secondary text-end">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="border-secondary"><span class="badge bg-danger">1</span></td>
                            <td class="text-white fw-bold border-secondary">홈 (Home)</td>
                            <td class="text-end pe-4 border-secondary">1,245</td>
                        </tr>
                        <tr>
                            <td class="border-secondary"><span class="badge bg-warning text-dark">2</span></td>
                            <td class="text-white fw-bold border-secondary">함께하는 사람들</td>
                            <td class="text-end pe-4 border-secondary">982</td>
                        </tr>
                        <tr>
                            <td class="border-secondary"><span class="badge bg-secondary">3</span></td>
                            <td class="text-white fw-bold border-secondary">후원하기</td>
                            <td class="text-end pe-4 border-secondary">843</td>
                        </tr>
                        <tr>
                            <td class="border-secondary"><span class="badge" style="background-color:#2b2b40;">4</span></td>
                            <td class="text-white fw-bold border-secondary">공지사항</td>
                            <td class="text-end pe-4 border-secondary">512</td>
                        </tr>
                        <tr>
                            <td class="border-secondary"><span class="badge" style="background-color:#2b2b40;">5</span></td>
                            <td class="text-white fw-bold border-secondary">자원봉사 신청</td>
                            <td class="text-end pe-4 border-secondary">420</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="premium-dark-card p-5 h-100 glassmorphism-box border-0" style="background: linear-gradient(145deg, rgba(30,30,45,0.8) 0%, rgba(21,21,33,0.9) 100%);">
            <h5 class="fw-bold mb-4 text-white"><i class="bi bi-cpu me-2 text-info"></i> 시스템 상태</h5>
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-circle-fill text-success me-3" style="font-size: 10px; text-shadow: 0 0 10px #39ff14;"></i>
                <div class="flex-grow-1">
                    <span class="fw-bold text-white d-block">서버 연결 상태</span>
                    <span class="text-muted fs-7">정상 가동 중 (Uptime: 45 Days)</span>
                </div>
            </div>
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-circle-fill text-success me-3" style="font-size: 10px; text-shadow: 0 0 10px #39ff14;"></i>
                <div class="flex-grow-1">
                    <span class="fw-bold text-white d-block">DB 통신 상태</span>
                    <span class="text-muted fs-7">응답 속도: 12ms</span>
                </div>
            </div>
            <div class="d-flex align-items-center">
                <i class="bi bi-circle-fill text-success me-3" style="font-size: 10px; text-shadow: 0 0 10px #39ff14;"></i>
                <div class="flex-grow-1">
                    <span class="fw-bold text-white d-block">토스페이먼츠 연동</span>
                    <span class="text-muted fs-7">정상 연결됨</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="layout/footer.jsp" %>