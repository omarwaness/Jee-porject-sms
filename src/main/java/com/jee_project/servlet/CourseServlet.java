package com.jee_project.servlet;

import com.jee_project.model.Course;
import com.jee_project.service.CourseService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/courses")
public class CourseServlet extends HttpServlet {

    @Inject
    private CourseService courseService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Security Check
        HttpSession session = req.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        // 1. Handle DELETE
        if ("delete".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                long id = Long.parseLong(idStr);
                courseService.deleteCourse(id);
            }
            resp.sendRedirect("courses");
            return;
        }

        // 2. Default: List all courses (Search is handled in JSP)
        List<Course> courses = courseService.getAllCourses();
        req.setAttribute("courses", courses);
        req.getRequestDispatcher("courses.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // Extract common form data
        String name = req.getParameter("name");
        String instructor = req.getParameter("instructor");
        int credits = Integer.parseInt(req.getParameter("credits"));
        int capacity = Integer.parseInt(req.getParameter("capacity"));

        // Create the course object (without ID initially)
        Course course = new Course();
        course.setName(name);
        course.setInstructor(instructor);
        course.setCredits(credits);
        course.setCapacity(capacity);

        if ("update".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                long id = Long.parseLong(idStr);

                // Pass ID as a separate parameter as requested
                courseService.updateCourse(id, course);
            }
        } else if ("add".equals(action)) {
            courseService.addCourse(course);
        }

        // Redirect to refresh list
        resp.sendRedirect("courses");
    }
}