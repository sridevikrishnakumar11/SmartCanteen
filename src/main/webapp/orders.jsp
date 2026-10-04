<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userRole = (String) session.getAttribute("userRole");
    if (userRole != null) {
        if ("Admin".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp#liveOrders");
            return;
        } else if ("Staff".equalsIgnoreCase(userRole) || "Kitchen".equalsIgnoreCase(userRole) || "Chef".equalsIgnoreCase(userRole)) {
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
    <title>My Orders | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>

    <!-- NAVBAR -->
    <div class="navbar-wrapper">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <span class="logo-icon">🍽️</span>
                <span>Smart<span>Canteen</span></span>
            </a>

            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/menu.jsp">Menu</a>
                <a href="${pageContext.request.contextPath}/orders.jsp" class="active">My Orders</a>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a>
            </div>

            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-cart">
                    <span>🛒</span>
                    <span class="cart-nav-text">Cart</span>
                    <span class="cart-badge" style="display:none;">0</span>
                </a>
                <a href="${pageContext.request.contextPath}/profile.jsp" class="nav-login">
                    Profile <span>👤</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- MAIN ORDERS VIEW -->
    <div class="container" style="margin-top: 40px; margin-bottom: 80px;">
        
        <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 30px; flex-wrap: wrap; gap: 16px;">
            <div>
                <h1 style="font-family: var(--font-heading); font-size: 34px; letter-spacing: -1px;">
                    Order History & Live Tokens
                </h1>
                <p style="color: var(--muted); font-size: 15px;">
                    Track live kitchen preparation, show your pickup token, or reorder previous favourites.
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/menu.jsp" class="primary-btn">
                + New Order
            </a>
        </div>

        <!-- FILTER TABS -->
        <div class="orders-filter-tabs">
            <button class="category-filter-btn active" onclick="filterOrderList('all', this)">All Orders</button>
            <button class="category-filter-btn" onclick="filterOrderList('active', this)">Active / In Kitchen</button>
            <button class="category-filter-btn" onclick="filterOrderList('completed', this)">Past Completed</button>
        </div>

        <!-- DYNAMIC ORDERS CONTAINER -->
        <div id="dynamicOrdersContainer"></div>

    </div>

    <!-- FOOTER -->
    <footer>
        <div class="footer-inner">
            <div class="footer-brand">
                <div class="logo">
                    <span class="logo-icon">🍽️</span>
                    <span>Smart<span>Canteen</span></span>
                </div>
                <p>Making campus food smarter, one order at a time.</p>
            </div>
            <div class="footer-col">
                <h4>Navigation</h4>
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/menu.jsp">Menu</a>
                <a href="${pageContext.request.contextPath}/cart.jsp">Tray</a>
            </div>
            <div class="footer-col">
                <h4>Account</h4>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a>
                <a href="${pageContext.request.contextPath}/profile.jsp">Profile</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2026 SmartCanteen</span>
            <span>Java Web Technology Lab Project</span>
        </div>
    </footer>

    <div id="toast-container" class="toast-container"></div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Render dynamic orders strictly belonging to the logged-in student
        function loadDynamicOrders() {
            try {
                const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
                const currentUser = savedUserStr ? JSON.parse(savedUserStr) : null;
                const container = document.getElementById('dynamicOrdersContainer');
                if (!container) return;

                // 1. Guard against unauthenticated visitors
                if (!currentUser) {
                    container.innerHTML = 
                        '<div class="empty-orders-card" style="text-align: center; padding: 60px 20px; background: #181C26; border-radius: var(--radius-lg); border: 1px solid #1D4ED8; box-shadow: 0 4px 20px rgba(0,0,0,0.4);">' +
                            '<span style="font-size: 52px; display: block; margin-bottom: 12px;">🔒</span>' +
                            '<h3 style="font-family: var(--font-heading); font-size: 24px; color: #60A5FA; margin-bottom: 8px;">Login Required to View Orders</h3>' +
                            '<p style="color: var(--muted); font-size: 15px; max-width: 440px; margin: 0 auto 24px auto;">' +
                                'Please sign in to track live meal preparation and view your digital pickup tokens.' +
                            '</p>' +
                            '<div style="display: flex; gap: 12px; justify-content: center; flex-wrap: wrap;">' +
                                '<a href="${pageContext.request.contextPath}/login.jsp?error=login_required&redirect=orders.jsp" class="primary-btn" style="display: inline-flex; padding: 12px 24px;">Sign In Now →</a>' +
                                '<a href="${pageContext.request.contextPath}/menu.jsp" class="secondary-btn" style="display: inline-flex; padding: 12px 24px;">Browse Menu</a>' +
                            '</div>' +
                        '</div>';
                    return;
                }

                const currentRole = (currentUser.role || 'Student').toLowerCase();

                // 2. Role redirection: Admin only maintains records; Staff only cooks
                if (currentRole === 'admin') {
                    window.location.href = '${pageContext.request.contextPath}/admin-dashboard.jsp#liveOrders';
                    return;
                }
                if (currentRole === 'staff' || currentRole === 'kitchen' || currentRole === 'chef') {
                    window.location.href = '${pageContext.request.contextPath}/staff-dashboard.jsp';
                    return;
                }

                // 3. Students see strictly their own orders
                const currentEmail = (currentUser.email || '').trim().toLowerCase();
                const allOrders = JSON.parse(localStorage.getItem('smartcanteen_orders') || '[]');
                
                const userOrders = allOrders.filter(o => {
                    if (!currentEmail) return false;
                    const orderEmail = (o.userEmail || (o.customer && o.customer.email) || '').trim().toLowerCase();
                    return orderEmail === currentEmail;
                });

                container.innerHTML = '';

                if (userOrders.length === 0) {
                    const emptyCard = document.createElement('div');
                    emptyCard.className = 'empty-orders-card';
                    emptyCard.style.cssText = 'text-align: center; padding: 60px 20px; background: #181C26; border-radius: var(--radius-lg); border: 1px solid var(--border); box-shadow: 0 4px 18px rgba(0,0,0,0.3);';
                    emptyCard.innerHTML = 
                        '<span style="font-size: 52px; display: block; margin-bottom: 12px;">📦</span>' +
                        '<h3 style="font-family: var(--font-heading); font-size: 22px; color: var(--dark); margin-bottom: 8px;">No orders placed yet</h3>' +
                        '<p style="color: var(--muted); font-size: 14px; max-width: 440px; margin: 0 auto 24px auto;">' +
                            'Logged in as <strong>' + (currentUser.name || currentUser.email) + '</strong> (' + currentUser.email + '). You do not have any active or past orders yet.' +
                        '</p>' +
                        '<a href="${pageContext.request.contextPath}/menu.jsp" class="primary-btn" style="display: inline-flex; padding: 12px 24px;">+ Explore Campus Menu</a>';
                    container.appendChild(emptyCard);
                    return;
                }

                userOrders.forEach(o => {
                    const card = document.createElement('div');
                    card.className = 'order-card';
                    card.setAttribute('data-order-id', o.orderId);
                    card.style.cssText = 'background: #161A24; border: 1px solid #242938; border-radius: 16px; margin-bottom: 20px; padding: 22px;';
                    
                    const orderStatus = o.status || 'Preparing';
                    const isCompleted = orderStatus.toLowerCase() === 'completed' || orderStatus.toLowerCase() === 'collected';
                    card.setAttribute('data-order-status', isCompleted ? 'completed' : 'active');
                    
                    let itemsHtml = '';
                    if (o.items && o.items.length) {
                        o.items.forEach(it => {
                            const lineTotal = (it.price * it.quantity).toFixed(2);
                            itemsHtml += '<div class="order-item-line" style="display: flex; justify-content: space-between; padding: 6px 0; border-bottom: 1px solid #1E2330; font-size: 14px; color: #D1D5DB;">' +
                                '<span>' + it.name + ' × ' + it.quantity + '</span>' +
                                '<strong>₹' + lineTotal + '</strong>' +
                            '</div>';
                        });
                    }

                    const totalDisplay = (o.summary && o.summary.total) ? Number(o.summary.total).toFixed(2) : (o.totalAmount ? Number(o.totalAmount).toFixed(2) : '150.00');
                    const orderTime = o.time || o.date || 'Today';
                    const pickupSlot = o.pickupSlot || '12:45 PM';

                    let badgeClass = 'preparing';
                    let badgeIcon = '●';
                    let badgeStyle = 'background: rgba(245, 158, 11, 0.15); color: #F59E0B; border: 1px solid rgba(245, 158, 11, 0.3);';
                    if (orderStatus.toLowerCase() === 'ready') {
                        badgeClass = 'ready';
                        badgeIcon = '🔔';
                        badgeStyle = 'background: rgba(16, 185, 129, 0.15); color: #10B981; border: 1px solid rgba(16, 185, 129, 0.3);';
                    } else if (isCompleted) {
                        badgeClass = 'completed';
                        badgeIcon = '✓';
                        badgeStyle = 'background: rgba(100, 116, 139, 0.15); color: #94A3B8; border: 1px solid rgba(100, 116, 139, 0.3);';
                    }

                    card.innerHTML = 
                        '<div class="order-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">' +
                            '<div>' +
                                '<strong style="font-family: var(--font-heading); font-size: 18px; color: #F59E0B;">' +
                                    'Order #' + o.orderId +
                                '</strong>' +
                                '<span style="font-size: 12px; color: var(--muted); margin-left: 8px;">• ' + orderTime + '</span>' +
                            '</div>' +
                            '<span class="status-badge ' + badgeClass + '" style="font-size: 12px; font-weight: 700; padding: 4px 12px; border-radius: 8px; ' + badgeStyle + '">' +
                                badgeIcon + ' ' + orderStatus +
                            '</span>' +
                        '</div>' +
                        '<div class="order-card-items" style="margin-bottom: 16px;">' +
                            itemsHtml +
                        '</div>' +
                        '<div class="order-card-footer" style="display: flex; justify-content: space-between; align-items: center; padding-top: 14px; border-top: 1px solid #202636;">' +
                            '<div>' +
                                '<span style="font-size: 12px; color: var(--muted);">Pickup Slot:</span>' +
                                '<strong style="font-size: 14px; margin-left: 4px; color: #F59E0B;">' + pickupSlot + '</strong>' +
                                '<span style="font-size: 12px; color: var(--muted); margin-left: 12px;">Counter #2</span>' +
                            '</div>' +
                            '<div style="display: flex; align-items: center; gap: 16px;">' +
                                '<strong style="font-family: var(--font-heading); font-size: 18px; color: var(--dark);">' +
                                    '₹' + totalDisplay +
                                '</strong>' +
                                '<a href="${pageContext.request.contextPath}/menu.jsp" class="btn-add-cart" style="text-decoration:none; padding: 8px 16px; font-size: 13px;">Order Again</a>' +
                            '</div>' +
                        '</div>';
                    container.appendChild(card);
                });

                // Start AJAX live status polling for customer
                setInterval(pollActiveOrderStatuses, 5000);
                                    '₹' + totalDisplay +
                                '</strong>' +
                                '<a href="${pageContext.request.contextPath}/menu.jsp" class="btn-add-cart" style="text-decoration:none;">Order Again</a>' +
                            '</div>' +
                        '</div>';
                    container.appendChild(card);
                });
            } catch (e) {
                console.error('Error reading orders for current user', e);
            }
        }

        function filterOrderList(status, btn) {
            document.querySelectorAll('.orders-filter-tabs .category-filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const cards = document.querySelectorAll('.order-card');
            cards.forEach(card => {
                const cardStatus = card.getAttribute('data-order-status');
                if (status === 'all' || cardStatus === status) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        function reorderDemo(itemNames) {
            showToast('✓ Added ' + itemNames.join(' & ') + ' to tray!');
        }

        document.addEventListener('DOMContentLoaded', loadDynamicOrders);
    </script>
</body>
</html>
