package com.jee_project.controller;

import com.jee_project.dto.EnrollmentRequest;
import com.jee_project.model.Enrollment;
import com.jee_project.service.EnrollmentService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/enrollments")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class EnrollmentController {

    @Inject
    private EnrollmentService service;

    @POST
    public Response enroll(EnrollmentRequest request) {
        service.enrollStudent(request.studentId, request.courseId, request.grade, request.enrollmentDate);
        return Response.status(Response.Status.CREATED).build();
    }

    @GET
    public List<Enrollment> getAll() {
        return service.getAllEnrollments();
    }

}
