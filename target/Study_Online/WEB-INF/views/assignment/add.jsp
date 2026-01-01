<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>创建作业 - 在线学习平台</title>
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
        }

        .main-content {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .form-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .form-card h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }

        .form-card .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
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

        .form-group label .required {
            color: #dc3545;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

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
            text-decoration: none;
            text-align: center;
            transition: transform 0.3s;
        }

        .btn:hover {
            transform: translateY(-2px);
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
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">📚 在线学习平台</div>
</div>

<div class="main-content">
    <div class="form-card">
        <h1>✨ 创建新作业</h1>
        <p class="subtitle">为您的课程创建作业</p>

        <div id="alertBox"></div>

        <form id="assignmentForm">
            <div class="form-group">
                <label>选择课程 <span class="required">*</span></label>
                <select name="courseId" id="courseId" required>
                    <option value="">请选择课程</option>
                    <c:forEach var="course" items="${courseList}">
                        <option value="${course.id}">${course.title}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>作业标题 <span class="required">*</span></label>
                <input type="text" name="title" id="title" placeholder="请输入作业标题" required>
            </div>

            <div class="form-group">
                <label>作业描述</label>
                <textarea name="description" id="description" placeholder="请输入作业要求和说明"></textarea>
            </div>

            <div class="form-group">
                <label>满分</label>
                <input type="number" name="totalScore" id="totalScore" value="100" min="1" max="1000">
            </div>

            <div class="form-group">
                <label>截止时间</label>
                <input type="datetime-local" name="deadline" id="deadline">
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/assignment/myList.action" class="btn btn-secondary">取消</a>
                <button type="submit" class="btn btn-primary">创建作业</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('assignmentForm').onsubmit = function(e) {
        e.preventDefault();

        var courseId = document.getElementById('courseId').value;
        var title = document.getElementById('title').value.trim();
        var description = document.getElementById('description').value.trim();
        var totalScore = document.getElementById('totalScore').value;
        var deadline = document.getElementById('deadline').value;

        if (!courseId) {
            showAlert('请选择课程', 'error');
            return;
        }

        if (!title) {
            showAlert('请输入作业标题', 'error');
            return;
        }

        var formData = 'courseId=' + courseId
            + '&title=' + encodeURIComponent(title)
            + '&description=' + encodeURIComponent(description)
            + '&totalScore=' + totalScore
            + '&deadline=' + encodeURIComponent(deadline);

        fetch('${pageContext.request.contextPath}/assignment/add.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                    setTimeout(function() {
                        window.location.href = '${pageContext.request.contextPath}/assignment/myList.action';
                    }, 1500);
                }
            })
            .catch(error => {
                showAlert('请求失败，请重试', 'error');
            });
    };

    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>
