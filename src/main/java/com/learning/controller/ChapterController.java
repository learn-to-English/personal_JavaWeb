package com.learning.controller;

import com.learning.model.Chapter;
import com.learning.model.Course;
import com.learning.model.User;
import com.learning.service.ChapterService;
import com.learning.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 * 章节控制器
 * 处理章节相关的请求
 */
@Controller
@RequestMapping("/chapter")
public class ChapterController {

    @Autowired
    private ChapterService chapterService;
    
    @Autowired
    private CourseService courseService;

    /**
     * 显示课程的章节列表页面
     */
    @RequestMapping("/list.action")
    public String list(Integer courseId, Model model, HttpSession session) {
        // 检查课程ID
        if (courseId == null) {
            return "redirect:/course/list.action";
        }
        
        // 获取课程信息
        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return "redirect:/course/list.action";
        }
        
        // 获取章节列表
        List<Chapter> chapterList = chapterService.getChaptersByCourseId(courseId);
        
        // 传递数据到页面
        model.addAttribute("course", course);
        model.addAttribute("chapterList", chapterList);
        
        // 检查当前用户是否是教师（用于判断是否显示管理按钮）
        User user = (User) session.getAttribute("user");
        boolean isTeacher = false;
        if (user != null && course.getTeacherId().equals(user.getId())) {
            isTeacher = true;
        }
        model.addAttribute("isTeacher", isTeacher);
        
        return "chapter/list";
    }

    /**
     * 显示添加章节页面
     */
    @RequestMapping("/toAdd.action")
    public String toAdd(Integer courseId, Model model, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }
        
        // 检查课程ID
        if (courseId == null) {
            return "redirect:/course/myList.action";
        }
        
        // 获取课程信息
        Course course = courseService.getCourseById(courseId);
        if (course == null) {
            return "redirect:/course/myList.action";
        }
        
        // 检查权限（只有课程的教师才能添加章节）
        if (!course.getTeacherId().equals(user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/course/myList.action";
        }
        
        model.addAttribute("course", course);
        return "chapter/add";
    }

    /**
     * 添加章节（表单提交）
     */
    @RequestMapping(value = "/add.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String add(Integer courseId, String title, String content, String videoUrl, 
                     Integer sortOrder, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }
        
        // 参数验证
        if (courseId == null) {
            return "{\"success\": false, \"message\": \"课程ID不能为空\"}";
        }
        
        if (title == null || title.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"章节标题不能为空\"}";
        }
        
        // 创建章节对象
        Chapter chapter = new Chapter();
        chapter.setCourseId(courseId);
        chapter.setTitle(title.trim());
        chapter.setContent(content);
        chapter.setVideoUrl(videoUrl);
        chapter.setSortOrder(sortOrder);
        
        // 调用Service添加章节
        boolean success = chapterService.addChapter(chapter);
        
        if (success) {
            return "{\"success\": true, \"message\": \"章节添加成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"章节添加失败\"}";
        }
    }

    /**
     * 显示章节详情页面
     */
    @RequestMapping("/detail.action")
    public String detail(Integer id, Model model) {
        // 检查章节ID
        if (id == null) {
            return "redirect:/course/list.action";
        }
        
        // 获取章节详情
        Chapter chapter = chapterService.getChapterById(id);
        if (chapter == null) {
            return "redirect:/course/list.action";
        }
        
        // 获取课程信息
        Course course = courseService.getCourseById(chapter.getCourseId());
        
        // 获取该课程的所有章节（用于上一章/下一章导航）
        List<Chapter> chapterList = chapterService.getChaptersByCourseId(chapter.getCourseId());
        
        model.addAttribute("chapter", chapter);
        model.addAttribute("course", course);
        model.addAttribute("chapterList", chapterList);
        
        return "chapter/detail";
    }

    /**
     * 显示编辑章节页面
     */
    @RequestMapping("/toEdit.action")
    public String toEdit(Integer id, Model model, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }
        
        // 获取章节详情
        Chapter chapter = chapterService.getChapterById(id);
        if (chapter == null) {
            return "redirect:/course/myList.action";
        }
        
        // 获取课程信息
        Course course = courseService.getCourseById(chapter.getCourseId());
        
        // 检查权限
        if (!course.getTeacherId().equals(user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/course/myList.action";
        }
        
        model.addAttribute("chapter", chapter);
        model.addAttribute("course", course);
        
        return "chapter/edit";
    }

    /**
     * 更新章节（表单提交）
     */
    @RequestMapping(value = "/update.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String update(Integer id, String title, String content, String videoUrl, 
                        Integer sortOrder, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }
        
        // 参数验证
        if (id == null) {
            return "{\"success\": false, \"message\": \"章节ID不能为空\"}";
        }
        
        if (title == null || title.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"章节标题不能为空\"}";
        }
        
        // 获取章节
        Chapter chapter = chapterService.getChapterById(id);
        if (chapter == null) {
            return "{\"success\": false, \"message\": \"章节不存在\"}";
        }
        
        // 更新章节信息
        chapter.setTitle(title.trim());
        chapter.setContent(content);
        chapter.setVideoUrl(videoUrl);
        chapter.setSortOrder(sortOrder);
        
        boolean success = chapterService.updateChapter(chapter);
        
        if (success) {
            return "{\"success\": true, \"message\": \"章节更新成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"章节更新失败\"}";
        }
    }

    /**
     * 删除章节
     */
    @RequestMapping(value = "/delete.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String delete(Integer id, HttpSession session) {
        // 检查登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }
        
        boolean success = chapterService.deleteChapter(id);
        
        if (success) {
            return "{\"success\": true, \"message\": \"章节已删除\"}";
        } else {
            return "{\"success\": false, \"message\": \"删除失败\"}";
        }
    }
}
