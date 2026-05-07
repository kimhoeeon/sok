<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 사이드바 전용 추가 스타일 */
    .sidebar { width: 260px; flex-shrink: 0; overflow-y: auto; }
    .sidebar::-webkit-scrollbar { width: 5px; }
    .sidebar::-webkit-scrollbar-thumb { background-color: rgba(255,255,255,0.15); border-radius: 10px; }

    /* 1 Depth 메뉴 폰트 */
    .sidebar-menu .nav-link { color: #a1a5b7; padding: 10px 15px; border-radius: 8px; font-size: 14px; font-weight: 500; transition: all 0.3s; margin-bottom: 2px; }
    .sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active { background: rgba(255,255,255,0.05); color: #fff; }
    /* 활성화된 메뉴의 아이콘 색상도 화이트로 차분하게 변경 */
    .sidebar-menu .nav-link.active i { color: #ffffff; text-shadow: 0 0 8px rgba(255, 255, 255, 0.4); }

    /* 2~3 Depth 하위 메뉴 폰트 */
    .collapse-menu { padding-left: 20px; }
    .collapse-menu .nav-link { font-size: 13px; font-weight: 400; padding: 8px 15px; margin-bottom: 2px; }
    .collapse-menu-depth3 { padding-left: 15px; }
</style>

<div class="sidebar premium-dark-card d-flex flex-column p-3 border-end" style="border-color: rgba(255,255,255,0.05) !important; border-radius: 0;">

    <div class="text-center mb-4 mt-3 pb-3 border-bottom" style="border-color: rgba(255,255,255,0.05) !important;">
        <h4 class="fw-bold m-0 text-white" style="letter-spacing: 1px;">
            <i class="bi bi-lightning-charge-fill neon-icon fs-3"></i> SOK ADMIN
        </h4>
    </div>

    <ul class="nav flex-column mb-auto sidebar-menu gap-1">

        <li class="nav-item">
            <a class="nav-link ${param.menuId eq 'main' ? 'active' : ''}" href="/admin/main">
                <i class="bi bi-speedometer2 me-2"></i> 방문 통계 대시보드
            </a>
        </li>

        <li class="nav-item mt-2">
            <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#collapseMenuManage" role="button" aria-expanded="true">
                <span><i class="bi bi-grid me-2"></i> 메뉴별 관리</span>
                <i class="bi bi-chevron-down" style="font-size: 12px;"></i>
            </a>
            <div class="collapse collapse-menu show" id="collapseMenuManage">
                <a class="nav-link ${param.menuId eq 'people' ? 'active text-white' : ''}" href="/admin/people/list">함께하는 사람들 관리</a>
                <a class="nav-link ${param.menuId eq 'notice' ? 'active text-white' : ''}" href="/admin/notice/list">공지사항 관리</a>
                <a class="nav-link ${param.menuId eq 'news' ? 'active text-white' : ''}" href="/admin/news/list">보도자료 관리</a>
                <a class="nav-link ${param.menuId eq 'management' ? 'active text-white' : ''}" href="/admin/management/list">경영공시 관리</a>
                <a class="nav-link ${param.menuId eq 'bidding' ? 'active text-white' : ''}" href="/admin/bidding/list">입찰정보 관리</a>
                <a class="nav-link ${param.menuId eq 'report' ? 'active text-white' : ''}" href="/admin/report/list">활동보고서 관리</a>
            </div>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#collapseHomeManage" role="button" aria-expanded="true">
                <span><i class="bi bi-pc-display me-2"></i> 홈페이지 관리</span>
                <i class="bi bi-chevron-down" style="font-size: 12px;"></i>
            </a>
            <div class="collapse collapse-menu show" id="collapseHomeManage">
                <a class="nav-link ${param.menuId eq 'popup' ? 'active text-white' : ''}" href="/admin/popup/list">팝업 관리</a>
                <a class="nav-link ${param.menuId eq 'dev' ? 'active text-white' : ''}" href="/admin/dev/list">홈페이지 요청/문의 관리</a>
            </div>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#collapseJoinManage" role="button" aria-expanded="true">
                <span><i class="bi bi-clipboard-check me-2"></i> 신청·참여 관리</span>
                <i class="bi bi-chevron-down" style="font-size: 12px;"></i>
            </a>
            <div class="collapse collapse-menu show" id="collapseJoinManage">

                <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#collapseSponsor" role="button" aria-expanded="true">
                    <span>후원 관리</span>
                    <i class="bi bi-chevron-down" style="font-size: 10px;"></i>
                </a>
                <div class="collapse collapse-menu-depth3 show" id="collapseSponsor">
                    <a class="nav-link ${param.menuId eq 'sponsor_member' ? 'active text-white' : ''}" href="/admin/sponsor/member/list">- 가입자 목록</a>
                    <a class="nav-link ${param.menuId eq 'sponsor_donate' ? 'active text-white' : ''}" href="/admin/sponsor/donate/list">- 기부금 목록</a>
                    <a class="nav-link ${param.menuId eq 'sponsor_campaign' ? 'active text-white' : ''}" href="/admin/campaign/list">- 기부 캠페인 관리</a>
                </div>

                <a class="nav-link ${param.menuId eq 'volunteer' ? 'active text-white' : ''}" href="/admin/volunteer/list">자원봉사 관리</a>
                <a class="nav-link ${param.menuId eq 'certificate' ? 'active text-white' : ''}" href="/admin/certificate/list">증명서 신청 관리</a>
            </div>
        </li>
    </ul>

    <div class="mt-4 pt-3 border-top" style="border-color: rgba(255,255,255,0.05) !important;">
        <a class="nav-link d-flex align-items-center text-danger hover-glow p-2" href="/admin/logout" style="border-radius: 8px; background: rgba(230, 25, 56, 0.1); transition: 0.3s;">
            <i class="bi bi-box-arrow-right fs-5 me-2"></i>
            <span class="fw-bold">로그아웃</span>
        </a>
    </div>
</div>