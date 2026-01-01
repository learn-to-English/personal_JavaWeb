package com.learning.dao;

import com.learning.model.Category;
import java.util.List;

/**
 * 课程分类数据访问接口
 */
public interface CategoryMapper {
    
    /**
     * 查询所有分类
     */
    List<Category> findAll();
    
    /**
     * 根据ID查询分类
     */
    Category findById(Integer id);
}
