package com.jee_project.controller;

import com.jee_project.model.Student;
import com.jee_project.service.StudentService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import java.util.List;

@Path("/students")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class StudentController {

    @Inject
    private StudentService service;

    @POST
    public void create(Student student) {
        System.out.println(student);
        service.addStudent(student);
    }

    @GET
    public List<Student> getAll() {
        return service.getStudents();
    }

}

