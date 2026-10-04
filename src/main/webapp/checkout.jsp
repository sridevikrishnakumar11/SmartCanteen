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
    <title>Checkout & Pickup Slot | SmartCanteen</title>

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
                <a href="${pageContext.request.contextPath}/cart.jsp">Back to Cart</a>
            </div>

            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-cart">
                    <span>🛒</span>
                    <span class="cart-nav-text">Cart</span>
                    <span class="cart-badge" style="display:none;">0</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- HEADER -->
    <div class="cart-page-header">
        <h1>Express Checkout ⚡</h1>
        <p>Pick your break pickup slot and select your preferred payment mode.</p>
    </div>

    <!-- MAIN FORM & LAYOUT -->
    <form id="checkoutForm">
        <div class="cart-layout-grid">
            
            <!-- LEFT COLUMN: STEPS -->
            <div>
                <!-- STEP 1: PICKUP SLOT -->
                <div class="checkout-section-box">
                    <h3><span>🕐</span> Step 1: Choose Your Pickup Slot</h3>
                    <p style="font-size: 13px; color: var(--muted); margin-bottom: 16px;">
                        The kitchen will prepare your food so it's fresh and hot at your selected time.
                    </p>

                    <input type="hidden" id="selectedPickupSlot" name="pickupSlot" value="12:45 PM">

                    <div class="slot-pills-grid">
                        <button type="button" class="slot-pill" data-slot="12:00 PM">12:00 PM</button>
                        <button type="button" class="slot-pill" data-slot="12:15 PM">12:15 PM</button>
                        <button type="button" class="slot-pill" data-slot="12:30 PM">12:30 PM</button>
                        <button type="button" class="slot-pill selected" data-slot="12:45 PM">12:45 PM</button>
                        <button type="button" class="slot-pill" data-slot="1:00 PM">1:00 PM</button>
                        <button type="button" class="slot-pill" data-slot="1:15 PM">1:15 PM</button>
                    </div>
                </div>

                <!-- STEP 2: STUDENT DETAILS -->
                <div class="checkout-section-box">
                    <h3><span>👤</span> Step 2: Student Identification</h3>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                        <div class="form-group">
                            <label for="custName" style="font-size: 13px; font-weight: 700;">Full Name</label>
                            <div class="input-wrapper">
                                <input type="text" id="custName" name="name" placeholder="Aarav Sharma" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="custRoll" style="font-size: 13px; font-weight: 700;">Roll / Student ID</label>
                            <div class="input-wrapper">
                                <input type="text" id="custRoll" name="roll" placeholder="CS-2024-042" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="custPhone" style="font-size: 13px; font-weight: 700;">Mobile Number (for Ready SMS)</label>
                        <div class="input-wrapper">
                            <input type="tel" id="custPhone" name="phone" placeholder="9876543210" pattern="[0-9]{10}" required>
                        </div>
                    </div>
                </div>

                <!-- STEP 3: KITCHEN NOTES -->
                <div class="checkout-section-box">
                    <h3><span>📝</span> Step 3: Kitchen Instructions (Optional)</h3>
                    <div class="form-group">
                        <textarea id="custNotes" name="notes" rows="2" style="width: 100%; border: 1px solid var(--border); border-radius: var(--radius-md); padding: 12px; font-family: inherit; font-size: 13px; outline: none;" placeholder="e.g. Extra spicy sambar, please don't add onions to burger..."></textarea>
                    </div>
                </div>

                <!-- STEP 4: PAYMENT OPTIONS -->
                <div class="checkout-section-box">
                    <h3><span>💳</span> Step 4: Payment Method</h3>

                    <input type="hidden" id="selectedPaymentMethod" name="paymentMethod" value="UPI">

                    <div class="payment-methods-grid">
                        <div class="payment-option active" data-method="UPI">
                            <span>📱</span>
                            <strong>Instant UPI</strong>
                            <small style="font-size: 11px; color: var(--muted);">GPay, PhonePe, Paytm</small>
                        </div>
                        <div class="payment-option" data-method="Cash">
                            <span>💵</span>
                            <strong>Pay at Counter</strong>
                            <small style="font-size: 11px; color: var(--muted);">Cash upon pickup</small>
                        </div>
                        <div class="payment-option" data-method="Card">
                            <span>💳</span>
                            <strong>Campus Smart Card</strong>
                            <small style="font-size: 11px; color: var(--muted);">Tap card at counter</small>
                        </div>
                    </div>

                    <!-- UPI QR PREVIEW -->
                    <div id="upiQrPreview" class="upi-preview-card">
                        <div class="qr-code-box">🏁</div>
                        <div>
                            <strong style="font-size: 14px; color: var(--dark); display: block;">UPI Instant Confirmation</strong>
                            <span style="font-size: 12px; color: var(--muted);">Scan at pickup counter or pay via VPA: <strong>smartcanteen@upi</strong></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: SUMMARY & SUBMIT -->
            <aside class="order-summary-card">
                <h3>Order Review</h3>

                <div id="checkoutSummaryList" style="margin-bottom: 20px;">
                    <!-- Filled by cart.js -->
                </div>

                <div class="summary-row total-row">
                    <span>Total Amount</span>
                    <span id="checkoutTotalAmount" style="color: var(--purple);">₹0.00</span>
                </div>

                <button type="submit" class="checkout-btn" style="margin-top: 24px;">
                    ✓ Place Order Now
                </button>

                <p style="font-size: 11px; color: var(--muted); text-align: center; margin-top: 14px;">
                    🔒 Safe & verified campus food checkout. Order token generated immediately.
                </p>
            </aside>

        </div>
    </form>

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
            </div>
            <div class="footer-col">
                <h4>Support</h4>
                <a href="${pageContext.request.contextPath}/orders.jsp">My Orders</a>
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
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            
            // 1. Mandatory login check: must be logged in to order
            if (!savedUserStr) {
                alert('🔒 Login Required: You must sign in with your student account before checkout.');
                window.location.href = '${pageContext.request.contextPath}/login.jsp?error=login_required&redirect=checkout.jsp';
                return;
            }

            try {
                const user = JSON.parse(savedUserStr);
                const role = (user.role || '').toLowerCase();
                
                // 2. Staff cannot order food
                if (role === 'staff' || role === 'kitchen' || role === 'chef') {
                    alert('👨‍🍳 Staff Mode Active: Kitchen staff accounts cannot checkout food. Redirecting to Kitchen KDS.');
                    window.location.href = '${pageContext.request.contextPath}/staff-dashboard.jsp';
                    return;
                }

                // 3. Admin cannot order food (maintains records only)
                if (role === 'admin') {
                    alert('⚡ Admin Mode Active: Administrator accounts only maintain records and cannot place food orders.');
                    window.location.href = '${pageContext.request.contextPath}/admin-dashboard.jsp';
                    return;
                }
            } catch(e) {}

            CartUI.initCheckoutPage();
        });
    </script>
</body>
</html>
