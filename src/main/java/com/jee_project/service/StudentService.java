package com.jee_project.service;


import com.jee_project.model.Student;
import com.jee_project.repository.StudentRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityNotFoundException;
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

    @Transactional
    public Student updateStudent(Long id, Student student) {
        Student existingStudent = repository.findById(id);

        if (existingStudent == null) {
            throw new EntityNotFoundException("Student not found with id " + id);
        }
        existingStudent.setName(student.getName());
        existingStudent.setEmail(student.getEmail());
        existingStudent.setMajor(student.getMajor());
        existingStudent.setGpa(student.getGpa());

        return repository.update(existingStudent);
    }


    public Student getStudentByEmail(String email) {
        return repository.findByEmail(email);
    }


}

