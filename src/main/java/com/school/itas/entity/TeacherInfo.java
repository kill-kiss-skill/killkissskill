package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

@Data
@TableName("teacher_info")
public class TeacherInfo {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String teacherNo;
    private Long departmentId;
    private String title;
}
