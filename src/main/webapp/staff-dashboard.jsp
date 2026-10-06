<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    /*
     * ============================================================
     * SERVER-SIDE ROLE PROTECTION
     * ============================================================
     *
     * The HTTP session is the source of truth.
     * localStorage/sessionStorage must NOT be used for authorization.
     */

    com.smartcanteen.model.User currentUser =
        (com.smartcanteen.model.User) session.getAttribute("user");

    String currentRole = (String) session.getAttribute("userRole");

    String currentUserName = (String) session.getAttribute("userName");

    /*
     * If userRole is not separately stored in session,
     * try to get it from the User object.
     */
    if (currentRole == null && currentUser != null) {
        currentRole = currentUser.getRole();
    }

    /*
     * If userName is not separately stored in session,
     * get it from the User object.
     */
    if (currentUserName == null && currentUser != null) {
        currentUserName = currentUser.getName();
    }

    /*
     * No logged-in user
     */
    if (currentUser == null && currentRole == null) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp?error=staff_only"
        );
        return;
    }

    /*
     * STUDENT
     */
    if ("Student".equalsIgnoreCase(currentRole)) {

        response.sendRedirect(
            request.getContextPath() +
            "/dashboard.jsp?error=unauthorized_staff"
        );
        return;
    }

    /*
     * ADMIN
     */
    if ("Admin".equalsIgnoreCase(currentRole)) {

        response.sendRedirect(
            request.getContextPath() +
            "/admin-dashboard.jsp?error=admin_cannot_access_kitchen"
        );
        return;
    }

    /*
     * ONLY THESE ROLES CAN ACCESS KDS
     */
    if (
        currentRole == null ||
        (
            !"Staff".equalsIgnoreCase(currentRole) &&
            !"Kitchen".equalsIgnoreCase(currentRole) &&
            !"Chef".equalsIgnoreCase(currentRole)
        )
    ) {

        response.sendRedirect(
            request.getContextPath() +
            "/login.jsp?error=staff_only"
        );
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Kitchen Staff & Order Display (KDS) | SmartCanteen
    </title>


    <!-- Google Fonts -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Space+Grotesk:wght@500;600;700&display=swap"
          rel="stylesheet">


    <!-- Stylesheets -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

</head>


<body class="kds-theme">


<div class="dashboard-layout">


    <!-- =========================================================
         SIDEBAR
         ========================================================= -->

    <aside class="sidebar">

        <div class="sidebar-header">

            <a href="${pageContext.request.contextPath}/index.jsp"
               class="logo">

                <span>
                    Kitchen<span>Staff</span>
                </span>

            </a>

        </div>


        <ul class="sidebar-menu">

            <span class="sidebar-menu-title">
                KDS Operations
            </span>


            <li>

                <a href="${pageContext.request.contextPath}/staff-dashboard.jsp"
                   class="sidebar-link active">

                    KDS Live Orders

                </a>

            </li>


            <li>

                <a href="${pageContext.request.contextPath}/menu.jsp"
                   class="sidebar-link">

                    Recipes &amp; Prep Times

                </a>

            </li>


            <li>

                <a href="#whyUsKitchen"
                   class="sidebar-link">

                    Kitchen Prep Standards

                </a>

            </li>


            <span class="sidebar-menu-title">
                Terminal Controls
            </span>


            <li>

                <a href="${pageContext.request.contextPath}/index.jsp"
                   class="sidebar-link">

                    Website Home

                </a>

            </li>


            <li>

                <a href="${pageContext.request.contextPath}/LogoutServlet"
                   class="sidebar-link"
                   style="color: #F87171 !important;">

                    Sign Out Kitchen

                </a>

            </li>

        </ul>


        <!-- SIDEBAR USER -->

        <div class="sidebar-user">

            <div class="user-avatar"
                 style="background: var(--emerald, #10B981);"
                 id="staffUserAvatar">

                <%= currentUserName != null &&
                    currentUserName.length() > 0
                    ? currentUserName.substring(0, 1).toUpperCase()
                    : "S" %>

            </div>


            <div class="user-info">

                <strong id="staffUserName">

                    <%= currentUserName != null
                        ? currentUserName
                        : "Kitchen Staff" %>

                </strong>


                <small id="staffUserRole">

                    <%= currentRole != null
                        ? currentRole
                        : "Staff" %>

                </small>

            </div>


            <a href="${pageContext.request.contextPath}/LogoutServlet"
               title="Logout"
               style="margin-left: auto;
                      color: var(--muted);
                      font-size: 16px;">

                &rarr;

            </a>

        </div>

    </aside>



    <!-- =========================================================
         MAIN CONTENT
         ========================================================= -->

    <main class="main-content">


        <!-- TOPBAR -->

        <header class="topbar kds-topbar">

            <div class="topbar-title">

                <h2>

                    KDS Industrial Terminal

                    <span style="
                        font-size: 13px;
                        font-weight: 700;
                        color: #10B981;
                        background: rgba(16, 185, 129, 0.15);
                        padding: 4px 10px;
                        border-radius: 8px;
                        vertical-align: middle;
                        margin-left: 8px;
                    ">

                        STATION 1

                    </span>

                </h2>


                <p style="
                    font-size: 13px;
                    color: #94A3B8;
                ">

                    Real-time student food preparation
                    pipeline &amp; dispatch window.

                </p>

            </div>


            <div class="topbar-actions">

                <button type="button"
                        class="primary-btn"
                        onclick="showToast('Chime sounded. Ticket refresh synced.');"
                        style="
                            padding: 10px 18px;
                            font-size: 13px;
                            background: linear-gradient(
                                135deg,
                                #10B981,
                                #059669
                            );
                        ">

                    Ring Counter Bell

                </button>


                <a href="${pageContext.request.contextPath}/LogoutServlet"
                   class="topbar-btn"
                   title="Sign Out"
                   style="
                       background: #1E293B;
                       border-color: #334155;
                       color: #F8FAFC;
                   ">

                    &rarr;

                </a>

            </div>

        </header>



        <!-- =========================================================
             DASHBOARD BODY
             ========================================================= -->

        <div class="dashboard-body">


            <!-- =====================================================
                 METRIC COUNTERS
                 ===================================================== -->

            <div class="metrics-grid">


                <div class="metric-card">

                    <div class="metric-icon purple">
                        Total
                    </div>

                    <div class="metric-data">

                        <small>
                            Today's Total Orders
                        </small>

                        <strong id="counterTotal">
                            142
                        </strong>

                    </div>

                </div>



                <div class="metric-card">

                    <div class="metric-icon pink">
                        Queue
                    </div>

                    <div class="metric-data">

                        <small>
                            New Orders Queue
                        </small>

                        <strong id="counterNew"
                                style="color: var(--pink);">

                            3 Orders

                        </strong>

                    </div>

                </div>



                <div class="metric-card">

                    <div class="metric-icon green">
                        Prep
                    </div>

                    <div class="metric-data">

                        <small>
                            Currently Preparing
                        </small>

                        <strong id="counterPrep"
                                style="color: var(--emerald, #10B981);">

                            5 Orders

                        </strong>

                    </div>

                </div>



                <div class="metric-card">

                    <div class="metric-icon green">
                        Ready
                    </div>

                    <div class="metric-data">

                        <small>
                            Ready for Pickup
                        </small>

                        <strong id="counterReady"
                                style="color: var(--green);">

                            4 Orders

                        </strong>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 KANBAN BOARD
                 ===================================================== -->

            <div class="kanban-board">


                <!-- =================================================
                     NEW ORDERS
                     ================================================= -->

                <div class="kanban-col"
                     id="colNew">

                    <div class="kanban-col-header">

                        <span>
                            New Orders
                        </span>

                        <span class="kanban-counter">
                            2
                        </span>

                    </div>


                    <div class="kanban-card"
                         id="kCard1025">

                        <div style="
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 8px;
                        ">

                            <strong style="color: var(--purple);">
                                #SC1025
                            </strong>

                            <span style="
                                font-size: 11px;
                                font-weight: 700;
                                color: var(--muted);
                            ">

                                Slot: 1:00 PM

                            </span>

                        </div>


                        <p style="
                            font-size: 13px;
                            font-weight: 600;
                            margin-bottom: 6px;
                        ">

                            2&times; Masala Dosa,
                            1&times; Cold Coffee

                        </p>


                        <small style="
                            color: var(--muted);
                            display: block;
                            margin-bottom: 12px;
                        ">

                            Student: Priya Nair (EC-12)

                        </small>


                        <div class="kanban-card-actions">

                            <button type="button"
                                    class="kanban-action-btn primary"
                                    onclick="moveOrder('kCard1025', 'colPrep', 'Cooking Started')">

                                Start Cooking &rarr;

                            </button>

                        </div>

                    </div>



                    <div class="kanban-card"
                         id="kCard1026">

                        <div style="
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 8px;
                        ">

                            <strong style="color: var(--purple);">
                                #SC1026
                            </strong>

                            <span style="
                                font-size: 11px;
                                font-weight: 700;
                                color: var(--muted);
                            ">

                                Slot: 1:15 PM

                            </span>

                        </div>


                        <p style="
                            font-size: 13px;
                            font-weight: 600;
                            margin-bottom: 6px;
                        ">

                            1&times; Chicken Dum Biryani

                        </p>


                        <small style="
                            color: var(--muted);
                            display: block;
                            margin-bottom: 12px;
                        ">

                            Student: Rahul V. (ME-08)

                        </small>


                        <div class="kanban-card-actions">

                            <button type="button"
                                    class="kanban-action-btn primary"
                                    onclick="moveOrder('kCard1026', 'colPrep', 'Cooking Started')">

                                Start Cooking &rarr;

                            </button>

                        </div>

                    </div>

                </div>



                <!-- =================================================
                     IN PREPARATION
                     ================================================= -->

                <div class="kanban-col"
                     id="colPrep">

                    <div class="kanban-col-header">

                        <span>
                            In Preparation
                        </span>

                        <span class="kanban-counter">
                            2
                        </span>

                    </div>


                    <div class="kanban-card"
                         id="kCard1024">

                        <div style="
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 8px;
                        ">

                            <strong style="color: #10B981;">
                                #SC1024
                            </strong>

                            <span style="
                                font-size: 11px;
                                font-weight: 700;
                                color: #10B981;
                            ">

                                Slot: 12:45 PM

                            </span>

                        </div>


                        <p style="
                            font-size: 13px;
                            font-weight: 600;
                            margin-bottom: 6px;
                        ">

                            1&times; Paneer Pizza,
                            1&times; Burger

                        </p>


                        <small style="
                            color: var(--muted);
                            display: block;
                            margin-bottom: 12px;
                        ">

                            Student: Aarav Sharma (CS-42)

                        </small>


                        <div class="kanban-card-actions">

                            <button type="button"
                                    class="kanban-action-btn success"
                                    onclick="moveOrder('kCard1024', 'colReady', 'Marked Ready for Pickup')">

                                Ready for Pickup

                            </button>

                        </div>

                    </div>



                    <div class="kanban-card"
                         id="kCard1023">

                        <div style="
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 8px;
                        ">

                            <strong style="color: #10B981;">
                                #SC1023
                            </strong>

                            <span style="
                                font-size: 11px;
                                font-weight: 700;
                                color: #10B981;
                            ">

                                Slot: 12:45 PM

                            </span>

                        </div>


                        <p style="
                            font-size: 13px;
                            font-weight: 600;
                            margin-bottom: 6px;
                        ">

                            2&times; Veg Sandwich,
                            2&times; Fries

                        </p>


                        <small style="
                            color: var(--muted);
                            display: block;
                            margin-bottom: 12px;
                        ">

                            Prof. Meenakshi (Maths)

                        </small>


                        <div class="kanban-card-actions">

                            <button type="button"
                                    class="kanban-action-btn success"
                                    onclick="moveOrder('kCard1023', 'colReady', 'Marked Ready for Pickup')">

                                Ready for Pickup

                            </button>

                        </div>

                    </div>

                </div>



                <!-- =================================================
                     READY FOR PICKUP
                     ================================================= -->

                <div class="kanban-col"
                     id="colReady">

                    <div class="kanban-col-header">

                        <span>
                            Ready for Pickup
                        </span>

                        <span class="kanban-counter">
                            1
                        </span>

                    </div>


                    <div class="kanban-card"
                         id="kCard1022">

                        <div style="
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 8px;
                        ">

                            <strong style="color: var(--green-dark);">
                                #SC1022
                            </strong>

                            <span style="
                                font-size: 11px;
                                font-weight: 700;
                                color: var(--green-dark);
                            ">

                                Slot: 12:30 PM

                            </span>

                        </div>


                        <p style="
                            font-size: 13px;
                            font-weight: 600;
                            margin-bottom: 6px;
                        ">

                            1&times; Chole Bhature,
                            1&times; Lime Soda

                        </p>


                        <small style="
                            color: var(--muted);
                            display: block;
                            margin-bottom: 12px;
                        ">

                            Counter 1 Alerted

                        </small>


                        <div class="kanban-card-actions">

                            <button type="button"
                                    class="kanban-action-btn"
                                    style="
                                        background: var(--dark);
                                        color: white;
                                    "
                                    onclick="moveOrder('kCard1022', 'colDone', 'Order Picked Up')">

                                Handed Over

                            </button>

                        </div>

                    </div>

                </div>



                <!-- =================================================
                     COMPLETED
                     ================================================= -->

                <div class="kanban-col"
                     id="colDone">

                    <div class="kanban-col-header">

                        <span>
                            Completed
                        </span>

                        <span class="kanban-counter">
                            1
                        </span>

                    </div>


                    <div class="kanban-card"
                         style="opacity: 0.8;">

                        <div style="
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 8px;
                        ">

                            <strong style="color: var(--muted);">
                                #SC1021
                            </strong>

                            <span style="
                                font-size: 11px;
                                color: var(--muted);
                            ">

                                Slot: 12:15 PM

                            </span>

                        </div>


                        <p style="
                            font-size: 13px;
                            margin-bottom: 6px;
                        ">

                            1&times; Veg Dum Biryani

                        </p>


                        <small style="
                            color: var(--green-dark);
                            font-weight: 700;
                        ">

                            Completed at 12:18 PM

                        </small>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 KITCHEN OPERATING PRINCIPLES
                 ===================================================== -->

            <div class="checkout-section-box"
                 id="whyUsKitchen"
                 style="
                     margin-top: 32px;
                     background: #0F172A;
                     border: 1px solid #1E293B;
                 ">


                <div style="
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 16px;
                    flex-wrap: wrap;
                    gap: 12px;
                ">

                    <div>

                        <h3 style="
                            margin-bottom: 4px;
                            color: #F8FAFC;
                        ">

                            Why Us: Kitchen Operating Principles

                        </h3>


                        <span style="
                            font-size: 13px;
                            color: #94A3B8;
                        ">

                            Pre-ordered batching makes campus
                            cooking faster and eliminates
                            counter chaos.

                        </span>

                    </div>


                    <span class="status-badge ready"
                          style="
                              font-size: 12px;
                              padding: 4px 12px;
                              background: rgba(16, 185, 129, 0.15);
                              color: #10B981;
                              border: 1px solid rgba(16, 185, 129, 0.3);
                          ">

                        Staff Protocol

                    </span>

                </div>



                <div style="
                    display: grid;
                    grid-template-columns:
                        repeat(auto-fit, minmax(240px, 1fr));
                    gap: 16px;
                ">


                    <div style="
                        padding: 18px;
                        background: #1E293B;
                        border: 1px solid #334155;
                        border-radius: var(--radius-md);
                    ">

                        <strong style="
                            color: #38BDF8;
                            font-size: 14px;
                            display: block;
                            margin-bottom: 4px;
                        ">

                            1. Zero Rush Chaos

                        </strong>


                        <p style="
                            font-size: 13px;
                            color: #94A3B8;
                            margin: 0;
                            line-height: 1.5;
                        ">

                            Student orders arrive pre-slotted
                            (12:00, 12:15, 12:45 PM), smoothing
                            out break counter crowds so the
                            kitchen is never flooded all at once.

                        </p>

                    </div>



                    <div style="
                        padding: 18px;
                        background: #1E293B;
                        border: 1px solid #334155;
                        border-radius: var(--radius-md);
                    ">

                        <strong style="
                            color: #10B981;
                            font-size: 14px;
                            display: block;
                            margin-bottom: 4px;
                        ">

                            2. Cook On Demand

                        </strong>


                        <p style="
                            font-size: 13px;
                            color: #94A3B8;
                            margin: 0;
                            line-height: 1.5;
                        ">

                            Staff clicks 'Start Cooking'
                            5-8 minutes before the student's
                            pickup slot, ensuring meals are
                            piping hot when collected at the window.

                        </p>

                    </div>



                    <div style="
                        padding: 18px;
                        background: #1E293B;
                        border: 1px solid #334155;
                        border-radius: var(--radius-md);
                    ">

                        <strong style="
                            color: #34D399;
                            font-size: 14px;
                            display: block;
                            margin-bottom: 4px;
                        ">

                            3. Zero Food Waste

                        </strong>


                        <p style="
                            font-size: 13px;
                            color: #94A3B8;
                            margin: 0;
                            line-height: 1.5;
                        ">

                            The kitchen only cooks food that
                            students have already ordered and
                            prepaid, eliminating leftover food
                            waste at day's end.

                        </p>

                    </div>

                </div>

            </div>

        </div>

    </main>

</div>



<!-- =============================================================
     TOAST
     ============================================================= -->

<div id="toast-container"
     class="toast-container">
</div>



<!-- MAIN JS -->

<script src="${pageContext.request.contextPath}/js/main.js"></script>



<!-- =============================================================
     USER INFORMATION FOR FRONTEND CONVENIENCE
     =============================================================

     This stores name/email/role for other frontend features.

     IMPORTANT:
     It is NOT used for authorization.
     The server session above remains the source of truth.
     ============================================================= -->

<script>

<%
    if (currentUser != null) {

        String safeName =
            currentUser.getName() != null
            ? currentUser.getName()
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "")
                .replace("\n", "")
            : "";

        String safeEmail =
            currentUser.getEmail() != null
            ? currentUser.getEmail()
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "")
                .replace("\n", "")
            : "";

        String safeRole =
            currentUser.getRole() != null
            ? currentUser.getRole()
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "")
                .replace("\n", "")
            : "";
%>

localStorage.setItem(
    'smartcanteen_logged_in_user',
    JSON.stringify({
        name: "<%= safeName %>",
        email: "<%= safeEmail %>",
        role: "<%= safeRole %>"
    })
);

sessionStorage.setItem(
    'smartcanteen_user',
    JSON.stringify({
        name: "<%= safeName %>",
        email: "<%= safeEmail %>",
        role: "<%= safeRole %>"
    })
);

<%
    }
%>

</script>



<!-- =============================================================
     KDS JAVASCRIPT
     ============================================================= -->

<script>

document.addEventListener('DOMContentLoaded', () => {

    /*
     * ============================================================
     * SERVER ROLE
     * ============================================================
     *
     * NEVER read role from localStorage for authorization.
     */

    const serverRole = "<%= currentRole != null
        ? currentRole
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "")
            .replace("\n", "")
        : "" %>";


    const serverName = "<%= currentUserName != null
        ? currentUserName
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "")
            .replace("\n", "")
        : "" %>";


    const role = serverRole.trim().toLowerCase();


    /*
     * ============================================================
     * NO SERVER ROLE
     * ============================================================
     */

    if (!role) {

        window.location.href =
            '${pageContext.request.contextPath}/login.jsp?error=staff_only';

        return;
    }


    /*
     * ============================================================
     * DISPLAY STAFF NAME
     * ============================================================
     */

    const nameEl =
        document.getElementById('staffUserName');

    const avatarEl =
        document.getElementById('staffUserAvatar');

    const roleEl =
        document.getElementById('staffUserRole');


    if (nameEl && serverName) {

        nameEl.textContent =
            serverName;

    }


    if (avatarEl && serverName) {

        avatarEl.textContent =
            serverName
                .charAt(0)
                .toUpperCase();

    }


    if (roleEl && serverRole) {

        roleEl.textContent =
            serverRole;

    }


    /*
     * ============================================================
     * ADMIN
     * ============================================================
     */

    if (role === 'admin') {

        window.location.href =
            '${pageContext.request.contextPath}/admin-dashboard.jsp';

        return;
    }


    /*
     * ============================================================
     * STUDENT
     * ============================================================
     */

    if (role === 'student') {

        window.location.href =
            '${pageContext.request.contextPath}/dashboard.jsp';

        return;
    }


    /*
     * ============================================================
     * ONLY STAFF / KITCHEN / CHEF
     * ============================================================
     */

    if (
        role !== 'staff' &&
        role !== 'kitchen' &&
        role !== 'chef'
    ) {

        window.location.href =
            '${pageContext.request.contextPath}/login.jsp?error=staff_only';

        return;
    }


    /*
     * ============================================================
     * VALID KITCHEN STAFF
     * ============================================================
     */

    renderKitchenLiveKanban();

});



/* ===============================================================
   DEFAULT ORDERS
   =============================================================== */

const defaultOrders = [

    {
        orderId: 'SC1025',

        customer: {
            name: 'Priya Nair (EC-12)'
        },

        pickupSlot: '1:00 PM',

        items: [
            {
                name: 'Masala Dosa',
                quantity: 2
            },
            {
                name: 'Cold Coffee',
                quantity: 1
            }
        ],

        status: 'New'
    },


    {
        orderId: 'SC1026',

        customer: {
            name: 'Rahul V. (ME-08)'
        },

        pickupSlot: '1:15 PM',

        items: [
            {
                name: 'Chicken Dum Biryani',
                quantity: 1
            }
        ],

        status: 'New'
    },


    {
        orderId: 'SC1024',

        customer: {
            name: 'Aarav Sharma (CS-42)'
        },

        pickupSlot: '12:45 PM',

        items: [
            {
                name: 'Paneer Pizza',
                quantity: 1
            },
            {
                name: 'Campus Burger',
                quantity: 1
            }
        ],

        status: 'Preparing'
    },


    {
        orderId: 'SC1023',

        customer: {
            name: 'Prof. Meenakshi'
        },

        pickupSlot: '12:45 PM',

        items: [
            {
                name: 'Veg Sandwich',
                quantity: 2
            },
            {
                name: 'Fries',
                quantity: 2
            }
        ],

        status: 'Preparing'
    },


    {
        orderId: 'SC1022',

        customer: {
            name: 'Counter 1 Alert'
        },

        pickupSlot: '12:30 PM',

        items: [
            {
                name: 'Chole Bhature',
                quantity: 1
            },
            {
                name: 'Lime Soda',
                quantity: 1
            }
        ],

        status: 'Ready'
    },


    {
        orderId: 'SC1021',

        customer: {
            name: 'Karan Patel'
        },

        pickupSlot: '12:15 PM',

        items: [
            {
                name: 'Veg Dum Biryani',
                quantity: 1
            }
        ],

        status: 'Completed'
    }

];



/* ===============================================================
   GET ACTIVE KITCHEN ORDERS
   =============================================================== */

function getActiveKitchenOrders() {

    let savedOrders =
        JSON.parse(
            localStorage.getItem('smartcanteen_orders') || '[]'
        );


    if (savedOrders.length === 0) {

        return defaultOrders;

    }


    const orderMap =
        new Map();


    defaultOrders.forEach(o => {

        orderMap.set(
            String(o.orderId),
            o
        );

    });


    savedOrders.forEach(o => {

        orderMap.set(
            String(o.orderId),
            o
        );

    });


    return Array.from(
        orderMap.values()
    );
}



/* ===============================================================
   RENDER KITCHEN LIVE KANBAN
   =============================================================== */

function renderKitchenLiveKanban() {

    const orders =
        getActiveKitchenOrders();


    const colNew =
        document.getElementById('colNew');

    const colPrep =
        document.getElementById('colPrep');

    const colReady =
        document.getElementById('colReady');

    const colDone =
        document.getElementById('colDone');


    if (
        !colNew ||
        !colPrep ||
        !colReady ||
        !colDone
    ) {

        return;
    }


    let countNew = 0;

    let countPrep = 0;

    let countReady = 0;

    let countDone = 0;


    /*
     * Remove dynamically rendered cards.
     */

    colNew
        .querySelectorAll(
            '.kds-ticket-card, .kanban-card'
        )
        .forEach(c => c.remove());


    colPrep
        .querySelectorAll(
            '.kds-ticket-card, .kanban-card'
        )
        .forEach(c => c.remove());


    colReady
        .querySelectorAll(
            '.kds-ticket-card, .kanban-card'
        )
        .forEach(c => c.remove());


    colDone
        .querySelectorAll(
            '.kds-ticket-card, .kanban-card'
        )
        .forEach(c => c.remove());



    /*
     * Render every order.
     */

    orders.forEach(o => {

        const status =
            (o.status || 'New')
                .toLowerCase();


        const custName =
            o.customer
                ? (
                    o.customer.name ||
                    o.customer.email ||
                    'Student'
                )
                : (
                    o.userEmail ||
                    'Student'
                );


        const itemsSummary =
            (o.items || [])
                .map(
                    i =>
                        i.quantity +
                        'x ' +
                        i.name
                )
                .join(', ')
                || 'Hot Meal';


        const card =
            document.createElement('div');



        /* =======================================================
           NEW
           ======================================================= */

        if (
            status === 'new' ||
            status === 'placed'
        ) {

            countNew++;


            card.className =
                'kds-ticket-card status-new';


            card.innerHTML =

                '<div style="' +
                'display:flex;' +
                'justify-content:space-between;' +
                'align-items:center;' +
                'margin-bottom:10px;' +
                '">' +

                    '<strong style="' +
                    'color:#38BDF8;' +
                    'font-size:15px;' +
                    'font-family:\'Space Grotesk\',monospace;' +
                    '">#' +

                    o.orderId +

                    '</strong>' +


                    '<span class="kds-timer-badge">' +

                        'Slot: ' +
                        (o.pickupSlot || '12:45 PM') +

                    '</span>' +

                '</div>' +


                '<div style="' +
                'font-size:14px;' +
                'font-weight:700;' +
                'color:#F8FAFC;' +
                'margin-bottom:8px;' +
                'line-height:1.4;' +
                '">' +

                    itemsSummary +

                '</div>' +


                '<div style="' +
                'font-size:12px;' +
                'color:#94A3B8;' +
                'margin-bottom:14px;' +
                '">' +

                    'Student: ' +

                    '<strong style="color:#CBD5E1;">' +

                        custName +

                    '</strong>' +

                '</div>' +


                '<div class="kanban-card-actions">' +

                    '<button type="button" ' +
                    'class="kds-btn-start" ' +
                    'onclick="updateOrderStatus(\'' +

                        o.orderId +

                    '\', \'Preparing\', \'Cooking Started for Order #' +

                        o.orderId +

                    '\')">' +

                        'Start Cooking &rarr;' +

                    '</button>' +

                '</div>';


            colNew.appendChild(card);

        }



        /* =======================================================
           PREPARING
           ======================================================= */

        else if (
            status === 'preparing'
        ) {

            countPrep++;


            card.className =
                'kds-ticket-card status-prep';


            card.innerHTML =

                '<div style="' +
                'display:flex;' +
                'justify-content:space-between;' +
                'align-items:center;' +
                'margin-bottom:10px;' +
                '">' +

                    '<strong style="' +
                    'color:#10B981;' +
                    'font-size:15px;' +
                    'font-family:\'Space Grotesk\',monospace;' +
                    '">#' +

                        o.orderId +

                    '</strong>' +


                    '<span class="kds-timer-badge" ' +
                    'style="' +
                    'background:rgba(16,185,129,0.2);' +
                    'color:#10B981;' +
                    '">' +

                        'ON GRILL / STOVE' +

                    '</span>' +

                '</div>' +


                '<div style="' +
                'font-size:14px;' +
                'font-weight:700;' +
                'color:#F8FAFC;' +
                'margin-bottom:8px;' +
                'line-height:1.4;' +
                '">' +

                    itemsSummary +

                '</div>' +


                '<div style="' +
                'font-size:12px;' +
                'color:#94A3B8;' +
                'margin-bottom:14px;' +
                '">' +

                    'Pickup Slot: ' +

                    '<strong style="color:#A7F3D0;">' +

                        (o.pickupSlot || '12:45 PM') +

                    '</strong>' +

                    ' (' +

                        custName +

                    ')' +

                '</div>' +


                '<div class="kanban-card-actions">' +

                    '<button type="button" ' +
                    'class="kds-btn-ready" ' +
                    'onclick="updateOrderStatus(\'' +

                        o.orderId +

                    '\', \'Ready\', \'Marked Order #' +

                        o.orderId +

                    ' Ready for Pickup\')">' +

                        'Ready for Pickup' +

                    '</button>' +

                '</div>';


            colPrep.appendChild(card);

        }



        /* =======================================================
           READY
           ======================================================= */

        else if (
            status === 'ready'
        ) {

            countReady++;


            card.className =
                'kds-ticket-card status-ready';


            card.innerHTML =

                '<div style="' +
                'display:flex;' +
                'justify-content:space-between;' +
                'align-items:center;' +
                'margin-bottom:10px;' +
                '">' +

                    '<strong style="' +
                    'color:#34D399;' +
                    'font-size:15px;' +
                    'font-family:\'Space Grotesk\',monospace;' +
                    '">#' +

                        o.orderId +

                    '</strong>' +


                    '<span class="kds-timer-badge" ' +
                    'style="' +
                    'background:rgba(52,211,153,0.2);' +
                    'color:#34D399;' +
                    '">' +

                        'AT COUNTER 1' +

                    '</span>' +

                '</div>' +


                '<div style="' +
                'font-size:14px;' +
                'font-weight:700;' +
                'color:#F8FAFC;' +
                'margin-bottom:8px;' +
                'line-height:1.4;' +
                '">' +

                    itemsSummary +

                '</div>' +


                '<div style="' +
                'font-size:12px;' +
                'color:#94A3B8;' +
                'margin-bottom:14px;' +
                '">' +

                    'Student: ' +

                    '<strong style="color:#A7F3D0;">' +

                        custName +

                    '</strong>' +

                '</div>' +


                '<div class="kanban-card-actions">' +

                    '<button type="button" ' +
                    'class="kds-btn-done" ' +
                    'onclick="updateOrderStatus(\'' +

                        o.orderId +

                    '\', \'Completed\', \'Order #' +

                        o.orderId +

                    ' Handed Over\')">' +

                        'Handed Over / Collected' +

                    '</button>' +

                '</div>';


            colReady.appendChild(card);

        }



        /* =======================================================
           COMPLETED
           ======================================================= */

        else {

            countDone++;


            card.className =
                'kds-ticket-card status-done';


            card.innerHTML =

                '<div style="' +
                'display:flex;' +
                'justify-content:space-between;' +
                'align-items:center;' +
                'margin-bottom:8px;' +
                '">' +

                    '<strong style="' +
                    'color:#94A3B8;' +
                    'font-size:14px;' +
                    'font-family:\'Space Grotesk\',monospace;' +
                    '">#' +

                        o.orderId +

                    '</strong>' +


                    '<span style="' +
                    'font-size:11px;' +
                    'color:#64748B;' +
                    '">' +

                        'Slot: ' +

                        (o.pickupSlot || '12:45 PM') +

                    '</span>' +

                '</div>' +


                '<div style="' +
                'font-size:13px;' +
                'color:#94A3B8;' +
                'margin-bottom:6px;' +
                '">' +

                    itemsSummary +

                '</div>' +


                '<small style="' +
                'color:#34D399;' +
                'font-weight:700;' +
                '">' +

                    'Collected by Student' +

                '</small>';


            colDone.appendChild(card);

        }

    });



    /*
     * Update column counters.
     */

    const newCounter =
        colNew.querySelector('.kanban-counter');

    const prepCounter =
        colPrep.querySelector('.kanban-counter');

    const readyCounter =
        colReady.querySelector('.kanban-counter');

    const doneCounter =
        colDone.querySelector('.kanban-counter');


    if (newCounter) {

        newCounter.textContent =
            countNew;

    }


    if (prepCounter) {

        prepCounter.textContent =
            countPrep;

    }


    if (readyCounter) {

        readyCounter.textContent =
            countReady;

    }


    if (doneCounter) {

        doneCounter.textContent =
            countDone;

    }



    /*
     * Update dashboard metrics.
     */

    const counterNew =
        document.getElementById('counterNew');

    const counterPrep =
        document.getElementById('counterPrep');

    const counterReady =
        document.getElementById('counterReady');


    if (counterNew) {

        counterNew.textContent =
            countNew + ' Orders';

    }


    if (counterPrep) {

        counterPrep.textContent =
            countPrep + ' Orders';

    }


    if (counterReady) {

        counterReady.textContent =
            countReady + ' Orders';

    }

}



/* ===============================================================
   UPDATE ORDER STATUS
   =============================================================== */

function updateOrderStatus(
    orderId,
    newStatus,
    toastMsg
) {

    /*
     * ============================================================
     * SERVER ROLE CHECK
     * ============================================================
     *
     * IMPORTANT:
     * Do NOT use localStorage/sessionStorage here.
     */

    const serverRole = "<%= currentRole != null
        ? currentRole
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\r", "")
            .replace("\n", "")
        : "" %>";


    const role =
        serverRole
            .trim()
            .toLowerCase();


    /*
     * Only Staff/Kitchen/Chef can update orders.
     */

    if (
        role !== 'staff' &&
        role !== 'kitchen' &&
        role !== 'chef'
    ) {

        showToast(
            'Access restricted: Kitchen Staff only.'
        );

        return;
    }



    /*
     * ============================================================
     * LOCAL ORDER UPDATE
     * ============================================================
     */

    let savedOrders =
        JSON.parse(
            localStorage.getItem(
                'smartcanteen_orders'
            ) || '[]'
        );


    let found = false;


    savedOrders =
        savedOrders.map(o => {

            if (
                String(o.orderId) ===
                String(orderId)
            ) {

                o.status =
                    newStatus;

                found = true;

            }

            return o;

        });



    /*
     * If default order isn't in localStorage,
     * copy it into localStorage first.
     */

    if (!found) {

        const def =
            defaultOrders.find(
                d =>
                    String(d.orderId) ===
                    String(orderId)
            );


        if (def) {

            const cloned =
                JSON.parse(
                    JSON.stringify(def)
                );


            cloned.status =
                newStatus;


            savedOrders.push(
                cloned
            );

        }

    }



    /*
     * Save updated orders locally.
     */

    localStorage.setItem(
        'smartcanteen_orders',
        JSON.stringify(savedOrders)
    );



    /*
     * ============================================================
     * SYNC WITH SERVER
     * ============================================================
     */

    fetch(
        '${pageContext.request.contextPath}/OrderAjaxServlet',
        {
            method: 'POST',

            headers: {
                'Content-Type':
                    'application/x-www-form-urlencoded'
            },

            body:
                new URLSearchParams({

                    action:
                        'updateStatus',

                    orderId:
                        orderId,

                    status:
                        newStatus

                })
        }
    )

    .then(response => {

        if (!response.ok) {

            throw new Error(
                'Server returned HTTP ' +
                response.status
            );

        }

        return response.json();

    })

    .then(data => {

        console.log(
            'Order status synced:',
            data
        );

    })

    .catch(error => {

        console.log(
            'Status updated locally:',
            error
        );

    });



    /*
     * Show notification.
     */

    showToast(
        toastMsg
    );


    /*
     * Re-render KDS.
     */

    renderKitchenLiveKanban();

}

</script>

</body>
</html>
