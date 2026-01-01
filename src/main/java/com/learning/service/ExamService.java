package com.learning.service;
import com.learning.model.*;
import java.util.List;
import java.util.Map;

public interface ExamService {
    List<Exam> getAllPublishedExams();
    Exam getExamById(Integer id);
    List<ExamQuestion> getExamQuestions(Integer examId);
    ExamRecord startExam(Integer examId, Integer studentId);
    ExamRecord getExamRecord(Integer examId, Integer studentId);
    boolean submitExam(Integer recordId, Map<Integer, String> answers);
    ExamRecord getExamResult(Integer recordId);
    List<ExamAnswer> getExamAnswers(Integer recordId);

    // 新增：创建考试和题目
    boolean createExam(Exam exam, List<ExamQuestion> questions);
}