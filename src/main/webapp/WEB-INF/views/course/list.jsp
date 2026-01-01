<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>全部课程 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .header .nav-links {
            display: flex;
            gap: 25px;
        }

        .header .nav-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            transition: background 0.3s;
        }

        .header .nav-links a:hover,
        .header .nav-links a.active {
            background: rgba(255,255,255,0.2);
        }

        .header .user-area a {
            color: white;
            text-decoration: none;
            padding: 8px 20px;
            border: 1px solid rgba(255,255,255,0.5);
            border-radius: 20px;
        }

        /* 搜索区域 */
        .search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 50px 80px;
            text-align: center;
        }

        .search-section h1 {
            color: white;
            font-size: 32px;
            margin-bottom: 25px;
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
            border: none;
            border-radius: 30px;
            font-size: 16px;
            outline: none;
        }

        .search-box button {
            padding: 15px 35px;
            background: #ff6b6b;
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .search-box button:hover {
            transform: scale(1.05);
        }

        /* 主内容区 */
        .main-content {
            max-width: 1200px;
            margin: -40px auto 40px;
            padding: 0 20px;
        }

        /* 课程网格 */
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .course-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .course-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .course-card .cover {
            height: 160px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            padding: 4px 12px;
            background: #e8f4fd;
            color: #667eea;
            border-radius: 15px;
            font-size: 12px;
            margin-bottom: 10px;
        }

        .course-card h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }

        .course-card .desc {
            font-size: 14px;
            color: #666;
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
            border-top: 1px solid #eee;
        }

        .course-card .teacher {
            font-size: 13px;
            color: #999;
        }

        .course-card .students {
            font-size: 13px;
            color: #667eea;
        }

        .course-card .btn-view {
            display: block;
            text-align: center;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin-top: 15px;
            transition: opacity 0.3s;
        }

        .course-card .btn-view:hover {
            opacity: 0.9;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .empty-state p {
            font-size: 18px;
            color: #666;
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
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/study/myList.action">我的学习</a>
                <c:if test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">
                    <a href="${pageContext.request.contextPath}/course/myList.action">课程管理</a>
                </c:if>
            </c:if>
        </div>
        <div class="user-area">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/user/logout.action">退出登录</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/toLogin.action">登录</a>
                </c:otherwise>
            </c:choose>
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
        <c:choose>
            <c:when test="${not empty courseList}">
                <div class="course-grid">
                    <c:forEach var="course" items="${courseList}">
                        <div class="course-card">
                            <div class="cover">📖</div>
                            <div class="info">
                                <c:if test="${not empty course.categoryName}">
                                    <span class="category-tag">${course.categoryName}</span>
                                </c:if>
                                <h3>${course.title}</h3>
                                <p class="desc">${course.description}</p>
                                <div class="meta">
                                    <span class="teacher">👨‍🏫 ${course.teacherName}</span>
                                    <span class="students">👥 ${course.studentCount}人学习</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/course/detail.action?id=${course.id}" class="btn-view">查看课程</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>暂无课程，敬请期待~</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
