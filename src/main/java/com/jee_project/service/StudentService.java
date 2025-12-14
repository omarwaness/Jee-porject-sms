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

    public Student getStudent(long id) {
        return repository.findById(id);
    }


    @Transactional
    public void deleteStudent(long id) {
        repository.remove(id);
    }



    public Student getStudentByEmail(String email) {
        return repository.findByEmail(email);
    }


}

