package com.learning.controller;

import com.learning.model.Enrollment;
import com.learning.model.User;
import com.learning.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 * 学习中心控制器
 * 处理选课、我的学习等功能
 */
@Controller
@RequestMapping("/study")
public class StudyController {
    
    @Autowired
    private EnrollmentService enrollmentService;

    /**
     * 我的学习页面（显示已选课程）
     */
    @RequestMapping("/myList.action")
    public String myList(HttpSession session, Model model) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }
        
        // 获取我的选课记录
        List<Enrollment> enrollmentList = enrollmentService.getMyEnrollments(user.getId());
        model.addAttribute("enrollmentList", enrollmentList);
        
        return "study/myList";
    }

    /**
     * 选课
     */
    @RequestMapping(value = "/enroll.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String enroll(Integer courseId, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }
        
        // 检查课程ID
        if (courseId == null) {
            return "{\"success\": false, \"message\": \"课程ID不能为空\"}";
        }
        
        // 检查是否已选
        if (enrollmentService.hasEnrolled(user.getId(), courseId)) {
            return "{\"success\": false, \"message\": \"您已经选过这门课了\"}";
        }
        
        // 执行选课
        boolean success = enrollmentService.enroll(user.getId(), courseId);
        
        if (success) {
            return "{\"success\": true, \"message\": \"选课成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"选课失败\"}";
        }
    }

    /**
     * 退课
     */
    @RequestMapping(value = "/unenroll.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String unenroll(Integer courseId, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }
        
        // 执行退课
        boolean success = enrollmentService.unenroll(user.getId(), courseId);
        
        if (success) {
            return "{\"success\": true, \"message\": \"退课成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"退课失败\"}";
        }
    }
}
