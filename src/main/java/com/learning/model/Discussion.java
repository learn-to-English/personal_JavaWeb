package com.learning.model;

import java.util.Date;

/**
 * 讨论话题实体类
 * 对应数据库的 discussion 表
 */
public class Discussion {

    private Integer id;             // 话题ID
    private Integer courseId;       // 课程ID
    private Integer userId;         // 发布者ID
    private String title;           // 话题标题
    private String content;         // 话题内容
    private Integer replyCount;     // 回复数量
    private Date createTime;        // 发布时间

    // 关联字段（不在数据库表中，用于页面显示）
    private String username;        // 发布者用户名
    private String courseName;      // 课程名称
    private String userRole;        // 发布者角色

    // ========== Getter 和 Setter 方法 ==========

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

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(Integer replyCount) {
        this.replyCount = replyCount;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    @Override
    public String toString() {
        return "Discussion{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", userId=" + userId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", replyCount=" + replyCount +
                ", createTime=" + createTime +
                ", username='" + username + '\'' +
                ", courseName='" + courseName + '\'' +
                ", userRole='" + userRole + '\'' +
                '}';
    }
}