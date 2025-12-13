package com.jee_project.controller;

import com.jee_project.model.Course;
import com.jee_project.service.CourseService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/courses")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CourseController {

    @Inject
    private CourseService service;

    @POST
    public Response create(Course course) {
        service.addCourse(course);
        return Response.status(Response.Status.CREATED).build();
    }

    @GET
    public List<Course> getAll() {
        return service.getAllCourses();
    }

    @GET
    @Path("/{id}")
    public Response getById(@PathParam("id") Long id) {
        Course course = service.getCourseById(id);
        if (course == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(course).build();
    }

    @DELETE
    @Path("/{id}")
    public Response delete(@PathParam("id") Long id) {
        service.deleteCourse(id);
        return Response.noContent().build();
    }

}
