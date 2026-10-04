<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body class="auth-page">

    <!-- NAVBAR -->
    <nav class="auth-navbar">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
            <span class="logo-icon">🍽️</span>
            <span>Smart<span>Canteen</span></span>
        </a>

        <div class="auth-nav-text">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register.jsp">Create account</a>
        </div>
    </nav>

    <!-- MAIN AUTH CONTAINER -->
    <main class="auth-container">

        <!-- LEFT SIDE: BRANDING & VISUAL -->
        <section class="auth-visual">
            <div class="visual-content">
                <span class="visual-badge">
                    🎓 Made for Campus Life
                </span>

                <h1>
                    Welcome back 👋<br>
                    <span>Your next meal is only a few clicks away.</span>
                </h1>

                <p>
                    Order delicious campus meals in seconds, skip the lunchtime rush, and pick up your hot food right between your lectures.
                </p>

                <div class="visual-food-cluster">
                    <div class="cluster-main">🍔</div>
                    <div class="cluster-item cluster-a">🍟</div>
                    <div class="cluster-item cluster-b">🥤</div>
                    <div class="cluster-item cluster-c">🍕</div>
                </div>
            </div>
        </section>

        <!-- RIGHT SIDE: LOGIN FORM -->
        <section class="auth-card-wrapper">
            <div class="auth-card">

                <div class="auth-heading">
                    <div class="auth-icon">👋</div>
                    <div>
                        <h2>Welcome back</h2>
                        <p>Sign in to continue ordering food.</p>
                    </div>
                </div>

                <!-- Context-Aware Auth Alert -->
                <% 
                    String errParam = request.getParameter("error");
                    String alertMsg = null;
                    if (request.getAttribute("errorMessage") != null) {
                        alertMsg = (String) request.getAttribute("errorMessage");
                    } else if (errParam != null) {
                        if ("login_required".equalsIgnoreCase(errParam)) {
                            alertMsg = "🔒 Please sign in with your student account to place food orders or checkout.";
                        } else if ("staff_no_checkout".equalsIgnoreCase(errParam)) {
                            alertMsg = "👨‍🍳 Kitchen Staff cannot place orders or checkout. Staff accounts manage cooking on the KDS.";
                        } else if ("admin_no_checkout".equalsIgnoreCase(errParam)) {
                            alertMsg = "⚡ Administrator accounts cannot place orders. Admins only maintain records and telemetry.";
                        } else if ("staff_only".equalsIgnoreCase(errParam)) {
                            alertMsg = "👨‍🍳 Kitchen Staff Access Only: Please log in with your kitchen staff credentials.";
                        } else if ("admin_only".equalsIgnoreCase(errParam)) {
                            alertMsg = "⚡ Administrator Access Only: Please log in with your canteen director credentials.";
                        } else {
                            alertMsg = "Invalid email or password. Please try again.";
                        }
                    }
                %>
                <% if (alertMsg != null) { %>
                    <div class="auth-alert error">
                        <span>⚠️</span>
                        <span><%= alertMsg %></span>
                    </div>
                <% } else if (request.getParameter("logged_out") != null) { %>
                    <div class="auth-alert success">
                        <span>✓</span>
                        <span>You have been safely signed out. See you next meal!</span>
                    </div>
                <% } else if (request.getParameter("registered") != null) { %>
                    <div class="auth-alert success">
                        <span>✓</span>
                        <span>Account created successfully! Please sign in.</span>
                    </div>
                <% } %>

                <!-- LOGIN FORM -->
                <form action="LoginServlet" method="post" class="auth-form" id="loginForm">
                    <input type="hidden" name="redirect" id="redirectInput" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect").replaceAll("\"", "&quot;") : "" %>">

                    <div class="form-group">
                        <label for="email">Campus Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon">✉️</span>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="student@campus.edu"
                                required
                                autofocus>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="label-row">
                            <label for="password">Password</label>
                            <a href="#" onclick="alert('Password reset link has been dispatched to your campus email!'); return false;">Forgot password?</a>
                        </div>

                        <div class="input-wrapper">
                            <span class="input-icon">🔒</span>
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Enter your password"
                                required>
                            <button type="button" class="password-toggle" id="togglePasswordBtn" title="Toggle password visibility">
                                👁
                            </button>
                        </div>
                    </div>

                    <div class="remember-row">
                        <label>
                            <input type="checkbox" name="remember" value="true">
                            <span>Remember me on this browser</span>
                        </label>
                    </div>

                    <button type="submit" class="auth-submit">
                        Login to SmartCanteen <span>→</span>
                    </button>
                </form>

                <div class="auth-divider">
                    <span>or quick test demo accounts</span>
                </div>

                <!-- DEMO ACCOUNTS HELPER (2 INTERNAL ROLES + CUSTOMER) -->
                <div class="demo-credentials">
                    <strong>Select Authentication Account:</strong>
                    <div class="demo-btn-group">
                        <button type="button" class="demo-btn" onclick="fillDemo('staff@smartcanteen.com', 'staff123')">👨‍🍳 Kitchen Staff</button>
                        <button type="button" class="demo-btn" onclick="fillDemo('admin@smartcanteen.com', 'admin123')">⚡ Admin (Rules &amp; Jobs Only)</button>
                        <button type="button" class="demo-btn" onclick="fillDemo('student@smartcanteen.com', 'student123')">👤 Customer / Student</button>
                    </div>
                </div>

                <div class="role-pill-badges">
                    <span>👨‍🍳 Staff: Manage Orders &amp; Cooking Only</span>
                    <span>•</span>
                    <span>⚡ Admin: Rules &amp; Jobs View Only</span>
                </div>

            </div>
        </section>

    </main>

    <script>
        // Clear local credentials on explicit logout
        const currentParams = new URLSearchParams(window.location.search);
        if (currentParams.get('logged_out')) {
            localStorage.removeItem('smartcanteen_logged_in_user');
            sessionStorage.removeItem('smartcanteen_user');
            sessionStorage.removeItem('smartcanteen_last_order');
        }

        // Password toggle
        const toggleBtn = document.getElementById('togglePasswordBtn');
        const passwordInput = document.getElementById('password');

        if (toggleBtn && passwordInput) {
            toggleBtn.addEventListener('click', () => {
                const isPassword = passwordInput.type === 'password';
                passwordInput.type = isPassword ? 'text' : 'password';
                toggleBtn.textContent = isPassword ? '🙈' : '👁';
            });
        }

        // Quick demo filler helper
        function fillDemo(email, pass) {
            document.getElementById('email').value = email;
            document.getElementById('password').value = pass;
        }

        // Standard form submission to LoginServlet for authentic database authentication
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            if (!email || !password) {
                e.preventDefault();
                alert('Please enter both email and password.');
                return;
            }
            // Clear any stale local user state prior to fresh server authentication
            localStorage.removeItem('smartcanteen_logged_in_user');
            sessionStorage.removeItem('smartcanteen_user');
        });
    </script>
</body>
</html>
