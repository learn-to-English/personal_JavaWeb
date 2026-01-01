package com.learning.model;

import java.util.Date;

/**
 * 选课记录实体类
 * 对应数据库的 enrollment 表
 */
public class Enrollment {
    
    private Integer id;           // 选课ID
    private Integer studentId;    // 学生ID
    private Integer courseId;     // 课程ID
    private Date enrollTime;      // 选课时间
    
    // 额外字段（用于页面显示，不是数据库字段）
    private String courseTitle;       // 课程标题
    private String courseDescription; // 课程简介
    private String teacherName;       // 教师姓名
    private String categoryName;      // 分类名称

    // ========== Getter 和 Setter ==========
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Date getEnrollTime() {
        return enrollTime;
    }

    public void setEnrollTime(Date enrollTime) {
        this.enrollTime = enrollTime;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public String getCourseDescription() {
        return courseDescription;
    }

    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
