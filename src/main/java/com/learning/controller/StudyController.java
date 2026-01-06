package com.learning.controller;

import com.learning.model.Enrollment;
import com.learning.model.User;
import com.learning.service.EnrollmentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    private static final Logger logger = LoggerFactory.getLogger(StudyController.class);

    @Autowired
    private EnrollmentService enrollmentService;

    /**
     * 我的学习页面（显示已选课程）
     */
    @RequestMapping("/myList.action")
    public String myList(HttpSession session, Model model) {
        logger.info("========== 访问【我的学习】页面 ==========");

        try {
            // 检查登录
            User user = (User) session.getAttribute("user");
            if (user == null) {
                logger.warn("用户未登录，重定向到登录页面");
                return "redirect:/user/toLogin.action";
            }

            logger.info("当前登录用户 - ID: {}, 用户名: {}, 角色: {}",
                user.getId(), user.getUsername(), user.getRole());

            // 获取我的选课记录
            logger.debug("开始查询用户ID={} 的选课记录", user.getId());
            List<Enrollment> enrollmentList = enrollmentService.getMyEnrollments(user.getId());

            if (enrollmentList == null) {
                logger.error("查询结果为NULL！这可能是数据库查询异常");
                enrollmentList = new java.util.ArrayList<>();
            } else {
                logger.info("查询到选课记录数: {}", enrollmentList.size());
                if (enrollmentList.isEmpty()) {
                    logger.warn("用户ID={} 没有任何选课记录", user.getId());
                } else {
                    for (int i = 0; i < enrollmentList.size(); i++) {
                        Enrollment e = enrollmentList.get(i);
                        logger.info("  [{}] 选课ID: {}, 课程ID: {}, 课程名: {}, 教师: {}, 选课时间: {}",
                            i+1, e.getId(), e.getCourseId(), e.getCourseTitle(),
                            e.getTeacherName(), e.getEnrollTime());
                    }
                }
            }

            model.addAttribute("enrollmentList", enrollmentList);
            logger.info("已将选课列表放入Model，准备返回视图: study/myList");

            return "study/myList";

        } catch (Exception e) {
            logger.error("【我的学习】页面发生异常", e);
            logger.error("异常详情 - 类型: {}, 消息: {}", e.getClass().getName(), e.getMessage());
            if (e.getCause() != null) {
                logger.error("异常原因: {}", e.getCause().getMessage());
            }
            // 打印堆栈跟踪
            for (StackTraceElement element : e.getStackTrace()) {
                logger.error("    at {}", element.toString());
            }
            model.addAttribute("errorMessage", "加载学习记录时出错: " + e.getMessage());
            model.addAttribute("enrollmentList", new java.util.ArrayList<>());
            return "study/myList";
        } finally {
            logger.info("========================================");
        }
    }

    /**
     * 选课
     */
    @RequestMapping(value = "/enroll.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String enroll(Integer courseId, HttpSession session) {
        logger.info("========== 选课操作 ==========");

        try {
            // 检查登录
            User user = (User) session.getAttribute("user");
            if (user == null) {
                logger.warn("选课失败：用户未登录");
                return "{\"success\": false, \"message\": \"请先登录\"}";
            }

            logger.info("选课用户 - ID: {}, 用户名: {}", user.getId(), user.getUsername());

            // 检查课程ID
            if (courseId == null) {
                logger.warn("选课失败：课程ID为空");
                return "{\"success\": false, \"message\": \"课程ID不能为空\"}";
            }

            logger.info("目标课程ID: {}", courseId);

            // 检查是否已选
            boolean hasEnrolled = enrollmentService.hasEnrolled(user.getId(), courseId);
            logger.debug("检查是否已选课 - 用户ID: {}, 课程ID: {}, 结果: {}",
                user.getId(), courseId, hasEnrolled);

            if (hasEnrolled) {
                logger.warn("选课失败：用户已经选过此课程");
                return "{\"success\": false, \"message\": \"您已经选过这门课了\"}";
            }

            // 执行选课
            logger.info("执行选课操作 - 用户ID: {}, 课程ID: {}", user.getId(), courseId);
            boolean success = enrollmentService.enroll(user.getId(), courseId);

            if (success) {
                logger.info("✓ 选课成功 - 用户ID: {}, 课程ID: {}", user.getId(), courseId);
                return "{\"success\": true, \"message\": \"选课成功\"}";
            } else {
                logger.error("✗ 选课失败 - 用户ID: {}, 课程ID: {}", user.getId(), courseId);
                return "{\"success\": false, \"message\": \"选课失败\"}";
            }

        } catch (Exception e) {
            logger.error("选课操作发生异常", e);
            return "{\"success\": false, \"message\": \"选课失败: " + e.getMessage() + "\"}";
        } finally {
            logger.info("==============================");
        }
    }

    /**
     * 退课
     */
    @RequestMapping(value = "/unenroll.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String unenroll(Integer courseId, HttpSession session) {
        logger.info("========== 退课操作 ==========");

        try {
            // 检查登录
            User user = (User) session.getAttribute("user");
            if (user == null) {
                logger.warn("退课失败：用户未登录");
                return "{\"success\": false, \"message\": \"请先登录\"}";
            }

            logger.info("退课用户 - ID: {}, 用户名: {}, 课程ID: {}",
                user.getId(), user.getUsername(), courseId);

            // 执行退课
            boolean success = enrollmentService.unenroll(user.getId(), courseId);

            if (success) {
                logger.info("✓ 退课成功 - 用户ID: {}, 课程ID: {}", user.getId(), courseId);
                return "{\"success\": true, \"message\": \"退课成功\"}";
            } else {
                logger.warn("✗ 退课失败 - 用户ID: {}, 课程ID: {}", user.getId(), courseId);
                return "{\"success\": false, \"message\": \"退课失败\"}";
            }

        } catch (Exception e) {
            logger.error("退课操作发生异常 - 课程ID: {}", courseId, e);
            return "{\"success\": false, \"message\": \"退课失败: " + e.getMessage() + "\"}";
        } finally {
            logger.info("==============================");
        }
    }
}
