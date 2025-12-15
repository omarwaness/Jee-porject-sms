package com.jee_project.service;

import com.jee_project.model.Course;
import com.jee_project.repository.CourseRepository;
import com.jee_project.repository.EnrollmentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;

@ApplicationScoped
public class CourseService {

    @Inject
    private CourseRepository repository;

    @Inject
    EnrollmentRepository enrollmentRepository;

    @Transactional
    public void addCourse(Course course) {
        repository.save(course);
    }

    public List<Course> getAllCourses() {
        return repository.findAll();
    }

    public Course getCourseById(Long id) {
        return repository.findById(id);
    }

    @Transactional
    public Course updateCourse(Long id, Course updatedCourse) {
        Course existing = repository.findById(id);

        if (existing == null) {
            return null;
        }
        existing.setName(updatedCourse.getName());
        existing.setInstructor(updatedCourse.getInstructor());
        existing.setCredits(updatedCourse.getCredits());
        existing.setCapacity(updatedCourse.getCapacity());

        return repository.update(existing);
    }

    @Transactional
    public void deleteCourse(Long id) {
        repository.delete(id);
    }
}

