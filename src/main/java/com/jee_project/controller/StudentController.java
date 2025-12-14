package com.jee_project.controller;

import com.jee_project.model.Student;
import com.jee_project.service.StudentService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

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

    @GET
    @Path("/{id}")
    public Student getById(@PathParam("id") long id) {
        return service.getStudent(id);
    }

    @DELETE
    @Path("/{id}")
    public void deleteById(@PathParam("id") long id) {
        service.deleteStudent(id);
    }

    @GET
    @Path("/email/{email}")
    public Response getByEmail(@PathParam("email") String email) {
        Student student = service.getStudentByEmail(email);

        if (student == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(student).build();
    }


}

