package com.learning.service.impl;

import com.learning.dao.SubmissionMapper;
import com.learning.model.Submission;
import com.learning.service.SubmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;

/**
 * 作业提交业务实现类
 */
@Service
public class SubmissionServiceImpl implements SubmissionService {

    @Autowired
    private SubmissionMapper submissionMapper;

    @Override
    public boolean submitAssignment(Submission submission) {
        if (submission == null || submission.getAssignmentId() == null || submission.getStudentId() == null) {
            return false;
        }

        // 检查是否已经提交过
        Submission existing = submissionMapper.findByAssignmentAndStudent(
                submission.getAssignmentId(),
                submission.getStudentId()
        );

        if (existing != null) {
            // 如果已批改，不允许重新提交
            if ("graded".equals(existing.getStatus())) {
                return false;
            }
            // 如果只是提交过但未批改，允许更新
            existing.setContent(submission.getContent());
            int result = submissionMapper.update(existing);
            return result > 0;
        } else {
            // 首次提交
            int result = submissionMapper.insert(submission);
            return result > 0;
        }
    }

    @Override
    public boolean gradeSubmission(Integer submissionId, Integer score, String feedback) {
        if (submissionId == null) {
            return false;
        }

        Submission submission = submissionMapper.findById(submissionId);
        if (submission == null) {
            return false;
        }

        submission.setScore(score);
        submission.setFeedback(feedback);
        submission.setStatus("graded");
        submission.setGradeTime(new Date());

        int result = submissionMapper.update(submission);
        return result > 0;
    }

    @Override
    public Submission getSubmission(Integer assignmentId, Integer studentId) {
        if (assignmentId == null || studentId == null) {
            return null;
        }
        return submissionMapper.findByAssignmentAndStudent(assignmentId, studentId);
    }

    @Override
    public Submission getSubmissionById(Integer id) {
        if (id == null) {
            return null;
        }
        return submissionMapper.findById(id);
    }

    @Override
    public List<Submission> getAssignmentSubmissions(Integer assignmentId) {
        if (assignmentId == null) {
            return null;
        }
        return submissionMapper.findByAssignmentId(assignmentId);
    }

    @Override
    public List<Submission> getStudentSubmissions(Integer studentId) {
        if (studentId == null) {
            return null;
        }
        return submissionMapper.findByStudentId(studentId);
    }

    @Override
    public boolean hasSubmitted(Integer assignmentId, Integer studentId) {
        if (assignmentId == null || studentId == null) {
            return false;
        }
        Submission submission = submissionMapper.findByAssignmentAndStudent(assignmentId, studentId);
        return submission != null;
    }

    @Override
    public boolean isGraded(Submission submission) {
        if (submission == null) {
            return false;
        }
        return "graded".equals(submission.getStatus());
    }
}