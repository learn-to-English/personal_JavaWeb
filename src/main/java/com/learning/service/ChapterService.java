package com.learning.service;

import com.learning.model.Chapter;
import java.util.List;

/**
 * 章节业务接口
 * 定义章节相关的业务方法
 */
public interface ChapterService {
    
    /**
     * 获取课程的所有章节（按排序升序）
     */
    List<Chapter> getChaptersByCourseId(Integer courseId);
    
    /**
     * 根据ID获取章节详情
     */
    Chapter getChapterById(Integer id);
    
    /**
     * 添加章节
     */
    boolean addChapter(Chapter chapter);
    
    /**
     * 更新章节
     */
    boolean updateChapter(Chapter chapter);
    
    /**
     * 删除章节
     */
    boolean deleteChapter(Integer id);
    
    /**
     * 获取课程的章节总数
     */
    int getChapterCount(Integer courseId);
}
