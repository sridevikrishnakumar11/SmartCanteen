package com.smartcanteen.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smartcanteen.dao.UserDAO;
import com.smartcanteen.model.User;

@WebServlet({"/RegisterServlet", "/register"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        // Validate basic parameters
        if (name == null || email == null || password == null || confirmPassword == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All registration fields are required.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match. Please re-enter.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();
        name = name.trim();

        // Public registration creates Student accounts (Admin & Staff are preloaded)
        if (role == null || "Admin".equalsIgnoreCase(role.trim()) || "Staff".equalsIgnoreCase(role.trim())) {
            role = "Student";
        } else {
            role = role.trim();
        }

        // Check if email already registered
        if (userDAO.isEmailRegistered(email)) {
            request.setAttribute("errorMessage", "An account with this email already exists. Please log in.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(name, email, password, role);
        boolean success = userDAO.registerUser(newUser);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
