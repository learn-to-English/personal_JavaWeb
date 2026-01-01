package com.learning.model;

import java.util.Date;

/**
 * 作业实体类
 * 对应数据库的 assignment 表
 */
public class Assignment {
    
    private Integer id;              // 作业ID
    private Integer courseId;        // 课程ID
    private String title;            // 作业标题
    private String description;      // 作业描述
    private Integer totalScore;      // 满分
    private Date deadline;           // 截止时间
    private Date createTime;         // 创建时间
    
    // 额外字段（不是数据库字段，用于页面显示）
    private String courseName;       // 课程名称
    private Integer submissionCount; // 已提交人数
    private Integer totalStudents;   // 总学生数
    private Double submitRate;       // 提交率

    // ========== Getter 和 Setter ==========
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getSubmissionCount() {
        return submissionCount;
    }

    public void setSubmissionCount(Integer submissionCount) {
        this.submissionCount = submissionCount;
    }

    public Integer getTotalStudents() {
        return totalStudents;
    }

    public void setTotalStudents(Integer totalStudents) {
        this.totalStudents = totalStudents;
    }

    public Double getSubmitRate() {
        return submitRate;
    }

    public void setSubmitRate(Double submitRate) {
        this.submitRate = submitRate;
    }
}
