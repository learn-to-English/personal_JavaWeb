<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${course.title} - 课程讨论区</title>
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
            padding: 8px 16px;
            border-radius: 20px;
        }

        .header .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }

        /* 主内容 */
        .main-content {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* 页面标题 */
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .page-header h1 {
            font-size: 26px;
            color: #333;
            margin-bottom: 10px;
        }

        .page-header .course-name {
            font-size: 16px;
            color: #666;
        }

        /* 操作栏 */
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .btn-new {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            transition: transform 0.3s;
        }

        .btn-new:hover {
            transform: scale(1.05);
        }

        .btn-back {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
        }

        /* 讨论列表 */
        .discussion-list {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .discussion-item {
            padding: 20px 25px;
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.3s;
            cursor: pointer;
        }

        .discussion-item:last-child {
            border-bottom: none;
        }

        .discussion-item:hover {
            background: #f8f9fa;
        }

        .discussion-item .title {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .discussion-item .title .icon {
            font-size: 20px;
        }

        .discussion-item .meta {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            color: #999;
        }

        .discussion-item .meta .author {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .discussion-item .meta .replies {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #667eea;
        }

        .role-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 12px;
            background: #d4edda;
            color: #28a745;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state .icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        .empty-state p {
            font-size: 16px;
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
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

<!-- 主内容 -->
<div class="main-content">
    <!-- 页面标题 -->
    <div class="page-header">
        <h1>💬 课程讨论区</h1>
        <p class="course-name">${course.title}</p>
    </div>

    <!-- 操作栏 -->
    <div class="action-bar">
        <a href="${pageContext.request.contextPath}/discussion/toAdd.action?courseId=${course.id}" class="btn-new">
            + 发布新话题
        </a>
        <a href="${pageContext.request.contextPath}/course/detail.action?id=${course.id}" class="btn-back">
            ← 返回课程
        </a>
    </div>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 讨论列表 -->
    <div class="discussion-list">
        <c:choose>
            <c:when test="${not empty discussionList}">
                <c:forEach var="disc" items="${discussionList}">
                    <div class="discussion-item" onclick="location.href='${pageContext.request.contextPath}/discussion/detail.action?id=${disc.id}'">
                        <div class="title">
                            <span class="icon">📌</span>
                            <span>${disc.title}</span>
                        </div>
                        <div class="meta">
                                <span class="author">
                                    👤 ${disc.username}
                                    <c:if test="${disc.userRole == 'teacher'}">
                                        <span class="role-badge">教师</span>
                                    </c:if>
                                </span>
                            <span class="replies">💬 ${disc.replyCount} 回复</span>
                            <span>📅 <fmt:formatDate value="${disc.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">💭</div>
                    <p>还没有讨论话题，快来发布第一个吧！</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>
