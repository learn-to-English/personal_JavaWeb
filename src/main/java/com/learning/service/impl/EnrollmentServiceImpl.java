package com.learning.service.impl;

import com.learning.dao.EnrollmentMapper;
import com.learning.dao.CourseMapper;
import com.learning.model.Enrollment;
import com.learning.service.EnrollmentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 选课业务实现类
 */
@Service
public class EnrollmentServiceImpl implements EnrollmentService {

    private static final Logger logger = LoggerFactory.getLogger(EnrollmentServiceImpl.class);

    @Autowired
    private EnrollmentMapper enrollmentMapper;

    @Autowired
    private CourseMapper courseMapper;

    /**
     * 获取学生的所有选课记录
     */
    @Override
    public List<Enrollment> getMyEnrollments(Integer studentId) {
        logger.debug("Service层 - 开始查询学生ID={} 的选课记录", studentId);

        try {
            List<Enrollment> result = enrollmentMapper.findByStudentId(studentId);

            if (result == null) {
                logger.warn("Mapper返回NULL - 学生ID: {}", studentId);
            } else {
                logger.debug("Mapper返回结果 - 学生ID: {}, 记录数: {}", studentId, result.size());
            }

            return result;

        } catch (Exception e) {
            logger.error("查询选课记录失败 - 学生ID: {}", studentId, e);
            throw e;
        }
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
        logger.info("Service层 - 执行选课 - 学生ID: {}, 课程ID: {}", studentId, courseId);

        try {
            // 检查是否已选过
            if (hasEnrolled(studentId, courseId)) {
                logger.warn("学生已选过此课程 - 学生ID: {}, 课程ID: {}", studentId, courseId);
                return false;
            }

            // 添加选课记录
            Enrollment enrollment = new Enrollment();
            enrollment.setStudentId(studentId);
            enrollment.setCourseId(courseId);

            logger.debug("准备插入选课记录: {}", enrollment);
            int result = enrollmentMapper.insert(enrollment);
            logger.debug("插入结果: {}, 生成的ID: {}", result, enrollment.getId());

            // 选课成功，增加课程学生数
            if (result > 0) {
                logger.debug("更新课程学生数 - 课程ID: {}", courseId);
                courseMapper.addStudentCount(courseId);
                logger.info("✓ 选课成功 - 学生ID: {}, 课程ID: {}, 选课记录ID: {}",
                    studentId, courseId, enrollment.getId());
            } else {
                logger.error("✗ 选课失败 - 插入返回0 - 学生ID: {}, 课程ID: {}", studentId, courseId);
            }

            return result > 0;

        } catch (Exception e) {
            logger.error("选课操作异常 - 学生ID: {}, 课程ID: {}", studentId, courseId, e);
            throw e;
        }
    }

    /**
     * 退课
     */
    @Override
    public boolean unenroll(Integer studentId, Integer courseId) {
        int result = enrollmentMapper.deleteByStudentAndCourse(studentId, courseId);

        // 退课成功，减少课程学生数
        if (result > 0) {
            courseMapper.reduceStudentCount(courseId);
        }

        return result > 0;
    }
}
