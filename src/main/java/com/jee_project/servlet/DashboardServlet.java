package com.jee_project.servlet;

import com.jee_project.model.Enrollment;
import com.jee_project.model.Student;
import com.jee_project.service.CourseService;
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

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Inject
    private StudentService studentService;

    @Inject
    private CourseService courseService;

    // Assuming you have an EnrollmentService for general stats
    @Inject
    private EnrollmentService enrollmentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Security Check
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. Fetch Aggregated Data
        // Ideally, create specialized count methods in your DAO for performance.
        // For now, using list size is acceptable for small datasets.
        List<Student> allStudents = studentService.getStudents();
        int studentCount = allStudents.size();

        int courseCount = courseService.getAllCourses().size();

        // If EnrollmentService doesn't have getAll(), you might need to add a count method
        List<Enrollment> enrollments = enrollmentService.getAllEnrollments();
        // Placeholder for demo:
        int enrollmentCount = enrollments.size();

        // 3. Get Recent Activity (e.g., last 5 students added)
        // You can sort 'allStudents' by ID desc or Date desc
        List<Student> recentStudents = allStudents.stream()
                .sorted((s1, s2) -> Long.compare(s2.getId(), s1.getId())) // Newest ID first
                .limit(5)
                .toList();

        // 4. Set Attributes
        req.setAttribute("studentCount", studentCount);
        req.setAttribute("courseCount", courseCount);
        req.setAttribute("enrollmentCount", enrollmentCount);
        req.setAttribute("recentStudents", recentStudents);

        // 5. Forward to JSP
        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
    }
}