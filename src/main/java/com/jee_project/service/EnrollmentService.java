package com.jee_project.service;

import com.jee_project.model.Course;
import com.jee_project.model.Enrollment;
import com.jee_project.model.Student;
import com.jee_project.repository.CourseRepository;
import com.jee_project.repository.EnrollmentRepository;
import com.jee_project.repository.StudentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;

@ApplicationScoped
public class EnrollmentService {

    @Inject
    private EnrollmentRepository enrollmentRepository;

    @Inject
    private StudentRepository studentRepository;

    @Inject
    private CourseRepository courseRepository;

    @Transactional
    public void enrollStudent(Long studentId, Long courseId,
            String grade, LocalDate enrollmentDate) {

        Student student = studentRepository.findById(studentId);
        Course course = courseRepository.findById(courseId);

        if (student == null || course == null) {
            throw new IllegalArgumentException("Student or Course not found");
        }

        Enrollment enrollment = new Enrollment(student, course, grade, enrollmentDate);

        enrollmentRepository.save(enrollment);
    }

    public List<Enrollment> getAllEnrollments() {
        return enrollmentRepository.findAll();
    }
}
