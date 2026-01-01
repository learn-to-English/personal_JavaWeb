<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布通知 - 在线学习平台</title>
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
            max-width: 800px;
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

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

        .radio-group {
            display: flex;
            gap: 20px;
        }

        .radio-group label {
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
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
            padding: 12px 20px;
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
    <div class="logo">📚 在线学习平台</div>
</div>

<div class="main-content">
    <div class="form-card">
        <h1>✨ 发布新通知</h1>

        <div id="alertBox"></div>

        <form id="noticeForm">
            <div class="form-group">
                <label>通知类型 <span style="color: #dc3545;">*</span></label>
                <div class="radio-group">
                    <label><input type="radio" name="type" value="course" checked onchange="toggleCourseSelect()"> 课程通知</label>
                    <label><input type="radio" name="type" value="system" onchange="toggleCourseSelect()"> 系统公告</label>
                </div>
            </div>

            <div class="form-group" id="courseGroup">
                <label>选择课程 <span style="color: #dc3545;">*</span></label>
                <select name="courseId" id="courseId">
                    <option value="">请选择课程</option>
                    <c:forEach var="course" items="${courseList}">
                        <option value="${course.id}">${course.title}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>优先级</label>
                <div class="radio-group">
                    <label><input type="radio" name="priority" value="normal" checked> 普通</label>
                    <label><input type="radio" name="priority" value="important"> 重要</label>
                    <label><input type="radio" name="priority" value="urgent"> 紧急</label>
                </div>
            </div>

            <div class="form-group">
                <label>通知标题 <span style="color: #dc3545;">*</span></label>
                <input type="text" name="title" id="title" placeholder="请输入通知标题">
            </div>

            <div class="form-group">
                <label>通知内容</label>
                <textarea name="content" id="content" placeholder="请输入通知详细内容..."></textarea>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/notice/list.action" class="btn btn-secondary">取消</a>
                <button type="submit" class="btn btn-primary">发布通知</button>
            </div>
        </form>
    </div>
</div>

<script>
    function toggleCourseSelect() {
        var type = document.querySelector('input[name="type"]:checked').value;
        var courseGroup = document.getElementById('courseGroup');
        courseGroup.style.display = type === 'course' ? 'block' : 'none';
        if (type === 'system') {
            document.getElementById('courseId').value = '';
        }
    }

    document.getElementById('noticeForm').onsubmit = function(e) {
        e.preventDefault();

        var type = document.querySelector('input[name="type"]:checked').value;
        var courseId = document.getElementById('courseId').value;
        var priority = document.querySelector('input[name="priority"]:checked').value;
        var title = document.getElementById('title').value.trim();
        var content = document.getElementById('content').value.trim();

        if (!title) {
            showAlert('请输入通知标题', 'error');
            return;
        }

        if (type === 'course' && !courseId) {
            showAlert('请选择课程', 'error');
            return;
        }

        var formData = 'type=' + type +
            '&courseId=' + (courseId || '') +
            '&priority=' + priority +
            '&title=' + encodeURIComponent(title) +
            '&content=' + encodeURIComponent(content);

        fetch('${pageContext.request.contextPath}/notice/add.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/notice/list.action';
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
