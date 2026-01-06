
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>通知公告 - 在线学习平台</title>
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
            --danger: #FF6B6B;
            --warning: #FFC107;
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 - 天空蓝渐变背景 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
            padding: 0;
        }

        /* 顶部导航栏 */
        .header {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(93, 173, 226, 0.3);
        }

        .header .logo {
            font-size: 26px;
            font-weight: bold;
            text-decoration: none;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .header .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
            padding: 10px 20px;
            border-radius: 25px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }

        /* 主内容区域 */
        .main-content {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 页面头部 */
        .page-header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-size: 28px;
            color: var(--text-dark);
        }

        /* 筛选标签 */
        .filter-tabs {
            display: flex;
            gap: 12px;
            margin-top: 18px;
        }

        .filter-tabs a {
            padding: 8px 20px;
            background: rgba(255, 255, 255, 0.6);
            color: var(--text-light);
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s;
            font-weight: 600;
            border: 2px solid transparent;
        }

        .filter-tabs a.active,
        .filter-tabs a:hover {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        /* 未读徽章 */
        .unread-badge {
            background: var(--danger);
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 12px;
            margin-left: 5px;
        }

        /* 发布按钮 */
        .btn-publish {
            padding: 12px 30px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-publish:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        /* 通知列表容器 */
        .notice-list {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
        }

        /* 通知项 */
        .notice-item {
            padding: 25px 30px;
            border-bottom: 1px solid rgba(93, 173, 226, 0.1);
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .notice-item:last-child {
            border-bottom: none;
        }

        .notice-item:hover {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            transform: translateX(5px);
        }

        /* 未读通知背景 */
        .notice-item.unread {
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 50%);
        }

        .notice-item.unread:hover {
            background: linear-gradient(135deg, #BBDEFB 0%, #90CAF9 50%);
        }

        /* 优先级图标 */
        .priority-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: bold;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            color: white;
        }

        .priority-urgent {
            background: linear-gradient(135deg, #FF8A80 0%, var(--danger) 100%);
        }

        .priority-important {
            background: linear-gradient(135deg, #FFD54F 0%, var(--warning) 100%);
        }

        .priority-normal {
            background: linear-gradient(135deg, #B0BEC5 0%, #90A4AE 100%);
        }

        /* 通知内容 */
        .notice-content {
            flex: 1;
        }

        .notice-title {
            font-size: 18px;
            color: var(--text-dark);
            margin-bottom: 10px;
            font-weight: 600;
        }

        .notice-meta {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            font-size: 14px;
            color: var(--text-light);
        }

        /* 类型标签 */
        .type-tag {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 15px;
            font-size: 13px;
            font-weight: 600;
        }

        .type-course {
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            color: var(--primary-dark);
        }

        .type-system {
            background: linear-gradient(135deg, #FFF9E5 0%, #FFE082 100%);
            color: #F57C00;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 100px 20px;
        }

        .empty-state .icon {
            font-size: 100px;
            margin-bottom: 25px;
            opacity: 0.8;
        }

        .empty-state p {
            font-size: 18px;
            color: var(--text-light);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 25px;
            }

            .main-content {
                padding: 0 15px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .notice-item {
                padding: 20px;
            }

            .notice-meta {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <%-- 判断：如果是教师，显示发布通知链接 --%>
        <c:if test="${sessionScope.user.role == 'teacher'}">
            <a href="${pageContext.request.contextPath}/notice/toAdd.action">发布通知</a>
        </c:if>
    </div>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <!-- 页面头部 -->
    <div class="page-header">
        <div>
            <h1>📢 通知公告</h1>
            <%-- 判断：如果是学生，显示筛选标签 --%>
            <c:if test="${sessionScope.user.role == 'student'}">
                <div class="filter-tabs">
                    <a href="${pageContext.request.contextPath}/notice/list.action"
                       class="${empty filter ? 'active' : ''}">全部</a>
                    <a href="${pageContext.request.contextPath}/notice/list.action?filter=unread"
                       class="${filter == 'unread' ? 'active' : ''}">
                        未读
                            <%-- 判断：如果有未读通知，显示数字徽章 --%>
                        <c:if test="${unreadCount > 0}">
                            <span class="unread-badge">${unreadCount}</span>
                        </c:if>
                    </a>
                    <a href="${pageContext.request.contextPath}/notice/list.action?filter=read"
                       class="${filter == 'read' ? 'active' : ''}">已读</a>
                </div>
            </c:if>
        </div>
        <%-- 判断：如果是教师，显示发布按钮 --%>
        <c:if test="${sessionScope.user.role == 'teacher'}">
            <a href="${pageContext.request.contextPath}/notice/toAdd.action" class="btn-publish">+ 发布通知</a>
        </c:if>
    </div>

    <!-- 通知列表 -->
    <div class="notice-list">
        <%-- 判断：是否有通知数据 --%>
        <c:choose>
            <%-- 情况1：有通知 --%>
            <c:when test="${not empty noticeList}">
                <%-- 循环显示每条通知 --%>
                <c:forEach var="notice" items="${noticeList}">
                    <%-- 通知项，点击跳转到详情，根据isRead判断是否添加unread类 --%>
                    <div class="notice-item ${notice.isRead ? '' : 'unread'}"
                         onclick="location.href='${pageContext.request.contextPath}/notice/detail.action?id=${notice.id}'">

                            <%-- 优先级图标 --%>
                        <div class="priority-icon
                              <c:choose>
                                  <c:when test='${notice.priority == "urgent"}'>priority-urgent</c:when>
                                  <c:when test='${notice.priority == "important"}'>priority-important</c:when>
                                  <c:otherwise>priority-normal</c:otherwise>
                              </c:choose>">
                                <%-- 根据优先级显示不同符号 --%>
                            <c:choose>
                                <c:when test='${notice.priority == "urgent"}'>!</c:when>
                                <c:when test='${notice.priority == "important"}'>★</c:when>
                                <c:otherwise>●</c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 通知内容 -->
                        <div class="notice-content">
                            <div class="notice-title">
                                    <%-- 判断：如果未读，显示红点 --%>
                                <c:if test="${!notice.isRead}">
                                    <span style="color: #FF6B6B; margin-right: 5px;">●</span>
                                </c:if>
                                    ${notice.title}
                            </div>
                            <div class="notice-meta">
                                    <%-- 类型标签：系统公告或课程通知 --%>
                                <span class="type-tag ${notice.type == 'system' ? 'type-system' : 'type-course'}">
                                        ${notice.type == 'system' ? '系统公告' : '课程通知'}
                                </span>
                                <span>👤 ${notice.publisherName}</span>
                                    <%-- 判断：如果有课程名称就显示 --%>
                                <c:if test="${not empty notice.courseName}">
                                    <span>📚 ${notice.courseName}</span>
                                </c:if>
                                <span>📅 <fmt:formatDate value="${notice.publishTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <%-- 情况2：没有通知 --%>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>暂无通知</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>