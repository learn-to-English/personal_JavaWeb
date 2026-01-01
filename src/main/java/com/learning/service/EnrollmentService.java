package com.learning.service;

import com.learning.model.Enrollment;
import java.util.List;

/**
 * 选课业务接口
 */
public interface EnrollmentService {
    
    /**
     * 获取学生的所有选课记录
     */
    List<Enrollment> getMyEnrollments(Integer studentId);
    
    /**
     * 检查学生是否已选某门课
     */
    boolean hasEnrolled(Integer studentId, Integer courseId);
    
    /**
     * 选课
     */
    boolean enroll(Integer studentId, Integer courseId);
    
    /**
     * 退课
     */
    boolean unenroll(Integer studentId, Integer courseId);
}
