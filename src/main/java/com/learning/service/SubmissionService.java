package com.learning.service;

import com.learning.model.Submission;
import java.util.List;

/**
 * 作业提交业务接口
 */
public interface SubmissionService {

    /**
     * 学生提交作业
     */
    boolean submitAssignment(Submission submission);

    /**
     * 教师批改作业
     */
    boolean gradeSubmission(Integer submissionId, Integer score, String feedback);

    /**
     * 查询学生的某个作业提交记录
     */
    Submission getSubmission(Integer assignmentId, Integer studentId);

    /**
     * 根据ID获取提交详情
     */
    Submission getSubmissionById(Integer id);

    /**
     * 查询作业的所有提交记录（教师查看）
     */
    List<Submission> getAssignmentSubmissions(Integer assignmentId);

    /**
     * 查询学生的所有提交记录
     */
    List<Submission> getStudentSubmissions(Integer studentId);

    /**
     * 检查学生是否已提交
     */
    boolean hasSubmitted(Integer assignmentId, Integer studentId);

    /**
     * 检查是否已批改
     */
    boolean isGraded(Submission submission);
}