/**
 * SmartCanteen - Shared Core JavaScript
 * Manages cart state in localStorage, UI interactions, toasts, and mobile navigation.
 */

// Cart Manager
const CartManager = {
    STORAGE_KEY: 'smartcanteen_cart',

    getCart: function() {
        try {
            const data = localStorage.getItem(this.STORAGE_KEY);
            return data ? JSON.parse(data) : [];
        } catch (e) {
            console.error('Error reading cart from localStorage', e);
            return [];
        }
    },

    saveCart: function(cart) {
        try {
            localStorage.setItem(this.STORAGE_KEY, JSON.stringify(cart));
            this.updateBadge();
            window.dispatchEvent(new CustomEvent('cartUpdated', { detail: cart }));
        } catch (e) {
            console.error('Error saving cart to localStorage', e);
        }
    },

    addItem: function(item) {
        const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
        
        // 1. Mandatory login check: students or any other must be allowed to order ONLY after login
        if (!savedUserStr) {
            showToast('🔒 Login Required: Please sign in with your student account to order food!', 'error');
            setTimeout(() => {
                window.location.href = 'login.jsp?error=login_required';
            }, 1000);
            return;
        }

        let userRole = 'student';
        try {
            const user = JSON.parse(savedUserStr);
            userRole = (user.role || 'Student').toLowerCase();
        } catch (e) {}

        // 2. Staff cannot order food (Kitchen staff operates KDS only)
        if (userRole === 'staff' || userRole === 'kitchen' || userRole === 'chef') {
            showToast('👨‍🍳 Staff Mode Active: Kitchen staff cannot place food orders. Manage orders via KDS.', 'error');
            return;
        }

        // 3. Admin cannot order food (Admin maintains records only)
        if (userRole === 'admin') {
            showToast('⚡ Admin Mode: Administrator accounts only maintain records and cannot place food orders.', 'error');
            return;
        }

        const cart = this.getCart();
        const existing = cart.find(i => i.id === item.id);
        if (existing) {
            existing.quantity = (existing.quantity || 1) + 1;
        } else {
            cart.push({
                id: item.id,
                name: item.name,
                price: parseFloat(item.price),
                image: item.image || '',
                category: item.category || 'General',
                isVeg: item.isVeg !== undefined ? item.isVeg : true,
                quantity: 1
            });
        }
        this.saveCart(cart);
        showToast(`✓ ${item.name} added to cart!`);
    },

    updateQuantity: function(id, delta) {
        let cart = this.getCart();
        const item = cart.find(i => i.id === id);
        if (item) {
            item.quantity = (item.quantity || 1) + delta;
            if (item.quantity <= 0) {
                cart = cart.filter(i => i.id !== id);
            }
            this.saveCart(cart);
        }
        return cart;
    },

    removeItem: function(id) {
        let cart = this.getCart();
        cart = cart.filter(i => i.id !== id);
        this.saveCart(cart);
        return cart;
    },

    clearCart: function() {
        this.saveCart([]);
    },

    getCount: function() {
        const cart = this.getCart();
        return cart.reduce((total, item) => total + (item.quantity || 1), 0);
    },

    getTotal: function() {
        const cart = this.getCart();
        return cart.reduce((total, item) => total + (item.price * (item.quantity || 1)), 0);
    },

    updateBadge: function() {
        const count = this.getCount();
        const badges = document.querySelectorAll('.cart-badge');
        badges.forEach(badge => {
            badge.textContent = count;
            badge.style.display = count > 0 ? 'inline-flex' : 'none';
        });

        const cartTexts = document.querySelectorAll('.cart-nav-text');
        cartTexts.forEach(el => {
            el.textContent = `Cart (${count})`;
        });
    }
};

// Toast Notification System
function showToast(message, type = 'success') {
    let container = document.getElementById('toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toast-container';
        container.className = 'toast-container';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    toast.className = `smart-toast ${type}`;
    toast.innerHTML = `
        <span class="toast-icon">${type === 'success' ? '✓' : 'ℹ'}</span>
        <span class="toast-msg">${message}</span>
    `;

    container.appendChild(toast);

    setTimeout(() => {
        toast.classList.add('show');
    }, 10);

    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 400);
    }, 3200);
}

// Category Filter Helper
function setupCategoryFilter(buttonsSelector, itemsSelector) {
    const buttons = document.querySelectorAll(buttonsSelector);
    const items = document.querySelectorAll(itemsSelector);

    if (!buttons.length || !items.length) return;

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            buttons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            const selected = (button.getAttribute('data-filter') || button.textContent).trim().toLowerCase();

            items.forEach(item => {
                const category = (item.getAttribute('data-category') || '').toLowerCase();
                if (selected === 'all' || category === selected) {
                    item.style.display = '';
                    item.style.opacity = '0';
                    item.style.transform = 'translateY(10px)';
                    setTimeout(() => {
                        item.style.transition = 'all 0.35s ease';
                        item.style.opacity = '1';
                        item.style.transform = 'translateY(0)';
                    }, 50);
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });
}

// Mobile Menu Toggle
function setupMobileMenu() {
    const toggleBtn = document.querySelector('.mobile-menu-toggle');
    const navLinks = document.querySelector('.nav-links');
    if (toggleBtn && navLinks) {
        toggleBtn.addEventListener('click', () => {
            navLinks.classList.toggle('open');
            toggleBtn.classList.toggle('active');
            toggleBtn.setAttribute('aria-expanded', navLinks.classList.contains('open'));
        });

        // Close on link click
        navLinks.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                navLinks.classList.remove('open');
                toggleBtn.classList.remove('active');
            });
        });
    }
}

// Setup Add to Cart Buttons
function setupAddToCartButtons() {
    document.addEventListener('click', function(e) {
        const btn = e.target.closest('.add-to-cart-btn, .btn-add-cart');
        if (btn) {
            e.preventDefault();
            const id = btn.getAttribute('data-id');
            const name = btn.getAttribute('data-name');
            const price = btn.getAttribute('data-price');
            const image = btn.getAttribute('data-image');
            const category = btn.getAttribute('data-category');
            const isVeg = btn.getAttribute('data-veg') !== 'false';

            if (id && name && price) {
                CartManager.addItem({
                    id: id,
                    name: name,
                    price: price,
                    image: image,
                    category: category,
                    isVeg: isVeg
                });

                // Micro-interaction animation on button
                btn.classList.add('clicked');
                setTimeout(() => btn.classList.remove('clicked'), 300);
            }
        }
    });
}

// Sync Navigation Bar with Logged In Role
function syncNavbarRole() {
    try {
        const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
        const user = savedUserStr ? JSON.parse(savedUserStr) : null;
        const navLogin = document.querySelector('.nav-login');
        const navCart = document.querySelector('.nav-cart');

        if (!user) {
            if (navLogin) {
                navLogin.href = 'login.jsp';
                navLogin.innerHTML = 'Login <span>→</span>';
            }
            return;
        }

        const role = (user.role || 'Student').toLowerCase();
        if (role === 'admin') {
            if (navLogin) {
                navLogin.href = 'admin-dashboard.jsp';
                navLogin.innerHTML = 'Admin Records <span>⚡</span>';
                navLogin.style.background = '#7C3AED';
                navLogin.style.borderColor = '#6D28D9';
                navLogin.style.color = '#ffffff';
                navLogin.style.boxShadow = '0 2px 8px rgba(124, 58, 237, 0.3)';
            }
            if (navCart) {
                navCart.style.display = 'none'; // Admin cannot order food
            }
        } else if (role === 'staff' || role === 'kitchen' || role === 'chef') {
            if (navLogin) {
                navLogin.href = 'staff-dashboard.jsp';
                navLogin.innerHTML = 'Kitchen KDS <span>👨‍🍳</span>';
                navLogin.style.background = '#EA580C';
                navLogin.style.borderColor = '#C2410C';
                navLogin.style.color = '#ffffff';
                navLogin.style.boxShadow = '0 2px 8px rgba(234, 88, 12, 0.3)';
            }
            if (navCart) {
                navCart.style.display = 'none'; // Staff cannot order food
            }
        } else {
            // Student
            if (navLogin) {
                navLogin.href = 'dashboard.jsp';
                const firstName = (user.name || 'Student').split(' ')[0];
                navLogin.innerHTML = `${firstName} <span>🎓</span>`;
            }
        }
    } catch (e) {
        console.error('Navbar role sync error', e);
    }
}

// Global initialization
document.addEventListener('DOMContentLoaded', () => {
    CartManager.updateBadge();
    syncNavbarRole();
    setupMobileMenu();
    setupAddToCartButtons();
    setupCategoryFilter('.category-filter-btn', '.food-card-item');
});
