package com.smartcanteen.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartcanteen.dao.UserDAO;
import com.smartcanteen.model.User;

@WebServlet({"/LoginServlet", "/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please provide both email and password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();
        password = password.trim();

        // 4. Authenticate user from Database
        User user = userDAO.authenticate(email, password);

        if (user != null) {
            // 5 & 7. Record login in database & check return value
            boolean logged = userDAO.recordLogin(
                user,
                request.getRemoteAddr(),
                request.getHeader("User-Agent")
            );

            if (!logged) {
                System.err.println("WARNING: Login succeeded but login audit could not be stored.");
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userEmail", user.getEmail());

            // Cookies Integration: Set persistent dark theme preference cookie
            javax.servlet.http.Cookie themeCookie = new javax.servlet.http.Cookie("canteen_theme", "dark");
            themeCookie.setMaxAge(60 * 60 * 24 * 30);
            themeCookie.setPath("/");
            response.addCookie(themeCookie);

            // Role-based redirection for the 3 core users:
            // 1. Admin   -> admin-dashboard.jsp
            // 2. Staff   -> staff-dashboard.jsp
            // 3. Student -> dashboard.jsp (or redirect parameter if provided)
            String role = user.getRole();
            if ("Admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
            } else if ("Staff".equalsIgnoreCase(role) || "Kitchen".equalsIgnoreCase(role) || "Lecturer".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/staff-dashboard.jsp");
            } else {
                String redirect = request.getParameter("redirect");
                if (redirect != null && !redirect.trim().isEmpty() 
                        && !redirect.toLowerCase().contains("admin") 
                        && !redirect.toLowerCase().contains("staff")) {
                    response.sendRedirect(request.getContextPath() + "/" + redirect.replaceFirst("^/", ""));
                } else {
                    response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                }
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
