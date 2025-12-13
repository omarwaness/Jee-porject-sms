package com.jee_project.dto;

import java.time.LocalDate;

public class EnrollmentRequest {
    public Long studentId;
    public Long courseId;
    public String grade;
    public LocalDate enrollmentDate;
}
