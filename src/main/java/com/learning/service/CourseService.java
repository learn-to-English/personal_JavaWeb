package com.learning.service;

import com.learning.model.Course;
import com.learning.model.Category;
import java.util.List;

/**
 * 课程业务接口
 * 定义课程相关的业务方法
 */
public interface CourseService {
    
    /**
     * 获取所有已发布的课程
     */
    List<Course> getAllPublishedCourses();
    
    /**
     * 根据ID获取课程
     */
    Course getCourseById(Integer id);
    
    /**
     * 获取教师的所有课程
     */
    List<Course> getCoursesByTeacherId(Integer teacherId);
    
    /**
     * 搜索课程
     */
    List<Course> searchCourses(String keyword);
    
    /**
     * 添加课程
     */
    boolean addCourse(Course course);
    
    /**
     * 更新课程
     */
    boolean updateCourse(Course course);
    
    /**
     * 删除课程
     */
    boolean deleteCourse(Integer id);
    
    /**
     * 发布课程
     */
    boolean publishCourse(Integer id);
    
    /**
     * 下架课程
     */
    boolean unpublishCourse(Integer id);
    
    /**
     * 获取所有分类
     */
    List<Category> getAllCategories();
}
