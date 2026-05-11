package com.school.itas.model.resp;

import lombok.Data;

@Data
public class TeacherCourseResp {
    private Long id;
    private String courseName;
    private String subject;
    private String semester;
}
