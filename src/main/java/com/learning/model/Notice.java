package com.learning.model;

import java.util.Date;

/**
 * 通知公告实体类
 * 对应数据库的 notice 表
 */
public class Notice {

    private Integer id;             // 通知ID
    private String type;            // 通知类型：course课程通知/system系统公告
    private String title;           // 通知标题
    private String content;         // 通知内容
    private String priority;        // 优先级：normal普通/important重要/urgent紧急
    private Integer courseId;       // 课程ID（课程通知专用）
    private Integer publisherId;    // 发布者ID
    private Date publishTime;       // 发布时间

    // 关联字段（不在数据库表中，用于页面显示）
    private String publisherName;   // 发布者姓名
    private String courseName;      // 课程名称
    private Integer readCount;      // 已读人数
    private Integer totalCount;     // 总人数（课程通知时）
    private Boolean isRead;         // 当前用户是否已读

    // ========== Getter 和 Setter 方法 ==========

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(Integer publisherId) {
        this.publisherId = publisherId;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getReadCount() {
        return readCount;
    }

    public void setReadCount(Integer readCount) {
        this.readCount = readCount;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Boolean getIsRead() {
        return isRead;
    }

    public void setIsRead(Boolean isRead) {
        this.isRead = isRead;
    }

    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", priority='" + priority + '\'' +
                ", courseId=" + courseId +
                ", publisherId=" + publisherId +
                ", publishTime=" + publishTime +
                '}';
    }
}