package com.learning.dao;
import com.learning.model.ExamQuestion;
import java.util.List;

public interface ExamQuestionMapper {
    List<ExamQuestion> findByExamId(Integer examId);
    int insert(ExamQuestion question);
}