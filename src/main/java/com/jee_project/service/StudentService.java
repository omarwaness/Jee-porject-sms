package com.jee_project.service;


import com.jee_project.model.Student;
import com.jee_project.repository.StudentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import java.util.List;

@ApplicationScoped
public class StudentService {

    @Inject
    private StudentRepository repository;

    @Transactional
    public void addStudent(Student student) {
        repository.save(student);
    }

    public List<Student> getStudents() {
        return repository.findAll();
    }

}

