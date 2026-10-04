<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentRole = (String) session.getAttribute("userRole");
    if (currentRole == null && session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=login_required&redirect=dashboard.jsp");
        return;
    }
    if (currentRole != null) {
        if ("Admin".equalsIgnoreCase(currentRole)) {
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
            return;
        } else if ("Staff".equalsIgnoreCase(currentRole) || "Kitchen".equalsIgnoreCase(currentRole) || "Chef".equalsIgnoreCase(currentRole) || "Lecturer".equalsIgnoreCase(currentRole)) {
            response.sendRedirect(request.getContextPath() + "/staff-dashboard.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
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
                <span class="sidebar-menu-title">Main Portal</span>
                <li>
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="sidebar-link active">
                        <span class="icon">🏠</span> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/menu.jsp" class="sidebar-link">
                        <span class="icon">🍔</span> Campus Menu
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/cart.jsp" class="sidebar-link">
                        <span class="icon">🛒</span> Food Tray
                        <span class="badge cart-badge" style="display:none;">0</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/orders.jsp" class="sidebar-link">
                        <span class="icon">📦</span> My Orders
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/profile.jsp" class="sidebar-link">
                        <span class="icon">❤️</span> Favourites
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/profile.jsp" class="sidebar-link">
                        <span class="icon">👤</span> Profile
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="handleStudentLogout(event)" class="sidebar-link" style="color: #F87171 !important;">
                        <span class="icon">🚪</span> Logout
                    </a>
                </li>
            </ul>

            <div class="sidebar-user">
                <div class="user-avatar" id="dashUserAvatar">${sessionScope.userName != null && sessionScope.userName.length() > 0 ? sessionScope.userName.substring(0, 1) : 'U'}</div>
                <div class="user-info">
                    <strong id="dashUserName">${sessionScope.userName != null ? sessionScope.userName : 'Student'}</strong>
                    <small id="dashUserEmail">${sessionScope.userEmail != null ? sessionScope.userEmail : 'student@smartcanteen.com'}</small>
                </div>
                <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="handleStudentLogout(event)" title="Sign Out" style="margin-left: auto; color: #F87171; font-size: 14px; padding: 6px 10px; border-radius: 8px; display: inline-flex; align-items: center; background: rgba(239, 68, 68, 0.12); border: 1px solid rgba(239, 68, 68, 0.3); text-decoration: none;">
                    🚪
                </a>
            </div>
        </aside>

        <!-- MAIN CANVAS -->
        <main class="main-content">
            
            <!-- TOPBAR -->
            <header class="topbar">
                <div class="topbar-title">
                    <h2>Welcome, <span id="dashWelcomeName">${sessionScope.userName != null ? sessionScope.userName : 'Student'}</span> 👋</h2>
                    <p style="font-size: 13px; color: var(--muted);">Ready for something delicious from the campus canteen?</p>
                </div>

                <div class="topbar-actions">
                    <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-cart">
                        <span>🛒</span>
                        <span class="cart-nav-text">Cart</span>
                        <span class="cart-badge" style="display:none;">0</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/orders.jsp" class="topbar-btn" title="My Orders">
                        📦
                    </a>
                    <!-- PROMINENT VISIBLE LOGOUT BUTTON -->
                    <a href="${pageContext.request.contextPath}/LogoutServlet" onclick="handleStudentLogout(event)" class="topbar-logout" title="Sign out of your account">
                        <span style="font-size: 15px;">🚪</span>
                        <span>Logout</span>
                    </a>
                </div>
            </header>

            <!-- DASHBOARD BODY -->
            <div class="dashboard-body">
                
                <!-- CATEGORY QUICK FILTER BAR -->
                <div class="genz-vibe-bar">
                    <button type="button" class="vibe-pill active" onclick="switchVibe('all', this)">🍽️ All Specials</button>
                    <button type="button" class="vibe-pill" onclick="switchVibe('broke', this)">🥞 Budget Bites (&lt; ₹40)</button>
                    <button type="button" class="vibe-pill" onclick="switchVibe('study', this)">☕ Beverages & Fuel</button>
                    <button type="button" class="vibe-pill" onclick="switchVibe('rush', this)">⚡ Quick Prep (2-5 min)</button>
                    <button type="button" class="vibe-pill" onclick="switchVibe('trending', this)">🔥 Campus Favourites</button>
                    <button type="button" class="vibe-pill" onclick="switchVibe('comfort', this)">🍛 Meals & Biryani</button>
                </div>

                <!-- BENTO HERO GRID: MEAL PASS + CAMPUS WALLET -->
                <div class="genz-bento-hero">
                    <!-- BENTO TILE 1: DYNAMIC ACTIVE ORDER MEAL PASS -->
                    <div id="dashActiveTrackerContainer"></div>

                    <!-- BENTO TILE 2: CAMPUS WALLET & STREAK PERKS -->
                    <div style="background: #181C26; border: 1px solid var(--border); border-radius: 20px; padding: 24px; display: flex; flex-direction: column; justify-content: space-between; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);">
                        <div>
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                                <span style="font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 1px; color: #F59E0B;">💳 SMART CANTEEN WALLET</span>
                                <span style="background: rgba(16, 185, 129, 0.2); color: #34D399; border: 1px solid rgba(16, 185, 129, 0.3); font-size: 11px; font-weight: 800; padding: 2px 8px; border-radius: 12px;">TAP-TO-PAY</span>
                            </div>
                            <div style="font-size: 34px; font-family: 'Space Grotesk', sans-serif; font-weight: 800; color: var(--dark); margin-bottom: 4px;">
                                ₹450.00
                            </div>
                            <p style="font-size: 12px; color: var(--muted); margin-bottom: 16px;">Contactless campus balance. Auto-debits when order is prepared.</p>
                        </div>

                        <div style="background: #12151D; border-radius: 14px; padding: 14px; border: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between;">
                            <div>
                                <div style="font-size: 13px; font-weight: 700; color: var(--dark);">🔥 Active Food Pass</div>
                                <div style="font-size: 11px; color: var(--muted);">Direct pickup counter clearance</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/menu.jsp" class="primary-btn" style="padding: 8px 16px; font-size: 12px; border-radius: 10px; text-decoration: none;">+ Order</a>
                        </div>
                    </div>
                </div>

                <!-- STUDENT 3 CORE ACTIONS BAR -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px; margin-bottom: 28px;">
                    <a href="${pageContext.request.contextPath}/menu.jsp" class="genz-action-pill-card">
                        <span style="font-size: 26px; background: #12151D; border: 1px solid var(--border); width: 50px; height: 50px; border-radius: 14px; display: grid; place-items: center;">🍽️</span>
                        <div>
                            <strong style="color: var(--dark); font-size: 14px; display: block; font-family: 'Space Grotesk', sans-serif;">1. Order Food</strong>
                            <small style="color: var(--muted); font-size: 12px;">Browse 22+ freshly made campus items</small>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/cart.jsp" class="genz-action-pill-card">
                        <span style="font-size: 26px; background: #12151D; border: 1px solid var(--border); width: 50px; height: 50px; border-radius: 14px; display: grid; place-items: center;">💳</span>
                        <div>
                            <strong style="color: var(--dark); font-size: 14px; display: block; font-family: 'Space Grotesk', sans-serif;">2. Food Tray & Checkout</strong>
                            <small style="color: var(--muted); font-size: 12px;">Instant UPI, Campus Card or Cash</small>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/orders.jsp" class="genz-action-pill-card">
                        <span style="font-size: 26px; background: #12151D; border: 1px solid var(--border); width: 50px; height: 50px; border-radius: 14px; display: grid; place-items: center;">📍</span>
                        <div>
                            <strong style="color: var(--dark); font-size: 14px; display: block; font-family: 'Space Grotesk', sans-serif;">3. Live Order Tracking</strong>
                            <small style="color: var(--muted); font-size: 12px;">Live kitchen updates & pickup token</small>
                        </div>
                    </a>
                </div>

                <!-- TWO COLUMN LAYOUT: RECENT ORDERS & VIBE PICKS -->
                <div style="display: grid; grid-template-columns: 1.2fr 0.8fr; gap: 30px; align-items: start;">
                    
                    <!-- RECENT ORDERS (FOR THIS STUDENT ACCOUNT) -->
                    <div class="checkout-section-box">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                            <h3 style="margin-bottom: 0;"><span>📦</span> Your Recent Deliveries & Orders</h3>
                            <a href="${pageContext.request.contextPath}/orders.jsp" style="font-size: 13px; color: var(--purple); font-weight: 700; text-decoration: none;">
                                View All <span>→</span>
                            </a>
                        </div>

                        <div id="dashRecentOrdersList">
                            <!-- Populated dynamically for logged-in user -->
                        </div>
                    </div>

                    <!-- VIBE & BROKE STUDENT PICKS -->
                    <div class="checkout-section-box">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                            <h3 style="margin-bottom: 0;"><span id="vibePicksIcon">🔥</span> <span id="vibePicksTitle">Featured Campus Picks</span></h3>
                            <span style="font-size: 11px; background: #FAF5FF; color: var(--purple); padding: 3px 8px; border-radius: 8px; font-weight: 700;">1-TAP ADD</span>
                        </div>

                        <div id="vibeRecommendationsGrid" style="display: flex; flex-direction: column; gap: 14px;">
                            <!-- Dynamically loaded based on vibe selection -->
                        </div>

                        <a href="${pageContext.request.contextPath}/menu.jsp" class="secondary-btn" style="display: block; text-align: center; margin-top: 20px; font-size: 13px; text-decoration: none;">
                            Explore Full 22+ Item Menu <span>→</span>
                        </a>
                    </div>

                </div>

            </div>

        </main>

    </div>

    <div id="toast-container" class="toast-container"></div>
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

        function handleStudentLogout(e) {
            localStorage.removeItem('smartcanteen_logged_in_user');
            sessionStorage.removeItem('smartcanteen_user');
            sessionStorage.removeItem('smartcanteen_last_order');
        }

        document.addEventListener('DOMContentLoaded', () => {
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            
            // 1. Mandatory login check
            if (!savedUserStr) {
                window.location.href = '${pageContext.request.contextPath}/login.jsp?error=login_required&redirect=dashboard.jsp';
                return;
            }

            const currentUser = JSON.parse(savedUserStr);
            const currentRole = currentUser && currentUser.role ? currentUser.role : 'Student';
            const currentEmail = currentUser && currentUser.email ? currentUser.email.trim().toLowerCase() : '';

            // 2. Redirect admin and staff to their dedicated portals
            if (currentRole === 'Admin') {
                window.location.href = '${pageContext.request.contextPath}/admin-dashboard.jsp';
                return;
            } else if (currentRole === 'Staff' || currentRole === 'Kitchen' || currentRole === 'Chef' || currentRole === 'Lecturer') {
                window.location.href = '${pageContext.request.contextPath}/staff-dashboard.jsp';
                return;
            }

            if (currentUser) {
                const nameEl = document.getElementById('dashUserName');
                const welcomeEl = document.getElementById('dashWelcomeName');
                const avatarEl = document.getElementById('dashUserAvatar');
                const emailEl = document.getElementById('dashUserEmail');

                if (nameEl) nameEl.textContent = currentUser.name || 'Student';
                if (welcomeEl) welcomeEl.textContent = currentUser.name ? currentUser.name.split(' ')[0] : 'Student';
                if (emailEl) emailEl.textContent = currentUser.email || '';
                if (avatarEl && currentUser.name) {
                    const initials = currentUser.name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase();
                    avatarEl.textContent = initials;
                }
            }

            // Load orders strictly for this logged-in student account
            const allOrders = JSON.parse(localStorage.getItem('smartcanteen_orders') || '[]');
            const userOrders = allOrders.filter(o => {
                if (!currentEmail) return false;
                const orderEmail = (o.userEmail || (o.customer && o.customer.email) || '').trim().toLowerCase();
                return orderEmail === currentEmail;
            });

            // Update order count badge
            const countEl = document.getElementById('dashOrderCount');
            if (countEl) countEl.textContent = userOrders.length + (userOrders.length === 1 ? ' Order' : ' Orders');

            // Find active order (Preparing or Ready)
            const activeOrder = userOrders.find(o => (o.status || '').toLowerCase() === 'preparing' || (o.status || '').toLowerCase() === 'ready');
            const trackerContainer = document.getElementById('dashActiveTrackerContainer');

            if (trackerContainer) {
                if (activeOrder) {
                    const itemNames = (activeOrder.items || []).map(i => i.name).join(', ') || 'Hot Campus Meal';
                    const isReady = (activeOrder.status || '').toLowerCase() === 'ready';
                    trackerContainer.innerHTML = 
                        '<div class="genz-pass-card">' +
                            '<div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px;">' +
                                '<div>' +
                                    '<span style="font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: #A78BFA; font-weight: 800;">' +
                                        'CAMPUS DIGITAL MEAL PASS • COUNTER #2' +
                                    '</span>' +
                                    '<h3 style="color: #FFF; font-size: 22px; margin: 4px 0 2px 0; font-family: \'Space Grotesk\', sans-serif;">Token #' + activeOrder.orderId + '</h3>' +
                                    '<span style="font-size: 13px; color: #C4B5FD;">' + itemNames + '</span>' +
                                '</div>' +
                                '<div class="tracker-status-pill" style="background: rgba(' + (isReady ? '52, 211, 153' : '251, 146, 60') + ', 0.2); color: ' + (isReady ? '#34D399' : '#FB923C') + '; border: 1px solid rgba(' + (isReady ? '52, 211, 153' : '251, 146, 60') + ', 0.3);">' +
                                    '<span class="pulse-dot" style="background: ' + (isReady ? '#34D399' : '#FB923C') + ';"></span>' +
                                    '<span>' + (isReady ? 'Ready for Pickup!' : 'Kitchen is Cooking') + '</span>' +
                                '</div>' +
                            '</div>' +
                            '<div style="background: rgba(255,255,255,0.06); padding: 12px 16px; border-radius: 12px; margin-bottom: 16px; display: flex; justify-content: space-between; align-items: center;">' +
                                '<div>' +
                                    '<small style="color: #9CA3AF; font-size: 11px; display: block;">PICKUP BREAK SLOT</small>' +
                                    '<strong style="color: #FFF; font-size: 14px;">' + (activeOrder.pickupSlot || '12:45 PM') + '</strong>' +
                                '</div>' +
                                '<div style="text-align: right;">' +
                                    '<small style="color: #9CA3AF; font-size: 11px; display: block;">PICKUP WINDOW</small>' +
                                    '<strong style="color: #38BDF8; font-size: 14px;">Express Gate #2</strong>' +
                                '</div>' +
                            '</div>' +
                            '<div class="progress-track">' +
                                '<div class="progress-line"><div class="progress-line-fill" style="width: ' + (isReady ? '75%' : '45%') + ';"></div></div>' +
                                '<div class="progress-step done"><div class="step-node">✓</div><span style="color:#C4B5FD;">Placed</span></div>' +
                                '<div class="progress-step done"><div class="step-node">🔥</div><span style="color:#C4B5FD;">In Kitchen</span></div>' +
                                '<div class="progress-step ' + (isReady ? 'done' : '') + '"><div class="step-node">🔔</div><span style="color:#C4B5FD;">Ready</span></div>' +
                                '<div class="progress-step"><div class="step-node">😋</div><span style="color:#C4B5FD;">Collected</span></div>' +
                            '</div>' +
                        '</div>';
                } else {
                    trackerContainer.innerHTML = 
                        '<div class="genz-pass-card" style="background: linear-gradient(135deg, #1E1B2E, #2A2544); padding: 24px;">' +
                            '<div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px;">' +
                                '<div>' +
                                    '<span style="font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: #34D399; font-weight: 800;">' +
                                        'NO ACTIVE HUNGER CRISIS 🍟' +
                                    '</span>' +
                                    '<h3 style="color: #FFF; margin: 4px 0 6px 0; font-size: 18px;">Skip the 20-min campus break rush!</h3>' +
                                    '<p style="font-size: 13px; color: #A39DB4; margin: 0;">Pre-order your favorite meal now so it is hot and waiting at the counter.</p>' +
                                '</div>' +
                                '<a href="${pageContext.request.contextPath}/menu.jsp" class="primary-btn" style="padding: 10px 20px; font-size: 13px; border-radius: 12px; text-decoration:none;">+ Order Food</a>' +
                            '</div>' +
                        '</div>';
                }
            }

            // Populate recent orders list strictly for this student account
            const recentContainer = document.getElementById('dashRecentOrdersList');
            if (recentContainer) {
                if (userOrders.length === 0) {
                    recentContainer.innerHTML = 
                        '<div style="text-align: center; padding: 30px 10px; color: var(--muted); font-size: 13px;">' +
                            '<span style="font-size: 28px; display: block; margin-bottom: 6px;">📭</span> No orders placed with this account yet.<br>' +
                            '<a href="${pageContext.request.contextPath}/menu.jsp" style="color: var(--purple); font-weight: 700; display: inline-block; margin-top: 8px; text-decoration: none;">Order from menu →</a>' +
                        '</div>';
                } else {
                    recentContainer.innerHTML = '';
                    userOrders.slice(0, 3).forEach(o => {
                        const itemsSummary = (o.items || []).map(i => i.name + ' × ' + i.quantity).join(', ') || 'Custom meal';
                        const totalDisplay = (o.summary && o.summary.total) ? Number(o.summary.total).toFixed(2) : (o.totalAmount ? Number(o.totalAmount).toFixed(2) : '150.00');
                        const statusClass = (o.status || '').toLowerCase() === 'ready' ? 'ready' : ((o.status || '').toLowerCase() === 'completed' ? 'completed' : 'preparing');

                        const card = document.createElement('div');
                        card.className = 'order-card';
                        card.style.cssText = 'margin-bottom: 12px; padding: 16px;';
                        card.innerHTML = 
                            '<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">' +
                                '<strong>Order #' + o.orderId + '</strong>' +
                                '<span class="status-badge ' + statusClass + '" style="font-size: 11px; padding: 3px 8px;">' + (o.status || 'Preparing') + '</span>' +
                            '</div>' +
                            '<p style="font-size: 13px; color: var(--muted); margin-bottom: 10px;">' + itemsSummary + '</p>' +
                            '<div style="display: flex; justify-content: space-between; align-items: center;">' +
                                '<strong style="color: var(--dark);">₹' + totalDisplay + '</strong>' +
                                '<a href="${pageContext.request.contextPath}/menu.jsp" class="btn-add-cart" style="text-decoration:none; padding: 6px 14px; font-size: 12px;">Order Again</a>' +
                            '</div>';
                        recentContainer.appendChild(card);
                    });
                }
            }

            // Initialize default vibe picks
            renderVibePicks('all');
        });

        // Gen Z Vibe Filter Data & Function
        const vibeData = {
            all: {
                title: 'Featured Campus Picks',
                icon: '🔥',
                items: [
                    { id: '17', name: 'Crispy Samosa (2 pcs)', price: 30, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/samosa.jpg', tag: '💸 Under ₹40' },
                    { id: '15', name: 'Special Masala Tea', price: 15, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/tea.jpg', tag: '☕ Study Fuel' },
                    { id: '22', name: 'Bakery Masala Egg Puff', price: 25, category: 'Snacks', isVeg: false, image: '${pageContext.request.contextPath}/images/puffs.jpg', tag: '⚡ 2-Min Rush' },
                    { id: '21', name: 'Cavin\'s Cold Milkshake', price: 40, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/cavin milkshake.jpg', tag: '⭐ Campus Hit' }
                ]
            },
            broke: {
                title: 'Broke Student Hacks (< ₹40)',
                icon: '💸',
                items: [
                    { id: '15', name: 'Special Masala Tea', price: 15, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/tea.jpg', tag: 'Pocket Saver' },
                    { id: '19', name: 'Crispy Onion Bajji', price: 20, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/bajji.jpg', tag: 'Under ₹25' },
                    { id: '22', name: 'Bakery Masala Egg Puff', price: 25, category: 'Snacks', isVeg: false, image: '${pageContext.request.contextPath}/images/puffs.jpg', tag: 'Steal Deal' },
                    { id: '17', name: 'Crispy Samosa (2 pcs)', price: 30, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/samosa.jpg', tag: 'Crunchy Snack' }
                ]
            },
            study: {
                title: 'Late-Night Study Fuel',
                icon: '☕',
                items: [
                    { id: '16', name: 'Filter Coffee', price: 20, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/coffe.jpg', tag: 'Caffeine Rush' },
                    { id: '15', name: 'Special Masala Tea', price: 15, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/tea.jpg', tag: 'Focus Booster' },
                    { id: '21', name: 'Cavin\'s Cold Milkshake', price: 40, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/cavin milkshake.jpg', tag: 'Brain Fuel' }
                ]
            },
            rush: {
                title: '5-Minute Rush Bites',
                icon: '⚡',
                items: [
                    { id: '22', name: 'Bakery Masala Egg Puff', price: 25, category: 'Snacks', isVeg: false, image: '${pageContext.request.contextPath}/images/puffs.jpg', tag: 'Grab & Go' },
                    { id: '18', name: 'Boiled Egg (2 pcs)', price: 20, category: 'Snacks', isVeg: false, image: '${pageContext.request.contextPath}/images/egg.jpg', tag: 'Protein Rush' },
                    { id: '20', name: 'Golden Potato Bonda', price: 25, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/bonda.jpg', tag: 'Hot & Ready' }
                ]
            },
            trending: {
                title: 'Campus Top Rated',
                icon: '🔥',
                items: [
                    { id: '3', name: 'Chicken Dum Biryani', price: 120, category: 'Lunch', isVeg: false, image: '${pageContext.request.contextPath}/images/biryani.jpg', tag: '#1 Most Ordered' },
                    { id: '5', name: 'Campus Burger', price: 70, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/burger.jpg', tag: '⭐ Student Fav' },
                    { id: '1', name: 'Crispy Masala Dosa', price: 45, category: 'Breakfast', isVeg: true, image: '${pageContext.request.contextPath}/images/dosa.jpg', tag: 'Golden Crisp' }
                ]
            },
            comfort: {
                title: 'Cravings & Comfort Food',
                icon: '🍕',
                items: [
                    { id: '4', name: 'Cheesy Paneer Pizza', price: 90, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/pizza.jpg', tag: 'Double Cheese' },
                    { id: '21', name: 'Cavin\'s Cold Milkshake', price: 40, category: 'Drinks', isVeg: true, image: '${pageContext.request.contextPath}/images/cavin milkshake.jpg', tag: 'Chilled Shake' },
                    { id: '5', name: 'Campus Burger', price: 70, category: 'Snacks', isVeg: true, image: '${pageContext.request.contextPath}/images/burger.jpg', tag: 'Loaded Patty' }
                ]
            }
        };

        function switchVibe(vibeKey, btn) {
            document.querySelectorAll('.vibe-pill').forEach(p => p.classList.remove('active'));
            if (btn) btn.classList.add('active');
            renderVibePicks(vibeKey);
        }

        function renderVibePicks(vibeKey) {
            const data = vibeData[vibeKey] || vibeData.all;
            const titleEl = document.getElementById('vibePicksTitle');
            const iconEl = document.getElementById('vibePicksIcon');
            const grid = document.getElementById('vibeRecommendationsGrid');

            if (titleEl) titleEl.textContent = data.title;
            if (iconEl) iconEl.textContent = data.icon;
            if (!grid) return;

            grid.innerHTML = '';
            data.items.forEach(item => {
                const row = document.createElement('div');
                row.style.cssText = 'display: flex; align-items: center; gap: 14px; padding: 12px; background: #FAF9FE; border-radius: var(--radius-md); border: 1px solid var(--border); transition: transform 0.2s;';
                row.onmouseover = () => row.style.transform = 'translateY(-2px)';
                row.onmouseout = () => row.style.transform = 'translateY(0)';

                row.innerHTML = 
                    '<img src="' + item.image + '" alt="' + item.name + '" style="width: 52px; height: 52px; border-radius: 12px; object-fit: cover;">' +
                    '<div style="flex: 1;">' +
                        '<div style="display: flex; align-items: center; gap: 6px; margin-bottom: 2px;">' +
                            '<strong style="font-size: 14px; color: var(--dark);">' + item.name + '</strong>' +
                            '<span style="font-size: 10px; background: rgba(124, 58, 237, 0.1); color: var(--purple); padding: 1px 6px; border-radius: 6px; font-weight: 700;">' + item.tag + '</span>' +
                        '</div>' +
                        '<span style="font-size: 13px; color: var(--purple); font-weight: 800;">₹' + item.price + '</span>' +
                    '</div>' +
                    '<button type="button" class="btn-add-cart" style="padding: 6px 12px; font-size: 13px;" onclick="CartManager.addItem({id:\'' + item.id + '\', name:\'' + item.name + '\', price:' + item.price + ', category:\'' + item.category + '\', isVeg:' + item.isVeg + ', image:\'' + item.image + '\'});">' +
                        '+ Add' +
                    '</button>';
                grid.appendChild(row);
            });
        }
    </script>
</body>
</html>
