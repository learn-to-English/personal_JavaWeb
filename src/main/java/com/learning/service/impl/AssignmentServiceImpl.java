package com.learning.service.impl;

import com.learning.dao.AssignmentMapper;
import com.learning.dao.CourseMapper;
import com.learning.model.Assignment;
import com.learning.model.Course;
import com.learning.service.AssignmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;

/**
 * 作业业务实现类
 */
@Service
public class AssignmentServiceImpl implements AssignmentService {

    @Autowired
    private AssignmentMapper assignmentMapper;

    @Autowired
    private CourseMapper courseMapper;

    @Override
    public boolean createAssignment(Assignment assignment) {
        if (assignment == null || assignment.getCourseId() == null) {
            return false;
        }

        // 设置默认值
        if (assignment.getTotalScore() == null || assignment.getTotalScore() <= 0) {
            assignment.setTotalScore(100);
        }

        int result = assignmentMapper.insert(assignment);
        return result > 0;
    }

    @Override
    public List<Assignment> getTeacherAssignments(Integer teacherId) {
        if (teacherId == null) {
            return null;
        }
        return assignmentMapper.findByTeacherId(teacherId);
    }

    @Override
    public List<Assignment> getStudentAssignments(Integer studentId) {
        if (studentId == null) {
            return null;
        }
        return assignmentMapper.findByStudentId(studentId);
    }

    @Override
    public List<Assignment> getAssignmentsByCourse(Integer courseId) {
        if (courseId == null) {
            return null;
        }
        return assignmentMapper.findByCourseId(courseId);
    }

    @Override
    public Assignment getAssignmentById(Integer id) {
        if (id == null) {
            return null;
        }
        return assignmentMapper.findById(id);
    }

    @Override
    public boolean updateAssignment(Assignment assignment) {
        if (assignment == null || assignment.getId() == null) {
            return false;
        }
        int result = assignmentMapper.update(assignment);
        return result > 0;
    }

    @Override
    public boolean deleteAssignment(Integer id) {
        if (id == null) {
            return false;
        }
        int result = assignmentMapper.delete(id);
        return result > 0;
    }

    @Override
    public boolean isTeacherAssignment(Integer assignmentId, Integer teacherId) {
        if (assignmentId == null || teacherId == null) {
            return false;
        }

        Assignment assignment = assignmentMapper.findById(assignmentId);
        if (assignment == null) {
            return false;
        }

        Course course = courseMapper.findById(assignment.getCourseId());
        if (course == null) {
            return false;
        }

        return course.getTeacherId().equals(teacherId);
    }

    @Override
    public boolean isExpired(Assignment assignment) {
        if (assignment == null || assignment.getDeadline() == null) {
            return false;
        }
        return assignment.getDeadline().before(new Date());
    }
}