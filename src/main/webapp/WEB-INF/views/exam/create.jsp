<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>创建考试 - 在线学习平台</title>
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
            --success: #51CF66;
            --error: #FF8787;
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 - 天空蓝渐变 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* 页面标题 */
        .header {
            max-width: 900px;
            margin: 0 auto 30px;
            color: var(--text-dark);
        }

        .header h1 {
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        .header .subtitle {
            font-size: 16px;
            opacity: 0.8;
        }

        .back-link {
            display: inline-block;
            color: var(--text-dark);
            text-decoration: none;
            padding: 10px 25px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 25px;
            margin-top: 15px;
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.8);
            transform: translateX(-5px);
        }

        /* 表单卡片 */
        .form-card {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .form-card h2 {
            font-size: 24px;
            color: var(--text-dark);
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-light);
        }

        /* 表单组 */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 15px;
        }

        .required {
            color: var(--error);
            margin-left: 3px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid rgba(93, 173, 226, 0.2);
            border-radius: 12px;
            font-size: 15px;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.9);
            font-family: var(--font-main);
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
            background: white;
        }

        /* 表单行 */
        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        /* 题目区域 */
        .question-section {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            padding: 30px;
            border-radius: 15px;
            margin-top: 30px;
        }

        .question-section h3 {
            font-size: 20px;
            color: var(--text-dark);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid rgba(93, 173, 226, 0.2);
        }

        /* 题目项 */
        .question-item {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 15px;
            border-left: 4px solid var(--primary);
            box-shadow: 0 3px 10px rgba(93, 173, 226, 0.1);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .question-title {
            font-size: 16px;
            color: var(--text-dark);
        }

        /* 按钮样式 */
        .btn-remove {
            padding: 6px 18px;
            background: var(--error);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-remove:hover {
            background: #E06C6C;
            transform: scale(1.05);
        }

        .btn-add {
            padding: 12px 25px;
            background: var(--success);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            margin-right: 10px;
            margin-top: 15px;
            transition: all 0.3s;
        }

        .btn-add:hover {
            background: #45B85C;
            transform: translateY(-2px);
        }

        /* 操作按钮 */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid rgba(93, 173, 226, 0.2);
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.8);
            color: var(--text-dark);
            border: 2px solid rgba(93, 173, 226, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 1);
            border-color: var(--primary-light);
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            text-align: center;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #E7F5E9 0%, #D4EDDA 100%);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .alert-error {
            background: linear-gradient(135deg, #FFE5E5 0%, #FFCCCB 100%);
            color: var(--error);
            border-left: 4px solid var(--error);
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body {
                padding: 20px 15px;
            }

            .header h1 {
                font-size: 26px;
            }

            .form-card {
                padding: 30px 25px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- 页面标题 -->
<div class="header">
    <h1>创建考试</h1>
    <p class="subtitle">设置考试信息并添加题目</p>
    <a href="${pageContext.request.contextPath}/exam/list.action" class="back-link">
        返回考试列表
    </a>
</div>

<!-- 表单卡片 -->
<div class="form-card">
    <h2>考试信息</h2>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 表单 -->
    <form id="examForm">
        <!-- 考试标题 -->
        <div class="form-group">
            <label>考试标题<span class="required">*</span></label>
            <input type="text" name="title" id="title" placeholder="请输入考试标题" required>
        </div>

        <!-- 选择课程 -->
        <div class="form-group">
            <label>选择课程<span class="required">*</span></label>
            <select name="courseId" id="courseId" required>
                <option value="">请选择课程</option>
                <c:forEach var="course" items="${courseList}">
                    <option value="${course.id}">${course.title}</option>
                </c:forEach>
            </select>
        </div>

        <!-- 时间设置 -->
        <div class="form-row">
            <div class="form-group">
                <label>开始时间<span class="required">*</span></label>
                <input type="datetime-local" name="startTime" id="startTime" required>
            </div>
            <div class="form-group">
                <label>结束时间<span class="required">*</span></label>
                <input type="datetime-local" name="endTime" id="endTime" required>
            </div>
        </div>

        <!-- 时长和总分 -->
        <div class="form-row">
            <div class="form-group">
                <label>考试时长（分钟）</label>
                <input type="number" name="duration" id="duration" value="60" min="1">
            </div>
            <div class="form-group">
                <label>总分</label>
                <input type="number" name="totalScore" id="totalScore" value="100" min="1">
            </div>
        </div>

        <!-- 考试说明 -->
        <div class="form-group">
            <label>考试说明</label>
            <textarea name="description" id="description" rows="3" placeholder="选填"></textarea>
        </div>

        <!-- 题目区域 -->
        <div class="question-section">
            <h3>添加题目</h3>
            <div id="questionList"></div>

            <button type="button" class="btn-add" onclick="addChoiceQuestion()">+ 添加单选题</button>
            <button type="button" class="btn-add" onclick="addJudgeQuestion()">+ 添加判断题</button>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/exam/list.action" class="btn btn-secondary">
                取消
            </a>
            <button type="submit" class="btn btn-primary">
                创建考试
            </button>
        </div>
    </form>
</div>

<script>
    // 题目计数器
    var questionCount = 0;

    // 功能1: 添加单选题
    function addChoiceQuestion() {
        addQuestion('choice');
    }

    // 功能2: 添加判断题
    function addJudgeQuestion() {
        addQuestion('judge');
    }

    // 功能3: 添加题目的通用函数
    function addQuestion(type) {
        // 增加计数
        questionCount = questionCount + 1;

        // 获取题目列表容器
        var questionList = document.getElementById('questionList');

        // 创建题目容器
        var questionDiv = document.createElement('div');
        questionDiv.className = 'question-item';
        questionDiv.id = 'question-' + questionCount;

        // 构建题目HTML内容
        var content = '';

        // 题目头部
        content = content + '<div class="question-header">';
        content = content + '<strong class="question-title">第 <span class="q-num">' + questionCount + '</span> 题 - ';
        if (type == 'choice') {
            content = content + '单选题';
        } else {
            content = content + '判断题';
        }
        content = content + '</strong>';
        content = content + '<button type="button" class="btn-remove" onclick="removeQuestion(this)">删除</button>';
        content = content + '</div>';

        // 隐藏字段：题目类型
        content = content + '<input type="hidden" name="questions[' + questionCount + '].type" value="' + type + '">';

        // 题目内容输入框
        content = content + '<div class="form-group">';
        content = content + '<label>题目内容</label>';
        content = content + '<textarea name="questions[' + questionCount + '].text" rows="2" required></textarea>';
        content = content + '</div>';

        // 如果是单选题，添加选项输入框
        if (type == 'choice') {
            content = content + '<div class="form-group">';
            content = content + '<label>选项（每行一个，格式：A. 选项内容）</label>';
            content = content + '<textarea name="questions[' + questionCount + '].options" rows="4" ';
            content = content + 'placeholder="A. 选项1\nB. 选项2\nC. 选项3\nD. 选项4"></textarea>';
            content = content + '</div>';

            // 正确答案和分值
            content = content + '<div class="form-row">';
            content = content + '<div class="form-group">';
            content = content + '<label>正确答案</label>';
            content = content + '<input type="text" name="questions[' + questionCount + '].answer" placeholder="A" required>';
            content = content + '</div>';
            content = content + '<div class="form-group">';
            content = content + '<label>分值</label>';
            content = content + '<input type="number" name="questions[' + questionCount + '].score" value="10" required>';
            content = content + '</div>';
            content = content + '</div>';
        } else {
            // 判断题的答案选择和分值
            content = content + '<div class="form-row">';
            content = content + '<div class="form-group">';
            content = content + '<label>正确答案</label>';
            content = content + '<select name="questions[' + questionCount + '].answer" required>';
            content = content + '<option value="正确">正确</option>';
            content = content + '<option value="错误">错误</option>';
            content = content + '</select>';
            content = content + '</div>';
            content = content + '<div class="form-group">';
            content = content + '<label>分值</label>';
            content = content + '<input type="number" name="questions[' + questionCount + '].score" value="5" required>';
            content = content + '</div>';
            content = content + '</div>';
        }

        // 设置HTML内容并添加到列表
        questionDiv.innerHTML = content;
        questionList.appendChild(questionDiv);

        // 更新题目序号
        updateQuestionNumbers();
    }

    // 功能4: 删除题目
    function removeQuestion(btn) {
        // 找到题目容器
        var questionItem = btn.parentNode.parentNode;

        // 删除题目
        if (questionItem) {
            questionItem.remove();
            // 更新题目序号
            updateQuestionNumbers();
        }
    }

    // 功能5: 更新题目序号
    function updateQuestionNumbers() {
        // 获取所有题目
        var questions = document.querySelectorAll('.question-item');

        // 遍历更新序号
        for (var i = 0; i < questions.length; i++) {
            var numSpan = questions[i].querySelector('.q-num');
            if (numSpan) {
                numSpan.textContent = i + 1;
            }
        }
    }

    // 功能6: 提交表单
    function submitExamForm(e) {
        // 阻止默认提交
        e.preventDefault();

        // 获取表单
        var form = document.getElementById('examForm');
        var formElements = form.elements;

        // 构建请求数据
        var params = new URLSearchParams();

        // 遍历表单元素
        for (var i = 0; i < formElements.length; i++) {
            var element = formElements[i];
            if (element.name && element.value) {
                params.append(element.name, element.value);
            }
        }

        // 发送请求
        sendCreateRequest(params.toString());
    }

    // 功能7: 发送创建请求
    function sendCreateRequest(data) {
        fetch('${pageContext.request.contextPath}/exam/create.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: data
        })
            .then(function(response) {
                return response.json();
            })
            .then(function(result) {
                handleCreateResult(result);
            })
            .catch(function(error) {
                showMessage('创建失败，请重试', 'error');
            });
    }

    // 功能8: 处理创建结果
    function handleCreateResult(result) {
        // 显示消息
        if (result.success) {
            showMessage(result.message, 'success');
            // 1.5秒后跳转
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/exam/list.action';
            }, 1500);
        } else {
            showMessage(result.message, 'error');
        }
    }

    // 功能9: 显示提示消息
    function showMessage(message, type) {
        var alertBox = document.getElementById('alertBox');
        alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
    }

    // 绑定表单提交事件
    document.getElementById('examForm').onsubmit = submitExamForm;

    // 初始化时间（页面加载时设置默认时间）
    function initDateTime() {
        var now = new Date();
        var tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);

        // 格式化为 datetime-local 格式
        var nowStr = formatDateTime(now);
        var tomorrowStr = formatDateTime(tomorrow);

        document.getElementById('startTime').value = nowStr;
        document.getElementById('endTime').value = tomorrowStr;
    }

    // 格式化日期时间
    function formatDateTime(date) {
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();

        // 补零
        if (month < 10) month = '0' + month;
        if (day < 10) day = '0' + day;
        if (hour < 10) hour = '0' + hour;
        if (minute < 10) minute = '0' + minute;

        return year + '-' + month + '-' + day + 'T' + hour + ':' + minute;
    }

    // 页面加载时初始化时间
    initDateTime();
</script>
</body>
</html>