<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${exam.title} - 在线考试</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: #f5f5f5;
        }

        .exam-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .exam-title {
            font-size: 24px;
        }

        .exam-timer {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .timer {
            font-size: 28px;
            font-weight: bold;
        }

        .btn-submit-top {
            padding: 10px 25px;
            background: rgba(255,255,255,0.2);
            color: white;
            border: 2px solid white;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-submit-top:hover {
            background: white;
            color: #667eea;
        }

        .main-content {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px 40px;
        }

        .question-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .question-num {
            font-size: 18px;
            font-weight: bold;
            color: #667eea;
        }

        .question-score {
            color: #999;
            font-size: 14px;
        }

        .question-text {
            font-size: 16px;
            color: #333;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .options {
            display: grid;
            gap: 12px;
        }

        .option-item {
            display: flex;
            align-items: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .option-item:hover {
            background: #e8f4fd;
        }

        .option-item input[type="radio"] {
            margin-right: 12px;
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .option-item label {
            flex: 1;
            cursor: pointer;
            font-size: 15px;
        }

        .submit-section {
            text-align: center;
            margin-top: 30px;
            padding: 30px;
            background: white;
            border-radius: 15px;
        }

        .btn-submit {
            padding: 15px 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .btn-submit:hover {
            transform: scale(1.05);
        }

        .warning {
            color: #ff6b6b;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="exam-header">
    <div class="exam-title">${exam.title}</div>
    <div class="exam-timer">
        <div class="timer" id="timer">--:--</div>
        <button type="button" class="btn-submit-top" onclick="submitExam()">提交试卷</button>
    </div>
</div>

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
                                <label for="q${question.id}_T">✓ 正确</label>
                            </div>
                            <div class="option-item">
                                <input type="radio" name="answer_${question.id}" value="错误" id="q${question.id}_F">
                                <label for="q${question.id}_F">✗ 错误</label>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </c:forEach>

        <div class="submit-section">
            <button type="button" class="btn-submit" onclick="submitExam()">提交试卷</button>
            <div class="warning">⚠️ 提交后将不能修改答案</div>
        </div>
    </form>
</div>

<script>
    // 倒计时
    var duration = ${exam.duration} * 60; // 转换为秒
    var timerDisplay = document.getElementById('timer');

    function updateTimer() {
        var minutes = Math.floor(duration / 60);
        var seconds = duration % 60;
        timerDisplay.textContent =
            (minutes < 10 ? '0' : '') + minutes + ':' +
            (seconds < 10 ? '0' : '') + seconds;

        if (duration <= 0) {
            alert('考试时间到，自动提交！');
            submitExam();
        } else {
            duration--;
        }
    }

    updateTimer();
    var timerInterval = setInterval(updateTimer, 1000);

    // 提交试卷
    function submitExam() {
        if (!confirm('确定要提交试卷吗？提交后将不能修改！')) {
            return;
        }

        clearInterval(timerInterval);

        var formData = new FormData(document.getElementById('examForm'));
        var params = new URLSearchParams(formData).toString();

        fetch('${pageContext.request.contextPath}/exam/submit.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params
        })
            .then(response => response.json())
            .then(data => {
                alert(data.message);
                if (data.success) {
                    window.location.href = '${pageContext.request.contextPath}/exam/result.action?recordId=' + data.recordId;
                }
            })
            .catch(error => {
                alert('提交失败，请重试');
            });
    }

    // 防止页面刷新
    window.onbeforeunload = function() {
        return '考试进行中，确定要离开吗？';
    };
</script>
</body>
</html>
