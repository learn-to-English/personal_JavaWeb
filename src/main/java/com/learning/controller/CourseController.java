package com.learning.controller;

import com.learning.model.Course;
import com.learning.model.Category;
import com.learning.model.User;
import com.learning.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import com.learning.service.AssignmentService;
import com.learning.service.SubmissionService;
import com.learning.model.Assignment;
import com.learning.model.Submission;

/**
 * 课程控制器
 * 处理所有课程相关的请求
 */
@Controller
@RequestMapping("/course")
public class CourseController {

    // 注入课程业务类
    @Autowired
    private CourseService courseService;

    @Autowired
    private AssignmentService assignmentService;

    @Autowired
    private SubmissionService submissionService;

    /**
     * 显示课程列表页面（所有人可访问）
     */
    @RequestMapping("/list.action")
    public String list(String keyword, Model model) {
        List<Course> courseList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            courseList = courseService.searchCourses(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            courseList = courseService.getAllPublishedCourses();
        }

        model.addAttribute("courseList", courseList);
        return "course/list";
    }

    /**
     * 显示课程详情页面（增强版：包含作业列表）
     */
    @RequestMapping("/detail.action")
    public String detail(Integer id, Model model, HttpSession session) {
        Course course = courseService.getCourseById(id);

        if (course == null) {
            return "redirect:/course/list.action";
        }

        model.addAttribute("course", course);

        List<Assignment> assignmentList = assignmentService.getAssignmentsByCourse(id);
        model.addAttribute("assignmentList", assignmentList);

        // 如果是学生，检查每个作业的提交状态
        User user = (User) session.getAttribute("user");
        if (user != null && "student".equals(user.getRole())) {
            for (Assignment assignment : assignmentList) {
                Submission submission = submissionService.getSubmission(assignment.getId(), user.getId());
                if (submission != null) {
                    if ("graded".equals(submission.getStatus())) {
                        assignment.setSubmitRate(2.0); // 已批改
                    } else {
                        assignment.setSubmitRate(1.0); // 已提交
                    }
                } else {
                    assignment.setSubmitRate(0.0); // 未提交
                }
            }
        }
        return "course/detail";
    }
    /**
     * 显示"我的课程"页面（教师查看自己创建的课程）
     */
    @RequestMapping("/myList.action")
    public String myList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        if (!"teacher".equals(user.getRole()) && !"admin".equals(user.getRole())) {
            return "redirect:/course/list.action";
        }

        List<Course> courseList = courseService.getCoursesByTeacherId(user.getId());
        model.addAttribute("courseList", courseList);

        return "course/myList";
    }

    /**
     * 显示添加课程页面
     */
    @RequestMapping("/toAdd.action")
    public String toAdd(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }
        if (!"teacher".equals(user.getRole()) && !"admin".equals(user.getRole())) {
            return "redirect:/course/list.action";
        }

        List<Category> categoryList = courseService.getAllCategories();
        model.addAttribute("categoryList", categoryList);

        return "course/add";
    }

    /**
     * 添加课程（表单提交）
     * 关键：produces 指定返回的编码为 UTF-8，解决中文乱码
     */
    @RequestMapping(value = "/add.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String add(String title, String description, Integer categoryId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        if (title == null || title.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"课程标题不能为空\"}";
        }

        Course course = new Course();
        course.setTitle(title.trim());
        course.setDescription(description);
        course.setCategoryId(categoryId);
        course.setTeacherId(user.getId());

        boolean success = courseService.addCourse(course);

        if (success) {
            return "{\"success\": true, \"message\": \"课程创建成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"课程创建失败\"}";
        }
    }

    /**
     * 显示编辑课程页面
     */
    @RequestMapping("/toEdit.action")
    public String toEdit(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Course course = courseService.getCourseById(id);
        if (course == null) {
            return "redirect:/course/myList.action";
        }

        if (!course.getTeacherId().equals(user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/course/myList.action";
        }

        List<Category> categoryList = courseService.getAllCategories();

        model.addAttribute("course", course);
        model.addAttribute("categoryList", categoryList);

        return "course/edit";
    }

    /**
     * 更新课程（表单提交）
     */
    @RequestMapping(value = "/update.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String update(Integer id, String title, String description, Integer categoryId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        Course course = courseService.getCourseById(id);
        if (course == null) {
            return "{\"success\": false, \"message\": \"课程不存在\"}";
        }

        if (!course.getTeacherId().equals(user.getId()) && !"admin".equals(user.getRole())) {
            return "{\"success\": false, \"message\": \"无权修改此课程\"}";
        }

        course.setTitle(title.trim());
        course.setDescription(description);
        course.setCategoryId(categoryId);

        boolean success = courseService.updateCourse(course);

        if (success) {
            return "{\"success\": true, \"message\": \"课程更新成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"课程更新失败\"}";
        }
    }

    /**
     * 发布课程
     */
    @RequestMapping(value = "/publish.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String publish(Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        boolean success = courseService.publishCourse(id);

        if (success) {
            return "{\"success\": true, \"message\": \"课程已发布\"}";
        } else {
            return "{\"success\": false, \"message\": \"发布失败\"}";
        }
    }

    /**
     * 下架课程
     */
    @RequestMapping(value = "/unpublish.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String unpublish(Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        boolean success = courseService.unpublishCourse(id);

        if (success) {
            return "{\"success\": true, \"message\": \"课程已下架\"}";
        } else {
            return "{\"success\": false, \"message\": \"下架失败\"}";
        }
    }

    /**
     * 删除课程
     */
    @RequestMapping(value = "/delete.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String delete(Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        boolean success = courseService.deleteCourse(id);

        if (success) {
            return "{\"success\": true, \"message\": \"课程已删除\"}";
        } else {
            return "{\"success\": false, \"message\": \"删除失败\"}";
        }
    }
}