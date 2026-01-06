<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} - 在线学习平台</title>
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
            --secondary: #FFD93D;
            --success: #51CF66;
            --error: #FF8787;
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 - 天空蓝渐变背景 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
        }

        /* 顶部导航 */
        .header {
            background: rgba(255, 255, 255, 0.95);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: var(--primary-dark);
        }

        .header .nav-links a {
            color: var(--text-dark);
            text-decoration: none;
            margin-left: 25px;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: var(--primary-light);
            color: white;
        }

        /* 课程头部 */
        .course-header {
            background: rgba(255, 255, 255, 0.8);
            padding: 50px;
            margin: 30px auto;
            max-width: 1200px;
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .course-header .container {
            display: flex;
            gap: 40px;
            align-items: center;
        }

        .course-header .cover {
            width: 300px;
            height: 200px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 80px;
            box-shadow: 0 10px 25px rgba(93, 173, 226, 0.3);
        }

        .course-header .info {
            flex: 1;
        }

        .course-header .category {
            display: inline-block;
            padding: 6px 18px;
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 15px;
            color: var(--primary-dark);
            font-weight: 600;
        }

        .course-header h1 {
            font-size: 32px;
            margin-bottom: 15px;
            color: var(--text-dark);
        }

        .course-header .desc {
            font-size: 16px;
            line-height: 1.8;
            color: var(--text-light);
            margin-bottom: 20px;
        }

        .course-header .meta {
            display: flex;
            gap: 30px;
            font-size: 14px;
            color: var(--text-light);
        }

        /* 操作按钮区 */
        .action-bar {
            background: rgba(255, 255, 255, 0.95);
            padding: 20px 50px;
            box-shadow: 0 2px 10px rgba(93, 173, 226, 0.15);
            backdrop-filter: blur(10px);
        }

        .action-bar .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .action-bar .btn-back {
            color: var(--text-dark);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .action-bar .btn-back:hover {
            background: var(--primary-light);
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
        }

        .btn-action {
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
            font-weight: 600;
        }

        .btn-chapters {
            background: linear-gradient(135deg, #51CF66 0%, #37B24D 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(81, 207, 102, 0.3);
        }

        .btn-chapters:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(81, 207, 102, 0.4);
        }

        .btn-enroll {
            background: linear-gradient(135deg, var(--secondary) 0%, #FFC107 100%);
            color: var(--text-dark);
            box-shadow: 0 5px 15px rgba(255, 217, 61, 0.3);
        }

        .btn-enroll:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 217, 61, 0.4);
        }

        .btn-discussion {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-discussion:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.4);
        }

        /* 主内容 */
        .main-content {
            max-width: 1200px;
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
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .card h2 {
            font-size: 20px;
            color: var(--text-dark);
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-light);
        }

        .card p {
            font-size: 15px;
            color: var(--text-light);
            line-height: 1.8;
        }

        /* 教师信息 */
        .teacher-card {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .teacher-card .avatar {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 35px;
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.3);
        }

        .teacher-card .name {
            font-size: 18px;
            font-weight: bold;
            color: var(--text-dark);
        }

        .teacher-card .role {
            font-size: 14px;
            color: var(--text-light);
            margin-top: 5px;
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
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

        /* 作业列表 */
        .assignment-list {
            list-style: none;
        }

        .assignment-item {
            padding: 20px;
            border: 2px solid rgba(93, 173, 226, 0.2);
            border-radius: 15px;
            margin-bottom: 15px;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.5);
        }

        .assignment-item:hover {
            border-color: var(--primary);
            background: rgba(255, 255, 255, 0.9);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.2);
        }

        .assignment-item .title {
            font-size: 16px;
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 10px;
        }

        .assignment-item .meta {
            font-size: 13px;
            color: var(--text-light);
            margin-bottom: 12px;
        }

        .assignment-item .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .assignment-item .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-not-submitted {
            background: linear-gradient(135deg, #FFF3CD 0%, #FFE69C 100%);
            color: #856404;
        }

        .status-submitted {
            background: linear-gradient(135deg, #CFE2FF 0%, #B6D4FE 100%);
            color: #084298;
        }

        .status-graded {
            background: linear-gradient(135deg, #D4EDDA 0%, #C3E6CB 100%);
            color: #155724;
        }

        .assignment-item .btn-submit {
            padding: 6px 20px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 15px;
            font-size: 13px;
            transition: all 0.3s;
        }

        .assignment-item .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .empty-assignments {
            text-align: center;
            padding: 40px;
            color: var(--text-light);
        }

        .empty-assignments .icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .course-header .container {
                flex-direction: column;
            }

            .course-header .cover {
                width: 100%;
            }

            .main-content {
                flex-direction: column;
            }

            .action-buttons {
                flex-wrap: wrap;
            }
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
            <!-- 判断是否有分类信息 -->
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
            <!-- 判断用户是否登录 -->
            <c:if test="${empty sessionScope.user}">
                <!-- 未登录：显示登录后选课 -->
                <a href="${pageContext.request.contextPath}/user/toLogin.action" class="btn-action btn-enroll">登录后选课</a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <!-- 已登录：判断是否是学生 -->
                <c:if test="${sessionScope.user.role == 'student'}">
                    <button class="btn-action btn-enroll" onclick="enrollCourse(${course.id})">立即选课</button>
                </c:if>
            </c:if>

            <!-- 讨论区按钮 -->
            <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}" class="btn-action btn-discussion">
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

        <!-- 课程作业模块 -->
        <div class="card">
            <h2>📋 课程作业</h2>
            <!-- 判断是否有作业列表 -->
            <c:if test="${not empty assignmentList}">
                <ul class="assignment-list">
                    <!-- 遍历每个作业 -->
                    <c:forEach var="assignment" items="${assignmentList}">
                        <li class="assignment-item">
                            <div class="title">📝 ${assignment.title}</div>
                            <div class="meta">
                                截止时间：<fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/> |
                                满分：${assignment.totalScore}分
                            </div>
                            <div class="actions">
                                <%-- 根据用户角色显示不同的内容 --%>
                                <c:choose>
                                    <%-- 如果是教师或管理员 --%>
                                    <c:when test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">
                                        <%-- 教师查看作业详情和批改 --%>
                                        <a href="${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}" class="btn-submit">查看提交</a>
                                    </c:when>
                                    <%-- 如果是学生 --%>
                                    <c:otherwise>
                                        <%-- 判断作业提交状态 --%>
                                        <%-- 如果 submitRate == 2.0，表示已批改 --%>
                                        <c:if test="${assignment.submitRate == 2.0}">
                                            <span class="status-badge status-graded">✅ 已批改</span>
                                            <a href="${pageContext.request.contextPath}/submission/viewGrade.action?id=${assignment.id}" class="btn-submit">查看成绩</a>
                                        </c:if>
                                        <%-- 如果 submitRate == 1.0，表示已提交 --%>
                                        <c:if test="${assignment.submitRate == 1.0}">
                                            <span class="status-badge status-submitted">📤 已提交</span>
                                            <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn-submit">查看详情</a>
                                        </c:if>
                                        <%-- 否则表示未提交 --%>
                                        <c:if test="${assignment.submitRate != 1.0 && assignment.submitRate != 2.0}">
                                            <span class="status-badge status-not-submitted">⏰ 未提交</span>
                                            <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn-submit">去提交</a>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>

            <c:if test="${empty assignmentList}">
                <!-- 没有作业：显示空状态 -->
                <div class="empty-assignments">
                    <div class="icon">📭</div>
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">
                            <p>该课程暂无作业，<a href="${pageContext.request.contextPath}/assignment/toAdd.action?courseId=${course.id}">去发布作业</a></p>
                        </c:when>
                        <c:otherwise>
                            <p>该课程暂无作业</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
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

<script>
    // 选课功能（仅学生可用）
    function enrollCourse(courseId) {
        // 弹出确认框
        if (confirm('确定要选修这门课程吗？')) {
            // 发送选课请求
            fetch('${pageContext.request.contextPath}/study/enroll.action?courseId=' + courseId, {
                method: 'POST'
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    // 判断请求是否成功
                    if (data.success) {
                        showAlert(data.message, 'success');
                        // 2秒后刷新页面
                        setTimeout(function() {
                            location.reload();
                        }, 2000);
                    } else {
                        showAlert(data.message, 'error');
                    }
                })
                .catch(function(error) {
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