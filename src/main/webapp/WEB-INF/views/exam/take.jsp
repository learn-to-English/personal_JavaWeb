<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${exam.title} - 在线考试</title>
    <style>
        /* 全局重置 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* CSS变量 - 天空蓝主题 */
        :root {
            --primary: #5DADE2;
            --primary-light: #A8D8EA;
            --primary-dark: #3498DB;
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
        }

        /* 固定顶部栏 */
        .exam-header {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 3px 15px rgba(93, 173, 226, 0.4);
        }

        .exam-title {
            font-size: 24px;
            font-weight: 600;
        }

        .exam-timer {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .timer {
            font-size: 32px;
            font-weight: bold;
            font-family: 'Courier New', monospace;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 20px;
            border-radius: 12px;
        }

        .btn-submit-top {
            padding: 10px 28px;
            background: rgba(255, 255, 255, 0.95);
            color: var(--primary);
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-submit-top:hover {
            background: white;
            transform: scale(1.05);
        }

        /* 主内容区 */
        .main-content {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px 40px;
        }

        /* 题目卡片 */
        .question-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(93, 173, 226, 0.2);
        }

        .question-num {
            font-size: 18px;
            font-weight: bold;
            color: var(--primary);
        }

        .question-score {
            color: var(--text-light);
            font-size: 14px;
        }

        .question-text {
            font-size: 16px;
            color: var(--text-dark);
            line-height: 1.8;
            margin-bottom: 20px;
        }

        /* 选项列表 */
        .options {
            display: grid;
            gap: 12px;
        }

        .option-item {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            border: 2px solid rgba(93, 173, 226, 0.2);
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .option-item:hover {
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            border-color: var(--primary-light);
            transform: translateX(5px);
        }

        .option-item input[type="radio"] {
            margin-right: 15px;
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: var(--primary);
        }

        .option-item label {
            flex: 1;
            cursor: pointer;
            font-size: 15px;
            color: var(--text-dark);
        }

        /* 提交区域 */
        .submit-section {
            text-align: center;
            margin-top: 30px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(93, 173, 226, 0.2);
        }

        .btn-submit {
            padding: 15px 60px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        .warning {
            color: #FF8787;
            margin-top: 15px;
            font-size: 14px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .exam-header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .exam-title {
                font-size: 20px;
            }

            .timer {
                font-size: 28px;
            }

            .main-content {
                padding: 0 15px 30px;
            }

            .question-card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
<!-- 固定顶部栏 -->
<div class="exam-header">
    <div class="exam-title">${exam.title}</div>
    <div class="exam-timer">
        <div class="timer" id="timer">--:--</div>
        <button type="button" class="btn-submit-top" onclick="confirmSubmit()">提交试卷</button>
    </div>
</div>

<!-- 主内容区 -->
<div class="main-content">
    <form id="examForm">
        <input type="hidden" name="recordId" value="${recordId}">

        <c:forEach var="question" items="${questions}" varStatus="status">
            <div class="question-card">
                <div class="question-header">
                    <span class="question-num">第 ${status.index + 1} 题</span>
                    <span class="question-score">${question.score} 分</span>
                </div>

                <div class="question-text">${question.questionText}</div>

                <div class="options">
                    <c:choose>
                        <c:when test="${question.questionType == 'choice'}">
                            <%-- 处理单选题选项 --%>
                            <%
                                com.learning.model.ExamQuestion q = (com.learning.model.ExamQuestion) pageContext.getAttribute("question");
                                String optionsJson = q.getOptions();
                                if (optionsJson != null && !optionsJson.isEmpty()) {
                                    // 解析JSON: ["A. 选项1", "B. 选项2"]
                                    optionsJson = optionsJson.replace("[", "").replace("]", "").replace("\"", "");
                                    String[] options = optionsJson.split(",");

                                    for (int i = 0; i < options.length; i++) {
                                        String option = options[i].trim();
                                        if (!option.isEmpty()) {
                                            String optValue = option.length() > 0 ? option.substring(0, 1) : "";
                            %>
                            <div class="option-item">
                                <input type="radio"
                                       name="answer_<%= q.getId() %>"
                                       value="<%= optValue %>"
                                       id="q<%= q.getId() %>_opt<%= i %>">
                                <label for="q<%= q.getId() %>_opt<%= i %>"><%= option %></label>
                            </div>
                            <%
                                        }
                                    }
                                }
                            %>
                        </c:when>
                        <c:when test="${question.questionType == 'judge'}">
                            <%-- 判断题选项 --%>
                            <div class="option-item">
                                <input type="radio" name="answer_${question.id}" value="正确" id="q${question.id}_T">
                                <label for="q${question.id}_T">正确</label>
                            </div>
                            <div class="option-item">
                                <input type="radio" name="answer_${question.id}" value="错误" id="q${question.id}_F">
                                <label for="q${question.id}_F">错误</label>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </c:forEach>

        <div class="submit-section">
            <button type="button" class="btn-submit" onclick="confirmSubmit()">提交试卷</button>
            <div class="warning">提交后将不能修改答案</div>
        </div>
    </form>
</div>

<script>
    // 倒计时时长（秒）
    var duration = ${exam.duration} * 60;
    var timerInterval = null;

    // 功能1: 更新倒计时显示
    function updateTimer() {
        // 计算分钟和秒数
        var minutes = Math.floor(duration / 60);
        var seconds = duration % 60;

        // 补零显示
        var minutesStr = minutes < 10 ? '0' + minutes : minutes;
        var secondsStr = seconds < 10 ? '0' + seconds : seconds;

        // 更新显示
        var timerDisplay = document.getElementById('timer');
        timerDisplay.textContent = minutesStr + ':' + secondsStr;

        // 判断是否时间到
        if (duration <= 0) {
            clearInterval(timerInterval);
            alert('考试时间到，自动提交！');
            submitExam();
        } else {
            duration = duration - 1;
        }
    }

    // 功能2: 启动倒计时
    function startTimer() {
        updateTimer();
        timerInterval = setInterval(updateTimer, 1000);
    }

    // 功能3: 确认提交
    function confirmSubmit() {
        var result = confirm('确定要提交试卷吗？提交后将不能修改！');
        if (result) {
            submitExam();
        }
    }

    // 功能4: 提交试卷
    function submitExam() {
        // 停止倒计时
        clearInterval(timerInterval);

        // 获取表单数据
        var form = document.getElementById('examForm');
        var formData = new FormData(form);
        var params = new URLSearchParams(formData).toString();

        // 发送请求
        sendSubmitRequest(params);
    }

    // 功能5: 发送提交请求
    function sendSubmitRequest(params) {
        fetch('${pageContext.request.contextPath}/exam/submit.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params
        })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                handleSubmitResult(data);
            })
            .catch(function(error) {
                alert('提交失败，请重试');
            });
    }

    // 功能6: 处理提交结果
    function handleSubmitResult(data) {
        alert(data.message);

        if (data.success) {
            // 跳转到成绩页面
            window.location.href = '${pageContext.request.contextPath}/exam/result.action?recordId=' + data.recordId;
        }
    }

    // 功能7: 防止页面刷新
    function preventRefresh() {
        return '考试进行中，确定要离开吗？';
    }

    // 页面加载时启动倒计时
    startTimer();

    // 绑定页面离开提示
    window.onbeforeunload = preventRefresh;
</script>
</body>
</html>