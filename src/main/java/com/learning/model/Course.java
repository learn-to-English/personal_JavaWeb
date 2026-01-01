package com.learning.model;

import java.util.Date;

/**
 * 课程实体类
 * 对应数据库的 course 表
 */
public class Course {
    
    private Integer id;             // 课程ID
    private String title;           // 课程标题
    private String description;     // 课程简介
    private Integer teacherId;      // 教师ID
    private Integer categoryId;     // 分类ID
    private String coverImage;      // 封面图片
    private String status;          // 状态：draft草稿/published已发布
    private Integer studentCount;   // 学生人数
    private Date createTime;        // 创建时间
    
    // 额外字段（不是数据库字段，用于页面显示）
    private String teacherName;     // 教师姓名
    private String categoryName;    // 分类名称

    // ========== 下面是 Getter 和 Setter 方法 ==========
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(Integer studentCount) {
        this.studentCount = studentCount;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
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
