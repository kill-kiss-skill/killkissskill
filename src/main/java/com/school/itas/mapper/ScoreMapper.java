package com.school.itas.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.school.itas.entity.Score;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface ScoreMapper extends BaseMapper<Score> {

    @Select("SELECT c.subject, AVG(s.total_score) AS avgScore " +
            "FROM score s JOIN course c ON s.course_id = c.id " +
            "WHERE s.student_id = #{studentId} " +
            "GROUP BY c.subject")
    List<Map<String, Object>> selectAvgScoreBySubject(@Param("studentId") Long studentId);

    @Select("<script>SELECT s.*, c.course_name, c.subject, " +
            "si.student_no, u.real_name AS student_name " +
            "FROM score s " +
            "JOIN course c ON s.course_id = c.id " +
            "LEFT JOIN student_info si ON s.student_id = si.id " +
            "LEFT JOIN sys_user u ON si.user_id = u.id " +
            "WHERE s.student_id = #{studentId} " +
            "<if test='semester != null and semester != \"\"'>AND s.semester = #{semester} </if>" +
            "ORDER BY s.semester DESC</script>")
    List<Map<String, Object>> selectScoreDetailByStudent(@Param("studentId") Long studentId,
                                                         @Param("semester") String semester);
}
