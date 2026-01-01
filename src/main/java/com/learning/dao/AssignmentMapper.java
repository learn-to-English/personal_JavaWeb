package com.learning.dao;

import com.learning.model.Assignment;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 作业数据访问接口
 */
public interface AssignmentMapper {

    /**
     * 根据课程ID查询作业列表
     */
    List<Assignment> findByCourseId(Integer courseId);

    /**
     * 根据教师ID查询所有作业（查询教师所有课程的作业）
     */
    List<Assignment> findByTeacherId(Integer teacherId);

    /**
     * 根据学生ID查询作业列表（查询学生已选课程的作业）
     */
    List<Assignment> findByStudentId(Integer studentId);

    /**
     * 根据ID查询作业详情
     */
    Assignment findById(Integer id);

    /**
     * 添加作业
     */
    int insert(Assignment assignment);

    /**
     * 更新作业
     */
    int update(Assignment assignment);

    /**
     * 删除作业
     */
    int delete(Integer id);

    /**
     * 统计作业的提交人数
     */
    int countSubmissions(Integer assignmentId);

    /**
     * 统计课程的学生总数
     */
    int countCourseStudents(Integer courseId);
}