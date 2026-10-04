/**
 * SmartCanteen - Cart & Checkout Logic (cart.js)
 * Interacts with CartManager, manages discounts, tax, and order submission.
 */

const CartUI = {
    DISCOUNT_CODE: 'CAMPUS10',
    discountApplied: false,
    discountPercent: 0.10,

    initCartPage: function() {
        this.renderCartTable();

        window.addEventListener('cartUpdated', () => {
            this.renderCartTable();
        });

        // Coupon code submit
        const applyCouponBtn = document.getElementById('applyCouponBtn');
        const couponInput = document.getElementById('couponCodeInput');
        if (applyCouponBtn && couponInput) {
            applyCouponBtn.addEventListener('click', () => {
                const code = couponInput.value.trim().toUpperCase();
                if (code === this.DISCOUNT_CODE) {
                    this.discountApplied = true;
                    showToast('🎉 Coupon CAMPUS10 applied! 10% off.');
                    this.renderCartTable();
                } else if (!code) {
                    showToast('Please enter a coupon code', 'info');
                } else {
                    showToast('Invalid coupon code. Try CAMPUS10', 'info');
                }
            });
        }
    },

    renderCartTable: function() {
        const cart = CartManager.getCart();
        const tbody = document.getElementById('cartTableBody');
        const emptyState = document.getElementById('cartEmptyState');
        const cartContent = document.getElementById('cartContentSection');

        if (!tbody) return;

        if (cart.length === 0) {
            if (emptyState) emptyState.style.display = 'block';
            if (cartContent) cartContent.style.display = 'none';
            return;
        }

        if (emptyState) emptyState.style.display = 'none';
        if (cartContent) cartContent.style.display = 'grid';

        tbody.innerHTML = '';
        let subtotal = 0;

        cart.forEach(item => {
            const itemTotal = item.price * item.quantity;
            subtotal += itemTotal;

            const tr = document.createElement('tr');
            tr.className = 'cart-item-row';
            tr.innerHTML = `
                <td class="cart-food-cell">
                    <img src="${item.image || 'images/dosa.jpg'}" alt="${item.name}">
                    <div>
                        <strong>${item.name}</strong>
                        <span class="cart-item-cat">${item.category || 'Food'}</span>
                    </div>
                </td>
                <td class="cart-price-cell">₹${item.price.toFixed(2)}</td>
                <td class="cart-qty-cell">
                    <div class="qty-stepper">
                        <button type="button" class="qty-btn minus" onclick="CartUI.changeQty('${item.id}', -1)">−</button>
                        <span class="qty-val">${item.quantity}</span>
                        <button type="button" class="qty-btn plus" onclick="CartUI.changeQty('${item.id}', 1)">+</button>
                    </div>
                </td>
                <td class="cart-subtotal-cell">₹${itemTotal.toFixed(2)}</td>
                <td class="cart-action-cell">
                    <button type="button" class="cart-remove-btn" onclick="CartUI.removeItem('${item.id}')" title="Remove Item">✕</button>
                </td>
            `;
            tbody.appendChild(tr);
        });

        // Summary Calculations
        const discountAmount = this.discountApplied ? subtotal * this.discountPercent : 0;
        const taxAmount = (subtotal - discountAmount) * 0.05; // 5% GST / Campus Fee
        const grandTotal = (subtotal - discountAmount) + taxAmount;

        const elSubtotal = document.getElementById('summarySubtotal');
        const elDiscountRow = document.getElementById('summaryDiscountRow');
        const elDiscount = document.getElementById('summaryDiscount');
        const elTax = document.getElementById('summaryTax');
        const elTotal = document.getElementById('summaryTotal');

        if (elSubtotal) elSubtotal.textContent = `₹${subtotal.toFixed(2)}`;
        if (elDiscountRow && elDiscount) {
            if (this.discountApplied) {
                elDiscountRow.style.display = 'flex';
                elDiscount.textContent = `-₹${discountAmount.toFixed(2)}`;
            } else {
                elDiscountRow.style.display = 'none';
            }
        }
        if (elTax) elTax.textContent = `₹${taxAmount.toFixed(2)}`;
        if (elTotal) elTotal.textContent = `₹${grandTotal.toFixed(2)}`;

        // Save order totals in sessionStorage for checkout
        sessionStorage.setItem('smartcanteen_order_summary', JSON.stringify({
            subtotal: subtotal,
            discount: discountAmount,
            tax: taxAmount,
            total: grandTotal,
            itemCount: CartManager.getCount()
        }));
    },

    changeQty: function(id, delta) {
        CartManager.updateQuantity(id, delta);
    },

    removeItem: function(id) {
        CartManager.removeItem(id);
        showToast('Item removed from cart', 'info');
    },

    initCheckoutPage: function() {
        const cart = CartManager.getCart();
        if (cart.length === 0) {
            window.location.href = 'cart.jsp';
            return;
        }

        // Render mini summary
        const summaryList = document.getElementById('checkoutSummaryList');
        if (summaryList) {
            summaryList.innerHTML = '';
            cart.forEach(item => {
                const li = document.createElement('div');
                li.className = 'checkout-item-preview';
                li.innerHTML = `
                    <div class="checkout-item-name">
                        <span>${item.quantity}×</span>
                        <strong>${item.name}</strong>
                    </div>
                    <span>₹${(item.price * item.quantity).toFixed(2)}</span>
                `;
                summaryList.appendChild(li);
            });
        }

        // Read totals
        const savedSummary = sessionStorage.getItem('smartcanteen_order_summary');
        if (savedSummary) {
            const data = JSON.parse(savedSummary);
            const totalEl = document.getElementById('checkoutTotalAmount');
            if (totalEl) totalEl.textContent = `₹${data.total.toFixed(2)}`;
        }

        // Time slot selection
        const slotButtons = document.querySelectorAll('.slot-pill');
        const selectedSlotInput = document.getElementById('selectedPickupSlot');
        slotButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                slotButtons.forEach(b => b.classList.remove('selected'));
                btn.classList.add('selected');
                if (selectedSlotInput) {
                    selectedSlotInput.value = btn.getAttribute('data-slot');
                }
            });
        });

        // Payment method selection
        const paymentOptions = document.querySelectorAll('.payment-option');
        const selectedPaymentInput = document.getElementById('selectedPaymentMethod');
        const upiPreview = document.getElementById('upiQrPreview');

        paymentOptions.forEach(opt => {
            opt.addEventListener('click', () => {
                paymentOptions.forEach(o => o.classList.remove('active'));
                opt.classList.add('active');
                const val = opt.getAttribute('data-method');
                if (selectedPaymentInput) selectedPaymentInput.value = val;

                if (upiPreview) {
                    upiPreview.style.display = val === 'UPI' ? 'block' : 'none';
                }
            });
        });

        // Prefill logged-in student info if available
        const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
        const currentUser = savedUserStr ? JSON.parse(savedUserStr) : null;
        if (currentUser) {
            const nameInput = document.getElementById('custName');
            if (nameInput && (!nameInput.value || nameInput.value === 'Aarav Sharma')) {
                nameInput.value = currentUser.name || '';
            }
        }

        // Form submission
        const checkoutForm = document.getElementById('checkoutForm');
        if (checkoutForm) {
            checkoutForm.addEventListener('submit', (e) => {
                e.preventDefault();

                // 1. Mandatory Student Login Guard
                const latestUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
                const loggedInUser = latestUserStr ? JSON.parse(latestUserStr) : null;

                if (!loggedInUser) {
                    alert('🔒 Login Required: You must sign in with your student account to place orders.');
                    window.location.href = 'login.jsp?error=login_required&redirect=checkout.jsp';
                    return;
                }

                const role = (loggedInUser.role || '').toLowerCase();
                if (role === 'staff' || role === 'kitchen' || role === 'chef') {
                    alert('👨‍🍳 Staff Mode Active: Kitchen staff cannot place food orders. Manage food preparation in the KDS.');
                    window.location.href = 'staff-dashboard.jsp';
                    return;
                }
                if (role === 'admin') {
                    alert('⚡ Admin Mode Active: Administrator accounts only maintain records and cannot place food orders.');
                    window.location.href = 'admin-dashboard.jsp';
                    return;
                }

                const slot = selectedSlotInput ? selectedSlotInput.value : '12:45 PM';
                const payment = selectedPaymentInput ? selectedPaymentInput.value : 'UPI';
                const name = document.getElementById('custName') ? document.getElementById('custName').value : (loggedInUser.name || 'Student');
                const roll = document.getElementById('custRoll') ? document.getElementById('custRoll').value : 'SC-2026';
                const phone = document.getElementById('custPhone') ? document.getElementById('custPhone').value : '9876543210';
                const notes = document.getElementById('custNotes') ? document.getElementById('custNotes').value : '';

                const userEmail = (loggedInUser.email || '').trim().toLowerCase();

                // Create confirmed order record tied to the logged-in account
                const orderId = 'SC' + Math.floor(1000 + Math.random() * 9000);
                const orderRecord = {
                    orderId: orderId,
                    userEmail: userEmail,
                    date: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                    pickupSlot: slot,
                    paymentMethod: payment,
                    customer: { name, roll, phone, notes, email: userEmail },
                    items: cart,
                    summary: JSON.parse(sessionStorage.getItem('smartcanteen_order_summary') || '{}'),
                    status: 'Preparing'
                };

                // Save to active orders history in localStorage
                try {
                    const existingOrders = JSON.parse(localStorage.getItem('smartcanteen_orders') || '[]');
                    existingOrders.unshift(orderRecord);
                    localStorage.setItem('smartcanteen_orders', JSON.stringify(existingOrders));
                    sessionStorage.setItem('smartcanteen_last_order', JSON.stringify(orderRecord));
                } catch (err) {
                    console.error('Error saving order', err);
                }

                // Clear current shopping cart
                CartManager.clearCart();

                // Redirect to success confirmation page
                window.location.href = `order-success.jsp?orderId=${orderId}&slot=${encodeURIComponent(slot)}`;
            });
        }
    },

    initSuccessPage: function() {
        // Retrieve last order details
        try {
            const lastOrderStr = sessionStorage.getItem('smartcanteen_last_order');
            if (lastOrderStr) {
                const order = JSON.parse(lastOrderStr);
                const idEl = document.getElementById('successOrderId');
                const slotEl = document.getElementById('successPickupSlot');
                const itemsList = document.getElementById('successItemsList');
                const totalEl = document.getElementById('successOrderTotal');

                if (idEl) idEl.textContent = '#' + order.orderId;
                if (slotEl) slotEl.textContent = order.pickupSlot;
                if (totalEl && order.summary && order.summary.total) {
                    totalEl.textContent = `₹${order.summary.total.toFixed(2)}`;
                }

                if (itemsList && order.items) {
                    itemsList.innerHTML = '';
                    order.items.forEach(it => {
                        const div = document.createElement('div');
                        div.className = 'order-item-chip';
                        div.innerHTML = `<span>${it.quantity}× ${it.name}</span> <strong>₹${(it.price * it.quantity).toFixed(2)}</strong>`;
                        itemsList.appendChild(div);
                    });
                }
            }
        } catch (e) {
            console.error('Error rendering order-success details', e);
        }
    }
};
