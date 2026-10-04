<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Food Menu | SmartCanteen</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
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
                <a href="${pageContext.request.contextPath}/menu.jsp" class="active">Menu</a>
                <a href="${pageContext.request.contextPath}/index.jsp#why">Why Us</a>
                <a href="${pageContext.request.contextPath}/index.jsp#how">How It Works</a>
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

    <!-- STAFF INSPECTION NOTICE -->
    <div id="staffInspectionBanner" style="display: none; background: #111827; color: #38BDF8; padding: 14px 24px; font-weight: 600; font-size: 14px; border-bottom: 1px solid #1E3A8A; box-shadow: 0 4px 12px rgba(0,0,0,0.4);">
        <div style="max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;">
            <div style="display: flex; align-items: center; gap: 10px;">
                <span style="font-size: 20px;">👨‍🍳</span>
                <span><strong>KITCHEN STAFF MODE:</strong> Viewing campus menu recipes and prep times. Online ordering is disabled for staff accounts.</span>
            </div>
            <a href="${pageContext.request.contextPath}/staff-dashboard.jsp" style="color: #34D399; font-weight: 700; text-decoration: none; padding: 6px 14px; background: rgba(52, 211, 153, 0.15); border-radius: 8px; border: 1px solid rgba(52, 211, 153, 0.3);">
                Return to Kitchen KDS →
            </a>
        </div>
    </div>

    <!-- ADMIN AUDIT NOTICE -->
    <div id="adminNoticeBanner" style="display: none; background: #1E1B2E; color: #C084FC; padding: 14px 24px; font-weight: 600; font-size: 14px; border-bottom: 1px solid #581C87; box-shadow: 0 4px 12px rgba(0,0,0,0.4);">
        <div style="max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;">
            <div style="display: flex; align-items: center; gap: 10px;">
                <span style="font-size: 20px;">⚡</span>
                <span><strong>ADMIN GOVERNANCE MODE:</strong> Viewing menu catalog. Admin accounts view rules & job assignments only. Online ordering is disabled.</span>
            </div>
            <a href="${pageContext.request.contextPath}/admin-dashboard.jsp" style="color: #C084FC; font-weight: 700; text-decoration: none; padding: 6px 14px; background: rgba(192, 132, 252, 0.15); border-radius: 8px; border: 1px solid rgba(192, 132, 252, 0.3);">
                Return to Rules & Jobs Console →
            </a>
        </div>
    </div>

    <!-- GUEST LOGIN NOTICE -->
    <div id="guestLoginNoticeBanner" style="display: none; background: #0F172A; color: #60A5FA; padding: 14px 24px; font-weight: 600; font-size: 14px; border-bottom: 1px solid #1D4ED8; box-shadow: 0 4px 12px rgba(0,0,0,0.4);">
        <div style="max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;">
            <div style="display: flex; align-items: center; gap: 10px;">
                <span style="font-size: 20px;">🔒</span>
                <span><strong>LOGIN REQUIRED:</strong> You must sign in to add items to cart and place food orders.</span>
            </div>
            <a href="${pageContext.request.contextPath}/login.jsp?redirect=menu.jsp" style="color: #60A5FA; font-weight: 700; text-decoration: none; padding: 6px 14px; background: rgba(96, 165, 250, 0.15); border-radius: 8px; border: 1px solid rgba(96, 165, 250, 0.3);">
                Sign In to Order →
            </a>
        </div>
    </div>

    <!-- MENU HERO BANNER -->
    <header class="menu-page-header">
        <div class="menu-hero-banner">
            <div class="menu-hero-text">
                <div class="eyebrow" style="background: rgba(255,255,255,0.15); color: #FFF; margin-bottom: 12px;">
                    🔥 LIVE CAMPUS KITCHEN
                </div>
                <h1>Order Ahead.<br><span>Pick Up Piping Hot.</span></h1>
                <p>Browse our kitchen's freshest daily items. Customize, add to cart, and choose your break slot.</p>
            </div>
            <div class="menu-hero-stat-badge">
                <strong>🟢 Open Now</strong>
                <span>Avg. Pickup: 5-8 mins</span>
            </div>
        </div>
    </header>

    <!-- STICKY SEARCH & CONTROLS TOOLBAR -->
    <div class="menu-toolbar">
        <div class="search-box-wrapper">
            <span class="search-icon">🔍</span>
            <input type="text" id="menuSearchInput" class="search-input" placeholder="Search dishes (e.g., Dosa, Biryani, Pizza, Burger)..." autocomplete="off">
            <button id="searchClearBtn" class="search-clear-btn" title="Clear search">✕</button>
        </div>

        <div class="toolbar-controls">
            <button id="vegToggleBtn" class="veg-toggle-btn" type="button">
                <span class="veg-indicator"></span>
                <span>Pure Veg Only</span>
            </button>

            <select id="sortSelect" class="sort-select">
                <option value="default">Sort: Recommended</option>
                <option value="price-asc">Price: Low to High</option>
                <option value="price-desc">Price: High to Low</option>
                <option value="rating-desc">Rating: Highest First</option>
            </select>
        </div>
    </div>

    <!-- CATEGORY FILTER BAR -->
    <div class="category-filter-bar" id="categoryFilterBar">
        <button class="menu-cat-btn active" data-category="all">🍽️ All Items</button>
        <button class="menu-cat-btn" data-category="breakfast">🥞 Breakfast</button>
        <button class="menu-cat-btn" data-category="lunch">🍛 Lunch</button>
        <button class="menu-cat-btn" data-category="snacks">🍔 Snacks</button>
        <button class="menu-cat-btn" data-category="drinks">🥤 Drinks</button>
        <button class="menu-cat-btn" data-category="desserts">🍰 Desserts</button>
    </div>

    <!-- FOOD GRID SECTION -->
    <section class="menu-grid-section">
        <div class="food-results-meta">
            <span id="resultsCount">Showing 22 delicious items</span>
            <span style="font-size: 12px; color: var(--muted);">Click <strong>+ Add</strong> to update your cart</span>
        </div>

        <div class="food-grid" id="menuFoodGrid">

            <!-- 1. Masala Dosa -->
            <div class="food-card-item" data-id="1" data-name="Masala Dosa" data-category="breakfast" data-price="60" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/dosa.jpg" alt="Masala Dosa">
                    <span class="food-badge popular">Popular</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Breakfast</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Masala Dosa</h3>
                    <p>Crispy golden rice crepe folded with spiced potato filling, coconut chutney & hot sambar.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 5 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹60</span>
                        <button class="btn-add-cart" data-id="1" data-name="Masala Dosa" data-price="60" data-category="Breakfast" data-veg="true" data-image="${pageContext.request.contextPath}/images/dosa.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 2. Paneer Pizza -->
            <div class="food-card-item" data-id="2" data-name="Paneer Pizza" data-category="snacks" data-price="120" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/pizza.jpg" alt="Paneer Pizza">
                    <span class="food-badge popular">Bestseller</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Paneer Pizza</h3>
                    <p>Tandoori marinated paneer cubes, crisp capsicum, sweet corn & stretchy mozzarella on crispy crust.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 8 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹120</span>
                        <button class="btn-add-cart" data-id="2" data-name="Paneer Pizza" data-price="120" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/pizza.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 3. Veg Biryani -->
            <div class="food-card-item" data-id="3" data-name="Veg Dum Biryani" data-category="lunch" data-price="90" data-rating="4.7" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/veg_biryani.jpg" alt="Veg Dum Biryani">
                    <span class="food-badge veg">Chef Special</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Lunch</span>
                        </div>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Veg Dum Biryani</h3>
                    <p>Fragrant basmati rice layered with garden veggies, whole spices, saffron & served with onion raita.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 4 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹90</span>
                        <button class="btn-add-cart" data-id="3" data-name="Veg Dum Biryani" data-price="90" data-category="Lunch" data-veg="true" data-image="${pageContext.request.contextPath}/images/veg_biryani.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 4. Chicken Biryani -->
            <div class="food-card-item" data-id="4" data-name="Chicken Dum Biryani" data-category="lunch" data-price="140" data-rating="4.9" data-veg="false">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/chicken_biryani.jpg" alt="Chicken Dum Biryani">
                    <span class="food-badge popular">Popular</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="non-veg-indicator" title="Non-Veg"></span>
                            <span class="food-cat">Lunch</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Chicken Dum Biryani</h3>
                    <p>Tender slow-cooked chicken pieces infused in basmati rice, aromatic spices & served with mirchi salan.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 5 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹140</span>
                        <button class="btn-add-cart" data-id="4" data-name="Chicken Dum Biryani" data-price="140" data-category="Lunch" data-veg="false" data-image="${pageContext.request.contextPath}/images/chicken_biryani.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 5. Campus Burger -->
            <div class="food-card-item" data-id="5" data-name="Campus Burger" data-category="snacks" data-price="70" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/burger.jpg" alt="Campus Burger">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Campus Burger</h3>
                    <p>Golden potato herb patty, cheddar slice, crunchy onions, sliced pickles & tangy burger sauce.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 6 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹70</span>
                        <button class="btn-add-cart" data-id="5" data-name="Campus Burger" data-price="70" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/burger.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 6. Steamed Idli -->
            <div class="food-card-item" data-id="6" data-name="Steamed Idli" data-category="breakfast" data-price="40" data-rating="4.6" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/idli.jpg" alt="Idli Sambar">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Breakfast</span>
                        </div>
                        <span class="food-rating">⭐ 4.6</span>
                    </div>
                    <h3>Steamed Idli (2 pcs)</h3>
                    <p>Steamed soft rice cakes served with hot vegetable sambar and fresh ground coconut chutney.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 3 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹40</span>
                        <button class="btn-add-cart" data-id="6" data-name="Steamed Idli" data-price="40" data-category="Breakfast" data-veg="true" data-image="${pageContext.request.contextPath}/images/idli.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 7. Veg Grilled Sandwich -->
            <div class="food-card-item" data-id="7" data-name="Veg Grilled Sandwich" data-category="snacks" data-price="60" data-rating="4.7" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/sandwich.jpg" alt="Veg Sandwich">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Veg Grilled Sandwich</h3>
                    <p>Crispy grilled bread layered with cucumber, tomatoes, house mint chutney & a sprinkle of chaat masala.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 5 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹60</span>
                        <button class="btn-add-cart" data-id="7" data-name="Veg Grilled Sandwich" data-price="60" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/sandwich.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 8. Peri-Peri Fries -->
            <div class="food-card-item" data-id="8" data-name="Peri-Peri Fries" data-category="snacks" data-price="50" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/fries.jpg" alt="Peri-Peri Fries">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Peri-Peri Fries</h3>
                    <p>Hot, salted potato fries generously dusted with smoky peri-peri seasoning. Served with tomato dip.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 4 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹50</span>
                        <button class="btn-add-cart" data-id="8" data-name="Peri-Peri Fries" data-price="50" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/fries.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 9. Paneer Butter Masala Combo -->
            <div class="food-card-item" data-id="9" data-name="Paneer Butter Combo" data-category="lunch" data-price="130" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/paneer_butter.jpg" alt="Paneer Butter Masala">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Lunch</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Paneer Butter Combo</h3>
                    <p>Rich creamy tomato gravy with cottage cheese cubes, served with 2 flaky Malabar parottas & salad.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 7 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹130</span>
                        <button class="btn-add-cart" data-id="9" data-name="Paneer Butter Combo" data-price="130" data-category="Lunch" data-veg="true" data-image="${pageContext.request.contextPath}/images/paneer_butter.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 10. Chole Bhature -->
            <div class="food-card-item" data-id="10" data-name="Chole Bhature" data-category="lunch" data-price="85" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/chole_bhature.jpg" alt="Chole Bhature">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Lunch</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Chole Bhature (2 pcs)</h3>
                    <p>Puffed golden bhature served with rich spicy Punjabi chickpea masala, pickled carrots & mint onions.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 6 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹85</span>
                        <button class="btn-add-cart" data-id="10" data-name="Chole Bhature" data-price="85" data-category="Lunch" data-veg="true" data-image="${pageContext.request.contextPath}/images/chole_bhature.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 11. Fresh Lime Soda -->
            <div class="food-card-item" data-id="11" data-name="Fresh Lime Soda" data-category="drinks" data-price="40" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/lime_soda.jpg" alt="Fresh Lime Soda">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Drinks</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Fresh Lime Soda</h3>
                    <p>Chilled sparkling soda with fresh key lime juice, fresh mint, and rock salt. Sweet and salty refresh.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 2 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹40</span>
                        <button class="btn-add-cart" data-id="11" data-name="Fresh Lime Soda" data-price="40" data-category="Drinks" data-veg="true" data-image="${pageContext.request.contextPath}/images/lime_soda.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 12. Cold Coffee -->
            <div class="food-card-item" data-id="12" data-name="Cold Coffee" data-category="drinks" data-price="50" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/cold_coffee.jpg" alt="Cold Coffee">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Drinks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Classic Cold Coffee</h3>
                    <p>Frothy chilled espresso blended with whole milk and vanilla ice cream, topped with chocolate drizzle.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 3 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹50</span>
                        <button class="btn-add-cart" data-id="12" data-name="Classic Cold Coffee" data-price="50" data-category="Drinks" data-veg="true" data-image="${pageContext.request.contextPath}/images/cold_coffee.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 13. Pav Bhaji -->
            <div class="food-card-item" data-id="13" data-name="Mumbai Pav Bhaji" data-category="snacks" data-price="70" data-rating="4.7" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/pav_bhaji.jpg" alt="Pav Bhaji">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Mumbai Pav Bhaji</h3>
                    <p>Spiced mashed vegetable curry loaded with butter, served with 2 warm toasted butter pavs and lemon.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 5 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹70</span>
                        <button class="btn-add-cart" data-id="13" data-name="Mumbai Pav Bhaji" data-price="70" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/pav_bhaji.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 14. Chocolate Brownie -->
            <div class="food-card-item" data-id="14" data-name="Chocolate Brownie" data-category="desserts" data-price="75" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/brownie.jpg" alt="Chocolate Brownie">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Desserts</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Fudge Brownie & Ice Cream</h3>
                    <p>Warm gooey chocolate walnut brownie crowned with a scoop of vanilla ice cream and hot fudge.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 3 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹75</span>
                        <button class="btn-add-cart" data-id="14" data-name="Fudge Brownie & Ice Cream" data-price="75" data-category="Desserts" data-veg="true" data-image="${pageContext.request.contextPath}/images/brownie.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 15. Special Masala Tea (Chai) -->
            <div class="food-card-item" data-id="15" data-name="Special Masala Tea" data-category="drinks" data-price="15" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/tea.jpg" alt="Special Masala Tea">
                    <span class="food-badge popular">Campus Favourite</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Drinks</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Special Masala Tea</h3>
                    <p>Steaming hot ginger & cardamom infused milk tea. The timeless campus break refresh.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 2 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹15</span>
                        <button class="btn-add-cart" data-id="15" data-name="Special Masala Tea" data-price="15" data-category="Drinks" data-veg="true" data-image="${pageContext.request.contextPath}/images/tea.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 16. South Indian Filter Coffee -->
            <div class="food-card-item" data-id="16" data-name="Filter Coffee" data-category="drinks" data-price="20" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/coffee.jpg" alt="Filter Coffee">
                    <span class="food-badge popular">Popular</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Drinks</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Filter Coffee</h3>
                    <p>Authentic South Indian degree filter coffee served piping hot with frothy head and chicory aroma.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 2 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹20</span>
                        <button class="btn-add-cart" data-id="16" data-name="Filter Coffee" data-price="20" data-category="Drinks" data-veg="true" data-image="${pageContext.request.contextPath}/images/coffee.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 17. Crispy Samosa -->
            <div class="food-card-item" data-id="17" data-name="Crispy Samosa" data-category="snacks" data-price="30" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/samosa.jpg" alt="Crispy Samosa">
                    <span class="food-badge popular">Bestseller</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Crispy Samosa (2 pcs)</h3>
                    <p>Golden, flaky crust stuffed with spicy mashed potato and green peas. Served with sweet tamarind dip.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 3 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹30</span>
                        <button class="btn-add-cart" data-id="17" data-name="Crispy Samosa (2 pcs)" data-price="30" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/samosa.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 18. Egg Curry Special -->
            <div class="food-card-item" data-id="18" data-name="Egg Curry Special" data-category="lunch" data-price="45" data-rating="4.7" data-veg="false">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/egg.jpg" alt="Egg Curry Special">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="non-veg-indicator" title="Non-Veg"></span>
                            <span class="food-cat">Lunch</span>
                        </div>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Egg Curry Special (2 Eggs)</h3>
                    <p>Farm-fresh boiled eggs simmered in spicy masala gravy with curry leaves. Great with rice or parotta.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 5 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹45</span>
                        <button class="btn-add-cart" data-id="18" data-name="Egg Curry Special" data-price="45" data-category="Lunch" data-veg="false" data-image="${pageContext.request.contextPath}/images/egg.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 19. Crispy Mirchi Bajji -->
            <div class="food-card-item" data-id="19" data-name="Crispy Mirchi Bajji" data-category="snacks" data-price="35" data-rating="4.8" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/bajji.jpg" alt="Crispy Mirchi Bajji">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Crispy Mirchi Bajji (3 pcs)</h3>
                    <p>Fresh banana peppers coated in spiced gram flour batter and fried until crisp. Topped with chaat masala.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 4 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹35</span>
                        <button class="btn-add-cart" data-id="19" data-name="Crispy Mirchi Bajji" data-price="35" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/bajji.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 20. Golden Aloo Bonda -->
            <div class="food-card-item" data-id="20" data-name="Golden Aloo Bonda" data-category="snacks" data-price="30" data-rating="4.7" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/bonda.jpg" alt="Golden Aloo Bonda">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.7</span>
                    </div>
                    <h3>Golden Aloo Bonda (2 pcs)</h3>
                    <p>Zesty mustard-tempered potato balls coated in golden gram flour and deep-fried. Served with chutney.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 4 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹30</span>
                        <button class="btn-add-cart" data-id="20" data-name="Golden Aloo Bonda" data-price="30" data-category="Snacks" data-veg="true" data-image="${pageContext.request.contextPath}/images/bonda.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 21. Cavin's Chocolate Milkshake -->
            <div class="food-card-item" data-id="21" data-name="Cavin's Milkshake" data-category="drinks" data-price="40" data-rating="4.9" data-veg="true">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/milkshake.jpg" alt="Cavin's Milkshake">
                    <span class="food-badge popular">Chilled</span>
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="veg-indicator" title="Pure Veg"></span>
                            <span class="food-cat">Drinks</span>
                        </div>
                        <span class="food-rating">⭐ 4.9</span>
                    </div>
                    <h3>Cavin's Milkshake (200ml)</h3>
                    <p>Chilled thick chocolate milkshake. Loaded with dairy goodness and sweet cocoa bliss on the run.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 1 min</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹40</span>
                        <button class="btn-add-cart" data-id="21" data-name="Cavin's Milkshake" data-price="40" data-category="Drinks" data-veg="true" data-image="${pageContext.request.contextPath}/images/milkshake.jpg">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- 22. Bakery Egg & Veg Puff -->
            <div class="food-card-item" data-id="22" data-name="Bakery Puff" data-category="snacks" data-price="25" data-rating="4.8" data-veg="false">
                <div class="food-thumb">
                    <img src="${pageContext.request.contextPath}/images/puffs.jpg" alt="Bakery Puff">
                </div>
                <div class="food-card-body">
                    <div class="food-header">
                        <div style="display:flex; align-items:center; gap:6px;">
                            <span class="non-veg-indicator" title="Non-Veg"></span>
                            <span class="food-cat">Snacks</span>
                        </div>
                        <span class="food-rating">⭐ 4.8</span>
                    </div>
                    <h3>Bakery Egg & Masala Puff</h3>
                    <p>Crispy golden layered puff pastry wrapped around hard-boiled egg and caramelized onion pepper masala.</p>
                    <div style="margin-bottom: 12px;">
                        <span class="prep-time">⏱️ 2 mins</span>
                    </div>
                    <div class="food-footer">
                        <span class="food-price">₹25</span>
                        <button class="btn-add-cart" data-id="22" data-name="Bakery Egg & Masala Puff" data-price="25" data-category="Snacks" data-veg="false" data-image="${pageContext.request.contextPath}/images/puffs.jpg">+ Add</button>
                    </div>
                </div>
            </div>

        </div>

        <!-- Empty search results -->
        <div id="emptyResults" class="empty-results" style="display: none;">
            <span>🔍</span>
            <h3>No matching food items found</h3>
            <p>Try searching with another keyword or reset the category filters.</p>
            <button class="reset-search-btn" onclick="resetMenuFilters()">Reset All Filters</button>
        </div>
    </section>

    <!-- FOOTER -->
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
                <a href="${pageContext.request.contextPath}/cart.jsp">Your Cart</a>
                <a href="${pageContext.request.contextPath}/orders.jsp">Order History</a>
            </div>
            <div class="footer-col">
                <h4>Account & Kitchen</h4>
                <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
                <a href="${pageContext.request.contextPath}/staff-dashboard.jsp">Kitchen Staff View</a>
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
    <script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
