package com.learning.controller;
import com.learning.model.*;
import com.learning.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    @Autowired private NoticeService noticeService;
    @Autowired private CourseService courseService;

    @RequestMapping("/list.action")
    public String list(String filter, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/toLogin.action";
        List<Notice> noticeList = noticeService.getUserNotices(user.getId(), filter);
        int unreadCount = noticeService.getUnreadCount(user.getId());
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("unreadCount", unreadCount);
        model.addAttribute("filter", filter);
        return "notice/list";
    }

    @RequestMapping("/detail.action")
    public String detail(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/toLogin.action";
        Notice notice = noticeService.getNoticeById(id, user.getId());
        if (notice == null) return "redirect:/notice/list.action";
        noticeService.markAsRead(id, user.getId());
        model.addAttribute("notice", notice);
        return "notice/detail";
    }

    @RequestMapping("/toAdd.action")
    public String toAdd(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"teacher".equals(user.getRole()))
            return "redirect:/notice/list.action";
        List<Course> courseList = courseService.getCoursesByTeacherId(user.getId());
        model.addAttribute("courseList", courseList);
        return "notice/add";
    }

    @RequestMapping(value="/add.action", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String add(Notice notice, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "{\"success\":false,\"message\":\"请先登录\"}";
        if (notice.getTitle() == null || notice.getTitle().trim().isEmpty())
            return "{\"success\":false,\"message\":\"标题不能为空\"}";
        notice.setPublisherId(user.getId());
        if ("system".equals(notice.getType())) notice.setCourseId(null);
        boolean success = noticeService.publishNotice(notice);
        return success ? "{\"success\":true,\"message\":\"发布成功\"}"
                : "{\"success\":false,\"message\":\"发布失败\"}";
    }

    @RequestMapping("/manage.action")
    public String manage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/toLogin.action";
        List<Notice> noticeList = noticeService.getPublisherNotices(user.getId());
        model.addAttribute("noticeList", noticeList);
        return "notice/manage";
    }

    @RequestMapping(value="/unreadCount.action", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String unreadCount(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "{\"count\":0}";
        int count = noticeService.getUnreadCount(user.getId());
        return "{\"count\":" + count + "}";
    }

    @RequestMapping(value="/delete.action", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String delete(Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "{\"success\":false,\"message\":\"请先登录\"}";
        boolean success = noticeService.deleteNotice(id);
        return success ? "{\"success\":true,\"message\":\"删除成功\"}"
                : "{\"success\":false,\"message\":\"删除失败\"}";
    }
}