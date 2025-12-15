package com.jee_project.repository;

import com.jee_project.model.Enrollment;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@ApplicationScoped
public class EnrollmentRepository {

    @PersistenceContext
    private EntityManager em;

    public void save(Enrollment enrollment) {
        em.persist(enrollment);
    }

    public Enrollment findById(Long id) {
        return em.find(Enrollment.class, id);
    }

    public List<Enrollment> findAll() {
        return em.createQuery("SELECT e FROM Enrollment e", Enrollment.class)
                .getResultList();
    }

    public List<Enrollment> findByStudentId(Long studentId) {
        return em.createQuery(
                        "SELECT e FROM Enrollment e WHERE e.student.id = :studentId",
                        Enrollment.class
                )
                .setParameter("studentId", studentId)
                .getResultList();
    }

    public List<Enrollment> findByCourseId(Long courseId) {
        return em.createQuery(
                        "SELECT e FROM Enrollment e WHERE e.course.id = :courseId",
                        Enrollment.class
                )
                .setParameter("courseId", courseId)
                .getResultList();
    }
}
