<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile | SmartCanteen</title>

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
                <a href="${pageContext.request.contextPath}/orders.jsp">My Orders</a>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a>
            </div>

            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-cart">
                    <span>🛒</span>
                    <span class="cart-nav-text">Cart</span>
                    <span class="cart-badge" style="display:none;">0</span>
                </a>
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-login" onclick="localStorage.removeItem('smartcanteen_logged_in_user'); sessionStorage.removeItem('smartcanteen_user');">
                    Sign Out <span>↳</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- PROFILE CONTAINER -->
    <div class="container" style="margin-top: 40px; margin-bottom: 80px;">
        
        <div style="margin-bottom: 30px;">
            <h1 style="font-family: var(--font-heading); font-size: 34px; letter-spacing: -1px;">
                Student Account & Profile
            </h1>
            <p style="color: var(--muted); font-size: 15px;">
                Manage your campus credentials, view your queue savings, and update dietary preferences.
            </p>
        </div>

        <div class="profile-grid">
            
            <!-- LEFT PROFILE CARD -->
            <div class="profile-card">
                <div class="profile-avatar-lg" id="profileAvatar">${sessionScope.userName != null && sessionScope.userName.length() > 0 ? sessionScope.userName.substring(0, 1) : 'U'}</div>
                <h3 id="profileName">${sessionScope.userName != null ? sessionScope.userName : 'Student User'}</h3>
                <span class="profile-role-tag" id="profileRole">🎓 ${sessionScope.userRole != null ? sessionScope.userRole : 'Student'} • SmartCanteen</span>

                <div style="text-align: left; padding: 20px 0; border-top: 1px solid var(--border-light); border-bottom: 1px solid var(--border-light); margin-bottom: 20px; font-size: 13px;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span style="color: var(--muted);">Campus Role:</span>
                        <strong id="profileRoleText">${sessionScope.userRole != null ? sessionScope.userRole : 'Student'}</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span style="color: var(--muted);">Campus Email:</span>
                        <strong id="profileEmail">${sessionScope.userEmail != null ? sessionScope.userEmail : 'student@smartcanteen.com'}</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span style="color: var(--muted);">Phone:</span>
                        <strong id="profilePhone">+91 98765 43210</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span style="color: var(--muted);">Campus Card:</span>
                        <strong style="color: var(--green-dark);">Active (₹450 Bal)</strong>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/orders.jsp" class="secondary-btn" style="display: block; text-align: center; margin-bottom: 10px;">
                    View Order History
                </a>
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="primary-btn" style="display: flex; justify-content: center;">
                    Go to Dashboard <span>→</span>
                </a>
            </div>

            <!-- RIGHT DETAILS & STATS -->
            <div>
                
                <!-- STATS STRIP -->
                <div class="metrics-grid" style="margin-bottom: 25px;">
                    <div class="metric-card">
                        <div class="metric-icon purple">📦</div>
                        <div class="metric-data">
                            <small>Total Orders Placed</small>
                            <strong id="profileOrderCount">0 Orders</strong>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-icon orange">⏰</div>
                        <div class="metric-data">
                            <small>Queue Hours Saved</small>
                            <strong id="profileTimeSaved">0 Hours</strong>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-icon green">🍕</div>
                        <div class="metric-data">
                            <small>Account Status</small>
                            <strong style="color: var(--green-dark);">Active Account</strong>
                        </div>
                    </div>
                </div>

                <!-- EDIT PROFILE FORM -->
                <div class="checkout-section-box">
                    <h3><span>⚙️</span> Personal Information</h3>
                    <form id="profileForm" onsubmit="handleSaveProfile(event)">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                            <div class="form-group">
                                <label style="font-size: 13px; font-weight: 700;">Full Name</label>
                                <div class="input-wrapper">
                                    <input type="text" id="inputProfileName" value="${sessionScope.userName != null ? sessionScope.userName : 'Student User'}" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label style="font-size: 13px; font-weight: 700;">Department</label>
                                <div class="input-wrapper">
                                    <input type="text" id="inputProfileDept" value="Computer Science & Engineering" required>
                                </div>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
                            <div class="form-group">
                                <label style="font-size: 13px; font-weight: 700;">Campus Email</label>
                                <div class="input-wrapper">
                                    <input type="email" id="inputProfileEmail" value="${sessionScope.userEmail != null ? sessionScope.userEmail : 'student@smartcanteen.com'}" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label style="font-size: 13px; font-weight: 700;">Mobile Phone</label>
                                <div class="input-wrapper">
                                    <input type="tel" id="inputProfilePhone" value="9876543210" required>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="primary-btn">
                            Save Changes
                        </button>
                    </form>
                </div>

                <!-- FAVOURITE FOODS QUICK ORDER -->
                <div class="checkout-section-box">
                    <h3><span>❤️</span> Quick Reorder Favourites</h3>
                    <div style="display: flex; flex-direction: column; gap: 12px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px 16px; background: #FAF9FE; border-radius: var(--radius-md); border: 1px solid var(--border);">
                            <div style="display: flex; align-items: center; gap: 12px;">
                                <span style="font-size: 24px;">🍕</span>
                                <div>
                                    <strong style="font-size: 14px; display: block;">Paneer Pizza</strong>
                                    <span style="font-size: 12px; color: var(--muted);">Ordered 12 times</span>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 14px;">
                                <strong style="color: var(--purple);">₹120</strong>
                                <button class="btn-add-cart" onclick="CartManager.addItem({id:'2', name:'Paneer Pizza', price:120, category:'Snacks', isVeg:true});">+ Add</button>
                            </div>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px 16px; background: #FAF9FE; border-radius: var(--radius-md); border: 1px solid var(--border);">
                            <div style="display: flex; align-items: center; gap: 12px;">
                                <span style="font-size: 24px;">🥞</span>
                                <div>
                                    <strong style="font-size: 14px; display: block;">Masala Dosa</strong>
                                    <span style="font-size: 12px; color: var(--muted);">Ordered 9 times</span>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 14px;">
                                <strong style="color: var(--purple);">₹60</strong>
                                <button class="btn-add-cart" onclick="CartManager.addItem({id:'1', name:'Masala Dosa', price:60, category:'Breakfast', isVeg:true});">+ Add</button>
                            </div>
                        </div>
                    </div>
                </div>

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
                <h4>Navigation</h4>
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

    <div id="toast-container" class="toast-container"></div>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            const currentUser = savedUserStr ? JSON.parse(savedUserStr) : null;
            const currentEmail = currentUser && currentUser.email ? currentUser.email.trim().toLowerCase() : '${sessionScope.userEmail != null ? sessionScope.userEmail : ""}';

            if (currentUser) {
                if (currentUser.name) {
                    const nameEl = document.getElementById('profileName');
                    const inputNameEl = document.getElementById('inputProfileName');
                    const avatarEl = document.getElementById('profileAvatar');
                    if (nameEl) nameEl.textContent = currentUser.name;
                    if (inputNameEl) inputNameEl.value = currentUser.name;
                    if (avatarEl) {
                        const initials = currentUser.name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase();
                        avatarEl.textContent = initials;
                    }
                }
                if (currentUser.email) {
                    const emailEl = document.getElementById('profileEmail');
                    const inputEmailEl = document.getElementById('inputProfileEmail');
                    if (emailEl) emailEl.textContent = currentUser.email;
                    if (inputEmailEl) inputEmailEl.value = currentUser.email;
                }
                if (currentUser.role) {
                    const roleEl = document.getElementById('profileRole');
                    const roleTextEl = document.getElementById('profileRoleText');
                    if (roleEl) roleEl.textContent = '🎓 ' + currentUser.role + ' • SmartCanteen';
                    if (roleTextEl) roleTextEl.textContent = currentUser.role;
                }
            }

            // Calculate orders for this specific logged-in account
            const allOrders = JSON.parse(localStorage.getItem('smartcanteen_orders') || '[]');
            const userOrders = allOrders.filter(o => {
                if (!currentEmail) return false;
                const orderEmail = (o.userEmail || (o.customer && o.customer.email) || '').trim().toLowerCase();
                return orderEmail === currentEmail;
            });

            const orderCountEl = document.getElementById('profileOrderCount');
            const timeSavedEl = document.getElementById('profileTimeSaved');
            if (orderCountEl) orderCountEl.textContent = userOrders.length + (userOrders.length === 1 ? ' Order' : ' Orders');
            if (timeSavedEl) {
                const hours = (userOrders.length * 0.4).toFixed(1);
                timeSavedEl.textContent = hours + ' Hours';
            }
        });

        function handleSaveProfile(e) {
            e.preventDefault();
            const name = document.getElementById('inputProfileName').value.trim();
            const email = document.getElementById('inputProfileEmail').value.trim();
            const phone = document.getElementById('inputProfilePhone').value.trim();

            const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
            const user = savedUserStr ? JSON.parse(savedUserStr) : { role: 'Student' };
            user.name = name;
            user.email = email;
            user.phone = phone;
            localStorage.setItem('smartcanteen_logged_in_user', JSON.stringify(user));

            const nameEl = document.getElementById('profileName');
            const emailEl = document.getElementById('profileEmail');
            const avatarEl = document.getElementById('profileAvatar');
            if (nameEl) nameEl.textContent = name;
            if (emailEl) emailEl.textContent = email;
            if (avatarEl) {
                const initials = name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase();
                avatarEl.textContent = initials;
            }

            if (typeof showToast === 'function') {
                showToast('Profile updated successfully!');
            } else {
                alert('Profile updated successfully!');
            }
        }
    </script>
</body>
</html>
