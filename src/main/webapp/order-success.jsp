<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed | SmartCanteen</title>

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
                <a href="${pageContext.request.contextPath}/orders.jsp" class="nav-login">
                    Track Orders <span>→</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- MAIN SUCCESS CONTAINER -->
    <div class="order-success-wrapper">
        <div class="success-badge-glow">✓</div>

        <h1 style="font-family: var(--font-heading); font-size: 38px; letter-spacing: -1.5px; margin-bottom: 8px;">
            Order Confirmed!
        </h1>
        <p style="color: var(--muted); font-size: 16px; margin-bottom: 30px;">
            Your kitchen ticket has been printed. Your food will be ready hot & fresh.
        </p>

        <!-- CARD DETAILS -->
        <div class="order-success-card">
            
            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-light); padding-bottom: 16px;">
                <div>
                    <span style="font-size: 12px; color: var(--muted); text-transform: uppercase; font-weight: 700;">Order Token</span>
                    <h2 id="successOrderId" style="font-family: var(--font-heading); font-size: 26px; color: var(--purple);">
                        <%= request.getParameter("orderId") != null ? "#" + request.getParameter("orderId") : "#SC1024" %>
                    </h2>
                </div>
                <div style="text-align: right;">
                    <span style="font-size: 12px; color: var(--muted); text-transform: uppercase; font-weight: 700;">Status</span>
                    <span style="display: block; font-size: 14px; font-weight: 700; color: var(--orange);">
                        ● Preparing in Kitchen
                    </span>
                </div>
            </div>

            <!-- PICKUP BANNER -->
            <div class="pickup-token-banner">
                <div>
                    <span style="font-size: 12px; opacity: 0.8; text-transform: uppercase; letter-spacing: 1px;">Selected Pickup Slot</span>
                    <div id="successPickupSlot" class="token-big">
                        <%= request.getParameter("slot") != null ? request.getParameter("slot") : "12:45 PM" %>
                    </div>
                </div>
                <div style="text-align: right;">
                    <span style="font-size: 12px; opacity: 0.8; display: block;">Pickup Counter</span>
                    <strong style="font-size: 20px; color: white;">Counter #2</strong>
                </div>
            </div>

            <!-- ORDER ITEMS LIST -->
            <h4 style="font-family: var(--font-heading); font-size: 16px; margin-bottom: 12px; color: var(--dark);">
                Items in This Order:
            </h4>
            <div id="successItemsList" style="margin-bottom: 20px;">
                <div class="order-item-chip">
                    <span>1× Masala Dosa</span>
                    <strong>₹60.00</strong>
                </div>
                <div class="order-item-chip">
                    <span>1× Paneer Pizza</span>
                    <strong>₹120.00</strong>
                </div>
            </div>

            <div style="display: flex; justify-content: space-between; font-weight: 700; font-size: 16px; padding-top: 12px; border-top: 1px solid var(--border);">
                <span>Total Paid / Due:</span>
                <span id="successOrderTotal" style="color: var(--purple);">₹189.00</span>
            </div>

            <div style="display: flex; gap: 14px; margin-top: 32px;">
                <a href="${pageContext.request.contextPath}/orders.jsp" class="primary-btn" style="flex: 1; justify-content: center;">
                    Track Order Status <span>→</span>
                </a>
                <a href="${pageContext.request.contextPath}/menu.jsp" class="secondary-btn" style="flex: 1; justify-content: center;">
                    Back to Menu
                </a>
            </div>

        </div>
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
                <h4>Shortcuts</h4>
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/menu.jsp">Menu</a>
                <a href="${pageContext.request.contextPath}/orders.jsp">My Orders</a>
            </div>
            <div class="footer-col">
                <h4>Dashboard</h4>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">Student Dashboard</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2026 SmartCanteen</span>
            <span>Java Web Technology Lab Project</span>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            CartUI.initSuccessPage();
        });
    </script>
</body>
</html>
