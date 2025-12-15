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
import java.time.LocalDate;
import java.util.List;

@WebServlet(value = "/students")
public class StudentServlet extends HttpServlet {

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

        String action = req.getParameter("action");

        // 1. Handle DELETE
        if ("delete".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                long id = Long.parseLong(idStr);
                studentService.deleteStudent(id);
            }
            resp.sendRedirect("students");
            return;
        }

        // 2. Default: List all students (Search is handled in JSP)
        List<Student> students = studentService.getStudents();
        req.setAttribute("students", students);
        req.getRequestDispatcher("students.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // Extract form data
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String major = req.getParameter("major");

        // Handle GPA (nullable)
        String gpaStr = req.getParameter("gpa");
        Double gpa = (gpaStr != null && !gpaStr.isEmpty()) ? Double.parseDouble(gpaStr) : null;

        // Handle Enrollment Date (default to now if missing, or parse input)
        String dateStr = req.getParameter("enrollmentDate");
        LocalDate enrollmentDate = (dateStr != null && !dateStr.isEmpty())
                ? LocalDate.parse(dateStr)
                : LocalDate.now();

        // Create Student object
        Student student = new Student();
        student.setName(name);
        student.setEmail(email);
        student.setMajor(major);
        student.setGpa(gpa);
        student.setEnrollmentDate(enrollmentDate);

        if ("update".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                long id = Long.parseLong(idStr);
                // Calls service update method: updateStudent(Long id, Student s)
                studentService.updateStudent(id, student);
            }
        } else if ("add".equals(action)) {
            studentService.addStudent(student);
        }

        // Redirect to refresh list and prevent form resubmission
        resp.sendRedirect("students");
    }
}