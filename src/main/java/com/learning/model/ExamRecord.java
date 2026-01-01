package com.learning.model;
import java.math.BigDecimal;
import java.util.Date;

public class ExamRecord {
    private Integer id;
    private Integer examId;
    private Integer studentId;
    private Date startTime;
    private Date submitTime;
    private BigDecimal score;
    private String status;

    // 关联字段
    private String examTitle;
    private String studentName;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getExamId() { return examId; }
    public void setExamId(Integer examId) { this.examId = examId; }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getSubmitTime() { return submitTime; }
    public void setSubmitTime(Date submitTime) { this.submitTime = submitTime; }
    public BigDecimal getScore() { return score; }
    public void setScore(BigDecimal score) { this.score = score; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getExamTitle() { return examTitle; }
    public void setExamTitle(String examTitle) { this.examTitle = examTitle; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
}