package com.jee_project.servlet;

import com.jee_project.model.Student;
import com.jee_project.service.StudentService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Inject
    private StudentService studentService;

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

        boolean isAuthenticated = false;
        String userType = null;
        String redirectUrl = "/login.jsp";

        // 2. Authentication Logic
        if ("student".equalsIgnoreCase(role)) {
            Student student = studentService.getStudentByEmail(username);

            if (student != null) {
                // Keep password hardcoded as requested
                if ("password".equals(password)) {
                    isAuthenticated = true;
                    userType = "STUDENT";

                    // Store the specific Student ID for the Portal
                    HttpSession session = request.getSession();
                    session.setAttribute("studentId", student.getId());

                    // Redirect to the Portal Servlet (mapped to /portal)
                    redirectUrl = "/portal";
                }
            }
        } else if ("administrator".equalsIgnoreCase(role)) {
            // Admin logic remains hardcoded as requested
            if ("admin@horizon-tech.tn".equals(username) && "adminpass".equals(password)) {
                isAuthenticated = true;
                userType = "ADMIN";
                redirectUrl = "/dashboard"; // Admin Dashboard
            }
        }

        // 3. Handle outcome
        if (isAuthenticated) {
            HttpSession session = request.getSession(); // Get existing or create new
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("userRole", userType);
            session.setAttribute("username", username);

            response.sendRedirect(request.getContextPath() + redirectUrl);
        } else {
            request.setAttribute("errorMessage", "Invalid credentials. Please check your role and inputs.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}