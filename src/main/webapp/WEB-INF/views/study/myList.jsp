<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的学习 - 在线学习平台</title>
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

        /* 顶部导航栏 */
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

        .header .nav-links {
            display: flex;
            gap: 25px;
        }

        .header .nav-links a {
            color: var(--text-dark);
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover,
        .header .nav-links a.active {
            background: var(--primary-light);
            color: white;
        }

        .header .user-area a {
            color: var(--text-dark);
            text-decoration: none;
            padding: 8px 20px;
            border: 2px solid var(--primary-light);
            border-radius: 20px;
            transition: all 0.3s;
        }

        .header .user-area a:hover {
            background: var(--primary-light);
            color: white;
        }

        /* 页面标题区域 */
        .page-title-section {
            background: rgba(255, 255, 255, 0.7);
            padding: 50px 50px;
            text-align: center;
            backdrop-filter: blur(10px);
            margin: 30px auto;
            max-width: 1200px;
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
        }

        .page-title-section h1 {
            color: var(--text-dark);
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.8);
        }

        .page-title-section p {
            color: var(--text-light);
            font-size: 16px;
        }

        /* 主内容区 */
        .main-content {
            max-width: 1200px;
            margin: 0 auto 40px;
            padding: 0 20px;
        }

        /* 课程网格 */
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        /* 课程卡片 */
        .course-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .course-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(93, 173, 226, 0.3);
        }

        .course-card .cover {
            height: 160px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
        }

        .course-card .info {
            padding: 20px;
        }

        .course-card .enroll-tag {
            display: inline-block;
            padding: 5px 15px;
            background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
            color: #2E7D32;
            border-radius: 15px;
            font-size: 12px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .course-card .enroll-tag.offline {
            background: linear-gradient(135deg, #FFEBEE 0%, #FFCDD2 100%);
            color: #C62828;
        }

        .course-card .enroll-tag.deleted {
            background: linear-gradient(135deg, #ECEFF1 0%, #CFD8DC 100%);
            color: #546E7A;
        }

        .course-card h3 {
            font-size: 18px;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .course-card .desc {
            font-size: 14px;
            color: var(--text-light);
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .course-card .meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 2px solid rgba(93, 173, 226, 0.15);
        }

        .course-card .teacher {
            font-size: 13px;
            color: var(--text-light);
        }

        .course-card .enroll-time {
            font-size: 13px;
            color: var(--primary);
            font-weight: 600;
        }

        .course-card .btn-view {
            display: block;
            text-align: center;
            padding: 12px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            margin-top: 15px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.2);
        }

        .course-card .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.3);
        }

        .course-card .btn-unenroll {
            display: block;
            text-align: center;
            padding: 12px;
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A52 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            margin-top: 10px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(238, 90, 82, 0.2);
            cursor: pointer;
            border: none;
            width: 100%;
            font-size: 14px;
            font-family: var(--font-main);
        }

        .course-card .btn-unenroll:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(238, 90, 82, 0.3);
            background: linear-gradient(135deg, #EE5A52 0%, #DC143C 100%);
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .empty-state p {
            font-size: 18px;
            color: var(--text-light);
            margin-bottom: 20px;
        }

        .empty-state .btn-explore {
            display: inline-block;
            padding: 15px 35px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-size: 16px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .empty-state .btn-explore:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.4);
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
            }

            .page-title-section {
                padding: 30px 20px;
                margin: 20px;
            }

            .page-title-section h1 {
                font-size: 24px;
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

        <!-- 判断用户是否登录 -->
        <c:if test="${not empty sessionScope.user}">
            <!-- 如果是学生，显示"我的学习" -->
            <c:if test="${sessionScope.user.role == 'student'}">
                <a href="${pageContext.request.contextPath}/study/myList.action" class="active">我的学习</a>
            </c:if>

            <!-- 如果是教师或管理员，显示"课程管理" -->
            <c:if test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">
                <a href="${pageContext.request.contextPath}/course/myList.action">课程管理</a>
            </c:if>
        </c:if>
    </div>
    <div class="user-area">
        <!-- 判断用户登录状态 -->
        <c:if test="${not empty sessionScope.user}">
            <!-- 已登录：显示退出登录按钮 -->
            <a href="${pageContext.request.contextPath}/user/logout.action">退出登录</a>
        </c:if>
        <c:if test="${empty sessionScope.user}">
            <!-- 未登录：显示登录按钮 -->
            <a href="${pageContext.request.contextPath}/user/toLogin.action">登录</a>
        </c:if>
    </div>
</div>

<!-- 页面标题区域 -->
<div class="page-title-section">
    <h1>📖 我的学习</h1>
    <p>查看您已报名的所有课程，继续您的学习之旅</p>
</div>

<!-- 主内容 -->
<div class="main-content">
    <!-- 判断是否有课程列表 -->
    <c:if test="${not empty enrollmentList}">
        <!-- 有课程：显示课程网格 -->
        <div class="course-grid">
            <!-- 遍历每个报名记录 -->
            <c:forEach var="enrollment" items="${enrollmentList}">
                <div class="course-card">
                    <div class="cover">📖</div>
                    <div class="info">
                        <!-- 根据课程状态显示不同标签 -->
                        <c:choose>
                            <c:when test="${empty enrollment.courseStatus}">
                                <span class="enroll-tag deleted">课程已删除</span>
                            </c:when>
                            <c:when test="${enrollment.courseStatus == 'draft'}">
                                <span class="enroll-tag offline">课程已下架</span>
                            </c:when>
                            <c:otherwise>
                                <span class="enroll-tag">已报名</span>
                            </c:otherwise>
                        </c:choose>
                        <h3>${not empty enrollment.courseTitle ? enrollment.courseTitle : '(课程已删除)'}</h3>
                        <div class="meta">
                            <span class="teacher">👨‍🏫 ${not empty enrollment.teacherName ? enrollment.teacherName : '未知'}</span>
                            <span class="enroll-time">📅 <fmt:formatDate value="${enrollment.enrollTime}" pattern="yyyy-MM-dd"/></span>
                        </div>
                        <!-- 根据课程状态显示不同按钮 -->
                        <c:choose>
                            <c:when test="${empty enrollment.courseStatus}">
                                <span class="btn-view" style="background: #ccc; cursor: not-allowed;">课程已删除</span>
                            </c:when>
                            <c:when test="${enrollment.courseStatus == 'draft'}">
                                <span class="btn-view" style="background: linear-gradient(135deg, #FFB74D 0%, #FF9800 100%); cursor: not-allowed;">课程暂时下架，请等待重新上架</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/course/detail.action?id=${enrollment.courseId}" class="btn-view">
                                    继续学习
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <button class="btn-unenroll" onclick="unenrollCourse(${enrollment.courseId}, '${not empty enrollment.courseTitle ? enrollment.courseTitle : "已删除的课程"}')">
                            退课
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty enrollmentList}">
        <!-- 没有课程：显示空状态 -->
        <div class="empty-state">
            <div class="icon">📭</div>
            <p>您还没有报名任何课程，快去探索吧~</p>
            <a href="${pageContext.request.contextPath}/course/list.action" class="btn-explore">浏览全部课程</a>
        </div>
    </c:if>
</div>

<script>
    // 退课功能
    function unenrollCourse(courseId, courseTitle) {
        // 显示确认对话框
        if (!confirm('确定要退出《' + courseTitle + '》这门课程吗？\n\n退课后将无法查看课程内容，请谨慎操作。')) {
            return;
        }

        // 发送退课请求
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '${pageContext.request.contextPath}/study/unenroll.action', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        alert('退课成功！');
                        // 刷新页面
                        window.location.reload();
                    } else {
                        alert('退课失败：' + response.message);
                    }
                } catch (e) {
                    alert('退课请求出错，请稍后重试');
                }
            }
        };

        xhr.send('courseId=' + courseId);
    }
</script>
</body>
</html>
