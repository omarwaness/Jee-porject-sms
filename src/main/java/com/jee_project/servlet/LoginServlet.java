package com.jee_project.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles user authentication for both Students and Administrators.
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get credentials and role from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // 'student' or 'administrator'

        // Basic validation
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // **2. Demo Authentication Logic (Hardcoded)**
        boolean isAuthenticated = false;
        String userType = null;
        String redirectUrl = "/login.jsp";

        if ("student".equalsIgnoreCase(role)) {
            // DEMO: Any student@uni.edu with password 'password' logs in as student
            if (username.endsWith("@horizon-tech.tn") && "password".equals(password)) {
                isAuthenticated = true;
                userType = "STUDENT";
                redirectUrl = "/portal.jsp"; // Student Portal
            }
        } else if ("administrator".equalsIgnoreCase(role)) {
            // DEMO: admin@uni.edu with password 'adminpass' logs in as admin
            if ("admin@horizon-tech.tn".equals(username) && "adminpass".equals(password)) {
                isAuthenticated = true;
                userType = "ADMIN";
                redirectUrl = "/dashboard.jsp"; // Admin Dashboard
            }
        }

        // 3. Handle outcome
        if (isAuthenticated) {
            // Create or retrieve session
            HttpSession session = request.getSession();

            // Set session attributes
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("userRole", userType);
            session.setAttribute("username", username); // Storing the email as username

            // Redirect to the appropriate page
            response.sendRedirect(request.getContextPath() + redirectUrl);
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Invalid credentials. Please check your role and inputs.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
