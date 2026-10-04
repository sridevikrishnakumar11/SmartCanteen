<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartCanteen — Campus Food, Zero Queue</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">
    
    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- ================= NAVBAR ================= -->
    <div class="navbar-wrapper">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <span class="logo-icon">🍽️</span>
                <span>Smart<span>Canteen</span></span>
            </a>

            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/index.jsp" class="active">Home</a>
                <a href="${pageContext.request.contextPath}/menu.jsp">Menu</a>
                <a href="#why">Why Us</a>
                <a href="#how">How It Works</a>
            </div>

            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-cart">
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

    <!-- ================= HERO SECTION ================= -->
    <section class="hero" id="home">
        <div class="hero-content">
            <div class="eyebrow">
                <span>✨</span> MADE FOR CAMPUS LIFE
            </div>
            <h1>
                Your cravings.<br>
                <span>Our kitchen.</span><br>
                Zero queue.
            </h1>
            <p class="hero-text">
                Order your favourite campus food before the break even starts.
                Pick your time, grab your food and get back to what matters.
            </p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/menu.jsp" class="primary-btn">
                    Start Ordering <span>→</span>
                </a>
                <a href="#how" class="secondary-btn">
                    How It Works
                </a>
            </div>
            <div class="hero-stats">
                <div class="stat-item">
                    <strong>10+</strong>
                    <span>Food Options</span>
                </div>
                <div class="stat-item">
                    <strong>5 min</strong>
                    <span>Quick Pickup</span>
                </div>
                <div class="stat-item">
                    <strong>100%</strong>
                    <span>Campus Ready</span>
                </div>
            </div>
        </div>

        <div class="hero-visual">
            <div class="hero-blob"></div>

            <!-- Floating Card: Pickup Ready -->
            <div class="floating-card pickup-card">
                <div class="pickup-icon">⚡</div>
                <div>
                    <small>Pickup Ready</small>
                    <strong>12:45 PM</strong>
                </div>
            </div>

            <!-- Floating Card: Rating -->
            <div class="floating-card rating-card">
                <span class="rating-badge-icon">⭐</span>
                <div>
                    <strong>4.9</strong>
                    <small>Student Rating</small>
                </div>
            </div>

            <!-- Floating Emojis -->
            <div class="floating-food food-emoji-1">🍕</div>
            <div class="floating-food food-emoji-2">🥤</div>

            <!-- Main Food Card -->
            <div class="food-card-hero">
                <div class="image-container">
                    <img src="${pageContext.request.contextPath}/images/dosa.jpg" alt="Crispy Masala Dosa">
                    <span class="hero-tag">🔥 Today's Favourite</span>
                </div>
                <div class="hero-card-info">
                    <div>
                        <small>Breakfast Special</small>
                        <h3>Masala Dosa</h3>
                    </div>
                    <strong>₹60</strong>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= TRUST / BENEFITS BAR ================= -->
    <div class="trust-bar-section">
        <div class="trust-bar">
            <div class="trust-item">
                <div class="trust-icon purple">⚡</div>
                <div>
                    <strong>Fast Ordering</strong>
                    <span>Skip the counter rush</span>
                </div>
            </div>
            <div class="trust-item">
                <div class="trust-icon orange">🕐</div>
                <div>
                    <strong>Smart Pickup Slots</strong>
                    <span>Timed between your classes</span>
                </div>
            </div>
            <div class="trust-item">
                <div class="trust-icon green">💳</div>
                <div>
                    <strong>Easy Payments</strong>
                    <span>UPI, Cash & Campus Card</span>
                </div>
            </div>
            <div class="trust-item">
                <div class="trust-icon pink">🌱</div>
                <div>
                    <strong>Less Food Waste</strong>
                    <span>Made-to-order kitchen prep</span>
                </div>
            </div>
        </div>
    </div>

    <!-- ================= WHY SMARTCANTEEN ================= -->
    <section class="section" id="why">
        <div class="section-header">
            <div>
                <div class="eyebrow">WHY SMARTCANTEEN</div>
                <h2>Campus food,<br><span>without the chaos.</span></h2>
            </div>
            <p>Built around the way students actually eat and spend their breaks between lecture halls.</p>
        </div>

        <div class="why-grid">
            <div class="why-card card-purple">
                <span class="why-number">01</span>
                <div class="why-icon-box">🏃</div>
                <h3>Skip the Queue</h3>
                <p>Order from anywhere on campus and avoid standing in long canteen queues during lunch rush.</p>
            </div>
            <div class="why-card card-orange">
                <span class="why-number">02</span>
                <div class="why-icon-box">⏰</div>
                <h3>Pick Your Time</h3>
                <p>Choose a precise pickup slot that fits perfectly between your classes and lab sessions.</p>
            </div>
            <div class="why-card card-green">
                <span class="why-number">03</span>
                <div class="why-icon-box">🌱</div>
                <h3>Reduce Food Waste</h3>
                <p>Smarter pre-ordering helps the canteen prepare just the right quantity of fresh meals every day.</p>
            </div>
        </div>
    </section>

    <!-- ================= MENU SECTION ================= -->
    <section class="section" id="menu">
        <div class="section-header">
            <div>
                <div class="eyebrow">CAMPUS DELIGHTS</div>
                <h2>What's cooking? 🔥</h2>
            </div>
            <a href="${pageContext.request.contextPath}/menu.jsp" class="view-all-link">
                View full menu <span>→</span>
            </a>
        </div>

        <div class="menu-controls">
            <div class="category-row">
                <button class="category-filter-btn active" data-filter="all">All</button>
                <button class="category-filter-btn" data-filter="breakfast">Breakfast</button>
                <button class="category-filter-btn" data-filter="lunch">Lunch</button>
                <button class="category-filter-btn" data-filter="snacks">Snacks</button>
                <button class="category-filter-btn" data-filter="drinks">Drinks</button>
            </div>
        </div>

        <div class="food-grid">
            <!-- 1. Masala Dosa -->
            <div class="food-card-item" data-category="breakfast">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/dosa.jpg" alt="Masala Dosa">
                    <span class="food-badge popular">Popular</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Breakfast</span>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Masala Dosa</h3>
                    <p>Crispy golden rice crepe folded with spiced mashed potato, served with coconut chutney & sambar.</p>
                    <div class="food-footer">
                        <span class="food-price">₹60</span>
                        <button class="btn-add-cart" data-id="1" data-name="Masala Dosa" data-price="60" data-category="Breakfast" data-image="${pageContext.request.contextPath}/images/dosa.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 2. Paneer Pizza -->
            <div class="food-card-item" data-category="snacks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/pizza.jpg" alt="Paneer Pizza">
                    <span class="food-badge popular">Bestseller</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Snacks</span>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Paneer Pizza</h3>
                    <p>Loaded with spiced marinated paneer, crunchy bell peppers, sweet corn & mozzarella cheese.</p>
                    <div class="food-footer">
                        <span class="food-price">₹120</span>
                        <button class="btn-add-cart" data-id="2" data-name="Paneer Pizza" data-price="120" data-category="Snacks" data-image="${pageContext.request.contextPath}/images/pizza.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 3. Veg Biryani -->
            <div class="food-card-item" data-category="lunch">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/veg_biryani.jpg" alt="Veg Biryani">
                    <span class="food-badge veg">Chef Pick</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Lunch</span>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Veg Biryani</h3>
                    <p>Fragrant long-grain basmati rice layered with garden vegetables, saffron & aromatic whole spices.</p>
                    <div class="food-footer">
                        <span class="food-price">₹90</span>
                        <button class="btn-add-cart" data-id="3" data-name="Veg Biryani" data-price="90" data-category="Lunch" data-image="${pageContext.request.contextPath}/images/veg_biryani.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 4. Campus Burger -->
            <div class="food-card-item" data-category="snacks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/burger.jpg" alt="Campus Burger">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Snacks</span>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Campus Burger</h3>
                    <p>Crispy herb potato patty, melted cheese slice, shredded crisp lettuce & creamy house sauce.</p>
                    <div class="food-footer">
                        <span class="food-price">₹70</span>
                        <button class="btn-add-cart" data-id="4" data-name="Campus Burger" data-price="70" data-category="Snacks" data-image="${pageContext.request.contextPath}/images/burger.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 5. Steamed Idli -->
            <div class="food-card-item" data-category="breakfast">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/idli.jpg" alt="Idli Sambar">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Breakfast</span>
                        <span class="food-rating">⭐ 4.6</span>
                    </div>
                    <h3>Steamed Idli (2 pcs)</h3>
                    <p>Fluffy steamed fermented rice cakes served piping hot with flavorful vegetable sambar & chutneys.</p>
                    <div class="food-footer">
                        <span class="food-price">₹40</span>
                        <button class="btn-add-cart" data-id="5" data-name="Steamed Idli" data-price="40" data-category="Breakfast" data-image="${pageContext.request.contextPath}/images/idli.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 6. Veg Sandwich -->
            <div class="food-card-item" data-category="snacks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/sandwich.jpg" alt="Veg Sandwich">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Snacks</span>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Veg Grilled Sandwich</h3>
                    <p>Multi-grain bread toasted golden with mint coriander chutney, cucumber, juicy tomato & cheese.</p>
                    <div class="food-footer">
                        <span class="food-price">₹60</span>
                        <button class="btn-add-cart" data-id="6" data-name="Veg Grilled Sandwich" data-price="60" data-category="Snacks" data-image="${pageContext.request.contextPath}/images/sandwich.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 7. French Fries -->
            <div class="food-card-item" data-category="snacks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/fries.jpg" alt="Peri-Peri Fries">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Snacks</span>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Peri-Peri Fries</h3>
                    <p>Crispy straight-cut potatoes salted and dusted with zesty peri-peri spice blend. Perfect break snack.</p>
                    <div class="food-footer">
                        <span class="food-price">₹50</span>
                        <button class="btn-add-cart" data-id="7" data-name="Peri-Peri Fries" data-price="50" data-category="Snacks" data-image="${pageContext.request.contextPath}/images/fries.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 8. Golden Samosa -->
            <div class="food-card-item" data-category="snacks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/samosa.jpg" alt="Golden Samosa">
                    <span class="food-badge popular">Hot Snack</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Snacks</span>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Crispy Golden Samosa (2 pcs)</h3>
                    <p>Flaky, deep-fried pastry pyramids filled with spicy spiced potatoes, peas, served with mint chutney.</p>
                    <div class="food-footer">
                        <span class="food-price">₹30</span>
                        <button class="btn-add-cart" data-id="17" data-name="Crispy Golden Samosa (2 pcs)" data-price="30" data-category="Snacks" data-image="${pageContext.request.contextPath}/images/samosa.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 9. Hot Irani Chai / Tea -->
            <div class="food-card-item" data-category="drinks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/tea.jpg" alt="Hot Special Chai">
                    <span class="food-badge popular">Student Fav</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Drinks</span>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Special Masala Chai (Tea)</h3>
                    <p>Authentic freshly brewed milk tea infused with crushed cardamom, ginger and premium Assam tea leaves.</p>
                    <div class="food-footer">
                        <span class="food-price">₹15</span>
                        <button class="btn-add-cart" data-id="15" data-name="Special Masala Chai (Tea)" data-price="15" data-category="Drinks" data-image="${pageContext.request.contextPath}/images/tea.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 10. South Indian Filter Coffee -->
            <div class="food-card-item" data-category="drinks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/coffee.jpg" alt="Filter Coffee">
                    <span class="food-badge popular">Authentic</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Drinks</span>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>South Indian Filter Coffee</h3>
                    <p>Traditional decoction filter coffee brewed with frothy fresh milk, served piping hot in tumbler style.</p>
                    <div class="food-footer">
                        <span class="food-price">₹25</span>
                        <button class="btn-add-cart" data-id="16" data-name="South Indian Filter Coffee" data-price="25" data-category="Drinks" data-image="${pageContext.request.contextPath}/images/coffee.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 11. Crispy Mirchi Bajji -->
            <div class="food-card-item" data-category="snacks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/bajji.jpg" alt="Mirchi Bajji">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Snacks</span>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Hot Mirchi Bajji (3 pcs)</h3>
                    <p>Deep-fried batter-dipped spiced banana peppers, served sizzling hot with tangy peanut-onion dip.</p>
                    <div class="food-footer">
                        <span class="food-price">₹30</span>
                        <button class="btn-add-cart" data-id="19" data-name="Hot Mirchi Bajji (3 pcs)" data-price="30" data-category="Snacks" data-image="${pageContext.request.contextPath}/images/bajji.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 12. Cavin's Milkshake -->
            <div class="food-card-item" data-category="drinks">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/milkshake.jpg" alt="Cavin's Milkshake">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <span class="food-cat">Drinks</span>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Cavin's Milkshake</h3>
                    <p>Rich and thick chocolate & vanilla flavoured chilled milkshake carton, refreshing break-time beverage.</p>
                    <div class="food-footer">
                        <span class="food-price">₹40</span>
                        <button class="btn-add-cart" data-id="21" data-name="Cavin's Milkshake" data-price="40" data-category="Drinks" data-image="${pageContext.request.contextPath}/images/milkshake.jpg">+ Add</button>
                    </div>
                </div>
            </div>
    </section>

    <!-- ================= PROMOTIONAL SECTION ================= -->
    <div class="dark-promo-section">
        <div class="dark-promo-content">
            <div class="eyebrow" style="background: rgba(255,255,255,0.1); color: #FFF;">
                ⚡ ZERO DELAYS
            </div>
            <h2>Your break is short.<br><span>Don't spend it waiting.</span></h2>
            <p>SmartCanteen makes campus food faster, simpler and more convenient. Order from your lecture hall, collect right on schedule.</p>
            <a href="${pageContext.request.contextPath}/menu.jsp" class="dark-promo-btn">
                Explore Food <span>→</span>
            </a>
        </div>
        <div class="dark-promo-visual">
            <div class="big-promo-emoji">🍜</div>
            <div class="promo-bubble bubble-1">🔥</div>
            <div class="promo-bubble bubble-2">❤️</div>
            <div class="promo-bubble bubble-3">✨</div>
        </div>
    </div>

    <!-- ================= HOW IT WORKS ================= -->
    <section class="section how-section" id="how">
        <div class="section-header center">
            <div class="eyebrow">SIMPLE AS 1, 2, 3</div>
            <h2>From hungry to happy.</h2>
            <p>Get your favorite meal in three ridiculously simple steps.</p>
        </div>

        <div class="steps-timeline">
            <div class="step-card">
                <div class="step-badge-circle">
                    <span class="step-num">01</span>
                    <span class="step-emoji">🍔</span>
                </div>
                <h3>Pick Your Food</h3>
                <p>Browse today's freshest canteen menu, filter by cravings, and add to your tray.</p>
            </div>
            <div class="step-divider"></div>
            <div class="step-card">
                <div class="step-badge-circle">
                    <span class="step-num">02</span>
                    <span class="step-emoji">🕐</span>
                </div>
                <h3>Choose Your Slot</h3>
                <p>Select the exact break time when you will arrive at the canteen pickup counter.</p>
            </div>
            <div class="step-divider"></div>
            <div class="step-card">
                <div class="step-badge-circle">
                    <span class="step-num">03</span>
                    <span class="step-emoji">😋</span>
                </div>
                <h3>Grab & Go</h3>
                <p>Flash your digital order token, pick up your piping hot meal, and get eating.</p>
            </div>
        </div>
    </section>

    <!-- ================= FINAL CTA ================= -->
    <div class="cta-banner">
        <h2>Your break deserves<br>better food. 🍕</h2>
        <p>Less waiting. More eating. More time for what matters on campus.</p>
        <a href="${pageContext.request.contextPath}/menu.jsp" class="cta-white-btn">
            Start Ordering <span>→</span>
        </a>
    </div>

    <!-- ================= FOOTER ================= -->
    <footer>
        <div class="footer-inner">
            <div class="footer-brand">
                <div class="logo">
                    <span class="logo-icon">🍽️</span>
                    <span>Smart<span>Canteen</span></span>
                </div>
                <p>Making campus food smarter, one order at a time. Designed for students, faculty and staff.</p>
            </div>
            <div class="footer-col">
                <h4>Quick Navigation</h4>
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/menu.jsp">Food Menu</a>
                <a href="#why">Why Us</a>
                <a href="#how">How It Works</a>
            </div>
            <div class="footer-col">
                <h4>Portals & Account</h4>
                <a href="${pageContext.request.contextPath}/login.jsp">Student Login</a>
                <a href="${pageContext.request.contextPath}/register.jsp">Create Account</a>
                <a href="${pageContext.request.contextPath}/staff-dashboard.jsp">Staff Kitchen View</a>
                <a href="${pageContext.request.contextPath}/admin-dashboard.jsp">Admin Portal</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2026 SmartCanteen. All rights reserved.</span>
            <span>Java Web Technology Lab Project</span>
        </div>
    </footer>

    <!-- Toast Notifications Container -->
    <div id="toast-container" class="toast-container"></div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>