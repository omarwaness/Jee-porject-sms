package com.jee_project.servlet;

import com.jee_project.model.Course;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/enrollments")
public class EnrollmentServlet extends HttpServlet {

    @Inject
    private CourseService courseService;

    @Inject
    private EnrollmentService enrollmentService;

    @Inject
    private StudentService studentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Security Check
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. Fetch All Courses
        List<Course> courses = courseService.getAllCourses();

        // 3. Fetch All Students (For the "Enroll New Student" dropdown)
        List<Student> allStudents = studentService.getStudents();

        // 4. Build a Map of Enrollments per Course
        // Key: Course ID (Long), Value: List of Enrollment DTOs/Objects
        Map<Long, List<?>> enrollmentsMap = new HashMap<>();

        for (Course course : courses) {
            List<?> courseEnrollments = enrollmentService.getEnrollmentsByCourseId(course.getId());
            enrollmentsMap.put(course.getId(), courseEnrollments);
        }

        // 5. Set Attributes
        req.setAttribute("courses", courses);
        req.setAttribute("allStudents", allStudents);
        req.setAttribute("enrollmentsMap", enrollmentsMap);

        req.getRequestDispatcher("enrollments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("enroll".equals(action)) {
            try {
                Long courseId = Long.parseLong(req.getParameter("courseId"));
                Long studentId = Long.parseLong(req.getParameter("studentId"));

                // Default grade is null when first enrolling
                enrollmentService.enrollStudent(studentId, courseId, null);

            } catch (NumberFormatException e) {
                e.printStackTrace(); // Log error
            }
        }

        // Redirect back to the same page to refresh data
        resp.sendRedirect("enrollments");
    }
}