package com.learning.dao;

import com.learning.model.Course;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 课程数据访问接口
 * 定义对 course 表的增删改查操作
 */
public interface CourseMapper {
    
    /**
     * 查询所有已发布的课程
     */
    List<Course> findAllPublished();
    
    /**
     * 根据ID查询课程
     */
    Course findById(Integer id);
    
    /**
     * 根据教师ID查询课程（教师查看自己的课程）
     */
    List<Course> findByTeacherId(Integer teacherId);
    
    /**
     * 根据关键词搜索课程
     */
    List<Course> searchByKeyword(String keyword);
    
    /**
     * 添加课程
     */
    int insert(Course course);
    
    /**
     * 更新课程
     */
    int update(Course course);
    
    /**
     * 删除课程
     */
    int delete(Integer id);
    
    /**
     * 更新课程状态（发布/下架）
     */
    int updateStatus(@Param("id") Integer id, @Param("status") String status);
    
    /**
     * 增加学生人数（选课时调用）
     */
    int addStudentCount(Integer id);
}
