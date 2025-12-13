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
}
