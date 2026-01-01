package com.learning.service.impl;

import com.learning.dao.CourseMapper;
import com.learning.dao.CategoryMapper;
import com.learning.model.Course;
import com.learning.model.Category;
import com.learning.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 课程业务实现类
 */
@Service
public class CourseServiceImpl implements CourseService {
    
    // 注入CourseMapper
    @Autowired
    private CourseMapper courseMapper;
    
    // 注入CategoryMapper
    @Autowired
    private CategoryMapper categoryMapper;

    /**
     * 获取所有已发布的课程
     */
    @Override
    public List<Course> getAllPublishedCourses() {
        return courseMapper.findAllPublished();
    }

    /**
     * 根据ID获取课程
     */
    @Override
    public Course getCourseById(Integer id) {
        return courseMapper.findById(id);
    }

    /**
     * 获取教师的所有课程
     */
    @Override
    public List<Course> getCoursesByTeacherId(Integer teacherId) {
        return courseMapper.findByTeacherId(teacherId);
    }

    /**
     * 搜索课程
     */
    @Override
    public List<Course> searchCourses(String keyword) {
        // 如果关键词为空，返回所有已发布课程
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllPublishedCourses();
        }
        return courseMapper.searchByKeyword(keyword.trim());
    }

    /**
     * 添加课程
     */
    @Override
    public boolean addCourse(Course course) {
        // 新课程默认是草稿状态
        course.setStatus("draft");
        int result = courseMapper.insert(course);
        return result > 0;
    }

    /**
     * 更新课程
     */
    @Override
    public boolean updateCourse(Course course) {
        int result = courseMapper.update(course);
        return result > 0;
    }

    /**
     * 删除课程
     */
    @Override
    public boolean deleteCourse(Integer id) {
        int result = courseMapper.delete(id);
        return result > 0;
    }

    /**
     * 发布课程
     */
    @Override
    public boolean publishCourse(Integer id) {
        int result = courseMapper.updateStatus(id, "published");
        return result > 0;
    }

    /**
     * 下架课程
     */
    @Override
    public boolean unpublishCourse(Integer id) {
        int result = courseMapper.updateStatus(id, "draft");
        return result > 0;
    }

    /**
     * 获取所有分类
     */
    @Override
    public List<Category> getAllCategories() {
        return categoryMapper.findAll();
    }
}
