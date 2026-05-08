package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

@Data
@TableName("student_info")
public class StudentInfo {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String studentNo;
    private Long classId;
    private Integer enrollmentYear;
}
