package com.learning.controller;

import com.learning.model.Course;
import com.learning.model.Discussion;
import com.learning.model.DiscussionReply;
import com.learning.model.User;
import com.learning.service.CourseService;
import com.learning.service.DiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 * 讨论区控制器
 */
@Controller
@RequestMapping("/discussion")
public class DiscussionController {

    @Autowired
    private DiscussionService discussionService;

    @Autowired
    private CourseService courseService;

    /**
     * 显示课程讨论区列表
     */
    @RequestMapping("/list.action")
    public String list(Integer courseId, Model model, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 检查courseId
        if (courseId == null) {
            return "redirect:/course/list.action";
        }

        // 查询课程信息
        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return "redirect:/course/list.action";
        }

        // 查询讨论列表
        List<Discussion> discussionList = discussionService.getCourseDiscussions(courseId);

        model.addAttribute("course", course);
        model.addAttribute("discussionList", discussionList);

        return "discussion/list";
    }

    /**
     * 显示发布话题页面
     */
    @RequestMapping("/toAdd.action")
    public String toAdd(Integer courseId, Model model, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 检查courseId
        if (courseId == null) {
            return "redirect:/course/list.action";
        }

        // 查询课程信息
        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return "redirect:/course/list.action";
        }

        model.addAttribute("course", course);

        return "discussion/add";
    }

    /**
     * 发布话题
     */
    @RequestMapping(value = "/add.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String add(Integer courseId, String title, String content, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        // 验证参数
        if (courseId == null) {
            return "{\"success\": false, \"message\": \"课程ID不能为空\"}";
        }

        if (title == null || title.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"话题标题不能为空\"}";
        }

        // 创建话题对象
        Discussion discussion = new Discussion();
        discussion.setCourseId(courseId);
        discussion.setUserId(user.getId());
        discussion.setTitle(title.trim());
        discussion.setContent(content != null ? content.trim() : "");

        // 添加话题
        boolean success = discussionService.addDiscussion(discussion);

        if (success) {
            return "{\"success\": true, \"message\": \"发布成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"发布失败\"}";
        }
    }

    /**
     * 显示话题详情（包含回复列表）
     */
    @RequestMapping("/detail.action")
    public String detail(Integer id, Model model, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 检查id
        if (id == null) {
            return "redirect:/course/list.action";
        }

        // 查询话题详情
        Discussion discussion = discussionService.getDiscussionById(id);
        if (discussion == null) {
            return "redirect:/course/list.action";
        }

        // 查询回复列表
        List<DiscussionReply> replyList = discussionService.getDiscussionReplies(id);

        model.addAttribute("discussion", discussion);
        model.addAttribute("replyList", replyList);

        return "discussion/detail";
    }

    /**
     * 添加回复
     */
    @RequestMapping(value = "/addReply.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String addReply(Integer discussionId, String content, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        // 验证参数
        if (discussionId == null) {
            return "{\"success\": false, \"message\": \"话题ID不能为空\"}";
        }

        if (content == null || content.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"回复内容不能为空\"}";
        }

        // 创建回复对象
        DiscussionReply reply = new DiscussionReply();
        reply.setDiscussionId(discussionId);
        reply.setUserId(user.getId());
        reply.setContent(content.trim());

        // 添加回复
        boolean success = discussionService.addReply(reply);

        if (success) {
            return "{\"success\": true, \"message\": \"回复成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"回复失败\"}";
        }
    }

    /**
     * 删除话题
     */
    @RequestMapping(value = "/delete.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String delete(Integer id, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        // 查询话题信息
        Discussion discussion = discussionService.getDiscussionById(id);
        if (discussion == null) {
            return "{\"success\": false, \"message\": \"话题不存在\"}";
        }

        // 权限检查：只有发布者或管理员可以删除
        if (!discussion.getUserId().equals(user.getId()) && !"admin".equals(user.getRole())) {
            return "{\"success\": false, \"message\": \"无权删除此话题\"}";
        }

        // 删除话题
        boolean success = discussionService.deleteDiscussion(id);

        if (success) {
            return "{\"success\": true, \"message\": \"删除成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"删除失败\"}";
        }
    }

    /**
     * 删除回复
     */
    @RequestMapping(value = "/deleteReply.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String deleteReply(Integer id, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        // 删除回复（Service层会处理权限）
        boolean success = discussionService.deleteReply(id);

        if (success) {
            return "{\"success\": true, \"message\": \"删除成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"删除失败\"}";
        }
    }
}