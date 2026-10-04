package com.smartcanteen.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartcanteen.model.Order;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Real-time live orders stored in memory across application runtime
    private static final List<Order> LIVE_ORDERS = Collections.synchronizedList(new ArrayList<>());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;

        List<Order> displayOrders = new ArrayList<>();
        synchronized (LIVE_ORDERS) {
            for (Order o : LIVE_ORDERS) {
                // Admin and Kitchen Staff see all incoming orders for kitchen operations
                if ("Admin".equalsIgnoreCase(userRole) || "Staff".equalsIgnoreCase(userRole)) {
                    displayOrders.add(o);
                } else if (userEmail != null && userEmail.equalsIgnoreCase(o.getUserEmail())) {
                    // Regular students see only their own deliveries
                    displayOrders.add(o);
                }
            }
        }

        request.setAttribute("orders", displayOrders);
        request.getRequestDispatcher("/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String userEmail = request.getParameter("email");
        if (userEmail == null || userEmail.trim().isEmpty()) {
            if (session != null && session.getAttribute("userEmail") != null) {
                userEmail = (String) session.getAttribute("userEmail");
            } else {
                userEmail = "student@smartcanteen.com";
            }
        }

        String name = request.getParameter("name");
        String pickupSlot = request.getParameter("pickupSlot");
        String payment = request.getParameter("paymentMethod");
        String amountStr = request.getParameter("amount");

        double amount = 150.0;
        if (amountStr != null) {
            try {
                amount = Double.parseDouble(amountStr);
            } catch (NumberFormatException ignored) {}
        }

        String orderId = "SC" + (1000 + new Random().nextInt(9000));
        Order order = new Order(orderId, name != null ? name : "Student", userEmail, pickupSlot != null ? pickupSlot : "12:45 PM", amount, payment != null ? payment : "UPI", "Preparing", "Just now");
        
        LIVE_ORDERS.add(0, order);

        response.sendRedirect(request.getContextPath() + "/order-success.jsp?orderId=" + orderId + "&slot=" + (pickupSlot != null ? pickupSlot : "12:45 PM"));
    }
}
