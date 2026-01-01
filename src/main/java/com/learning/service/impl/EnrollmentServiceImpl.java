package com.learning.service.impl;

import com.learning.dao.EnrollmentMapper;
import com.learning.dao.CourseMapper;
import com.learning.model.Enrollment;
import com.learning.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 选课业务实现类
 */
@Service
public class EnrollmentServiceImpl implements EnrollmentService {
    
    @Autowired
    private EnrollmentMapper enrollmentMapper;
    
    @Autowired
    private CourseMapper courseMapper;

    /**
     * 获取学生的所有选课记录
     */
    @Override
    public List<Enrollment> getMyEnrollments(Integer studentId) {
        return enrollmentMapper.findByStudentId(studentId);
    }

    /**
     * 检查学生是否已选某门课
     */
    @Override
    public boolean hasEnrolled(Integer studentId, Integer courseId) {
        Enrollment enrollment = enrollmentMapper.findByStudentAndCourse(studentId, courseId);
        return enrollment != null;
    }

    /**
     * 选课
     */
    @Override
    public boolean enroll(Integer studentId, Integer courseId) {
        // 检查是否已选过
        if (hasEnrolled(studentId, courseId)) {
            return false;
        }
        
        // 添加选课记录
        Enrollment enrollment = new Enrollment();
        enrollment.setStudentId(studentId);
        enrollment.setCourseId(courseId);
        
        int result = enrollmentMapper.insert(enrollment);
        
        // 选课成功，增加课程学生数
        if (result > 0) {
            courseMapper.addStudentCount(courseId);
        }
        
        return result > 0;
    }

    /**
     * 退课
     */
    @Override
    public boolean unenroll(Integer studentId, Integer courseId) {
        int result = enrollmentMapper.deleteByStudentAndCourse(studentId, courseId);
        return result > 0;
    }
}
