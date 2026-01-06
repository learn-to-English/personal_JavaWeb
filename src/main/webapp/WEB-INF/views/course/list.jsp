
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>全部课程 - 在线学习平台</title>
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

        /* 搜索区域 */
        .search-section {
            background: rgba(255, 255, 255, 0.7);
            padding: 50px 50px;
            text-align: center;
            backdrop-filter: blur(10px);
            margin: 30px auto;
            max-width: 1200px;
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
        }

        .search-section h1 {
            color: var(--text-dark);
            font-size: 32px;
            margin-bottom: 25px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.8);
        }

        .search-box {
            max-width: 600px;
            margin: 0 auto;
            display: flex;
            gap: 10px;
        }

        .search-box input {
            flex: 1;
            padding: 15px 25px;
            border: 2px solid var(--primary-light);
            border-radius: 30px;
            font-size: 16px;
            outline: none;
            transition: all 0.3s;
        }

        .search-box input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
        }

        .search-box button {
            padding: 15px 35px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .search-box button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.4);
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

        .course-card .category-tag {
            display: inline-block;
            padding: 5px 15px;
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            color: var(--primary-dark);
            border-radius: 15px;
            font-size: 12px;
            margin-bottom: 10px;
            font-weight: 600;
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
            height: 44px;
            overflow: hidden;
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

        .course-card .students {
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
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
            }

            .search-section {
                padding: 30px 20px;
                margin: 20px;
            }

            .search-section h1 {
                font-size: 24px;
            }

            .search-box {
                flex-direction: column;
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
        <a href="${pageContext.request.contextPath}/course/list.action" class="active">全部课程</a>

        <!-- 判断用户是否登录 -->
        <c:if test="${not empty sessionScope.user}">
            <!-- 如果是学生，显示"我的学习" -->
            <c:if test="${sessionScope.user.role == 'student'}">
                <a href="${pageContext.request.contextPath}/study/myList.action">我的学习</a>
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

<!-- 搜索区域 -->
<div class="search-section">
    <h1>🔍 发现优质课程</h1>
    <form class="search-box" action="${pageContext.request.contextPath}/course/list.action" method="get">
        <input type="text" name="keyword" placeholder="搜索你想学习的课程..." value="${keyword}">
        <button type="submit">搜索</button>
    </form>
</div>

<!-- 主内容 -->
<div class="main-content">
    <!-- 判断是否有课程列表 -->
    <c:if test="${not empty courseList}">
        <!-- 有课程：显示课程网格 -->
        <div class="course-grid">
            <!-- 遍历每个课程 -->
            <c:forEach var="course" items="${courseList}">
                <div class="course-card">
                    <div class="cover">📖</div>
                    <div class="info">
                        <!-- 判断是否有分类信息 -->
                        <c:if test="${not empty course.categoryName}">
                            <span class="category-tag">${course.categoryName}</span>
                        </c:if>
                        <h3>${course.title}</h3>
                        <p class="desc">${course.description}</p>
                        <div class="meta">
                            <span class="teacher">👨‍🏫 ${course.teacherName}</span>
                            <span class="students">👥 ${course.studentCount}人学习</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/course/detail.action?id=${course.id}" class="btn-view">
                            查看课程
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty courseList}">
        <!-- 没有课程：显示空状态 -->
        <div class="empty-state">
            <div class="icon">📭</div>
            <p>暂无课程，敬请期待~</p>
        </div>
    </c:if>
</div>
</body>
</html>