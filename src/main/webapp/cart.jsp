<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentRole = (String) session.getAttribute("userRole");
    if (currentRole != null && ("Staff".equalsIgnoreCase(currentRole) || "Kitchen".equalsIgnoreCase(currentRole) || "Chef".equalsIgnoreCase(currentRole))) {
        response.sendRedirect(request.getContextPath() + "/staff-dashboard.jsp?error=staff_no_checkout");
        return;
    }
    if (currentRole != null && "Admin".equalsIgnoreCase(currentRole)) {
        response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp?error=admin_no_checkout");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Food Tray (Cart) | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                <a href="${pageContext.request.contextPath}/orders.jsp">My Orders</a>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a>
            </div>

            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-cart active">
                    <span>🛒</span>
                    <span class="cart-nav-text">Cart</span>
                    <span class="cart-badge" style="display:none;">0</span>
                </a>
                <a href="${pageContext.request.contextPath}/login.jsp" class="nav-login">
                    Login <span>→</span>
                </a>
                <button class="mobile-menu-toggle" aria-label="Toggle Navigation">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
            </div>
        </nav>
    </div>

    <!-- CART PAGE HEADER -->
    <div class="cart-page-header">
        <h1>Your Food Tray 🛒</h1>
        <p>Review your selected campus items before selecting your pickup break slot.</p>
    </div>

    <!-- LOGIN REQUIRED BANNER (MUST LOG IN TO ORDER) -->
    <div id="loginRequiredBanner" style="display: none; max-width: 1000px; margin: 30px auto; background: #0F172A; border: 1px solid #1D4ED8; border-radius: 16px; padding: 24px; align-items: center; justify-content: space-between; gap: 18px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">
        <div style="display: flex; align-items: center; gap: 18px;">
            <span style="font-size: 40px;">🔒</span>
            <div>
                <h3 style="color: #60A5FA; margin: 0 0 4px 0; font-size: 18px;">Login Required to Order Food</h3>
                <p style="color: #93C5FD; margin: 0; font-size: 14px;">You must be signed in to add items, view your food tray, and proceed with canteen checkout.</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/login.jsp?redirect=cart.jsp" class="primary-btn" style="background: #2563EB; color: #FFFFFF; white-space: nowrap; text-decoration: none;">
            Sign In to Continue →
        </a>
    </div>

    <!-- STAFF RESTRICTION BANNER -->
    <div id="staffRestrictedState" class="staff-restricted-banner" style="display: none; max-width: 1000px; margin: 30px auto; background: #18151D; border: 1px solid #7C2D12; border-radius: 16px; padding: 24px; align-items: center; justify-content: space-between; gap: 18px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">
        <div style="display: flex; align-items: center; gap: 18px;">
            <span style="font-size: 40px;">👨‍🍳</span>
            <div>
                <h3 style="color: #FB923C; margin: 0 0 4px 0; font-size: 18px;">Staff & Kitchen Ordering Disabled</h3>
                <p style="color: #FED7AA; margin: 0; font-size: 14px;">You are currently logged in with a <strong>Kitchen Staff</strong> account. Staff accounts manage incoming kitchen orders on the KDS and cannot place food orders.</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/staff-dashboard.jsp" class="primary-btn" style="background: #EA580C; color: #FFFFFF; white-space: nowrap; text-decoration: none;">
            Open Kitchen KDS →
        </a>
    </div>

    <!-- ADMIN RESTRICTION BANNER -->
    <div id="adminRestrictedState" class="staff-restricted-banner" style="display: none; max-width: 1000px; margin: 30px auto; background: #1E1B2E; border: 1px solid #581C87; border-radius: 16px; padding: 24px; align-items: center; justify-content: space-between; gap: 18px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">
        <div style="display: flex; align-items: center; gap: 18px;">
            <span style="font-size: 40px;">⚡</span>
            <div>
                <h3 style="color: #C084FC; margin: 0 0 4px 0; font-size: 18px;">Admin Rules & Jobs Governance Mode</h3>
                <p style="color: #E9D5FF; margin: 0; font-size: 14px;">Admin accounts are restricted to viewing canteen operating rules, hygiene standards, and job allocations. Admins cannot place food orders.</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/admin-dashboard.jsp" class="primary-btn" style="background: #7C3AED; color: #FFFFFF; white-space: nowrap; text-decoration: none;">
            Go to Rules & Jobs Console →
        </a>
    </div>

    <!-- EMPTY STATE -->
    <div id="cartEmptyState" class="cart-empty-card" style="display: none;">
        <span>🍽️</span>
        <h2>Your tray is completely empty!</h2>
        <p>You haven't added any delicious food yet. Check out today's fresh canteen specials.</p>
        <a href="${pageContext.request.contextPath}/menu.jsp" class="primary-btn">
            Browse Campus Menu <span>→</span>
        </a>
    </div>

    <!-- CART CONTENT GRID -->
    <div id="cartContentSection" class="cart-layout-grid" style="display: none;">
        
        <!-- ITEMS TABLE -->
        <div class="cart-table-card">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Food Item</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="cartTableBody">
                    <!-- Populated by cart.js -->
                </tbody>
            </table>
        </div>

        <!-- SUMMARY SIDEBAR -->
        <aside class="order-summary-card">
            <h3>Order Summary</h3>

            <div class="summary-row">
                <span>Items Subtotal</span>
                <span id="summarySubtotal">₹0.00</span>
            </div>

            <!-- Discount Row -->
            <div class="summary-row" id="summaryDiscountRow" style="display: none; color: var(--green-dark); font-weight: 700;">
                <span>Campus Discount (10%)</span>
                <span id="summaryDiscount">-₹0.00</span>
            </div>

            <div class="summary-row">
                <span>Canteen Facility & GST (5%)</span>
                <span id="summaryTax">₹0.00</span>
            </div>

            <!-- Coupon Input -->
            <div class="coupon-group">
                <input type="text" id="couponCodeInput" class="coupon-input" placeholder="Promo code (CAMPUS10)">
                <button type="button" id="applyCouponBtn" class="coupon-btn">Apply</button>
            </div>

            <div class="summary-row total-row">
                <span>Total Payable</span>
                <span id="summaryTotal" style="color: var(--purple);">₹0.00</span>
            </div>

            <a href="${pageContext.request.contextPath}/checkout.jsp" class="checkout-btn">
                Proceed to Checkout <span>→</span>
            </a>

            <div style="text-align: center; margin-top: 16px;">
                <a href="${pageContext.request.contextPath}/menu.jsp" style="font-size: 13px; color: var(--muted); text-decoration: underline;">
                    + Add more items from menu
                </a>
            </div>
        </aside>

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
                <h4>Explore</h4>
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/menu.jsp">Menu</a>
                <a href="${pageContext.request.contextPath}/orders.jsp">My Orders</a>
            </div>
            <div class="footer-col">
                <h4>Support</h4>
                <a href="${pageContext.request.contextPath}/profile.jsp">Student Profile</a>
                <a href="${pageContext.request.contextPath}/login.jsp">Account Login</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2026 SmartCanteen</span>
            <span>Java Web Technology Lab Project</span>
        </div>
    </footer>

    <!-- Toast container -->
    <div id="toast-container" class="toast-container"></div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            
            // 1. If not logged in, show login required banner
            if (!savedUserStr) {
                const loginBanner = document.getElementById('loginRequiredBanner');
                if (loginBanner) loginBanner.style.display = 'flex';
                const empty = document.getElementById('cartEmptyState');
                if (empty) empty.style.display = 'none';
                const content = document.getElementById('cartContentSection');
                if (content) content.style.display = 'none';
                return;
            }

            try {
                const user = JSON.parse(savedUserStr);
                const role = (user.role || '').toLowerCase();
                
                // 2. Staff cannot order food
                if (role === 'staff' || role === 'kitchen' || role === 'chef') {
                    const banner = document.getElementById('staffRestrictedState');
                    if (banner) banner.style.display = 'flex';
                    const empty = document.getElementById('cartEmptyState');
                    if (empty) empty.style.display = 'none';
                    const content = document.getElementById('cartContentSection');
                    if (content) content.style.display = 'none';
                    return;
                }

                // 3. Admin cannot order food (maintains records only)
                if (role === 'admin') {
                    const adminBanner = document.getElementById('adminRestrictedState');
                    if (adminBanner) adminBanner.style.display = 'flex';
                    const empty = document.getElementById('cartEmptyState');
                    if (empty) empty.style.display = 'none';
                    const content = document.getElementById('cartContentSection');
                    if (content) content.style.display = 'none';
                    return;
                }
            } catch(e) {}

            CartUI.initCartPage();
        });
    </script>
</body>
</html>
