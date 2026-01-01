package com.learning.controller;

import com.learning.model.Assignment;
import com.learning.model.Course;
import com.learning.model.User;
import com.learning.service.AssignmentService;
import com.learning.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 作业控制器
 */
@Controller
@RequestMapping("/assignment")
public class AssignmentController {

    @Autowired
    private AssignmentService assignmentService;

    @Autowired
    private CourseService courseService;

    /**
     * 教师查看我的作业列表
     */
    @RequestMapping("/myList.action")
    public String myList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 只有教师和管理员可以访问
        if (!"teacher".equals(user.getRole()) && !"admin".equals(user.getRole())) {
            return "redirect:/home.action";
        }

        List<Assignment> assignmentList = assignmentService.getTeacherAssignments(user.getId());
        model.addAttribute("assignmentList", assignmentList);

        return "assignment/myList";
    }

    /**
     * 进入创建作业页面
     */
    @RequestMapping("/toAdd.action")
    public String toAdd(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        if (!"teacher".equals(user.getRole()) && !"admin".equals(user.getRole())) {
            return "redirect:/home.action";
        }

        // 获取教师的所有课程
        List<Course> courseList = courseService.getCoursesByTeacherId(user.getId());
        model.addAttribute("courseList", courseList);

        return "assignment/add";
    }

    /**
     * 创建作业
     */
    @RequestMapping(value = "/add.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String add(Integer courseId, String title, String description,
                      Integer totalScore, String deadline, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        if (title == null || title.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"作业标题不能为空\"}";
        }

        if (courseId == null) {
            return "{\"success\": false, \"message\": \"请选择课程\"}";
        }

        try {
            Assignment assignment = new Assignment();
            assignment.setCourseId(courseId);
            assignment.setTitle(title.trim());
            assignment.setDescription(description);
            assignment.setTotalScore(totalScore != null ? totalScore : 100);

            // 解析截止时间
            if (deadline != null && !deadline.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                assignment.setDeadline(sdf.parse(deadline));
            }

            boolean success = assignmentService.createAssignment(assignment);

            if (success) {
                return "{\"success\": true, \"message\": \"作业创建成功\"}";
            } else {
                return "{\"success\": false, \"message\": \"作业创建失败\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"系统错误：" + e.getMessage() + "\"}";
        }
    }

    /**
     * 查看作业详情（教师查看提交列表）
     */
    @RequestMapping("/detail.action")
    public String detail(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Assignment assignment = assignmentService.getAssignmentById(id);
        if (assignment == null) {
            return "redirect:/assignment/myList.action";
        }

        // 检查权限
        if (!assignmentService.isTeacherAssignment(id, user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/assignment/myList.action";
        }

        model.addAttribute("assignment", assignment);

        return "assignment/detail";
    }

    /**
     * 进入编辑页面
     */
    @RequestMapping("/toEdit.action")
    public String toEdit(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Assignment assignment = assignmentService.getAssignmentById(id);
        if (assignment == null) {
            return "redirect:/assignment/myList.action";
        }

        // 检查权限
        if (!assignmentService.isTeacherAssignment(id, user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/assignment/myList.action";
        }

        List<Course> courseList = courseService.getCoursesByTeacherId(user.getId());

        model.addAttribute("assignment", assignment);
        model.addAttribute("courseList", courseList);

        return "assignment/edit";
    }

    /**
     * 更新作业
     */
    @RequestMapping(value = "/update.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String update(Integer id, Integer courseId, String title, String description,
                         Integer totalScore, String deadline, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        Assignment assignment = assignmentService.getAssignmentById(id);
        if (assignment == null) {
            return "{\"success\": false, \"message\": \"作业不存在\"}";
        }

        // 检查权限
        if (!assignmentService.isTeacherAssignment(id, user.getId()) && !"admin".equals(user.getRole())) {
            return "{\"success\": false, \"message\": \"无权修改此作业\"}";
        }

        try {
            assignment.setCourseId(courseId);
            assignment.setTitle(title.trim());
            assignment.setDescription(description);
            assignment.setTotalScore(totalScore != null ? totalScore : 100);

            if (deadline != null && !deadline.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                assignment.setDeadline(sdf.parse(deadline));
            }

            boolean success = assignmentService.updateAssignment(assignment);

            if (success) {
                return "{\"success\": true, \"message\": \"作业更新成功\"}";
            } else {
                return "{\"success\": false, \"message\": \"作业更新失败\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"系统错误：" + e.getMessage() + "\"}";
        }
    }

    /**
     * 删除作业
     */
    @RequestMapping(value = "/delete.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String delete(Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        // 检查权限
        if (!assignmentService.isTeacherAssignment(id, user.getId()) && !"admin".equals(user.getRole())) {
            return "{\"success\": false, \"message\": \"无权删除此作业\"}";
        }

        boolean success = assignmentService.deleteAssignment(id);

        if (success) {
            return "{\"success\": true, \"message\": \"作业已删除\"}";
        } else {
            return "{\"success\": false, \"message\": \"删除失败\"}";
        }
    }
}