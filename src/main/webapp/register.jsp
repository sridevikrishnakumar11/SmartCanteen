<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | SmartCanteen</title>

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
            Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
        </div>
    </nav>

    <!-- MAIN AUTH CONTAINER -->
    <main class="auth-container">

        <!-- LEFT SIDE: BRANDING -->
        <section class="auth-visual">
            <div class="visual-content">
                <span class="visual-badge">
                    ⚡ Fast & Fresh Campus Meals
                </span>

                <h1>
                    Join the smart food revolution.<br>
                    <span>Never wait in canteen queues again.</span>
                </h1>

                <p>
                    Set up your campus profile in seconds. Enjoy real-time slot selection, instant food tracking, and personalized campus menu recommendations.
                </p>

                <div class="visual-food-cluster">
                    <div class="cluster-main">🍕</div>
                    <div class="cluster-item cluster-a">🥪</div>
                    <div class="cluster-item cluster-b">🍱</div>
                    <div class="cluster-item cluster-c">🥤</div>
                </div>
            </div>
        </section>

        <!-- RIGHT SIDE: REGISTRATION FORM -->
        <section class="auth-card-wrapper">
            <div class="auth-card">

                <div class="auth-heading">
                    <div class="auth-icon">🚀</div>
                    <div>
                        <h2>Create Account</h2>
                        <p>Sign up to start placing quick campus orders.</p>
                    </div>
                </div>

                <!-- Error Alert if present -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="auth-alert error">
                        <span>⚠️</span>
                        <span><%= request.getAttribute("errorMessage") %></span>
                    </div>
                <% } %>

                <div id="validationAlert" class="auth-alert error" style="display: none;">
                    <span>⚠️</span>
                    <span id="validationMsg"></span>
                </div>

                <!-- REGISTER FORM -->
                <form action="RegisterServlet" method="post" class="auth-form" id="registerForm" onsubmit="return validateRegister()">

                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <div class="input-wrapper">
                            <span class="input-icon">👤</span>
                            <input
                                type="text"
                                id="name"
                                name="name"
                                placeholder="Aarav Sharma"
                                required
                                autofocus>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Campus Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon">✉️</span>
                            <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="aarav@campus.edu"
                                required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="role">Campus Role</label>
                        <div class="input-wrapper">
                            <span class="input-icon">🎓</span>
                            <select id="role" name="role" required>
                                <option value="Student" selected>Student</option>
                                <option value="Lecturer">Lecturer / Academic Staff</option>
                                <option value="Staff">Canteen / Kitchen Staff</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">🔒</span>
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Minimum 6 characters"
                                required>
                            <button type="button" class="password-toggle" onclick="togglePass('password', this)" title="Show/Hide">
                                👁
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon">🔒</span>
                            <input
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="Re-type your password"
                                required>
                            <button type="button" class="password-toggle" onclick="togglePass('confirmPassword', this)" title="Show/Hide">
                                👁
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="auth-submit">
                        Create My Account <span>→</span>
                    </button>
                </form>

                <div class="auth-divider">
                    <span>or</span>
                </div>

                <div class="register-prompt">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login.jsp">Sign in here</a>
                </div>

            </div>
        </section>

    </main>

    <script>
        function togglePass(id, btn) {
            const input = document.getElementById(id);
            if (input) {
                const isPass = input.type === 'password';
                input.type = isPass ? 'text' : 'password';
                btn.textContent = isPass ? '🙈' : '👁';
            }
        }

        function validateRegister() {
            const pass = document.getElementById('password').value;
            const confirm = document.getElementById('confirmPassword').value;
            const alertBox = document.getElementById('validationAlert');
            const alertMsg = document.getElementById('validationMsg');

            if (pass.length < 6) {
                alertMsg.textContent = 'Password must be at least 6 characters long.';
                alertBox.style.display = 'flex';
                return false;
            }

            if (pass !== confirm) {
                alertMsg.textContent = 'Passwords do not match. Please verify.';
                alertBox.style.display = 'flex';
                return false;
            }

            alertBox.style.display = 'none';
            return true;
        }

        document.getElementById('registerForm').addEventListener('submit', async function(e) {
            if (!validateRegister()) {
                e.preventDefault();
                return;
            }
            e.preventDefault();

            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const role = document.getElementById('role').value;

            sessionStorage.setItem('smartcanteen_user', JSON.stringify({ name: name, email: email, role: role }));

            try {
                const formData = new URLSearchParams(new FormData(this));
                const resp = await fetch('RegisterServlet', {
                    method: 'POST',
                    body: formData,
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
                });
                if (resp.redirected) {
                    window.location.href = resp.url;
                    return;
                } else if (resp.ok) {
                    window.location.href = '${pageContext.request.contextPath}/login.jsp?registered=1';
                    return;
                }
            } catch (err) {
                console.log('RegisterServlet connecting...');
            }
            window.location.href = '${pageContext.request.contextPath}/login.jsp?registered=1';
        });
    </script>
</body>
</html>
