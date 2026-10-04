<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, com.smartcanteen.dao.UserDAO" %>
<%
    String currentRole = (String) session.getAttribute("userRole");
    if (session.getAttribute("user") == null && currentRole == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=admin_only&redirect=admin-dashboard.jsp");
        return;
    }
    if (currentRole != null && !"Admin".equalsIgnoreCase(currentRole)) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp?error=unauthorized_admin");
        return;
    }

    UserDAO userDAO = new UserDAO();
    List<Map<String, String>> loginLogs = userDAO.getRecentLogins(8);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Canteen Governance, Rules &amp; Staff Job Roles | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">

    <style>
        /* =========================================================
           CLEAN, MINIMAL & PROFESSIONAL ADMIN DASHBOARD STYLES
           ========================================================= */
        :root {
            --admin-bg: #0B0E14;
            --admin-surface: #131722;
            --admin-surface-hover: #181D2B;
            --admin-border: #1F2638;
            --admin-border-subtle: #192030;
            --admin-border-hover: #313D57;
            --admin-text-main: #F1F5F9;
            --admin-text-muted: #8491A5;
            --admin-text-subtle: #576479;
            --admin-amber: #F59E0B;
            --admin-amber-bg: rgba(245, 158, 11, 0.08);
            --admin-amber-border: rgba(245, 158, 11, 0.25);
            --admin-blue: #60A5FA;
            --admin-blue-bg: rgba(96, 165, 250, 0.08);
            --admin-green: #34D399;
            --admin-green-bg: rgba(52, 211, 153, 0.08);
            --admin-red: #F87171;
            --admin-red-bg: rgba(248, 113, 113, 0.08);
        }

        html {
            scroll-behavior: smooth;
        }

        .dashboard-body {
            max-width: 1320px;
            width: 100%;
            margin: 0 auto;
            padding: 28px 32px 48px;
            display: flex;
            flex-direction: column;
            gap: 32px;
        }

        /* Topbar styling */
        .admin-topbar {
            height: 72px;
            background: rgba(18, 22, 31, 0.9);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--admin-border);
            padding: 0 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .admin-topbar-title h2 {
            font-family: var(--font-heading);
            font-size: 19px;
            font-weight: 700;
            color: var(--admin-text-main);
            margin: 0;
            letter-spacing: -0.3px;
        }

        .admin-topbar-title p {
            font-size: 13px;
            color: var(--admin-text-muted);
            margin: 2px 0 0;
        }

        .admin-topbar-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* KPI Summary Grid */
        .admin-stat-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
        }

        .admin-stat-card {
            background: var(--admin-surface);
            border: 1px solid var(--admin-border);
            border-radius: 12px;
            padding: 18px 20px;
            display: flex;
            flex-direction: column;
            gap: 6px;
            transition: border-color 0.2s ease, transform 0.2s ease;
        }

        .admin-stat-card:hover {
            border-color: var(--admin-border-hover);
            transform: translateY(-1px);
        }

        .admin-stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-stat-label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: var(--admin-text-muted);
        }

        .admin-stat-icon-sm {
            font-size: 16px;
            opacity: 0.85;
        }

        .admin-stat-value {
            font-size: 22px;
            font-weight: 700;
            font-family: var(--font-heading);
            color: var(--admin-text-main);
            letter-spacing: -0.5px;
            margin: 2px 0;
        }

        .admin-stat-sub {
            font-size: 12px;
            color: var(--admin-text-subtle);
        }

        /* Governance Alert Banner */
        .admin-banner {
            background: var(--admin-amber-bg);
            border: 1px solid var(--admin-amber-border);
            border-radius: 10px;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }

        .admin-banner-left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }

        .admin-banner-icon {
            font-size: 18px;
            flex-shrink: 0;
        }

        .admin-banner-text strong {
            color: var(--admin-amber);
            font-size: 13px;
            font-weight: 700;
            display: inline-block;
            margin-right: 6px;
        }

        .admin-banner-text span {
            color: #D1D5DB;
            font-size: 13px;
        }

        .admin-banner-badge {
            font-size: 11px;
            font-weight: 700;
            background: rgba(245, 158, 11, 0.14);
            color: var(--admin-amber);
            border: 1px solid var(--admin-amber-border);
            padding: 4px 10px;
            border-radius: 6px;
            white-space: nowrap;
            letter-spacing: 0.3px;
            flex-shrink: 0;
        }

        /* Section Containers */
        .admin-section {
            display: flex;
            flex-direction: column;
            gap: 16px;
            scroll-margin-top: 88px;
        }

        .admin-section-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 16px;
        }

        .admin-section-title-wrap h3 {
            font-family: var(--font-heading);
            font-size: 17px;
            font-weight: 700;
            color: var(--admin-text-main);
            margin: 0;
            letter-spacing: -0.2px;
        }

        .admin-section-title-wrap p {
            font-size: 13px;
            color: var(--admin-text-muted);
            margin: 4px 0 0;
        }

        .admin-badge-pill {
            font-size: 11px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 6px;
            white-space: nowrap;
            letter-spacing: 0.3px;
        }

        .admin-badge-green {
            background: var(--admin-green-bg);
            color: var(--admin-green);
            border: 1px solid rgba(52, 211, 153, 0.25);
        }

        .admin-badge-muted {
            background: rgba(148, 163, 184, 0.1);
            color: #94A3B8;
            border: 1px solid rgba(148, 163, 184, 0.2);
        }

        /* 3-Column Uniform Cards Grid */
        .admin-grid-3 {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
        }

        /* Rule Cards */
        .rule-card {
            background: var(--admin-surface);
            border: 1px solid var(--admin-border);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 14px;
            transition: border-color 0.2s ease, transform 0.2s ease;
        }

        .rule-card:hover {
            border-color: var(--admin-border-hover);
            transform: translateY(-1px);
        }

        .rule-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .rule-code {
            font-family: 'Space Grotesk', monospace;
            font-size: 12px;
            font-weight: 700;
            color: var(--admin-text-muted);
        }

        .rule-priority {
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 2px 7px;
            border-radius: 5px;
        }

        .priority-mandatory {
            background: var(--admin-red-bg);
            color: var(--admin-red);
            border: 1px solid rgba(248, 113, 113, 0.3);
        }

        .priority-critical {
            background: var(--admin-amber-bg);
            color: var(--admin-amber);
            border: 1px solid var(--admin-amber-border);
        }

        .priority-standard {
            background: var(--admin-blue-bg);
            color: var(--admin-blue);
            border: 1px solid rgba(96, 165, 250, 0.3);
        }

        .rule-card-body h4 {
            font-size: 14.5px;
            font-weight: 700;
            color: var(--admin-text-main);
            margin: 0 0 6px 0;
            line-height: 1.35;
            min-height: 40px;
        }

        .rule-card-body p {
            font-size: 13px;
            color: var(--admin-text-muted);
            line-height: 1.45;
            margin: 0;
            min-height: 38px;
        }

        .rule-card-footer {
            background: #0E121A;
            border: 1px solid var(--admin-border-subtle);
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 12px;
            color: var(--admin-text-muted);
            display: flex;
            align-items: center;
            gap: 8px;
            min-height: 38px;
        }

        /* Staff Station Cards */
        .staff-card {
            background: var(--admin-surface);
            border: 1px solid var(--admin-border);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 16px;
            transition: border-color 0.2s ease, transform 0.2s ease;
        }

        .staff-card:hover {
            border-color: var(--admin-border-hover);
            transform: translateY(-1px);
        }

        .staff-card-header {
            display: flex;
            flex-direction: column;
            gap: 4px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--admin-border-subtle);
            min-height: 84px;
        }

        .staff-role-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .staff-role-title {
            font-size: 15px;
            font-weight: 700;
            font-family: var(--font-heading);
            color: var(--admin-text-main);
            margin: 0;
        }

        .staff-shift-badge {
            font-size: 11px;
            font-weight: 600;
            background: #19202E;
            color: var(--admin-text-muted);
            padding: 2px 7px;
            border-radius: 5px;
        }

        .staff-assignee {
            font-size: 12px;
            color: var(--admin-text-muted);
        }

        .staff-assignee strong {
            color: var(--admin-text-main);
        }

        .staff-duties-title {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--admin-text-subtle);
            font-weight: 700;
            margin: 0 0 8px 0;
        }

        .staff-duties-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .staff-duties-list li {
            font-size: 13px;
            color: #CBD5E1;
            display: flex;
            align-items: flex-start;
            gap: 8px;
            line-height: 1.4;
        }

        .staff-bullet {
            color: var(--admin-amber);
            font-weight: 800;
            line-height: 1;
            margin-top: 2px;
        }

        .staff-restriction {
            background: var(--admin-red-bg);
            border: 1px solid rgba(248, 113, 113, 0.2);
            border-radius: 7px;
            padding: 8px 12px;
            font-size: 12px;
            color: #FCA5A5;
            display: flex;
            align-items: center;
            gap: 6px;
            min-height: 42px;
        }

        /* Database Login Logs Table */
        .table-card {
            background: var(--admin-surface);
            border: 1px solid var(--admin-border);
            border-radius: 12px;
            overflow-x: auto;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            text-align: left;
        }

        .data-table th {
            padding: 14px 20px;
            background: #0F121C;
            color: var(--admin-text-muted);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            border-bottom: 1px solid var(--admin-border);
        }

        .data-table td {
            padding: 13px 20px;
            border-bottom: 1px solid var(--admin-border-subtle);
            color: var(--admin-text-main);
            vertical-align: middle;
        }

        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        .data-table tbody tr:hover {
            background: var(--admin-surface-hover);
        }

        .user-email-text {
            font-weight: 600;
            color: #F8FAFC;
        }

        .user-name-text {
            color: var(--admin-text-muted);
        }

        .role-pill {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 11px;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 5px;
        }

        .role-admin {
            background: rgba(192, 132, 252, 0.12);
            color: #C084FC;
            border: 1px solid rgba(192, 132, 252, 0.25);
        }

        .role-staff {
            background: var(--admin-amber-bg);
            color: var(--admin-amber);
            border: 1px solid var(--admin-amber-border);
        }

        .role-student {
            background: var(--admin-blue-bg);
            color: var(--admin-blue);
            border: 1px solid rgba(96, 165, 250, 0.25);
        }

        .ip-badge {
            font-family: 'Space Grotesk', monospace;
            font-size: 12px;
            color: var(--admin-text-muted);
            background: #0E121A;
            padding: 2px 8px;
            border-radius: 5px;
            border: 1px solid var(--admin-border-subtle);
        }

        .time-text {
            color: var(--admin-green);
            font-weight: 600;
            font-size: 12px;
            font-family: 'Space Grotesk', monospace;
        }

        /* XML Feed Inspector */
        .xml-card {
            background: var(--admin-surface);
            border: 1px solid var(--admin-border);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .xml-status-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--admin-border-subtle);
        }

        .xml-status-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .xml-status-title {
            font-size: 13px;
            font-weight: 700;
            color: var(--admin-text-main);
        }

        .xml-summary-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .xml-subcard {
            background: #0F131D;
            border: 1px solid var(--admin-border-subtle);
            border-radius: 8px;
            padding: 14px 16px;
        }

        .xml-subcard-title {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0 0 8px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .xml-subcard-list {
            margin: 0;
            padding-left: 18px;
            font-size: 12px;
            color: var(--admin-text-muted);
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .xml-code-display {
            background: #080A10;
            border: 1px solid var(--admin-border);
            border-radius: 8px;
            padding: 16px;
            font-family: 'Space Grotesk', monospace;
            font-size: 12px;
            color: #6EE7B7;
            max-height: 280px;
            overflow-y: auto;
            white-space: pre-wrap;
            line-height: 1.5;
            margin-top: 12px;
        }

        /* Buttons */
        .btn-minimal {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s ease;
            background: var(--admin-surface);
            color: var(--admin-text-main);
            border: 1px solid var(--admin-border);
        }

        .btn-minimal:hover {
            background: var(--admin-surface-hover);
            border-color: var(--admin-border-hover);
            color: #FFFFFF;
        }

        .btn-minimal-primary {
            background: rgba(245, 158, 11, 0.12);
            color: var(--admin-amber);
            border: 1px solid var(--admin-amber-border);
        }

        .btn-minimal-primary:hover {
            background: var(--admin-amber);
            color: #0B0E14;
            border-color: var(--admin-amber);
        }

        .btn-minimal-danger {
            background: var(--admin-red-bg);
            color: var(--admin-red);
            border: 1px solid rgba(248, 113, 113, 0.3);
        }

        .btn-minimal-danger:hover {
            background: #EF4444;
            color: #FFFFFF;
            border-color: #EF4444;
        }

        /* Responsive Breakpoints */
        @media (max-width: 1100px) {
            .admin-stat-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .admin-grid-3 {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .admin-stat-grid {
                grid-template-columns: 1fr;
            }
            .admin-grid-3 {
                grid-template-columns: 1fr;
            }
            .xml-summary-grid {
                grid-template-columns: 1fr;
            }
            .dashboard-body {
                padding: 18px 16px;
            }
            .admin-topbar {
                padding: 0 16px;
            }
        }
    </style>
</head>
<body>

    <div class="dashboard-layout">
        
        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                    <span class="logo-icon">🍽️</span>
                    <span>Smart<span>Canteen</span></span>
                </a>
            </div>

            <ul class="sidebar-menu">
                <span class="sidebar-menu-title">Admin Management</span>
                <li>
                    <a href="#canteenRules" class="sidebar-link active">
                        <span class="icon">📜</span> Canteen Rules &amp; SOP
                    </a>
                </li>
                <li>
                    <a href="#staffJobs" class="sidebar-link">
                        <span class="icon">👨‍🍳</span> Staff Job Allocations
                    </a>
                </li>
                <li>
                    <a href="#loginAudit" class="sidebar-link">
                        <span class="icon">🔐</span> Database Login Logs
                    </a>
                </li>
                <li>
                    <a href="#xmlFeed" class="sidebar-link">
                        <span class="icon">📄</span> Live XML &amp; AJAX Feed
                    </a>
                </li>

                <span class="sidebar-menu-title">Navigation</span>
                <li>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="sidebar-link">
                        <span class="icon">🌐</span> Website Home
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/menu.jsp" class="sidebar-link">
                        <span class="icon">🍔</span> View Campus Menu
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="handleAdminLogout()" class="sidebar-link" style="color: #F87171 !important;">
                        <span class="icon">🚪</span> Sign Out Admin
                    </a>
                </li>
            </ul>

            <div class="sidebar-user">
                <div class="user-avatar" id="adminUserAvatar">${sessionScope.userName != null && sessionScope.userName.length() > 0 ? sessionScope.userName.substring(0, 1) : 'A'}</div>
                <div class="user-info">
                    <strong id="adminUserName">${sessionScope.userName != null ? sessionScope.userName : 'Canteen Administrator'}</strong>
                    <small id="adminUserRole">Admin • Rules &amp; Jobs Only</small>
                </div>
                <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="handleAdminLogout()" title="Sign Out Admin" style="margin-left: auto; color: #F87171; font-size: 14px; padding: 6px 10px; border-radius: 8px; display: inline-flex; align-items: center; background: rgba(239, 68, 68, 0.12); border: 1px solid rgba(239, 68, 68, 0.3); text-decoration: none;">
                    🚪
                </a>
            </div>
        </aside>

        <!-- MAIN ADMIN VIEW -->
        <main class="main-content">
            
            <!-- TOPBAR -->
            <header class="admin-topbar">
                <div class="admin-topbar-title">
                    <h2>Canteen Governance &amp; Staff Job Matrix</h2>
                    <p>Official canteen operating rules, staff allocations, and database logs (Read-Only).</p>
                </div>

                <div class="admin-topbar-actions">
                    <button type="button" class="btn-minimal btn-minimal-primary" onclick="fetchRulesXmlAjax()">
                        <span>🔄</span> Refresh XML Feed
                    </button>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="handleAdminLogout()" class="btn-minimal btn-minimal-danger" title="Sign Out Admin">
                        <span>🚪</span> Sign Out Admin
                    </a>
                </div>
            </header>

            <!-- DASHBOARD BODY (CENTERED, CLEAN & MINIMAL) -->
            <div class="dashboard-body">

                <!-- 1. KPI SUMMARY STATS ROW -->
                <div class="admin-stat-grid">
                    <div class="admin-stat-card">
                        <div class="admin-stat-header">
                            <span class="admin-stat-label">Active SOP Rules</span>
                            <span class="admin-stat-icon-sm">📜</span>
                        </div>
                        <div class="admin-stat-value">6 Active</div>
                        <div class="admin-stat-sub">FSSAI Protocol v2026.4</div>
                    </div>

                    <div class="admin-stat-card">
                        <div class="admin-stat-header">
                            <span class="admin-stat-label">Kitchen Stations</span>
                            <span class="admin-stat-icon-sm">👨‍🍳</span>
                        </div>
                        <div class="admin-stat-value">3 Stations</div>
                        <div class="admin-stat-sub">Cooking &amp; Prep Only</div>
                    </div>

                    <div class="admin-stat-card">
                        <div class="admin-stat-header">
                            <span class="admin-stat-label">Database Login Logs</span>
                            <span class="admin-stat-icon-sm">🔐</span>
                        </div>
                        <div class="admin-stat-value"><%= loginLogs != null ? loginLogs.size() : 0 %> Records</div>
                        <div class="admin-stat-sub">Supabase PostgreSQL Live Sync</div>
                    </div>

                    <div class="admin-stat-card">
                        <div class="admin-stat-header">
                            <span class="admin-stat-label">Curriculum Integration</span>
                            <span class="admin-stat-icon-sm">⚡</span>
                        </div>
                        <div class="admin-stat-value">XML + JDBC</div>
                        <div class="admin-stat-sub">Full Stack Java EE Active</div>
                    </div>
                </div>

                <!-- 2. READ-ONLY GOVERNANCE NOTICE BANNER -->
                <div class="admin-banner">
                    <div class="admin-banner-left">
                        <span class="admin-banner-icon">🔒</span>
                        <div class="admin-banner-text">
                            <strong>Administrative Read-Only Governance:</strong>
                            <span>View-only authority for canteen operating rules, staff jobs, and database login logs.</span>
                        </div>
                    </div>
                    <span class="admin-banner-badge">Rules Oversight Only</span>
                </div>

                <!-- 3. SECTION 1: CANTEEN OPERATIONAL RULES & POLICIES -->
                <section class="admin-section" id="canteenRules">
                    <div class="admin-section-header">
                        <div class="admin-section-title-wrap">
                            <h3>📜 Canteen Operational Rules &amp; Standards</h3>
                            <p>Mandatory guidelines governing food prep, hygiene, break slot scheduling, and pricing.</p>
                        </div>
                        <span class="admin-badge-pill admin-badge-muted">FSSAI Protocol v2026.4</span>
                    </div>

                    <div class="admin-grid-3">
                        
                        <!-- RULE 1 -->
                        <div class="rule-card">
                            <div>
                                <div class="rule-card-top">
                                    <span class="rule-code">Rule #R101</span>
                                    <span class="rule-priority priority-mandatory">Mandatory</span>
                                </div>
                                <div class="rule-card-body" style="margin-top: 10px;">
                                    <h4>Kitchen Headgear, Gloves &amp; Sanitization</h4>
                                    <p>Mandatory hairnets, gloves, and sanitized aprons in food prep zones.</p>
                                </div>
                            </div>
                            <div class="rule-card-footer">
                                <span>📋</span>
                                <span>Daily 8:00 AM shift inspection by Head Chef.</span>
                            </div>
                        </div>

                        <!-- RULE 2 -->
                        <div class="rule-card">
                            <div>
                                <div class="rule-card-top">
                                    <span class="rule-code">Rule #R102</span>
                                    <span class="rule-priority priority-critical">Critical</span>
                                </div>
                                <div class="rule-card-body" style="margin-top: 10px;">
                                    <h4>Temperature Control for Perishables</h4>
                                    <p>Refrigerate dairy at or below 4°C; hold hot food above 65°C.</p>
                                </div>
                            </div>
                            <div class="rule-card-footer">
                                <span>🌡️</span>
                                <span>Digital probe logs recorded every 2 hours.</span>
                            </div>
                        </div>

                        <!-- RULE 3 -->
                        <div class="rule-card">
                            <div>
                                <div class="rule-card-top">
                                    <span class="rule-code">Rule #R201</span>
                                    <span class="rule-priority priority-critical">Critical</span>
                                </div>
                                <div class="rule-card-body" style="margin-top: 10px;">
                                    <h4>Break Window Time-Slot Discipline</h4>
                                    <p>Batch meals prepared to match student break slots without delay.</p>
                                </div>
                            </div>
                            <div class="rule-card-footer">
                                <span>⏱️</span>
                                <span>Latency monitored via Kitchen Display System (KDS).</span>
                            </div>
                        </div>

                        <!-- RULE 4 -->
                        <div class="rule-card">
                            <div>
                                <div class="rule-card-top">
                                    <span class="rule-code">Rule #R202</span>
                                    <span class="rule-priority priority-standard">Standard</span>
                                </div>
                                <div class="rule-card-body" style="margin-top: 10px;">
                                    <h4>Digital Token Pass Verification</h4>
                                    <p>Show digital token on mobile screen before parcel collection.</p>
                                </div>
                            </div>
                            <div class="rule-card-footer">
                                <span>🎫</span>
                                <span>Digital token matched with kitchen ticket before handoff.</span>
                            </div>
                        </div>

                        <!-- RULE 5 -->
                        <div class="rule-card">
                            <div>
                                <div class="rule-card-top">
                                    <span class="rule-code">Rule #R301</span>
                                    <span class="rule-priority priority-mandatory">Mandatory</span>
                                </div>
                                <div class="rule-card-body" style="margin-top: 10px;">
                                    <h4>Subsidized Student Price Ceilings</h4>
                                    <p>Snack prices capped between ₹15 and ₹30 with zero unauthorized hikes.</p>
                                </div>
                            </div>
                            <div class="rule-card-footer">
                                <span>💰</span>
                                <span>Monthly administrative pricing and billing audit.</span>
                            </div>
                        </div>

                        <!-- RULE 6 -->
                        <div class="rule-card">
                            <div>
                                <div class="rule-card-top">
                                    <span class="rule-code">Rule #R302</span>
                                    <span class="rule-priority priority-critical">Critical</span>
                                </div>
                                <div class="rule-card-body" style="margin-top: 10px;">
                                    <h4>100% Digital Order Generation</h4>
                                    <p>Every customer transaction must originate through the web portal.</p>
                                </div>
                            </div>
                            <div class="rule-card-footer">
                                <span>📊</span>
                                <span>Nightly automated database transaction reconciliation.</span>
                            </div>
                        </div>

                    </div>
                </section>

                <!-- 4. SECTION 2: KITCHEN STAFF JOB ROLES & ALLOCATIONS -->
                <section class="admin-section" id="staffJobs">
                    <div class="admin-section-header">
                        <div class="admin-section-title-wrap">
                            <h3>👨‍🍳 Kitchen Staff Job Allocations &amp; Duty Matrix</h3>
                            <p>Defined kitchen crew responsibilities; staff cannot order food or process payments.</p>
                        </div>
                        <span class="admin-badge-pill admin-badge-muted">3 Assigned Stations</span>
                    </div>

                    <div class="admin-grid-3">
                        
                        <!-- STATION 1: HEAD CHEF -->
                        <div class="staff-card" style="border-top: 3px solid var(--admin-amber);">
                            <div>
                                <div class="staff-card-header">
                                    <div class="staff-role-row">
                                        <h4 class="staff-role-title">Head Kitchen Chef</h4>
                                        <span class="staff-shift-badge">07:30 – 16:30</span>
                                    </div>
                                    <div class="staff-assignee">
                                        Assignee: <strong>Chef Kumar</strong> (staff@smartcanteen.com)
                                    </div>
                                    <div style="font-size: 11px; color: var(--admin-text-subtle); margin-top: 2px;">
                                        Station: Main Hot Range &amp; KDS Terminal
                                    </div>
                                </div>

                                <div style="margin-top: 14px;">
                                    <div class="staff-duties-title">Assigned Responsibilities:</div>
                                    <ul class="staff-duties-list">
                                        <li><span class="staff-bullet">•</span> Triage incoming live orders on the KDS console.</li>
                                        <li><span class="staff-bullet">•</span> Click "Start Cooking" when meal preparation begins.</li>
                                        <li><span class="staff-bullet">•</span> Enforce recipe portion weights and cooking times.</li>
                                        <li><span class="staff-bullet">•</span> Click "Ready for Pickup" when order is plated.</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="staff-restriction">
                                <span>⛔</span>
                                <span>Restriction: Cannot place food orders or execute payments.</span>
                            </div>
                        </div>

                        <!-- STATION 2: STATION COOK -->
                        <div class="staff-card" style="border-top: 3px solid var(--admin-blue);">
                            <div>
                                <div class="staff-card-header">
                                    <div class="staff-role-row">
                                        <h4 class="staff-role-title">Station Line Cook</h4>
                                        <span class="staff-shift-badge">08:00 – 17:00</span>
                                    </div>
                                    <div class="staff-assignee">
                                        Assignee: <strong>Ramesh</strong> (Line Cook #2)
                                    </div>
                                    <div style="font-size: 11px; color: var(--admin-text-subtle); margin-top: 2px;">
                                        Station: Tava Station &amp; Deep-Fryer Bay
                                    </div>
                                </div>

                                <div style="margin-top: 14px;">
                                    <div class="staff-duties-title">Assigned Responsibilities:</div>
                                    <ul class="staff-duties-list">
                                        <li><span class="staff-bullet">•</span> Batch fry samosas, bajjis, bondas, and puffs.</li>
                                        <li><span class="staff-bullet">•</span> Brew fresh filter coffee and masala tea on schedule.</li>
                                        <li><span class="staff-bullet">•</span> Replenish fresh coconut chutney and sambar every 30m.</li>
                                        <li><span class="staff-bullet">•</span> Maintain frying oil standards and filter equipment daily.</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="staff-restriction">
                                <span>⛔</span>
                                <span>Restriction: Cannot access admin panels or modify menu prices.</span>
                            </div>
                        </div>

                        <!-- STATION 3: COUNTER EXPEDITOR -->
                        <div class="staff-card" style="border-top: 3px solid var(--admin-green);">
                            <div>
                                <div class="staff-card-header">
                                    <div class="staff-role-row">
                                        <h4 class="staff-role-title">Counter Expeditor</h4>
                                        <span class="staff-shift-badge">11:00 – 15:00</span>
                                    </div>
                                    <div class="staff-assignee">
                                        Assignee: <strong>Priya &amp; Suresh</strong> (Dispatch)
                                    </div>
                                    <div style="font-size: 11px; color: var(--admin-text-subtle); margin-top: 2px;">
                                        Station: Express Dispatch Counters #1 &amp; #2
                                    </div>
                                </div>

                                <div style="margin-top: 14px;">
                                    <div class="staff-duties-title">Assigned Responsibilities:</div>
                                    <ul class="staff-duties-list">
                                        <li><span class="staff-bullet">•</span> Inspect customer digital token screen prior to handoff.</li>
                                        <li><span class="staff-bullet">•</span> Organize prepared parcels by customer pickup break slot.</li>
                                        <li><span class="staff-bullet">•</span> Click "Handed Over" to finalize order on counter register.</li>
                                        <li><span class="staff-bullet">•</span> Maintain zero congestion at express pickup counters.</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="staff-restriction">
                                <span>⛔</span>
                                <span>Restriction: Cannot alter kitchen cooking stages or reassign prices.</span>
                            </div>
                        </div>

                    </div>
                </section>

                <!-- 5. SECTION 3: LIVE DATABASE AUTHENTICATION & LOGIN AUDIT LOGS -->
                <section class="admin-section" id="loginAudit">
                    <div class="admin-section-header">
                        <div class="admin-section-title-wrap">
                            <h3>🔐 Live Database Authentication &amp; Login Audit Logs</h3>
                            <p>Real-time database log recording every user login into smartcanteen_login_logs table in Supabase PostgreSQL.</p>
                        </div>
                        <span class="admin-badge-pill admin-badge-green">● Supabase PostgreSQL Live Sync</span>
                    </div>

                    <div class="table-card">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>User Email</th>
                                    <th>Full Name</th>
                                    <th>Role</th>
                                    <th>Client IP</th>
                                    <th>Login Timestamp (Stored in DB)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (loginLogs != null && !loginLogs.isEmpty()) { 
                                    for (Map<String, String> log : loginLogs) { %>
                                    <tr>
                                        <td><span class="user-email-text"><%= log.get("email") %></span></td>
                                        <td><span class="user-name-text"><%= log.get("name") %></span></td>
                                        <td>
                                            <% String r = log.get("role"); 
                                               String rClass = "role-student";
                                               if ("Admin".equalsIgnoreCase(r)) rClass = "role-admin";
                                               else if ("Staff".equalsIgnoreCase(r) || "Kitchen".equalsIgnoreCase(r)) rClass = "role-staff";
                                            %>
                                            <span class="role-pill <%= rClass %>">
                                                <span>●</span> <%= r %>
                                            </span>
                                        </td>
                                        <td><span class="ip-badge"><%= log.get("ip") %></span></td>
                                        <td><span class="time-text"><%= log.get("time") %></span></td>
                                    </tr>
                                <%  } 
                                   } else { %>
                                    <tr>
                                        <td colspan="5" style="text-align: center; color: var(--admin-text-muted); padding: 32px;">
                                            No logins recorded yet. Log in with any student, staff, or admin account to see live database records.
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </section>

                <!-- 6. SECTION 4: LIVE XML & AJAX RULES VIEWER -->
                <section class="admin-section" id="xmlFeed">
                    <div class="admin-section-header">
                        <div class="admin-section-title-wrap">
                            <h3>📄 Live XML &amp; AJAX Feed Inspector</h3>
                            <p>Asynchronous AJAX retrieval and DOM parsing of canteen_rules.xml.</p>
                        </div>
                        <div style="display: flex; gap: 8px;">
                            <button type="button" class="btn-minimal" id="btnToggleXmlRaw" onclick="toggleRawXml()">
                                View Raw XML
                            </button>
                            <a href="${pageContext.request.contextPath}/MenuXmlServlet" target="_blank" class="btn-minimal" style="text-decoration: none;">
                                Open Menu Servlet XML ↗
                            </a>
                        </div>
                    </div>

                    <div class="xml-card">
                        <div class="xml-status-bar">
                            <div class="xml-status-left">
                                <span style="font-size: 16px;">⚡</span>
                                <span class="xml-status-title">AJAX Dynamic XML Node Extraction Status:</span>
                            </div>
                            <span id="ajaxStatusBadge" class="admin-badge-pill admin-badge-green">
                                Ready
                            </span>
                        </div>

                        <!-- DYNAMIC AJAX OUTPUT TARGET -->
                        <div id="ajaxXmlOutput">
                            <span style="font-size: 13px; color: var(--admin-text-muted);">
                                Loading canteen rules XML feed asynchronously via AJAX...
                            </span>
                        </div>

                        <!-- RAW XML CODE BLOCK (COLLAPSIBLE) -->
                        <div id="xmlRawContainer" style="display: none;">
                            <pre class="xml-code-display" id="xmlRawContent"></pre>
                        </div>
                    </div>
                </section>

            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        <% if (session.getAttribute("user") != null) { 
            com.smartcanteen.model.User u = (com.smartcanteen.model.User) session.getAttribute("user");
        %>
        localStorage.setItem('smartcanteen_logged_in_user', JSON.stringify({
            name: "<%= u.getName().replace("\"", "\\\"") %>",
            email: "<%= u.getEmail() %>",
            role: "<%= u.getRole() %>"
        }));
        sessionStorage.setItem('smartcanteen_user', JSON.stringify({
            name: "<%= u.getName().replace("\"", "\\\"") %>",
            email: "<%= u.getEmail() %>",
            role: "<%= u.getRole() %>"
        }));
        <% } %>

        function handleAdminLogout() {
            localStorage.removeItem('smartcanteen_logged_in_user');
            sessionStorage.removeItem('smartcanteen_user');
            sessionStorage.removeItem('smartcanteen_last_order');
        }

        // Enforce Admin Authentication & Redirection
        document.addEventListener('DOMContentLoaded', () => {
            const serverRole = "<%= currentRole != null ? currentRole : "" %>";
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            
            if (!savedUserStr && serverRole.toLowerCase() !== 'admin') {
                window.location.href = '${pageContext.request.contextPath}/login.jsp?error=admin_only&redirect=admin-dashboard.jsp';
                return;
            }

            if (savedUserStr) {
                try {
                    const user = JSON.parse(savedUserStr);
                    const role = (user.role || '').toLowerCase();
                    
                    if (role && role !== 'admin') {
                        if (role === 'staff' || role === 'kitchen' || role === 'chef') {
                            window.location.href = '${pageContext.request.contextPath}/staff-dashboard.jsp';
                        } else {
                            window.location.href = '${pageContext.request.contextPath}/dashboard.jsp';
                        }
                        return;
                    }

                    const nameEl = document.getElementById('adminUserName');
                    const avatarEl = document.getElementById('adminUserAvatar');
                    if (nameEl && user.name) nameEl.textContent = user.name;
                    if (avatarEl && user.name) avatarEl.textContent = user.name.charAt(0).toUpperCase();

                } catch(e) {
                    console.error('Error parsing admin user state', e);
                }
            }

            // Sync sidebar active state on anchor clicks
            document.querySelectorAll('.sidebar-link[href^="#"]').forEach(link => {
                link.addEventListener('click', function() {
                    document.querySelectorAll('.sidebar-link').forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Automatically load and parse rules XML via AJAX on page load
            fetchRulesXmlAjax();
        });

        // AJAX Function: Fetches and parses canteen_rules.xml asynchronously
        function fetchRulesXmlAjax() {
            const statusBadge = document.getElementById('ajaxStatusBadge');
            const outputEl = document.getElementById('ajaxXmlOutput');
            const rawEl = document.getElementById('xmlRawContent');

            if (statusBadge) {
                statusBadge.textContent = 'Fetching via AJAX...';
                statusBadge.className = 'admin-badge-pill admin-badge-muted';
                statusBadge.style.color = '#F59E0B';
            }

            const xhr = new XMLHttpRequest();
            xhr.open('GET', '${pageContext.request.contextPath}/canteen_rules.xml?t=' + new Date().getTime(), true);
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const xmlText = xhr.responseText;
                        if (rawEl) rawEl.textContent = xmlText;

                        // Parse XML with DOMParser
                        const parser = new DOMParser();
                        const xmlDoc = parser.parseFromString(xmlText, 'application/xml');

                        const rules = xmlDoc.getElementsByTagName('rule');
                        const jobs = xmlDoc.getElementsByTagName('jobRole');

                        let summaryHtml = '<div class="xml-summary-grid">';
                        
                        summaryHtml += '<div class="xml-subcard">';
                        summaryHtml += '<div class="xml-subcard-title" style="color: var(--admin-amber);">';
                        summaryHtml += '<span>Active Rules in XML</span>';
                        summaryHtml += '<span class="admin-badge-pill" style="background: rgba(245, 158, 11, 0.15); color: #F59E0B;">' + rules.length + ' Rules</span>';
                        summaryHtml += '</div>';
                        summaryHtml += '<ul class="xml-subcard-list">';
                        for (let i = 0; i < Math.min(rules.length, 4); i++) {
                            const title = rules[i].getElementsByTagName('title')[0]?.textContent || '';
                            const priority = rules[i].getAttribute('priority') || '';
                            summaryHtml += '<li><strong>[' + priority + ']</strong> ' + title + '</li>';
                        }
                        summaryHtml += '</ul></div>';

                        summaryHtml += '<div class="xml-subcard">';
                        summaryHtml += '<div class="xml-subcard-title" style="color: var(--admin-blue);">';
                        summaryHtml += '<span>Staff Roles in XML</span>';
                        summaryHtml += '<span class="admin-badge-pill" style="background: rgba(96, 165, 250, 0.15); color: #60A5FA;">' + jobs.length + ' Roles</span>';
                        summaryHtml += '</div>';
                        summaryHtml += '<ul class="xml-subcard-list">';
                        for (let j = 0; j < jobs.length; j++) {
                            const title = jobs[j].getElementsByTagName('title')[0]?.textContent || '';
                            const assignee = jobs[j].getElementsByTagName('assignee')[0]?.textContent || '';
                            summaryHtml += '<li><strong>' + title + '</strong>: ' + assignee + '</li>';
                        }
                        summaryHtml += '</ul></div>';

                        summaryHtml += '</div>';

                        if (outputEl) outputEl.innerHTML = summaryHtml;
                        if (statusBadge) {
                            statusBadge.textContent = 'XML Loaded & Parsed (200 OK)';
                            statusBadge.className = 'admin-badge-pill admin-badge-green';
                            statusBadge.style.color = '#34D399';
                        }
                    } else {
                        if (statusBadge) {
                            statusBadge.textContent = 'AJAX Error (' + xhr.status + ')';
                            statusBadge.className = 'admin-badge-pill';
                            statusBadge.style.background = 'rgba(239, 68, 68, 0.15)';
                            statusBadge.style.color = '#EF4444';
                        }
                        if (outputEl) outputEl.innerHTML = '<span style="color: #F87171; font-size: 13px;">Could not load rules XML via AJAX.</span>';
                    }
                }
            };

            xhr.send();
        }

        function toggleRawXml() {
            const raw = document.getElementById('xmlRawContainer');
            const btn = document.getElementById('btnToggleXmlRaw');
            if (raw) {
                const isHidden = raw.style.display === 'none';
                raw.style.display = isHidden ? 'block' : 'none';
                if (btn) btn.textContent = isHidden ? 'Hide Raw XML' : 'View Raw XML';
            }
        }
    </script>
</body>
</html>
