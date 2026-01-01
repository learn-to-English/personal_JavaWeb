package com.learning.service.impl;

import com.learning.dao.ChapterMapper;
import com.learning.model.Chapter;
import com.learning.service.ChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 章节业务实现类
 */
@Service
public class ChapterServiceImpl implements ChapterService {
    
    // 注入ChapterMapper
    @Autowired
    private ChapterMapper chapterMapper;

    /**
     * 获取课程的所有章节（按排序升序）
     */
    @Override
    public List<Chapter> getChaptersByCourseId(Integer courseId) {
        if (courseId == null || courseId <= 0) {
            return null;
        }
        return chapterMapper.findByCourseId(courseId);
    }

    /**
     * 根据ID获取章节详情
     */
    @Override
    public Chapter getChapterById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }
        return chapterMapper.findById(id);
    }

    /**
     * 添加章节
     */
    @Override
    public boolean addChapter(Chapter chapter) {
        if (chapter == null || chapter.getCourseId() == null || chapter.getTitle() == null) {
            return false;
        }
        
        // 如果没有设置排序序号，自动设置为最后
        if (chapter.getSortOrder() == null) {
            int count = chapterMapper.countByCourseId(chapter.getCourseId());
            chapter.setSortOrder(count + 1);
        }
        
        int result = chapterMapper.insert(chapter);
        return result > 0;
    }

    /**
     * 更新章节
     */
    @Override
    public boolean updateChapter(Chapter chapter) {
        if (chapter == null || chapter.getId() == null) {
            return false;
        }
        int result = chapterMapper.update(chapter);
        return result > 0;
    }

    /**
     * 删除章节
     */
    @Override
    public boolean deleteChapter(Integer id) {
        if (id == null || id <= 0) {
            return false;
        }
        int result = chapterMapper.delete(id);
        return result > 0;
    }

    /**
     * 获取课程的章节总数
     */
    @Override
    public int getChapterCount(Integer courseId) {
        if (courseId == null || courseId <= 0) {
            return 0;
        }
        return chapterMapper.countByCourseId(courseId);
    }
}
