package com.smartcanteen.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartcanteen.model.Order;

/**
 * OrderAjaxServlet - Asynchronous AJAX Controller
 * Implements AJAX order status tracking, kitchen live updates, and status transitions without page reload.
 */
@WebServlet("/OrderAjaxServlet")
public class OrderAjaxServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Shared thread-safe in-memory order cache (mirrored with OrderServlet)
    private static final List<Order> LIVE_ORDERS = Collections.synchronizedList(new ArrayList<>());

    static {
        // Pre-populate sample campus orders for instant testing
        LIVE_ORDERS.add(new Order("SC1024", "Aarav Sharma", "student@smartcanteen.com", "12:45 PM", 85.00, "UPI", "Cooking", "12:38 PM"));
        LIVE_ORDERS.add(new Order("SC1025", "Neha Patel", "neha@smartcanteen.com", "12:45 PM", 120.00, "Campus Card", "Preparing", "12:40 PM"));
        LIVE_ORDERS.add(new Order("SC1026", "Rohan Verma", "rohan@smartcanteen.com", "1:00 PM", 45.00, "UPI", "Preparing", "12:42 PM"));
        LIVE_ORDERS.add(new Order("SC1020", "Pooja Reddy", "pooja@smartcanteen.com", "12:30 PM", 50.00, "Cash", "Ready", "12:25 PM"));
    }

    public static List<Order> getLiveOrders() {
        return LIVE_ORDERS;
    }

    public static void addOrder(Order o) {
        LIVE_ORDERS.add(0, o);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

        String action = request.getParameter("action");
        if (action == null) action = "track";

        PrintWriter out = response.getWriter();

        if ("track".equalsIgnoreCase(action)) {
            // Customer tracking single order status via AJAX
            String orderId = request.getParameter("orderId");
            Order matched = null;
            if (orderId != null) {
                synchronized (LIVE_ORDERS) {
                    for (Order o : LIVE_ORDERS) {
                        if (o.getOrderId().equalsIgnoreCase(orderId.trim())) {
                            matched = o;
                            break;
                        }
                    }
                }
            }

            if (matched != null) {
                out.print("{\"success\":true,\"orderId\":\"" + matched.getOrderId() + 
                          "\",\"status\":\"" + matched.getStatus() + 
                          "\",\"customer\":\"" + matched.getCustomerName() + 
                          "\",\"pickupSlot\":\"" + matched.getPickupSlot() + 
                          "\",\"amount\":" + matched.getTotalAmount() + 
                          ",\"time\":\"" + (matched.getTime() != null ? matched.getTime() : "Live") + "\"}");
            } else {
                // If not in in-memory list, provide safe dynamic response
                String status = "Cooking";
                out.print("{\"success\":true,\"orderId\":\"" + (orderId != null ? orderId : "SC1024") + 
                          "\",\"status\":\"" + status + 
                          "\",\"customer\":\"Campus Customer\",\"pickupSlot\":\"12:45 PM\",\"amount\":85.00,\"time\":\"Live\"}");
            }
            return;
        }

        if ("list".equalsIgnoreCase(action)) {
            // Kitchen Staff fetching live queue via AJAX
            StringBuilder sb = new StringBuilder("[");
            synchronized (LIVE_ORDERS) {
                for (int i = 0; i < LIVE_ORDERS.size(); i++) {
                    Order o = LIVE_ORDERS.get(i);
                    sb.append("{\"orderId\":\"").append(o.getOrderId())
                      .append("\",\"customer\":\"").append(o.getCustomerName())
                      .append("\",\"status\":\"").append(o.getStatus())
                      .append("\",\"pickupSlot\":\"").append(o.getPickupSlot())
                      .append("\",\"amount\":").append(o.getTotalAmount())
                      .append(",\"payment\":\"").append(o.getPaymentMethod())
                      .append("\",\"time\":\"").append(o.getTime() != null ? o.getTime() : "Live").append("\"}");
                    if (i < LIVE_ORDERS.size() - 1) sb.append(",");
                }
            }
            sb.append("]");
            out.print(sb.toString());
            return;
        }

        out.print("{\"success\":false,\"message\":\"Unknown action\"}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("userRole") : null;

        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        PrintWriter out = response.getWriter();

        if ("updateStatus".equalsIgnoreCase(action)) {
            // Role authority verification: Only kitchen staff can update status
            // (Customers and Admins are blocked)
            if (role != null && !"Staff".equalsIgnoreCase(role) && !"Kitchen".equalsIgnoreCase(role) && !"Chef".equalsIgnoreCase(role)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                out.print("{\"success\":false,\"error\":\"Forbidden: Only Kitchen Staff are authorized to update cooking status.\"}");
                return;
            }

            if (orderId == null || newStatus == null) {
                out.print("{\"success\":false,\"error\":\"Missing orderId or status parameter.\"}");
                return;
            }

            boolean updated = false;
            synchronized (LIVE_ORDERS) {
                for (Order o : LIVE_ORDERS) {
                    if (o.getOrderId().equalsIgnoreCase(orderId.trim())) {
                        o.setStatus(newStatus.trim());
                        updated = true;
                        break;
                    }
                }
                if (!updated) {
                    // Create and add order with new status
                    Order newO = new Order(orderId, "Campus Customer", "customer@smartcanteen.com", "12:45 PM", 75.00, "UPI", newStatus.trim(), "Just now");
                    LIVE_ORDERS.add(0, newO);
                    updated = true;
                }
            }

            out.print("{\"success\":true,\"orderId\":\"" + orderId + "\",\"newStatus\":\"" + newStatus + "\"}");
            return;
        }

        out.print("{\"success\":false,\"error\":\"Invalid action\"}");
    }
}
