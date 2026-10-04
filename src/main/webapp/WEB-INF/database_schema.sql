-- ============================================================================
-- SMARTCANTEEN - RELATIONAL DATABASE SCHEMA (SQL & JDBC INTEGRATION)
-- Compatible with MySQL 8.0 & PostgreSQL
-- ============================================================================

-- 1. USERS TABLE (Kitchen Staff, Admin, and Customers)
CREATE TABLE IF NOT EXISTS smartcanteen_users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    phone VARCHAR(20),
    card_balance DECIMAL(10, 2) DEFAULT 450.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. USER LOGIN LOGS TABLE (Stores detail whenever anyone logs in)
CREATE TABLE IF NOT EXISTS smartcanteen_login_logs (
    id SERIAL PRIMARY KEY,
    user_email VARCHAR(120) NOT NULL,
    user_name VARCHAR(100),
    role VARCHAR(20) NOT NULL,
    ip_address VARCHAR(50),
    user_agent VARCHAR(255),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. FOOD MENU ITEMS TABLE
CREATE TABLE IF NOT EXISTS smartcanteen_menu (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    is_veg BOOLEAN DEFAULT TRUE,
    image_url VARCHAR(255),
    prep_time_minutes INT DEFAULT 8,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. ORDERS TABLE
CREATE TABLE IF NOT EXISTS smartcanteen_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20) UNIQUE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(120) NOT NULL,
    pickup_slot VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Preparing',
    placed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 5. ORDER LINE ITEMS TABLE
CREATE TABLE IF NOT EXISTS smartcanteen_order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    item_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(8, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL
);

-- 6. CANTEEN RULES & POLICIES TABLE
CREATE TABLE IF NOT EXISTS smartcanteen_rules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rule_code VARCHAR(20) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    title VARCHAR(150) NOT NULL,
    description VARCHAR(255) NOT NULL,
    compliance_check VARCHAR(200),
    priority VARCHAR(20) DEFAULT 'STANDARD'
);

-- ============================================================================
-- SEED DATA FOR AUTHENTICATION & CORE ROLES
-- ============================================================================

INSERT INTO smartcanteen_users (name, email, password, role, phone, card_balance)
VALUES 
    ('Chef Kumar (Kitchen)', 'staff@smartcanteen.com', 'staff123', 'Staff', '+91 98765 00001', 0.00),
    ('Canteen Director', 'admin@smartcanteen.com', 'admin123', 'Admin', '+91 98765 00002', 0.00),
    ('Aarav Sharma (Customer)', 'student@smartcanteen.com', 'student123', 'Customer', '+91 98765 43210', 450.00),
    ('Campus Customer', 'customer@smartcanteen.com', 'customer123', 'Customer', '+91 98765 43211', 450.00)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- SEED DATA FOR CANTEEN MENU
INSERT INTO smartcanteen_menu (id, name, category, price, is_veg, image_url, prep_time_minutes)
VALUES
    (1, 'Crispy Masala Dosa', 'South Indian', 45.00, TRUE, 'images/dosa.jpg', 6),
    (2, 'Steamed Idli Sambar (2 pcs)', 'South Indian', 30.00, TRUE, 'images/idli.jpg', 4),
    (3, 'Chicken Dum Biryani', 'Meals & Biryani', 120.00, FALSE, 'images/biryani.jpg', 5),
    (4, 'Cheesy Paneer Pizza', 'Snacks & Bakery', 90.00, TRUE, 'images/pizza.jpg', 10),
    (5, 'Campus Burger', 'Snacks & Bakery', 70.00, TRUE, 'images/burger.jpg', 7),
    (15, 'Special Masala Tea', 'Beverages', 15.00, TRUE, 'images/tea.jpg', 3),
    (16, 'South Indian Filter Coffee', 'Beverages', 20.00, TRUE, 'images/coffe.jpg', 3),
    (17, 'Crispy Samosa (2 pcs)', 'Snacks & Bakery', 30.00, TRUE, 'images/samosa.jpg', 4),
    (18, 'Boiled Egg (2 pcs)', 'Snacks & Bakery', 20.00, FALSE, 'images/egg.jpg', 2),
    (19, 'Crispy Onion Bajji', 'Snacks & Bakery', 20.00, TRUE, 'images/bajji.jpg', 5),
    (20, 'Golden Potato Bonda', 'Snacks & Bakery', 25.00, TRUE, 'images/bonda.jpg', 4),
    (21, 'Cavin''s Cold Milkshake', 'Beverages', 40.00, TRUE, 'images/cavin milkshake.jpg', 1),
    (22, 'Bakery Masala Egg Puff', 'Snacks & Bakery', 25.00, FALSE, 'images/puffs.jpg', 2)
ON DUPLICATE KEY UPDATE name=VALUES(name);
