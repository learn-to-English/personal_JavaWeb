package com.learning.model;
import java.math.BigDecimal;

public class ExamAnswer {
    private Integer id;
    private Integer recordId;
    private Integer questionId;
    private String studentAnswer;
    private Integer isCorrect;
    private BigDecimal score;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getRecordId() { return recordId; }
    public void setRecordId(Integer recordId) { this.recordId = recordId; }
    public Integer getQuestionId() { return questionId; }
    public void setQuestionId(Integer questionId) { this.questionId = questionId; }
    public String getStudentAnswer() { return studentAnswer; }
    public void setStudentAnswer(String studentAnswer) { this.studentAnswer = studentAnswer; }
    public Integer getIsCorrect() { return isCorrect; }
    public void setIsCorrect(Integer isCorrect) { this.isCorrect = isCorrect; }
    public BigDecimal getScore() { return score; }
    public void setScore(BigDecimal score) { this.score = score; }
}