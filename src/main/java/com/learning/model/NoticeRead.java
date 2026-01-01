package com.learning.model;

import java.util.Date;

/**
 * 通知阅读记录实体类
 * 对应数据库的 notice_read 表
 */
public class NoticeRead {

    private Integer id;          // 记录ID
    private Integer noticeId;    // 通知ID
    private Integer userId;      // 用户ID
    private Date readTime;       // 阅读时间

    // ========== Getter 和 Setter 方法 ==========

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getReadTime() {
        return readTime;
    }

    public void setReadTime(Date readTime) {
        this.readTime = readTime;
    }

    @Override
    public String toString() {
        return "NoticeRead{" +
                "id=" + id +
                ", noticeId=" + noticeId +
                ", userId=" + userId +
                ", readTime=" + readTime +
                '}';
    }
}