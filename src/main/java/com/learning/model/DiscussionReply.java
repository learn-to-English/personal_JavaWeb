package com.learning.model;

import java.util.Date;

/**
 * 讨论回复实体类
 * 对应数据库的 discussion_reply 表
 */
public class DiscussionReply {

    private Integer id;             // 回复ID
    private Integer discussionId;   // 话题ID
    private Integer userId;         // 回复者ID
    private String content;         // 回复内容
    private Date createTime;        // 回复时间

    // 关联字段（不在数据库表中，用于页面显示）
    private String username;        // 回复者用户名
    private String userRole;        // 回复者角色（用于标识教师）

    // ========== Getter 和 Setter 方法 ==========

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDiscussionId() {
        return discussionId;
    }

    public void setDiscussionId(Integer discussionId) {
        this.discussionId = discussionId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    @Override
    public String toString() {
        return "DiscussionReply{" +
                "id=" + id +
                ", discussionId=" + discussionId +
                ", userId=" + userId +
                ", content='" + content + '\'' +
                ", createTime=" + createTime +
                ", username='" + username + '\'' +
                ", userRole='" + userRole + '\'' +
                '}';
    }
}