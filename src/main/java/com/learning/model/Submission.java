package com.learning.model;

import java.util.Date;

/**
 * 作业提交实体类
 * 对应数据库的 submission 表
 */
public class Submission {
    
    private Integer id;              // 提交ID
    private Integer assignmentId;    // 作业ID
    private Integer studentId;       // 学生ID
    private String content;          // 提交内容
    private Integer score;           // 得分
    private String feedback;         // 教师评语
    private String status;           // 状态：submitted/graded
    private Date submitTime;         // 提交时间
    private Date gradeTime;          // 批改时间
    
    // 额外字段（用于页面显示）
    private String studentName;      // 学生姓名
    private String assignmentTitle;  // 作业标题
    private String courseName;       // 课程名称
    private Integer totalScore;      // 作业满分
    private Date deadline;           // 截止时间

    // ========== Getter 和 Setter ==========
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(Integer assignmentId) {
        this.assignmentId = assignmentId;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Date getGradeTime() {
        return gradeTime;
    }

    public void setGradeTime(Date gradeTime) {
        this.gradeTime = gradeTime;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getAssignmentTitle() {
        return assignmentTitle;
    }

    public void setAssignmentTitle(String assignmentTitle) {
        this.assignmentTitle = assignmentTitle;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }
}
