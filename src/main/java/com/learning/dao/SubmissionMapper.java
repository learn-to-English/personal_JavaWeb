package com.learning.dao;

import com.learning.model.Submission;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 作业提交数据访问接口
 */
public interface SubmissionMapper {

    /**
     * 根据作业ID和学生ID查询提交记录
     */
    Submission findByAssignmentAndStudent(@Param("assignmentId") Integer assignmentId,
                                          @Param("studentId") Integer studentId);

    /**
     * 根据作业ID查询所有提交记录
     */
    List<Submission> findByAssignmentId(Integer assignmentId);

    /**
     * 根据学生ID查询所有提交记录
     */
    List<Submission> findByStudentId(Integer studentId);

    /**
     * 根据ID查询提交详情
     */
    Submission findById(Integer id);

    /**
     * 添加提交记录
     */
    int insert(Submission submission);

    /**
     * 更新提交记录
     */
    int update(Submission submission);

    /**
     * 删除提交记录
     */
    int delete(Integer id);
}