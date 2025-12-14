package com.jee_project.repository;

import com.jee_project.model.Course;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@ApplicationScoped
public class CourseRepository {

    @PersistenceContext
    private EntityManager em;

    public void save(Course course) {
        em.persist(course);
    }

    public Course findById(Long id) {
        return em.find(Course.class, id);
    }

    public List<Course> findAll() {
        return em.createQuery("SELECT c FROM Course c", Course.class)
                .getResultList();
    }

    public void delete(Long id) {
        Course course = findById(id);
        if (course != null) {
            em.remove(course);
        }
    }

    public Course update(Course course) {
        return em.merge(course);
    }

}

