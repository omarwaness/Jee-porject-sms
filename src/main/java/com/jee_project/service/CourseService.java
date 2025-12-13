package com.jee_project.service;

import com.jee_project.model.Course;
import com.jee_project.repository.CourseRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;

@ApplicationScoped
public class CourseService {

    @Inject
    private CourseRepository repository;

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
    public void deleteCourse(Long id) {
        repository.delete(id);
    }
}

