<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>创建考试 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 50px;
        }
        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }
        .main-content {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .form-card {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .form-card h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        .required { color: #dc3545; }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .question-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            margin-top: 30px;
        }
        .question-section h3 {
            margin-bottom: 20px;
            color: #667eea;
        }
        .question-item {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid #667eea;
        }
        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .btn-remove {
            padding: 5px 15px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-add {
            padding: 12px 25px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
        }
        .btn-add:hover { background: #218838; }
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
</div>

<div class="main-content">
    <div class="form-card">
        <h1>📝 创建考试</h1>

        <div id="alertBox"></div>

        <form id="examForm">
            <div class="form-group">
                <label>考试标题 <span class="required">*</span></label>
                <input type="text" name="title" id="title" placeholder="请输入考试标题" required>
            </div>

            <div class="form-group">
                <label>选择课程 <span class="required">*</span></label>
                <select name="courseId" id="courseId" required>
                    <option value="">请选择课程</option>
                    <c:forEach var="course" items="${courseList}">
                        <option value="${course.id}">${course.title}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>开始时间 <span class="required">*</span></label>
                    <input type="datetime-local" name="startTime" id="startTime" required>
                </div>
                <div class="form-group">
                    <label>结束时间 <span class="required">*</span></label>
                    <input type="datetime-local" name="endTime" id="endTime" required>
                </div>
            </div>

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

            <div class="form-group">
                <label>考试说明</label>
                <textarea name="description" id="description" rows="3" placeholder="选填"></textarea>
            </div>

            <!-- 题目区域 -->
            <div class="question-section">
                <h3>📋 添加题目</h3>
                <div id="questionList"></div>

                <button type="button" class="btn-add" onclick="addQuestion('choice')">+ 添加单选题</button>
                <button type="button" class="btn-add" onclick="addQuestion('judge')">+ 添加判断题</button>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/exam/list.action" class="btn btn-secondary">取消</a>
                <button type="submit" class="btn btn-primary">创建考试</button>
            </div>
        </form>
    </div>
</div>

<script>
    let questionCount = 0;

    function addQuestion(type) {
        questionCount++;
        const questionList = document.getElementById('questionList');
        const questionDiv = document.createElement('div');
        questionDiv.className = 'question-item';
        questionDiv.id = 'question-' + questionCount;

        // 重要：使用字符串拼接，不要用模板字符串的${questionCount}
        const qNum = questionCount;

        let content = '<div class="question-header">';
        content += '<strong class="question-title">第 <span class="q-num">' + qNum + '</span> 题 - ' + (type == 'choice' ? '单选题' : '判断题') + '</strong>';
        content += '<button type="button" class="btn-remove" onclick="removeQuestionById(this)">删除</button>';
        content += '</div>';
        content += '<input type="hidden" name="questions[' + qNum + '].type" value="' + type + '">';
        content += '<div class="form-group">';
        content += '<label>题目内容</label>';
        content += '<textarea name="questions[' + qNum + '].text" rows="2" required></textarea>';
        content += '</div>';

        if (type == 'choice') {
            content += '<div class="form-group">';
            content += '<label>选项（每行一个，格式：A. 选项内容）</label>';
            content += '<textarea name="questions[' + qNum + '].options" rows="4" placeholder="A. 选项1\nB. 选项2\nC. 选项3\nD. 选项4"></textarea>';
            content += '</div>';
            content += '<div class="form-row">';
            content += '<div class="form-group">';
            content += '<label>正确答案</label>';
            content += '<input type="text" name="questions[' + qNum + '].answer" placeholder="A" required>';
            content += '</div>';
            content += '<div class="form-group">';
            content += '<label>分值</label>';
            content += '<input type="number" name="questions[' + qNum + '].score" value="10" required>';
            content += '</div>';
            content += '</div>';
        } else {
            content += '<div class="form-row">';
            content += '<div class="form-group">';
            content += '<label>正确答案</label>';
            content += '<select name="questions[' + qNum + '].answer" required>';
            content += '<option value="正确">正确</option>';
            content += '<option value="错误">错误</option>';
            content += '</select>';
            content += '</div>';
            content += '<div class="form-group">';
            content += '<label>分值</label>';
            content += '<input type="number" name="questions[' + qNum + '].score" value="5" required>';
            content += '</div>';
            content += '</div>';
        }

        questionDiv.innerHTML = content;
        questionList.appendChild(questionDiv);
        updateQuestionNumbers();
    }

    function removeQuestionById(btn) {
        // 找到题目容器并删除
        const questionItem = btn.closest('.question-item');
        if (questionItem) {
            questionItem.remove();
            updateQuestionNumbers();
        }
    }

    function updateQuestionNumbers() {
        const questions = document.querySelectorAll('.question-item');
        questions.forEach((q, index) => {
            const numSpan = q.querySelector('.q-num');
            if (numSpan) {
                numSpan.textContent = index + 1;
            }
        });
    }

    document.getElementById('examForm').onsubmit = function(e) {
        e.preventDefault();

        // 使用表单序列化
        const form = this;
        const formElements = form.elements;
        const params = new URLSearchParams();

        for (let i = 0; i < formElements.length; i++) {
            const element = formElements[i];
            if (element.name && element.value) {
                params.append(element.name, element.value);
            }
        }

        console.log('提交的参数:', params.toString());

        fetch('${pageContext.request.contextPath}/exam/create.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params.toString()
        })
            .then(response => response.json())
            .then(data => {
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/exam/list.action';
                    }, 1500);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('创建失败，请重试', 'error');
            });
    };

    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }

    // 初始化时间
    const now = new Date();
    const tomorrow = new Date(now.getTime() + 24*60*60*1000);
    document.getElementById('startTime').value = now.toISOString().slice(0,16);
    document.getElementById('endTime').value = tomorrow.toISOString().slice(0,16);
</script>
</body>
</html>
