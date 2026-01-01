package com.learning.model;

import java.util.Date;

/**
 * 课程分类实体类
 * 对应数据库的 category 表
 */
public class Category {
    
    private Integer id;         // 分类ID
    private String name;        // 分类名称
    private Date createTime;    // 创建时间

    // ========== Getter 和 Setter 方法 ==========
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
