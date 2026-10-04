<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentRole = (String) session.getAttribute("userRole");
    if (currentRole != null) {
        if ("Student".equalsIgnoreCase(currentRole)) {
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp?error=unauthorized_staff");
            return;
        } else if ("Admin".equalsIgnoreCase(currentRole)) {
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp?error=admin_cannot_access_kitchen");
            return;
        } else if (!"Staff".equalsIgnoreCase(currentRole) && !"Kitchen".equalsIgnoreCase(currentRole) && !"Chef".equalsIgnoreCase(currentRole) && !"Lecturer".equalsIgnoreCase(currentRole)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=staff_only");
            return;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kitchen Staff & Order Display (KDS) | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="kds-theme">

    <div class="dashboard-layout">
        
        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                    <span class="logo-icon">👨‍🍳</span>
                    <span>Kitchen<span>Staff</span></span>
                </a>
            </div>

            <ul class="sidebar-menu">
                <span class="sidebar-menu-title">KDS Operations</span>
                <li>
                    <a href="${pageContext.request.contextPath}/staff-dashboard.jsp" class="sidebar-link active">
                        <span class="icon">📋</span> KDS Live Orders
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/menu.jsp" class="sidebar-link">
                        <span class="icon">🍔</span> Recipes & Prep Times
                    </a>
                </li>
                <li>
                    <a href="#whyUsKitchen" class="sidebar-link">
                        <span class="icon">💡</span> Kitchen Prep Standards
                    </a>
                </li>
                <span class="sidebar-menu-title">Terminal Controls</span>
                <li>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="sidebar-link">
                        <span class="icon">🌐</span> Website Home
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="sidebar-link" style="color: #F87171 !important;">
                        <span class="icon">🚪</span> Sign Out Kitchen
                    </a>
                </li>
            </ul>

            <div class="sidebar-user">
                <div class="user-avatar" style="background: linear-gradient(135deg, var(--orange), #EA580C);" id="staffUserAvatar">${sessionScope.userName != null && sessionScope.userName.length() > 0 ? sessionScope.userName.substring(0, 1) : 'S'}</div>
                <div class="user-info">
                    <strong id="staffUserName">${sessionScope.userName != null ? sessionScope.userName : 'Chef Kumar'}</strong>
                    <small id="staffUserRole">${sessionScope.userRole != null ? sessionScope.userRole : 'Staff'} • Kitchen Crew</small>
                </div>
                <a href="${pageContext.request.contextPath}/LogoutServlet" title="Logout" style="margin-left: auto; color: var(--muted); font-size: 16px;">
                    ↳
                </a>
            </div>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content">
            
            <!-- TOPBAR -->
            <header class="topbar kds-topbar">
                <div class="topbar-title">
                    <h2>KDS Industrial Terminal 👨‍🍳 <span style="font-size: 13px; font-weight: 700; color: #38BDF8; background: rgba(56, 189, 248, 0.15); padding: 4px 10px; border-radius: 8px; vertical-align: middle; margin-left: 8px;">STATION #1</span></h2>
                    <p style="font-size: 13px; color: #94A3B8;">Real-time student food preparation pipeline & dispatch window.</p>
                </div>

                <div class="topbar-actions">
                    <button type="button" class="primary-btn" onclick="showToast('🔔 Chime sounded! Ticket refresh synced.');" style="padding: 10px 18px; font-size: 13px; background: linear-gradient(135deg, #0284C7, #0369A1);">
                        🔔 Ring Counter Bell
                    </button>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="topbar-btn" title="Sign Out" style="background: #1E293B; border-color: #334155; color: #F8FAFC;">
                        ↳
                    </a>
                </div>
            </header>

            <!-- DASHBOARD BODY -->
            <div class="dashboard-body">
                
                <!-- METRIC COUNTERS -->
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-icon purple">📦</div>
                        <div class="metric-data">
                            <small>Today's Total Orders</small>
                            <strong id="counterTotal">142</strong>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-icon pink">⏳</div>
                        <div class="metric-data">
                            <small>New Orders Queue</small>
                            <strong id="counterNew" style="color: var(--pink);">3 Orders</strong>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-icon orange">🍳</div>
                        <div class="metric-data">
                            <small>Currently Preparing</small>
                            <strong id="counterPrep" style="color: var(--orange);">5 Orders</strong>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-icon green">🔔</div>
                        <div class="metric-data">
                            <small>Ready for Pickup</small>
                            <strong id="counterReady" style="color: var(--green);">4 Orders</strong>
                        </div>
                    </div>
                </div>

                <!-- KANBAN BOARD -->
                <div class="kanban-board">
                    
                    <!-- COLUMN 1: NEW ORDERS -->
                    <div class="kanban-col" id="colNew">
                        <div class="kanban-col-header">
                            <span>⏳ New Orders</span>
                            <span class="kanban-counter">2</span>
                        </div>

                        <div class="kanban-card" id="kCard1025">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <strong style="color: var(--purple);">#SC1025</strong>
                                <span style="font-size: 11px; font-weight: 700; color: var(--muted);">Slot: 1:00 PM</span>
                            </div>
                            <p style="font-size: 13px; font-weight: 600; margin-bottom: 6px;">2× Masala Dosa, 1× Cold Coffee</p>
                            <small style="color: var(--muted); display: block; margin-bottom: 12px;">Student: Priya Nair (EC-12)</small>
                            <div class="kanban-card-actions">
                                <button type="button" class="kanban-action-btn primary" onclick="moveOrder('kCard1025', 'colPrep', 'Cooking Started')">
                                    Start Cooking →
                                </button>
                            </div>
                        </div>

                        <div class="kanban-card" id="kCard1026">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <strong style="color: var(--purple);">#SC1026</strong>
                                <span style="font-size: 11px; font-weight: 700; color: var(--muted);">Slot: 1:15 PM</span>
                            </div>
                            <p style="font-size: 13px; font-weight: 600; margin-bottom: 6px;">1× Chicken Dum Biryani</p>
                            <small style="color: var(--muted); display: block; margin-bottom: 12px;">Student: Rahul V. (ME-08)</small>
                            <div class="kanban-card-actions">
                                <button type="button" class="kanban-action-btn primary" onclick="moveOrder('kCard1026', 'colPrep', 'Cooking Started')">
                                    Start Cooking →
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- COLUMN 2: IN PREPARATION -->
                    <div class="kanban-col" id="colPrep">
                        <div class="kanban-col-header">
                            <span>🍳 In Preparation</span>
                            <span class="kanban-counter">2</span>
                        </div>

                        <div class="kanban-card" id="kCard1024">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <strong style="color: var(--orange);">#SC1024</strong>
                                <span style="font-size: 11px; font-weight: 700; color: var(--orange);">Slot: 12:45 PM</span>
                            </div>
                            <p style="font-size: 13px; font-weight: 600; margin-bottom: 6px;">1× Paneer Pizza, 1× Burger</p>
                            <small style="color: var(--muted); display: block; margin-bottom: 12px;">Student: Aarav Sharma (CS-42)</small>
                            <div class="kanban-card-actions">
                                <button type="button" class="kanban-action-btn success" onclick="moveOrder('kCard1024', 'colReady', 'Marked Ready for Pickup!')">
                                    Ready for Pickup 🔔
                                </button>
                            </div>
                        </div>

                        <div class="kanban-card" id="kCard1023">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <strong style="color: var(--orange);">#SC1023</strong>
                                <span style="font-size: 11px; font-weight: 700; color: var(--orange);">Slot: 12:45 PM</span>
                            </div>
                            <p style="font-size: 13px; font-weight: 600; margin-bottom: 6px;">2× Veg Sandwich, 2× Fries</p>
                            <small style="color: var(--muted); display: block; margin-bottom: 12px;">Prof. Meenakshi (Maths)</small>
                            <div class="kanban-card-actions">
                                <button type="button" class="kanban-action-btn success" onclick="moveOrder('kCard1023', 'colReady', 'Marked Ready for Pickup!')">
                                    Ready for Pickup 🔔
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- COLUMN 3: READY FOR PICKUP -->
                    <div class="kanban-col" id="colReady">
                        <div class="kanban-col-header">
                            <span>🔔 Ready for Pickup</span>
                            <span class="kanban-counter">1</span>
                        </div>

                        <div class="kanban-card" id="kCard1022">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <strong style="color: var(--green-dark);">#SC1022</strong>
                                <span style="font-size: 11px; font-weight: 700; color: var(--green-dark);">Slot: 12:30 PM</span>
                            </div>
                            <p style="font-size: 13px; font-weight: 600; margin-bottom: 6px;">1× Chole Bhature, 1× Lime Soda</p>
                            <small style="color: var(--muted); display: block; margin-bottom: 12px;">Counter #1 Alerted</small>
                            <div class="kanban-card-actions">
                                <button type="button" class="kanban-action-btn" style="background: var(--dark); color: white;" onclick="moveOrder('kCard1022', 'colDone', 'Order Picked Up!')">
                                    Handed Over ✓
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- COLUMN 4: COMPLETED -->
                    <div class="kanban-col" id="colDone">
                        <div class="kanban-col-header">
                            <span>✓ Completed</span>
                            <span class="kanban-counter">1</span>
                        </div>

                        <div class="kanban-card" style="opacity: 0.8;">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <strong style="color: var(--muted);">#SC1021</strong>
                                <span style="font-size: 11px; color: var(--muted);">Slot: 12:15 PM</span>
                            </div>
                            <p style="font-size: 13px; margin-bottom: 6px;">1× Veg Dum Biryani</p>
                            <small style="color: var(--green-dark); font-weight: 700;">Completed at 12:18 PM</small>
                        </div>
                    </div>

                </div>

                <!-- WHY US & KITCHEN OPERATING PRINCIPLES (STAFF GUIDELINES) -->
                <div class="checkout-section-box" id="whyUsKitchen" style="margin-top: 32px; background: #0F172A; border: 1px solid #1E293B;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; flex-wrap: wrap; gap: 12px;">
                        <div>
                            <h3 style="margin-bottom: 4px; color: #F8FAFC;"><span>💡</span> Why Us: Kitchen Operating Principles</h3>
                            <span style="font-size: 13px; color: #94A3B8;">How pre-ordered batching makes campus cooking faster and eliminates counter chaos.</span>
                        </div>
                        <span class="status-badge ready" style="font-size: 12px; padding: 4px 12px; background: rgba(52, 211, 153, 0.15); color: #34D399; border: 1px solid rgba(52, 211, 153, 0.3);">👨‍🍳 Kitchen Staff Protocol</span>
                    </div>

                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 16px;">
                        <div style="padding: 18px; background: #1E293B; border: 1px solid #334155; border-radius: var(--radius-md);">
                            <span style="font-size: 26px; display: block; margin-bottom: 8px;">🏃</span>
                            <strong style="color: #38BDF8; font-size: 14px; display: block; margin-bottom: 4px;">1. Zero Rush Chaos</strong>
                            <p style="font-size: 13px; color: #94A3B8; margin: 0; line-height: 1.5;">Student orders arrive pre-slotted (12:00, 12:15, 12:45 PM), smoothing out break counter crowds so the kitchen is never flooded all at once.</p>
                        </div>
                        <div style="padding: 18px; background: #1E293B; border: 1px solid #334155; border-radius: var(--radius-md);">
                            <span style="font-size: 26px; display: block; margin-bottom: 8px;">🔥</span>
                            <strong style="color: #FB923C; font-size: 14px; display: block; margin-bottom: 4px;">2. Cook On Demand</strong>
                            <p style="font-size: 13px; color: #94A3B8; margin: 0; line-height: 1.5;">Staff clicks 'Start Cooking' 5-8 minutes before the student's pickup slot, ensuring meals are piping hot when collected at the window.</p>
                        </div>
                        <div style="padding: 18px; background: #1E293B; border: 1px solid #334155; border-radius: var(--radius-md);">
                            <span style="font-size: 26px; display: block; margin-bottom: 8px;">🌱</span>
                            <strong style="color: #34D399; font-size: 14px; display: block; margin-bottom: 4px;">3. Zero Food Waste</strong>
                            <p style="font-size: 13px; color: #94A3B8; margin: 0; line-height: 1.5;">The kitchen only cooks food that students have already ordered and prepaid, eliminating leftover food waste at day's end.</p>
                        </div>
                    </div>
                </div>

            </div>

        </main>

    </div>

    <div id="toast-container" class="toast-container"></div>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // STRICT ROLE ENFORCEMENT: ONLY KITCHEN STAFF CAN ACCESS KDS AND START COOKING
        document.addEventListener('DOMContentLoaded', () => {
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            if (!savedUserStr) {
                alert('🔒 Login Required: Kitchen staff credentials required to access KDS.');
                window.location.href = '${pageContext.request.contextPath}/login.jsp?error=staff_only';
                return;
            }

            const currentUser = JSON.parse(savedUserStr);
            const role = (currentUser.role || '').toLowerCase();

            if (role === 'student') {
                alert('⛔ Access Denied: Students can only order and track food. Only Canteen Staff can operate kitchen KDS.');
                window.location.href = '${pageContext.request.contextPath}/dashboard.jsp';
                return;
            } else if (role === 'admin') {
                alert('⛔ Kitchen Restricted: Admin accounts maintain records and telemetry only. Only Kitchen Staff can start cooking or mark food ready.');
                window.location.href = '${pageContext.request.contextPath}/admin-dashboard.jsp';
                return;
            } else if (role !== 'staff' && role !== 'kitchen' && role !== 'chef' && role !== 'lecturer') {
                alert('⛔ Access Denied: Only authorized kitchen staff accounts can access this terminal.');
                window.location.href = '${pageContext.request.contextPath}/login.jsp?error=staff_only';
                return;
            }

            renderKitchenLiveKanban();
        });

        // Default demo cards when no local student orders exist yet
        const defaultOrders = [
            { orderId: 'SC1025', customer: { name: 'Priya Nair (EC-12)' }, pickupSlot: '1:00 PM', items: [{ name: 'Masala Dosa', quantity: 2 }, { name: 'Cold Coffee', quantity: 1 }], status: 'New' },
            { orderId: 'SC1026', customer: { name: 'Rahul V. (ME-08)' }, pickupSlot: '1:15 PM', items: [{ name: 'Chicken Dum Biryani', quantity: 1 }], status: 'New' },
            { orderId: 'SC1024', customer: { name: 'Aarav Sharma (CS-42)' }, pickupSlot: '12:45 PM', items: [{ name: 'Paneer Pizza', quantity: 1 }, { name: 'Campus Burger', quantity: 1 }], status: 'Preparing' },
            { orderId: 'SC1023', customer: { name: 'Prof. Meenakshi' }, pickupSlot: '12:45 PM', items: [{ name: 'Veg Sandwich', quantity: 2 }, { name: 'Fries', quantity: 2 }], status: 'Preparing' },
            { orderId: 'SC1022', customer: { name: 'Counter #1 Alert' }, pickupSlot: '12:30 PM', items: [{ name: 'Chole Bhature', quantity: 1 }, { name: 'Lime Soda', quantity: 1 }], status: 'Ready' },
            { orderId: 'SC1021', customer: { name: 'Karan Patel' }, pickupSlot: '12:15 PM', items: [{ name: 'Veg Dum Biryani', quantity: 1 }], status: 'Completed' }
        ];

        function getActiveKitchenOrders() {
            let savedOrders = JSON.parse(localStorage.getItem('smartcanteen_orders') || '[]');
            if (savedOrders.length === 0) {
                return defaultOrders;
            }
            // Merge custom student orders with defaults
            const orderMap = new Map();
            defaultOrders.forEach(o => orderMap.set(String(o.orderId), o));
            savedOrders.forEach(o => orderMap.set(String(o.orderId), o));
            return Array.from(orderMap.values());
        }

        function renderKitchenLiveKanban() {
            const orders = getActiveKitchenOrders();

            const colNew = document.getElementById('colNew');
            const colPrep = document.getElementById('colPrep');
            const colReady = document.getElementById('colReady');
            const colDone = document.getElementById('colDone');

            let countNew = 0, countPrep = 0, countReady = 0, countDone = 0;

            // Clear columns but keep headers
            colNew.querySelectorAll('.kds-ticket-card, .kanban-card').forEach(c => c.remove());
            colPrep.querySelectorAll('.kds-ticket-card, .kanban-card').forEach(c => c.remove());
            colReady.querySelectorAll('.kds-ticket-card, .kanban-card').forEach(c => c.remove());
            colDone.querySelectorAll('.kds-ticket-card, .kanban-card').forEach(c => c.remove());

            orders.forEach(o => {
                const status = (o.status || 'New').toLowerCase();
                const custName = o.customer ? (o.customer.name || o.customer.email || 'Student') : (o.userEmail || 'Student');
                const itemsSummary = (o.items || []).map(i => i.quantity + '× ' + i.name).join(', ') || 'Hot Meal';
                const card = document.createElement('div');

                if (status === 'new' || status === 'placed') {
                    countNew++;
                    card.className = 'kds-ticket-card status-new';
                    card.innerHTML = 
                        '<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">' +
                            '<strong style="color: #FBBF24; font-size: 15px; font-family: \'Space Grotesk\', monospace;">#' + o.orderId + '</strong>' +
                            '<span class="kds-timer-badge">⏳ Slot: ' + (o.pickupSlot || '12:45 PM') + '</span>' +
                        '</div>' +
                        '<div style="font-size: 14px; font-weight: 700; color: #F8FAFC; margin-bottom: 8px; line-height: 1.4;">' + itemsSummary + '</div>' +
                        '<div style="font-size: 12px; color: #94A3B8; margin-bottom: 14px;">Student: <strong style="color:#CBD5E1;">' + custName + '</strong></div>' +
                        '<div class="kanban-card-actions">' +
                            '<button type="button" class="kds-btn-start" onclick="updateOrderStatus(\'' + o.orderId + '\', \'Preparing\', \'🔥 Cooking Started for Order #' + o.orderId + '\')">' +
                                '🔥 Start Cooking →' +
                            '</button>' +
                        '</div>';
                    colNew.appendChild(card);
                } else if (status === 'preparing') {
                    countPrep++;
                    card.className = 'kds-ticket-card status-prep';
                    card.innerHTML = 
                        '<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">' +
                            '<strong style="color: #FB923C; font-size: 15px; font-family: \'Space Grotesk\', monospace;">#' + o.orderId + '</strong>' +
                            '<span class="kds-timer-badge" style="background: rgba(251, 146, 60, 0.2); color: #FB923C;">🔥 ON GRILL / STOVE</span>' +
                        '</div>' +
                        '<div style="font-size: 14px; font-weight: 700; color: #F8FAFC; margin-bottom: 8px; line-height: 1.4;">' + itemsSummary + '</div>' +
                        '<div style="font-size: 12px; color: #94A3B8; margin-bottom: 14px;">Pickup Slot: <strong style="color:#FDBA74;">' + (o.pickupSlot || '12:45 PM') + '</strong> (' + custName + ')</div>' +
                        '<div class="kanban-card-actions">' +
                            '<button type="button" class="kds-btn-ready" onclick="updateOrderStatus(\'' + o.orderId + '\', \'Ready\', \'🔔 Marked Order #' + o.orderId + ' Ready for Pickup!\')">' +
                                '🔔 Ready for Pickup' +
                            '</button>' +
                        '</div>';
                    colPrep.appendChild(card);
                } else if (status === 'ready') {
                    countReady++;
                    card.className = 'kds-ticket-card status-ready';
                    card.innerHTML = 
                        '<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">' +
                            '<strong style="color: #34D399; font-size: 15px; font-family: \'Space Grotesk\', monospace;">#' + o.orderId + '</strong>' +
                            '<span class="kds-timer-badge" style="background: rgba(52, 211, 153, 0.2); color: #34D399;">🔔 AT COUNTER #1</span>' +
                        '</div>' +
                        '<div style="font-size: 14px; font-weight: 700; color: #F8FAFC; margin-bottom: 8px; line-height: 1.4;">' + itemsSummary + '</div>' +
                        '<div style="font-size: 12px; color: #94A3B8; margin-bottom: 14px;">Student: <strong style="color:#A7F3D0;">' + custName + '</strong></div>' +
                        '<div class="kanban-card-actions">' +
                            '<button type="button" class="kds-btn-done" onclick="updateOrderStatus(\'' + o.orderId + '\', \'Completed\', \'✓ Order #' + o.orderId + ' Handed Over!\')">' +
                                '✓ Handed Over / Collected' +
                            '</button>' +
                        '</div>';
                    colReady.appendChild(card);
                } else {
                    countDone++;
                    card.className = 'kds-ticket-card status-done';
                    card.innerHTML = 
                        '<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">' +
                            '<strong style="color: #94A3B8; font-size: 14px; font-family: \'Space Grotesk\', monospace;">#' + o.orderId + '</strong>' +
                            '<span style="font-size: 11px; color: #64748B;">Slot: ' + (o.pickupSlot || '12:45 PM') + '</span>' +
                        '</div>' +
                        '<div style="font-size: 13px; color: #94A3B8; margin-bottom: 6px;">' + itemsSummary + '</div>' +
                        '<small style="color: #34D399; font-weight: 700;">✓ Collected by Student</small>';
                    colDone.appendChild(card);
                }
            });

            // Update column badge counters
            const newCounter = colNew.querySelector('.kanban-counter');
            const prepCounter = colPrep.querySelector('.kanban-counter');
            const readyCounter = colReady.querySelector('.kanban-counter');
            const doneCounter = colDone.querySelector('.kanban-counter');

            if (newCounter) newCounter.textContent = countNew;
            if (prepCounter) prepCounter.textContent = countPrep;
            if (readyCounter) readyCounter.textContent = countReady;
            if (doneCounter) doneCounter.textContent = countDone;
        }

        function updateOrderStatus(orderId, newStatus, toastMsg) {
            // Strict role guard: only staff can change status
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            const currentUser = savedUserStr ? JSON.parse(savedUserStr) : null;
            const role = currentUser ? (currentUser.role || '').toLowerCase() : '';
            if (role !== 'staff' && role !== 'kitchen' && role !== 'chef' && role !== 'lecturer') {
                alert('⛔ Action Denied: Only Kitchen Staff are authorized to start cooking or mark food ready.');
                return;
            }

            let savedOrders = JSON.parse(localStorage.getItem('smartcanteen_orders') || '[]');
            let found = false;

            savedOrders = savedOrders.map(o => {
                if (String(o.orderId) === String(orderId)) {
                    o.status = newStatus;
                    found = true;
                }
                return o;
            });

            if (!found) {
                // If it's one of the default orders, add it to savedOrders
                const def = defaultOrders.find(d => String(d.orderId) === String(orderId));
                if (def) {
                    const cloned = JSON.parse(JSON.stringify(def));
                    cloned.status = newStatus;
                    savedOrders.push(cloned);
                }
            }

            localStorage.setItem('smartcanteen_orders', JSON.stringify(savedOrders));
            
            // Asynchronous AJAX Request: Sync order status with Tomcat backend
            fetch('OrderAjaxServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({
                    action: 'updateStatus',
                    orderId: orderId,
                    status: newStatus
                })
            }).then(r => r.json()).then(data => {
                console.log('AJAX Order Status Synced:', data);
            }).catch(err => {
                console.log('AJAX connection handled, local state preserved:', err);
            });

            showToast(toastMsg);
            renderKitchenLiveKanban();
        }
    </script>
</body>
</html>
