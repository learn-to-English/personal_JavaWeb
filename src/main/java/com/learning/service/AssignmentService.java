package com.learning.service;

import com.learning.model.Assignment;
import java.util.List;

/**
 * 作业业务接口
 */
public interface AssignmentService {

    /**
     * 教师创建作业
     */
    boolean createAssignment(Assignment assignment);

    /**
     * 教师查看自己的所有作业
     */
    List<Assignment> getTeacherAssignments(Integer teacherId);

    /**
     * 学生查看作业列表（已选课程的作业）
     */
    List<Assignment> getStudentAssignments(Integer studentId);

    /**
     * 根据课程ID查询作业
     */
    List<Assignment> getAssignmentsByCourse(Integer courseId);

    /**
     * 获取作业详情
     */
    Assignment getAssignmentById(Integer id);

    /**
     * 更新作业
     */
    boolean updateAssignment(Assignment assignment);

    /**
     * 删除作业
     */
    boolean deleteAssignment(Integer id);

    /**
     * 检查作业是否属于某个教师
     */
    boolean isTeacherAssignment(Integer assignmentId, Integer teacherId);

    /**
     * 检查作业是否过期
     */
    boolean isExpired(Assignment assignment);
}