package com.learning.dao;

import com.learning.model.Chapter;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 章节数据访问接口
 * 定义对 chapter 表的增删改查操作
 */
public interface ChapterMapper {
    
    /**
     * 根据课程ID查询所有章节（按排序序号升序）
     */
    List<Chapter> findByCourseId(Integer courseId);
    
    /**
     * 根据章节ID查询章节详情
     */
    Chapter findById(Integer id);
    
    /**
     * 添加章节
     */
    int insert(Chapter chapter);
    
    /**
     * 更新章节
     */
    int update(Chapter chapter);
    
    /**
     * 删除章节
     */
    int delete(Integer id);
    
    /**
     * 获取课程的章节总数
     */
    int countByCourseId(Integer courseId);
    
    /**
     * 更新章节排序
     */
    int updateSortOrder(@Param("id") Integer id, @Param("sortOrder") Integer sortOrder);
}
