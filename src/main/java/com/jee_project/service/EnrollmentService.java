package com.jee_project.service;

import com.jee_project.dto.EnrollmentResponse;
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
import java.util.ArrayList;
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
            String grade) {

        Student student = studentRepository.findById(studentId);
        Course course = courseRepository.findById(courseId);

        if (student == null || course == null) {
            throw new IllegalArgumentException("Student or Course not found");
        }

        LocalDate enrollmentDate = LocalDate.now();
        Enrollment enrollment = new Enrollment(student, course, grade, enrollmentDate);

        enrollmentRepository.save(enrollment);
    }

    public List<Enrollment> getAllEnrollments() {
        return enrollmentRepository.findAll();
    }

    @Transactional
    public List<EnrollmentResponse> getEnrollmentsByStudentId(Long studentId) {
        List<Enrollment> enrollments = enrollmentRepository.findByStudentId(studentId);
        List<EnrollmentResponse> enrollmentResponses = new ArrayList<>();

        for (Enrollment enrollment : enrollments) {
            EnrollmentResponse enrollmentResponse = new EnrollmentResponse();

            enrollmentResponse.setStudentName(enrollment.getStudent().getName());
            enrollmentResponse.setCourseName(enrollment.getCourse().getName());
            enrollmentResponse.setGrade(enrollment.getGrade());
            enrollmentResponse.setEnrollmentDate(enrollment.getEnrollmentDate());

            enrollmentResponses.add(enrollmentResponse);
        }
        return enrollmentResponses;
    }

    @Transactional
    public List<EnrollmentResponse> getEnrollmentsByCourseId(Long courseId) {
        List<Enrollment> enrollments = enrollmentRepository.findByCourseId(courseId);
        List<EnrollmentResponse> enrollmentResponses = new ArrayList<>();

        for (Enrollment enrollment : enrollments) {
            EnrollmentResponse enrollmentResponse = new EnrollmentResponse();

            enrollmentResponse.setStudentName(enrollment.getStudent().getName());
            enrollmentResponse.setCourseName(enrollment.getCourse().getName());
            enrollmentResponse.setGrade(enrollment.getGrade());
            enrollmentResponse.setEnrollmentDate(enrollment.getEnrollmentDate());
            enrollmentResponses.add(enrollmentResponse);
        }
        return enrollmentResponses;
    }

}
