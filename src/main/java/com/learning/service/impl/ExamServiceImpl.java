package com.learning.service.impl;
import com.learning.dao.*;
import com.learning.model.*;
import com.learning.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Service
public class ExamServiceImpl implements ExamService {
    @Autowired private ExamMapper examMapper;
    @Autowired private ExamQuestionMapper examQuestionMapper;
    @Autowired private ExamRecordMapper examRecordMapper;
    @Autowired private ExamAnswerMapper examAnswerMapper;

    public List<Exam> getAllPublishedExams() {
        return examMapper.findAllPublished();
    }

    public Exam getExamById(Integer id) {
        return examMapper.findById(id);
    }

    public List<ExamQuestion> getExamQuestions(Integer examId) {
        return examQuestionMapper.findByExamId(examId);
    }

    @Transactional
    public ExamRecord startExam(Integer examId, Integer studentId) {
        ExamRecord existing = examRecordMapper.findByExamAndStudent(examId, studentId);
        if (existing != null) return existing;

        ExamRecord record = new ExamRecord();
        record.setExamId(examId);
        record.setStudentId(studentId);
        examRecordMapper.insert(record);
        return record;
    }

    public ExamRecord getExamRecord(Integer examId, Integer studentId) {
        return examRecordMapper.findByExamAndStudent(examId, studentId);
    }

    @Transactional
    public boolean submitExam(Integer recordId, Map<Integer, String> answers) {
        // 先根据recordId获取考试记录
        ExamRecord record = examRecordMapper.findById(recordId);
        if (record == null) {

            return false;
        }
        // 获取考试题目列表
        List<ExamQuestion> questions = examQuestionMapper.findByExamId(record.getExamId());

        BigDecimal totalScore = BigDecimal.ZERO;

        for (Map.Entry<Integer, String> entry : answers.entrySet()) {
            Integer questionId = entry.getKey();
            String studentAnswer = entry.getValue();

            ExamQuestion question = null;
            for (ExamQuestion q : questions) {
                if (q.getId().equals(questionId)) {
                    question = q;
                    break;
                }
            }

            if (question == null) continue;

            ExamAnswer answer = new ExamAnswer();
            answer.setRecordId(recordId);
            answer.setQuestionId(questionId);
            answer.setStudentAnswer(studentAnswer);

            boolean isCorrect = studentAnswer != null &&
                    studentAnswer.trim().equals(question.getCorrectAnswer());
            answer.setIsCorrect(isCorrect ? 1 : 0);
            answer.setScore(isCorrect ? new BigDecimal(question.getScore()) : BigDecimal.ZERO);

            if (isCorrect) {
                totalScore = totalScore.add(new BigDecimal(question.getScore()));
            }

            examAnswerMapper.insert(answer);
        }

        examRecordMapper.updateScore(recordId, totalScore, "submitted");
        return true;
    }

    public ExamRecord getExamResult(Integer recordId) {
        return null; // Implement if needed
    }

    public List<ExamAnswer> getExamAnswers(Integer recordId) {
        return examAnswerMapper.findByRecordId(recordId);
    }

    @Override
    @Transactional
    public boolean createExam(Exam exam, List<ExamQuestion> questions) {
        // 插入考试
        int result = examMapper.insert(exam);
        if (result <= 0) {
            return false;
        }

        // 插入题目
        for (int i = 0; i < questions.size(); i++) {
            ExamQuestion question = questions.get(i);
            question.setExamId(exam.getId());
            question.setOrderNum(i + 1);
            examQuestionMapper.insert(question);
        }

        return true;
    }
}