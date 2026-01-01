package com.learning.controller;
import com.learning.model.*;
import com.learning.service.ExamService;
import com.learning.service.CourseService;
import com.learning.dao.ExamRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.*;

/**
 * 考试控制器
 */
@Controller
@RequestMapping("/exam")
public class ExamController {

    @Autowired
    private ExamService examService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private ExamRecordMapper examRecordMapper;

    /**
     * 考试列表
     */
    @RequestMapping("/list.action")
    public String list(Model model) {
        List<Exam> examList = examService.getAllPublishedExams();
        model.addAttribute("examList", examList);
        return "exam/list";
    }

    /**
     * 开始考试
     */
    @RequestMapping("/start.action")
    public String start(Integer examId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 检查是否已经参加过
        ExamRecord record = examService.getExamRecord(examId, user.getId());
        if (record != null && "submitted".equals(record.getStatus())) {
            return "redirect:/exam/result.action?recordId=" + record.getId();
        }

        // 开始考试
        if (record == null) {
            record = examService.startExam(examId, user.getId());
        }

        Exam exam = examService.getExamById(examId);
        List<ExamQuestion> questions = examService.getExamQuestions(examId);

        model.addAttribute("exam", exam);
        model.addAttribute("questions", questions);
        model.addAttribute("recordId", record.getId());

        return "exam/take";
    }

    /**
     * 提交答案
     */
    @RequestMapping(value = "/submit.action", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String submit(Integer recordId, HttpSession session, @RequestParam Map<String, String> params) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        // 提取答案
        Map<Integer, String> answers = new HashMap<>();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (entry.getKey().startsWith("answer_")) {
                Integer questionId = Integer.parseInt(entry.getKey().replace("answer_", ""));
                answers.put(questionId, entry.getValue());
            }
        }

        boolean success = examService.submitExam(recordId, answers);

        if (success) {
            return "{\"success\": true, \"message\": \"提交成功\", \"recordId\": " + recordId + "}";
        } else {
            return "{\"success\": false, \"message\": \"提交失败\"}";
        }
    }

    /**
     * 查看成绩
     */
    @RequestMapping("/result.action")
    public String result(Integer recordId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        // 根据recordId查询考试记录
        ExamRecord record = examRecordMapper.findById(recordId);
        if (record == null) {
            return "redirect:/exam/list.action";
        }

        // 查询考试信息
        Exam exam = examService.getExamById(record.getExamId());

        // 查询学生的答案
        List<ExamAnswer> answers = examService.getExamAnswers(recordId);

        // 查询所有题目（用于显示正确答案）
        List<ExamQuestion> questions = examService.getExamQuestions(record.getExamId());

        // 将题目信息关联到答案中（用Map方便查找）
        Map<Integer, ExamQuestion> questionMap = new HashMap<>();
        for (ExamQuestion q : questions) {
            questionMap.put(q.getId(), q);
        }

        model.addAttribute("exam", exam);
        model.addAttribute("record", record);
        model.addAttribute("answers", answers);
        model.addAttribute("questionMap", questionMap);

        return "exam/result";
    }

    /**
     * 显示创建考试页面（教师）
     */
    @RequestMapping("/toCreate.action")
    public String toCreate(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }
        if (!"teacher".equals(user.getRole())) {
            return "redirect:/exam/list.action";
        }

        // 获取教师的课程列表
        List<Course> courseList = courseService.getCoursesByTeacherId(user.getId());
        model.addAttribute("courseList", courseList);

        return "exam/create";
    }

    /**
     * 创建考试（提交表单）
     */
    @RequestMapping(value = "/create.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String create(@RequestParam Map<String, String> params, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "{\"success\": false, \"message\": \"请先登录\"}";
        }

        try {
            System.out.println("=== 开始创建考试 ===");
            System.out.println("收到的参数：" + params);

            // 创建考试对象
            Exam exam = new Exam();

            String title = params.get("title");
            if (title == null || title.trim().isEmpty()) {
                return "{\"success\": false, \"message\": \"考试标题不能为空\"}";
            }
            exam.setTitle(title);

            exam.setDescription(params.get("description"));

            String courseIdStr = params.get("courseId");
            if (courseIdStr == null || courseIdStr.isEmpty()) {
                return "{\"success\": false, \"message\": \"请选择课程\"}";
            }
            exam.setCourseId(Integer.parseInt(courseIdStr));

            exam.setTeacherId(user.getId());

            String durationStr = params.get("duration");
            exam.setDuration(durationStr != null ? Integer.parseInt(durationStr) : 60);

            String totalScoreStr = params.get("totalScore");
            exam.setTotalScore(totalScoreStr != null ? Integer.parseInt(totalScoreStr) : 100);

            exam.setStatus("published");

            // 解析开始时间
            String startTimeStr = params.get("startTime");
            System.out.println("开始时间字符串: " + startTimeStr);

            if (startTimeStr != null && !startTimeStr.isEmpty()) {
                try {
                    startTimeStr = startTimeStr.replace("T", " ");
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                    exam.setStartTime(sdf.parse(startTimeStr));
                } catch (Exception e) {
                    System.out.println("开始时间解析失败: " + e.getMessage());
                    exam.setStartTime(new java.util.Date());
                }
            } else {
                exam.setStartTime(new java.util.Date());
            }

            // 解析结束时间
            String endTimeStr = params.get("endTime");
            System.out.println("结束时间字符串: " + endTimeStr);

            if (endTimeStr != null && !endTimeStr.isEmpty()) {
                try {
                    endTimeStr = endTimeStr.replace("T", " ");
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                    exam.setEndTime(sdf.parse(endTimeStr));
                } catch (Exception e) {
                    System.out.println("结束时间解析失败: " + e.getMessage());
                    exam.setEndTime(new java.util.Date(System.currentTimeMillis() + 30L * 24 * 60 * 60 * 1000));
                }
            } else {
                exam.setEndTime(new java.util.Date(System.currentTimeMillis() + 30L * 24 * 60 * 60 * 1000));
            }

            System.out.println("考试对象创建完成: " + exam.getTitle());

            // 收集题目
            List<ExamQuestion> questions = new ArrayList<>();
            int questionIndex = 1;

            while (params.containsKey("questions[" + questionIndex + "].type")) {
                System.out.println("处理第 " + questionIndex + " 题");

                ExamQuestion question = new ExamQuestion();

                String type = params.get("questions[" + questionIndex + "].type");
                String text = params.get("questions[" + questionIndex + "].text");
                String answer = params.get("questions[" + questionIndex + "].answer");
                String scoreStr = params.get("questions[" + questionIndex + "].score");

                if (text == null || text.trim().isEmpty()) {
                    return "{\"success\": false, \"message\": \"第" + questionIndex + "题题目内容不能为空\"}";
                }

                question.setQuestionType(type);
                question.setQuestionText(text);
                question.setCorrectAnswer(answer != null ? answer : "");
                question.setScore(scoreStr != null ? Integer.parseInt(scoreStr) : 10);

                String options = params.get("questions[" + questionIndex + "].options");
                if (options != null && !options.isEmpty()) {
                    String[] lines = options.split("\\n");
                    StringBuilder jsonOptions = new StringBuilder("[");
                    for (int i = 0; i < lines.length; i++) {
                        String line = lines[i].trim();
                        if (!line.isEmpty()) {
                            if (i > 0) jsonOptions.append(",");
                            jsonOptions.append("\"").append(line.replace("\"", "\\\"")).append("\"");
                        }
                    }
                    jsonOptions.append("]");
                    question.setOptions(jsonOptions.toString());
                }

                questions.add(question);
                questionIndex++;
            }

            System.out.println("收集到 " + questions.size() + " 道题目");

            if (questions.isEmpty()) {
                return "{\"success\": false, \"message\": \"请至少添加一道题目\"}";
            }

            // 保存考试和题目
            boolean success = examService.createExam(exam, questions);

            System.out.println("保存结果: " + success);

            if (success) {
                return "{\"success\": true, \"message\": \"考试创建成功\"}";
            } else {
                return "{\"success\": false, \"message\": \"考试创建失败\"}";
            }
        } catch (Exception e) {
            System.out.println("=== 创建考试异常 ===");
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"创建失败：" + e.getMessage() + "\"}";
        }
    }
}