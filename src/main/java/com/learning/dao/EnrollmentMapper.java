package com.learning.dao;

import com.learning.model.Enrollment;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 选课数据访问接口
 */
public interface EnrollmentMapper {
    
    /**
     * 查询学生的所有选课记录
     */
    List<Enrollment> findByStudentId(Integer studentId);
    
    /**
     * 查询学生是否已选某门课
     */
    Enrollment findByStudentAndCourse(@Param("studentId") Integer studentId, 
                                       @Param("courseId") Integer courseId);
    
    /**
     * 添加选课记录
     */
    int insert(Enrollment enrollment);
    
    /**
     * 删除选课记录（退课）
     */
    int delete(Integer id);
    
    /**
     * 根据学生ID和课程ID删除
     */
    int deleteByStudentAndCourse(@Param("studentId") Integer studentId,
                                  @Param("courseId") Integer courseId);

    /**
     * 根据课程ID删除所有选课记录（课程删除时级联删除）
     */
    int deleteByCourseId(Integer courseId);
}
