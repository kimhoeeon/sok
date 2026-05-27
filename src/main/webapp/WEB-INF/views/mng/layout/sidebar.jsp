<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 사이드바 전용 추가 스타일 */
    .sidebar { width: 260px; flex-shrink: 0; overflow-y: auto; }
    .sidebar::-webkit-scrollbar { width: 5px; }
    .sidebar::-webkit-scrollbar-thumb { background-color: rgba(0,0,0,0.15); border-radius: 10px; } /* [수정됨] 스크롤바 색상 반전 */

    /* 1 Depth 메뉴 폰트 */
    .sidebar-menu .nav-link { color: #4b5675; padding: 10px 15px; border-radius: 8px; font-size: 14px; font-weight: 500; transition: all 0.3s; margin-bottom: 2px; } /* [수정됨] 기본 글자색 다크 그레이 */
    .sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active { background: rgba(0,0,0,0.05); color: #000; } /* [수정됨] 호버/액티브 시 연한 회색 배경과 검은 글자 */
    /* 활성화된 메뉴의 아이콘 색상 변경 */
    .sidebar-menu .nav-link.active i { color: #009ef7; text-shadow: none; } /* [수정됨] 아이콘 색상 포인트 컬러로 변경 및 그림자 제거 */

    /* 2 Depth 하위 메뉴 */
    .collapse-menu { padding-left: 10px; margin-top: 2px; margin-bottom: 5px; }
    .collapse-menu .nav-link { color: #6c757d; font-size: 13.5px; padding: 8px 15px 8px 30px; position: relative; } /* [수정됨] 하위 메뉴 글자색 반전 */
    .collapse-menu .nav-link::before { content: ''; position: absolute; left: 15px; top: 50%; transform: translateY(-50%); width: 4px; height: 4px; border-radius: 50%; background-color: #ced4da; } /* [수정됨] 불릿 점 색상 반전 */
    .collapse-menu .nav-link:hover, .collapse-menu .nav-link.active { color: #009ef7; background: transparent; } /* [수정됨] 액티브 글자색 반전 */
    .collapse-menu .nav-link.active::before { background-color: #009ef7; width: 6px; height: 6px; }

    /* 3 Depth 하위 메뉴 */
    .collapse-menu-depth3 { padding-left: 20px; margin-top: 2px; margin-bottom: 5px; }
    .collapse-menu-depth3 .nav-link { color: #8a90a5; font-size: 13px; padding: 6px 15px 6px 30px; position: relative; } /* [수정됨] 글자색 반전 */
    .collapse-menu-depth3 .nav-link:hover, .collapse-menu-depth3 .nav-link.active { color: #009ef7; background: transparent; font-weight: 600; } /* [수정됨] 액티브 글자색 반전 */

    /* 드롭다운 화살표 애니메이션 */
    .sidebar-menu .nav-link[data-bs-toggle="collapse"] { display: flex; justify-content: space-between; align-items: center; }
    .sidebar-menu .nav-link[data-bs-toggle="collapse"] i.bi-chevron-down { transition: transform 0.3s; }
    .sidebar-menu .nav-link[data-bs-toggle="collapse"][aria-expanded="true"] i.bi-chevron-down { transform: rotate(-180deg); }
</style>

<div class="sidebar premium-card d-flex flex-column p-3 border-end" style="border-color: rgba(255,255,255,0.05) !important; border-radius: 0;">

    <div class="text-center mb-4 mt-3 pb-3 border-bottom" style="border-color: rgba(255,255,255,0.05) !important;">
        <h4 class="fw-bold m-0 text-dark" style="letter-spacing: 1px;">
            <i class="bi bi-lightning-charge-fill neon-icon fs-3"></i> SOK ADMIN
        </h4>
    </div>

    <ul class="nav flex-column mb-auto sidebar-menu gap-1">

        <li class="nav-item">
            <a class="nav-link ${param.menuId eq 'main' ? 'active' : ''}" href="/mng/main">
                <i class="bi bi-speedometer2 me-2"></i> 방문 통계 대시보드
            </a>
        </li>

        <li class="nav-item mt-2">
            <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#collapseMenuManage" role="button" aria-expanded="true">
                <span><i class="bi bi-grid me-2"></i> 메뉴별 관리</span>
                <i class="bi bi-chevron-down" style="font-size: 12px;"></i>
            </a>
            <div class="collapse collapse-menu show" id="collapseMenuManage">
                <a class="nav-link ${param.menuId eq 'people' ? 'active text-dark' : ''}" href="/mng/people/list">SOK 스토리 관리</a>
                <a class="nav-link ${param.menuId eq 'notice' ? 'active text-dark' : ''}" href="/mng/notice/list">공지사항 관리</a>
                <a class="nav-link ${param.menuId eq 'bidding' ? 'active text-dark' : ''}" href="/mng/bidding/list">입찰정보 관리</a>
                <a class="nav-link ${param.menuId eq 'careers' ? 'active text-dark' : ''}" href="/mng/careers/list">채용정보 관리</a>
                <a class="nav-link ${param.menuId eq 'press' ? 'active text-dark' : ''}" href="/mng/press/list">자료실 관리</a>
                <a class="nav-link ${param.menuId eq 'report' ? 'active text-dark' : ''}" href="/mng/report/list">활동보고서 관리</a>
                <a class="nav-link ${param.menuId eq 'news' ? 'active text-dark' : ''}" href="/mng/news/list">SOK 소식 관리</a>
                <a class="nav-link ${param.menuId eq 'management' ? 'active text-dark' : ''}" href="/mng/management/list">운영자료 관리</a>
            </div>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" href="#collapseHomeManage" role="button" aria-expanded="true">
                <span><i class="bi bi-pc-display me-2"></i> 홈페이지 관리</span>
                <i class="bi bi-chevron-down" style="font-size: 12px;"></i>
            </a>
            <div class="collapse collapse-menu show" id="collapseHomeManage">
                <a class="nav-link ${param.menuId eq 'popup' ? 'active text-dark' : ''}" href="/mng/popup/list">팝업 관리</a>
                <a class="nav-link ${param.menuId eq 'dev' ? 'active text-dark' : ''}" href="/mng/dev/list">홈페이지 요청/문의 관리</a>
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
                    <a class="nav-link ${param.menuId eq 'sponsor_member' ? 'active text-dark' : ''}" href="/mng/sponsor/member/list">- 가입자 목록</a>
                    <a class="nav-link ${param.menuId eq 'sponsor_donate' ? 'active text-dark' : ''}" href="/mng/sponsor/donate/list">- 기부금 목록</a>
                    <a class="nav-link ${param.menuId eq 'sponsor_campaign' ? 'active text-dark' : ''}" href="/mng/campaign/list">- 기부 캠페인 관리</a>
                </div>

                <a class="nav-link ${param.menuId eq 'volunteer' ? 'active text-dark' : ''}" href="/mng/volunteer/list">자원봉사 관리</a>
                <a class="nav-link ${param.menuId eq 'certificate' ? 'active text-dark' : ''}" href="/mng/certificate/list">증명서 신청 관리</a>
            </div>
        </li>
    </ul>

    <div class="mt-4 pt-3 border-top" style="border-color: rgba(255,255,255,0.05) !important;">
        <a class="nav-link d-flex align-items-center text-danger hover-glow p-2" href="#" onclick="event.preventDefault(); document.getElementById('adminLogoutForm').submit();" style="border-radius: 8px; background: rgba(230, 25, 56, 0.1); transition: 0.3s; cursor: pointer;">
            <i class="bi bi-box-arrow-right fs-5 me-2"></i>
            <span class="fw-bold">로그아웃</span>
        </a>
    </div>
</div>

<form id="adminLogoutForm" action="/mng/logout" method="post" style="display: none;">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>