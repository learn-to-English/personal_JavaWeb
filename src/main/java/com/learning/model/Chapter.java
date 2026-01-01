package com.learning.model;

import java.util.Date;

/**
 * 章节实体类
 * 对应数据库的 chapter 表
 */
public class Chapter {
    
    private Integer id;           // 章节ID
    private Integer courseId;     // 课程ID
    private String title;         // 章节标题
    private String content;       // 章节内容
    private String videoUrl;      // 视频链接
    private Integer sortOrder;    // 排序序号
    private Date createTime;      // 创建时间
    
    // 额外字段（用于页面显示，不是数据库字段）
    private String courseTitle;   // 课程标题

    // ========== 构造方法 ==========
    
    public Chapter() {
    }

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

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    // ========== toString 方法（方便调试）==========
    
    @Override
    public String toString() {
        return "Chapter{" +
                "id=" + id +
                ", courseId=" + courseId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", videoUrl='" + videoUrl + '\'' +
                ", sortOrder=" + sortOrder +
                ", createTime=" + createTime +
                '}';
    }
}
