/**
 * SmartCanteen - Menu Page Interactivity (menu.js)
 * Implements instant search, category filtering, veg toggle, and sorting.
 */

document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('menuSearchInput');
    const clearBtn = document.getElementById('searchClearBtn');
    const catButtons = document.querySelectorAll('.menu-cat-btn');
    const vegToggleBtn = document.getElementById('vegToggleBtn');
    const sortSelect = document.getElementById('sortSelect');
    const foodCards = Array.from(document.querySelectorAll('.food-card-item'));
    const resultsCount = document.getElementById('resultsCount');
    const emptyResults = document.getElementById('emptyResults');
    const foodGrid = document.getElementById('menuFoodGrid');

    let currentCategory = 'all';
    let searchQuery = '';
    let vegOnly = false;

    function filterAndSortMenu() {
        let visibleCount = 0;
        const matchingCards = [];

        foodCards.forEach(card => {
            const name = (card.getAttribute('data-name') || '').toLowerCase();
            const desc = (card.querySelector('p') ? card.querySelector('p').textContent : '').toLowerCase();
            const category = (card.getAttribute('data-category') || '').toLowerCase();
            const isVeg = card.getAttribute('data-veg') !== 'false';

            const matchesSearch = !searchQuery || name.includes(searchQuery) || desc.includes(searchQuery);
            const matchesCat = currentCategory === 'all' || category === currentCategory;
            const matchesVeg = !vegOnly || isVeg;

            if (matchesSearch && matchesCat && matchesVeg) {
                card.style.display = 'flex';
                matchingCards.push(card);
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        // Apply Sorting
        if (sortSelect) {
            const sortBy = sortSelect.value;
            matchingCards.sort((a, b) => {
                const priceA = parseFloat(a.getAttribute('data-price') || 0);
                const priceB = parseFloat(b.getAttribute('data-price') || 0);
                const ratingA = parseFloat(a.getAttribute('data-rating') || 0);
                const ratingB = parseFloat(b.getAttribute('data-rating') || 0);

                if (sortBy === 'price-asc') return priceA - priceB;
                if (sortBy === 'price-desc') return priceB - priceA;
                if (sortBy === 'rating-desc') return ratingB - ratingA;
                return 0; // default
            });

            // Reorder in DOM
            matchingCards.forEach(card => foodGrid.appendChild(card));
        }

        // Update counts
        if (resultsCount) {
            resultsCount.textContent = `Showing ${visibleCount} delicious items`;
        }

        // Handle empty state
        if (emptyResults) {
            emptyResults.style.display = visibleCount === 0 ? 'block' : 'none';
        }
    }

    // Search events
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            searchQuery = e.target.value.trim().toLowerCase();
            if (clearBtn) {
                clearBtn.style.display = searchQuery ? 'block' : 'none';
            }
            filterAndSortMenu();
        });
    }

    if (clearBtn) {
        clearBtn.addEventListener('click', () => {
            searchInput.value = '';
            searchQuery = '';
            clearBtn.style.display = 'none';
            filterAndSortMenu();
            searchInput.focus();
        });
    }

    // Category button events
    catButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            catButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = (btn.getAttribute('data-category') || 'all').toLowerCase();
            filterAndSortMenu();
        });
    });

    // Veg toggle event
    if (vegToggleBtn) {
        vegToggleBtn.addEventListener('click', () => {
            vegOnly = !vegOnly;
            vegToggleBtn.classList.toggle('active', vegOnly);
            filterAndSortMenu();
        });
    }

    // Sort event
    if (sortSelect) {
        sortSelect.addEventListener('change', () => {
            filterAndSortMenu();
        });
    }

    // Reset filters helper
    window.resetMenuFilters = function() {
        if (searchInput) searchInput.value = '';
        searchQuery = '';
        if (clearBtn) clearBtn.style.display = 'none';
        currentCategory = 'all';
        catButtons.forEach(b => b.classList.toggle('active', b.getAttribute('data-category') === 'all'));
        vegOnly = false;
        if (vegToggleBtn) vegToggleBtn.classList.remove('active');
        if (sortSelect) sortSelect.value = 'default';
        filterAndSortMenu();
    };

    filterAndSortMenu();

    // Authentication & Role detection for Menu
    const savedUserStr = localStorage.getItem('smartcanteen_logged_in_user') || sessionStorage.getItem('smartcanteen_user');
    
    if (!savedUserStr) {
        // Guest mode: Must log in to order
        const guestBanner = document.getElementById('guestLoginNoticeBanner');
        if (guestBanner) guestBanner.style.display = 'block';

        document.querySelectorAll('.btn-add-cart').forEach(btn => {
            btn.title = 'Please log in with your student account to order food.';
        });
    } else {
        try {
            const user = JSON.parse(savedUserStr);
            const role = (user.role || '').toLowerCase();
            
            if (role === 'staff' || role === 'kitchen' || role === 'chef') {
                // Staff mode: Kitchen Display System only
                const staffBanner = document.getElementById('staffInspectionBanner');
                if (staffBanner) staffBanner.style.display = 'block';

                document.querySelectorAll('.btn-add-cart').forEach(btn => {
                    btn.textContent = '👨‍🍳 Prep View';
                    btn.title = 'Staff accounts operate the KDS and cannot place food orders.';
                    btn.style.background = '#475569';
                    btn.style.color = '#E2E8F0';
                    btn.style.borderColor = '#64748B';
                });
            } else if (role === 'admin') {
                // Admin mode: Records maintenance only
                const adminBanner = document.getElementById('adminNoticeBanner');
                if (adminBanner) adminBanner.style.display = 'block';

                document.querySelectorAll('.btn-add-cart').forEach(btn => {
                    btn.textContent = '⚡ Catalog View';
                    btn.title = 'Admin accounts maintain records only and cannot place food orders.';
                    btn.style.background = '#6B21A8';
                    btn.style.color = '#F3E8FF';
                    btn.style.borderColor = '#9333EA';
                });
            }
        } catch (e) {}
    }
});
