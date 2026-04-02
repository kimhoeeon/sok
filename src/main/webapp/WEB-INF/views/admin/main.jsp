<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentMenu" value="main" scope="request" />
<%@ include file="layout/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<div class="row align-items-center mb-4">
    <div class="col-md-8">
        <h3 class="fw-bold text-white mb-1">통합 운영 현황</h3>
        <p class="text-muted mb-0">SOK 공식 홈페이지의 데이터 및 시스템 상태를 실시간으로 확인합니다.</p>
    </div>
    <div class="col-md-4 text-end">
        <div class="d-inline-flex align-items-center p-2 px-3 rounded glassmorphism-box border border-danger" style="transform: scale(0.9); transform-origin: right;">
            <i class="bi bi-exclamation-octagon text-danger me-2"></i>
            <span class="text-muted me-2" style="font-size: 12px;">미처리 유지보수 티켓</span>
            <span class="text-danger fw-bold fs-5">${summary.waitTicketCnt}</span>
        </div>
    </div>
</div>

<div class="row g-3 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="premium-dark-card p-4 h-100 border-0 shadow-sm">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <span class="text-muted d-block mb-1" style="font-size: 13px;">오늘 방문자</span>
                    <h2 class="text-success fw-bold mb-0"><fmt:formatNumber value="${summary.todayVisitor}" pattern="#,###"/> <small class="fs-6 opacity-50">명</small></h2>
                </div>
                <div class="p-3 bg-success bg-opacity-10 rounded-circle"><i class="bi bi-person-walking text-success fs-3"></i></div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="premium-dark-card p-4 h-100 border-0 shadow-sm">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <span class="text-muted d-block mb-1" style="font-size: 13px;">누적 방문자</span>
                    <h2 class="text-white fw-bold mb-0"><fmt:formatNumber value="${summary.totalVisitor}" pattern="#,###"/> <small class="fs-6 opacity-50">명</small></h2>
                </div>
                <div class="p-3 bg-secondary bg-opacity-25 rounded-circle"><i class="bi bi-people-fill text-light fs-3"></i></div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="premium-dark-card p-4 h-100 border-0 shadow-sm">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <span class="text-muted d-block mb-1" style="font-size: 13px;">누적 후원자</span>
                    <h2 class="text-primary fw-bold mb-0"><fmt:formatNumber value="${summary.totalDonorCnt}" pattern="#,###"/> <small class="fs-6 opacity-50">명</small></h2>
                </div>
                <div class="p-3 bg-primary bg-opacity-10 rounded-circle"><i class="bi bi-person-heart text-primary fs-3"></i></div>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="premium-dark-card p-4 h-100 border-0 shadow-sm">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <span class="text-muted d-block mb-1" style="font-size: 13px;">누적 후원액</span>
                    <h2 class="fw-bold mb-0" style="color: #ff99e2;"><fmt:formatNumber value="${summary.totalDonationAmt}" pattern="#,###"/> <small class="fs-6 opacity-50">원</small></h2>
                </div>
                <div class="p-3 bg-danger bg-opacity-10 rounded-circle"><i class="bi bi-piggy-bank-fill text-danger fs-3"></i></div>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-xl-8">
        <div class="premium-dark-card p-4 h-100">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold text-white m-0"><i class="bi bi-activity me-2 text-success"></i>방문자 현황</h5>
                <div class="btn-group btn-group-sm shadow-sm">
                    <button type="button" class="btn btn-outline-secondary active" onclick="loadVisitorChart('DAY', this)">일별</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="loadVisitorChart('WEEK', this)">주별</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="loadVisitorChart('MONTH', this)">월별</button>
                </div>
            </div>
            <div id="visitorLineChart" style="height: 320px;"></div>
        </div>
    </div>

    <div class="col-xl-4">
        <div class="premium-dark-card p-4 h-100 d-flex flex-column">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-fire me-2 text-danger"></i>인기 페이지 TOP 5</h5>
            <div class="list-group list-group-flush bg-transparent mt-2 flex-grow-1 d-flex flex-column">
                <c:choose>
                    <c:when test="${empty topPages}">
                        <div class="d-flex flex-grow-1 justify-content-center align-items-center text-muted" style="min-height: 250px;">
                            <div class="text-center">
                                <i class="bi bi-bar-chart-line fs-1 d-block mb-2 opacity-50"></i>
                                조회된 통계 데이터가 없습니다.
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="page" items="${topPages}" varStatus="status">
                            <div class="list-group-item bg-transparent border-secondary border-opacity-25 d-flex justify-content-between align-items-center px-0 py-3">
                                <div class="text-truncate" style="max-width: 75%;">
                                    <span class="badge bg-dark text-muted me-2" style="width: 25px;">${status.count}</span>
                                    <span class="text-white" style="font-size: 14px;">${page.TITLE}</span>
                                </div>
                                <span class="badge bg-secondary rounded-pill fw-normal" style="font-size: 11px;">${page.VIEW_CNT} Hit</span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-xl-8">
        <div class="premium-dark-card p-4 h-100">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold text-white m-0"><i class="bi bi-journal-check me-2 text-warning"></i>신청/참여 현황</h5>
                <div class="btn-group btn-group-sm">
                    <button type="button" class="btn btn-outline-secondary active" onclick="loadApplyChart('DAY', this)">일별</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="loadApplyChart('WEEK', this)">주별</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="loadApplyChart('MONTH', this)">월별</button>
                </div>
            </div>
            <div id="applyBarChart" style="height: 320px;"></div>
        </div>
    </div>

    <div class="col-xl-4">
        <div class="premium-dark-card p-4 h-100 d-flex flex-column">
            <h5 class="fw-bold text-white mb-4"><i class="bi bi-server me-2 text-info"></i>JVM & 웹 서버 상태</h5>

            <div class="text-center mb-4 p-3 rounded" style="background: rgba(57, 255, 20, 0.05); border: 1px dashed rgba(57, 255, 20, 0.2);">
                <span class="text-success d-block mb-1" style="font-size: 12px;"><i class="bi bi-broadcast me-1"></i>System Live Time</span>
                <h3 class="text-white fw-bold m-0" id="liveServerTime" style="letter-spacing: 2px;">00:00:00</h3>
                <span class="text-muted" style="font-size: 11px;" id="liveServerDate">YYYY-MM-DD</span>
            </div>

            <div class="mb-4 p-4 rounded flex-grow-1 d-flex flex-column justify-content-center" style="background: rgba(0,0,0,0.2);">
                <div class="d-flex justify-content-between mb-3 border-bottom border-secondary pb-3">
                    <span class="text-muted" style="font-size: 13px;">호스팅 환경</span>
                    <span class="text-white fw-bold" style="font-size: 13px;">Cafe24 Tomcat JSP</span>
                </div>
                <div class="d-flex justify-content-between mb-3 border-bottom border-secondary pb-3">
                    <span class="text-muted" style="font-size: 13px;">DB 연결상태</span>
                    <c:choose>
                        <c:when test="${dbStatus}">
                            <span class="text-success fw-bold" style="font-size: 13px;"><i class="bi bi-check-circle-fill me-1"></i>정상 (Active)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger fw-bold" style="font-size: 13px;"><i class="bi bi-x-circle-fill me-1"></i>연결 실패</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex justify-content-between mb-3 border-bottom border-secondary pb-3">
                    <span class="text-muted" style="font-size: 13px;">서버 구동 시간</span>
                    <span class="text-warning fw-bold" style="font-size: 13px;"><i class="bi bi-clock-history me-1"></i>${jvmUptime}</span>
                </div>
                <div class="d-flex justify-content-between">
                    <span class="text-muted" style="font-size: 13px;">Java 버전</span>
                    <span class="text-info fw-bold" style="font-size: 13px;">v ${javaVersion}</span>
                </div>
            </div>

            <div class="mt-auto pt-2">
                <div class="d-flex justify-content-between mb-2">
                    <label class="text-muted" style="font-size: 12px;"><i class="bi bi-memory me-1"></i>자바 힙 메모리 (JVM Memory)</label>
                    <span class="text-white fw-bold" style="font-size: 12px;">${jvmUsage}% (${jvmUsedMB}MB / ${jvmTotalMB}MB)</span>
                </div>
                <div class="progress" style="height: 12px; background: rgba(255,255,255,0.05); border-radius: 6px;">
                    <div class="progress-bar bg-info progress-bar-striped progress-bar-animated" style="width: ${jvmUsage}%"></div>
                </div>
                <small class="text-muted d-block mt-3 lh-base" style="font-size: 11.5px;">※ 공용 서버의 전체 리소스가 아닌, 현재 SOK 애플리케이션(JVM)에 할당된 실제 메모리 기준입니다.</small>
            </div>
        </div>
    </div>
</div>

<div class="premium-dark-card p-4 mb-0 shadow-sm">
    <h5 class="fw-bold text-white mb-4"><i class="bi bi-lightning-charge-fill me-2 text-warning"></i>빠른 업무 이동 (Quick Links)</h5>
    <div class="row g-3 text-center">
        <c:set var="links" value="notice,sponsor/donate,volunteer,certificate,popup,dev" />
        <c:set var="linkNames" value="공지 등록,후원 관리,봉사 관리,증명서 발급,팝업 설정,유지보수" />
        <c:set var="linkIcons" value="megaphone,credit-card,person-check,file-earmark-check,window-stack,headset" />

        <c:forTokens items="${links}" delims="," var="link" varStatus="st">
            <div class="col-lg-2 col-md-4 col-6">
                <a href="/admin/${link}/list" class="d-block p-4 rounded glassmorphism-box text-decoration-none hover-glow transition-all">
                    <i class="bi bi-${linkIcons.split(',')[st.index]} fs-1 d-block mb-2 text-white"></i>
                    <span class="text-muted" style="font-size: 13px;">${linkNames.split(',')[st.index]}</span>
                </a>
            </div>
        </c:forTokens>
    </div>
</div>

<script>
    var visitorChart, applyChart;

    document.addEventListener("DOMContentLoaded", function () {
        initCharts();
        loadVisitorChart('DAY');
        loadApplyChart('DAY');

        // ★ 실시간 시계 구동 스크립트
        setInterval(updateLiveTime, 1000);
        updateLiveTime();
    });

    // ★ 실시간 시계 업데이트 함수
    function updateLiveTime() {
        const now = new Date();
        const timeStr = String(now.getHours()).padStart(2, '0') + ':' +
                        String(now.getMinutes()).padStart(2, '0') + ':' +
                        String(now.getSeconds()).padStart(2, '0');
        const dateStr = now.getFullYear() + '년 ' +
                        String(now.getMonth() + 1).padStart(2, '0') + '월 ' +
                        String(now.getDate()).padStart(2, '0') + '일';

        const timeEl = document.getElementById('liveServerTime');
        const dateEl = document.getElementById('liveServerDate');
        if(timeEl) timeEl.innerText = timeStr;
        if(dateEl) dateEl.innerText = dateStr;
    }

    function initCharts() {
        var commonOptions = {
            chart: { height: 320, toolbar: {show:false}, background:'transparent' },
            theme: { mode: 'dark' },
            noData: {
                text: '수집된 통계 데이터가 없습니다.',
                align: 'center', verticalAlign: 'middle',
                style: { color: '#a1a5b7', fontSize: '14px' }
            }
        };

        visitorChart = new ApexCharts(document.querySelector("#visitorLineChart"), {
            ...commonOptions,
            series: [],
            chart: { ...commonOptions.chart, type: 'area' },
            colors: ['#39ff14'],
            stroke: { curve: 'smooth', width: 3 },
            fill: { type: 'gradient', gradient: { shadeIntensity: 1, opacityFrom: 0.3, opacityTo: 0.05 } }
        });
        visitorChart.render();

        applyChart = new ApexCharts(document.querySelector("#applyBarChart"), {
            ...commonOptions,
            series: [],
            chart: { ...commonOptions.chart, type: 'bar', stacked: false },
            colors: ['#ff99e2', '#009ef7'],
            plotOptions: { bar: { borderRadius: 4, columnWidth: '45%' } }
        });
        applyChart.render();
    }

    function loadVisitorChart(period, btn) {
        if(btn) setActive(btn);
        $.get("/admin/api/stats/visitor?period=" + period, function(data) {
            if(!data || data.length === 0) {
                visitorChart.updateSeries([]);
            } else {
                visitorChart.updateSeries([{ name: '방문자 수', data: data.map(item => item.cnt || item.CNT) }]);
                visitorChart.updateOptions({ xaxis: { categories: data.map(item => item.label || item.LABEL) } });
            }
        });
    }

    function loadApplyChart(period, btn) {
        if(btn) setActive(btn);
        $.get("/admin/api/stats/apply?period=" + period, function(data) {
            if(!data || data.length === 0) {
                applyChart.updateSeries([]);
            } else {
                applyChart.updateSeries([
                    { name: '후원 신청', data: data.map(item => item.donateCnt || item.DONATECNT) },
                    { name: '자원봉사 신청', data: data.map(item => item.volCnt || item.VOLCNT) }
                ]);
                applyChart.updateOptions({ xaxis: { categories: data.map(item => item.label || item.LABEL) } });
            }
        });
    }

    function setActive(btn) {
        $(btn).parent().find('.btn').removeClass('active');
        $(btn).addClass('active');
    }
</script>

<%@ include file="layout/footer.jsp" %>