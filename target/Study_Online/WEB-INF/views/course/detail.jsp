<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${course.title} - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
        }

        /* 顶部导航 */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .header .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
        }

        /* 课程头部 */
        .course-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 50px;
        }

        .course-header .container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            gap: 40px;
        }

        .course-header .cover {
            width: 300px;
            height: 200px;
            background: rgba(255,255,255,0.1);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 80px;
        }

        .course-header .info {
            flex: 1;
        }

        .course-header .category {
            display: inline-block;
            padding: 5px 15px;
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .course-header h1 {
            font-size: 32px;
            margin-bottom: 15px;
        }

        .course-header .desc {
            font-size: 16px;
            line-height: 1.8;
            opacity: 0.9;
            margin-bottom: 20px;
        }

        .course-header .meta {
            display: flex;
            gap: 30px;
            font-size: 14px;
            opacity: 0.8;
        }

        /* 操作按钮区 */
        .action-bar {
            background: white;
            padding: 20px 50px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .action-bar .container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .action-bar .btn-back {
            color: #666;
            text-decoration: none;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
        }

        .btn-action {
            padding: 15px 40px;
            border: none;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-chapters {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(40,167,69,0.3);
        }

        .btn-chapters:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(40,167,69,0.4);
        }

        .btn-enroll {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(255,107,107,0.3);
        }

        .btn-enroll:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(255,107,107,0.4);
        }

        /* 主内容 */
        .main-content {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
            display: flex;
            gap: 30px;
        }

        .content-left {
            flex: 2;
        }

        .content-right {
            flex: 1;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .card h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #667eea;
        }

        .card p {
            font-size: 15px;
            color: #666;
            line-height: 1.8;
        }

        /* 教师信息 */
        .teacher-card {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .teacher-card .avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            color: white;
        }

        .teacher-card .name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .teacher-card .role {
            font-size: 14px;
            color: #999;
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }

        /* 作业列表样式 */
        .assignment-list {
            list-style: none;
        }

        .assignment-item {
            padding: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }

        .assignment-item:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }

        .assignment-item .title {
            font-size: 16px;
            color: #333;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .assignment-item .meta {
            font-size: 13px;
            color: #999;
            margin-bottom: 10px;
        }

        .assignment-item .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .assignment-item .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
        }

        .status-not-submitted { background: #fff3cd; color: #856404; }
        .status-submitted { background: #cfe2ff; color: #084298; }
        .status-graded { background: #d4edda; color: #155724; }

        .assignment-item .btn-submit {
            padding: 6px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 15px;
            font-size: 13px;
        }

        .empty-assignments {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .empty-assignments .icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        /* 按钮容器 */
        .action-buttons {
            display: flex;
            gap: 15px;
        }

        /* 讨论区按钮 */
        .btn-discussion {
            padding: 15px 40px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            transition: transform 0.3s;
        }

        .btn-discussion:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <!-- 顶部导航 -->
    <div class="header">
        <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home.action">首页</a>
            <a href="${pageContext.request.contextPath}/course/list.action">全部课程</a>
        </div>
    </div>

    <!-- 课程头部 -->
    <div class="course-header">
        <div class="container">
            <div class="cover">📖</div>
            <div class="info">
                <c:if test="${not empty course.categoryName}">
                    <span class="category">${course.categoryName}</span>
                </c:if>
                <h1>${course.title}</h1>
                <p class="desc">${course.description}</p>
                <div class="meta">
                    <span>👨‍🏫 讲师：${course.teacherName}</span>
                    <span>👥 ${course.studentCount} 人学习</span>
                </div>
            </div>
        </div>
    </div>

    <!-- 操作按钮区 -->
    <div class="action-bar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/course/list.action" class="btn-back">← 返回课程列表</a>
            <div class="action-buttons">
                <!-- 查看章节按钮 - 所有人都能看到 -->
                <a href="${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}" class="btn-action btn-chapters">
                    📖 查看章节
                </a>
                
                <!-- 选课按钮 - 仅学生能看到 -->
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/user/toLogin.action" class="btn-action btn-enroll">登录后选课</a>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'student'}">
                        <button class="btn-action btn-enroll" onclick="enrollCourse(${course.id})">立即选课</button>
                    </c:when>
                </c:choose>

                <!-- 新增：讨论区按钮 -->
                <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}"
                   class="btn-discussion">
                    💬 课程讨论
                </a>

            </div>
        </div>
    </div>

    <!-- 主内容 -->
    <div class="main-content">
        <div class="content-left">
            <!-- 提示消息 -->
            <div id="alertBox"></div>
            
            <!-- 课程介绍 -->
            <div class="card">
                <h2>📝 课程介绍</h2>
                <p>${course.description}</p>
            </div>
        </div>

        <div class="content-right">
            <!-- 讲师信息 -->
            <div class="card">
                <h2>👨‍🏫 授课教师</h2>
                <div class="teacher-card">
                    <div class="avatar">👤</div>
                    <div>
                        <div class="name">${course.teacherName}</div>
                        <div class="role">讲师</div>
                    </div>
                </div>
            </div>

            <!-- 课程统计 -->
            <div class="card">
                <h2>📊 课程信息</h2>
                <p>👥 学习人数：${course.studentCount} 人</p>
            </div>
        </div>
    </div>

    <!-- 课程作业模块 -->
    <div class="card">
        <h2>📋 课程作业</h2>
        <c:choose>
            <c:when test="${not empty assignmentList}">
                <ul class="assignment-list">
                    <c:forEach var="assignment" items="${assignmentList}">
                        <li class="assignment-item">
                            <div class="title">📝 ${assignment.title}</div>
                            <div class="meta">
                                截止时间：<fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/> |
                                满分：${assignment.totalScore}分
                            </div>
                            <div class="actions">
                                <c:choose>
                                    <c:when test="${assignment.submitRate == 2.0}">
                                        <span class="status-badge status-graded">✅ 已批改</span>
                                        <a href="${pageContext.request.contextPath}/submission/viewGrade.action?id=${assignment.id}" class="btn-submit">查看成绩</a>
                                    </c:when>
                                    <c:when test="${assignment.submitRate == 1.0}">
                                        <span class="status-badge status-submitted">📤 已提交</span>
                                        <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn-submit">查看详情</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-not-submitted">⏰ 未提交</span>
                                        <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn-submit">去提交</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="empty-assignments">
                    <div class="icon">📭</div>
                    <p>该课程暂无作业</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // 选课功能（仅学生）
        function enrollCourse(courseId) {
            if (confirm('确定要选修这门课程吗？')) {
                fetch('${pageContext.request.contextPath}/study/enroll.action?courseId=' + courseId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    showAlert(data.message, data.success ? 'success' : 'error');
                    if (data.success) {
                        setTimeout(function() {
                            location.reload();
                        }, 2000);
                    }
                })
                .catch(error => {
                    showAlert('请求失败，请重试', 'error');
                });
            }
        }

        // 显示提示消息
        function showAlert(message, type) {
            var alertBox = document.getElementById('alertBox');
            alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
        }
    </script>
</body>
</html>
