package com.learning.controller;

import com.learning.model.Assignment;
import com.learning.model.Submission;
import com.learning.model.User;
import com.learning.service.AssignmentService;
import com.learning.service.SubmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 * 作业提交控制器
 */
@Controller
@RequestMapping("/submission")
public class SubmissionController {

    @Autowired
    private SubmissionService submissionService;

    @Autowired
    private AssignmentService assignmentService;

    /**
     * 学生查看作业列表
     */
    @RequestMapping("/list.action")
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 获取学生的所有作业
        List<Assignment> assignmentList = assignmentService.getStudentAssignments(user.getId());

        // 为每个作业添加提交状态信息
        if (assignmentList != null) {
            for (Assignment assignment : assignmentList) {
                Submission submission = submissionService.getSubmission(assignment.getId(), user.getId());
                if (submission != null) {
                    // 已提交，设置状态
                    assignment.setSubmitRate(submissionService.isGraded(submission) ? 2.0 : 1.0);
                    // 2.0表示已批改，1.0表示已提交未批改，0.0或null表示未提交
                } else {
                    assignment.setSubmitRate(0.0);
                }
            }
        }

        model.addAttribute("assignmentList", assignmentList);

        return "submission/list";
    }

    /**
     * 进入提交作业页面
     */
    @RequestMapping("/toSubmit.action")
    public String toSubmit(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Assignment assignment = assignmentService.getAssignmentById(id);
        if (assignment == null) {
            return "redirect:/submission/list.action";
        }

        // 检查是否已提交
        Submission existingSubmission = submissionService.getSubmission(id, user.getId());

        model.addAttribute("assignment", assignment);
        model.addAttribute("submission", existingSubmission);

        return "submission/submit";
    }

    /**
     * 提交作业
     */
    @RequestMapping(value = "/submit.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String submit(Integer assignmentId, String content, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        if (content == null || content.trim().isEmpty()) {
            return "{\"success\": false, \"message\": \"作业内容不能为空\"}";
        }

        // 检查作业是否存在
        Assignment assignment = assignmentService.getAssignmentById(assignmentId);
        if (assignment == null) {
            return "{\"success\": false, \"message\": \"作业不存在\"}";
        }

        // 检查是否过期
        if (assignmentService.isExpired(assignment)) {
            return "{\"success\": false, \"message\": \"作业已过截止时间，无法提交\"}";
        }

        Submission submission = new Submission();
        submission.setAssignmentId(assignmentId);
        submission.setStudentId(user.getId());
        submission.setContent(content.trim());

        boolean success = submissionService.submitAssignment(submission);

        if (success) {
            return "{\"success\": true, \"message\": \"作业提交成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"提交失败，可能已批改无法重新提交\"}";
        }
    }

    /**
     * 查看作业成绩
     */
    @RequestMapping("/viewGrade.action")
    public String viewGrade(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Assignment assignment = assignmentService.getAssignmentById(id);
        if (assignment == null) {
            return "redirect:/submission/list.action";
        }

        Submission submission = submissionService.getSubmission(id, user.getId());
        if (submission == null) {
            return "redirect:/submission/list.action";
        }

        model.addAttribute("assignment", assignment);
        model.addAttribute("submission", submission);

        return "submission/viewGrade";
    }

    /**
     * 教师查看作业提交列表
     */
    @RequestMapping("/submissions.action")
    public String submissions(Integer assignmentId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Assignment assignment = assignmentService.getAssignmentById(assignmentId);
        if (assignment == null) {
            return "redirect:/assignment/myList.action";
        }

        // 检查权限
        if (!assignmentService.isTeacherAssignment(assignmentId, user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/assignment/myList.action";
        }

        List<Submission> submissionList = submissionService.getAssignmentSubmissions(assignmentId);

        model.addAttribute("assignment", assignment);
        model.addAttribute("submissionList", submissionList);

        return "submission/submissions";
    }

    /**
     * 进入批改页面
     */
    @RequestMapping("/toGrade.action")
    public String toGrade(Integer id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        Submission submission = submissionService.getSubmissionById(id);
        if (submission == null) {
            return "redirect:/assignment/myList.action";
        }

        Assignment assignment = assignmentService.getAssignmentById(submission.getAssignmentId());

        // 检查权限
        if (!assignmentService.isTeacherAssignment(assignment.getId(), user.getId()) && !"admin".equals(user.getRole())) {
            return "redirect:/assignment/myList.action";
        }

        model.addAttribute("submission", submission);
        model.addAttribute("assignment", assignment);

        return "submission/grade";
    }

    /**
     * 批改作业
     */
    @RequestMapping(value = "/grade.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String grade(Integer submissionId, Integer score, String feedback, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        if (score == null) {
            return "{\"success\": false, \"message\": \"请输入分数\"}";
        }

        Submission submission = submissionService.getSubmissionById(submissionId);
        if (submission == null) {
            return "{\"success\": false, \"message\": \"提交记录不存在\"}";
        }

        // 检查分数范围
        if (score < 0 || score > submission.getTotalScore()) {
            return "{\"success\": false, \"message\": \"分数必须在0-" + submission.getTotalScore() + "之间\"}";
        }

        boolean success = submissionService.gradeSubmission(submissionId, score, feedback);

        if (success) {
            return "{\"success\": true, \"message\": \"批改成功\"}";
        } else {
            return "{\"success\": false, \"message\": \"批改失败\"}";
        }
    }
}