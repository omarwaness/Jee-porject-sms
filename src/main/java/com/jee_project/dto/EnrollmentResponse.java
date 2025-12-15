package com.jee_project.dto;

import lombok.*;

import java.time.LocalDate;


@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class EnrollmentResponse {
    private String studentName;
    private String courseName;
    private String grade;
    private LocalDate enrollmentDate;
}
