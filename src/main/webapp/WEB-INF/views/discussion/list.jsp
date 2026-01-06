<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程讨论区 - 在线学习平台</title>
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
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 - 天空蓝渐变 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
        }

        /* 顶部导航 */
        .header {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 15px rgba(93, 173, 226, 0.4);
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
            padding: 8px 18px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        /* 主内容 */
        .main-content {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px 40px;
        }

        /* 页面标题 */
        .page-header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .page-header h1 {
            font-size: 28px;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        .page-header .course-name {
            font-size: 16px;
            color: var(--text-light);
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
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-new:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        .btn-back {
            color: var(--text-dark);
            text-decoration: none;
            padding: 10px 25px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 25px;
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.8);
        }

        /* 讨论列表 */
        .discussion-list {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .discussion-item {
            padding: 25px 30px;
            border-bottom: 1px solid rgba(93, 173, 226, 0.1);
            transition: all 0.3s;
            cursor: pointer;
        }

        .discussion-item:last-child {
            border-bottom: none;
        }

        .discussion-item:hover {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            transform: translateX(5px);
        }

        .discussion-item .title {
            font-size: 18px;
            color: var(--text-dark);
            margin-bottom: 12px;
            font-weight: 600;
        }

        .discussion-item .meta {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            color: var(--text-light);
        }

        .discussion-item .meta .author {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .discussion-item .meta .replies {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--primary);
            font-weight: 600;
        }

        .role-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 10px;
            font-size: 12px;
            background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
            color: #2E7D32;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-light);
        }

        .empty-state .icon {
            font-size: 60px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .empty-state p {
            font-size: 16px;
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
            color: #51CF66;
            border-left: 4px solid #51CF66;
        }

        .alert-error {
            background: linear-gradient(135deg, #FFE5E5 0%, #FFCCCB 100%);
            color: #FF8787;
            border-left: 4px solid #FF8787;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .main-content {
                padding: 0 15px 30px;
            }

            .page-header {
                padding: 25px 20px;
            }

            .action-bar {
                flex-direction: column;
                gap: 15px;
            }

            .discussion-item {
                padding: 20px;
            }

            .discussion-item .meta {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航 -->
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <a href="${pageContext.request.contextPath}/course/list.action">全部课程</a>
    </div>
</div>

<!-- 主内容 -->
<div class="main-content">
    <!-- 页面标题 -->
    <div class="page-header">
        <h1>课程讨论区</h1>
        <p class="course-name">${course.title}</p>
    </div>

    <!-- 操作栏 -->
    <div class="action-bar">
        <a href="${pageContext.request.contextPath}/discussion/toAdd.action?courseId=${course.id}" class="btn-new">
            + 发布新话题
        </a>
        <a href="${pageContext.request.contextPath}/course/detail.action?id=${course.id}" class="btn-back">
            返回课程
        </a>
    </div>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 讨论列表 -->
    <div class="discussion-list">
        <c:choose>
            <c:when test="${not empty discussionList}">
                <c:forEach var="disc" items="${discussionList}">
                    <div class="discussion-item" onclick="goToDetail(${disc.id})">
                        <div class="title">${disc.title}</div>
                        <div class="meta">
                              <span class="author">
                                  ${disc.username}
                                  <c:if test="${disc.userRole == 'teacher'}">
                                      <span class="role-badge">教师</span>
                                  </c:if>
                              </span>
                            <span class="replies">${disc.replyCount} 回复</span>
                            <span><fmt:formatDate value="${disc.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">o</div>
                    <p>还没有讨论话题，快来发布第一个吧！</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    // 功能1: 跳转到详情页
    function goToDetail(discussionId) {
        var url = '${pageContext.request.contextPath}/discussion/detail.action?id=' + discussionId;
        window.location.href = url;
    }

    // 功能2: 显示提示消息
    function showAlert(message, type) {
        var alertBox = document.getElementById('alertBox');
        alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>