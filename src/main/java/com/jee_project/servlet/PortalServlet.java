package com.jee_project.servlet;

import com.jee_project.model.Student;
import com.jee_project.service.EnrollmentService;
import com.jee_project.service.StudentService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

// Map this to /portal so the LoginServlet redirects here
@WebServlet(value = "/portal")
public class PortalServlet extends HttpServlet {

    @Inject
    private StudentService studentService;

    @Inject
    private EnrollmentService enrollmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false); // Do not create a new session if one doesn't exist

        // 1. Security Check: Is user logged in and is a student?
        if (session == null || session.getAttribute("studentId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. Retrieve Student ID from Session
        Long studentId = (Long) session.getAttribute("studentId");

        // 3. Fetch Data
        try {
            // Get Student Profile
            Student student = studentService.getStudent(studentId);

            // Get Student's Enrollments (returns the list of DTOs or Objects as specified)
            // Assumes return type is List<?> matching your JSON structure
            List<?> enrollments = enrollmentService.getEnrollmentsByStudentId(studentId);

            // 4. Set Attributes for JSP
            req.setAttribute("student", student);
            req.setAttribute("enrollments", enrollments);

            // 5. Forward to View
            req.getRequestDispatcher("portal.jsp").forward(req, resp);

        } catch (Exception e) {
            // Handle cases where student might not exist or DB error
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=DataFetchError");
        }
    }
}