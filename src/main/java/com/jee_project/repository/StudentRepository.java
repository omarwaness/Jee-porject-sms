package com.jee_project.repository;

import com.jee_project.model.Student;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@ApplicationScoped
public class StudentRepository {

    @PersistenceContext
    private EntityManager em;

    public void save(Student student) {
        em.persist(student);
    }

    public List<Student> findAll() {
        return em.createQuery("SELECT s FROM Student s", Student.class)
                .getResultList();
    }

    public Student findById(Long id) {
        return em.find(Student.class, id);
    }

    public void remove(Long id) {
        Student student = em.find(Student.class, id);
        if (student != null) {
            em.remove(student);
        }
    }


    public Student findByEmail(String email) {
        return em.createQuery(
                        "SELECT s FROM Student s WHERE s.email = :email",
                        Student.class
                )
                .setParameter("email", email)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }


}
