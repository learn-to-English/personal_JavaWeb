<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>通知公告 - 在线学习平台</title>
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

        .main-content {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-header {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-size: 26px;
            color: #333;
        }

        .filter-tabs {
            display: flex;
            gap: 10px;
        }

        .filter-tabs a {
            padding: 8px 20px;
            background: #f0f0f0;
            color: #666;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .filter-tabs a.active,
        .filter-tabs a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .notice-list {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .notice-item {
            padding: 20px 25px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .notice-item:last-child {
            border-bottom: none;
        }

        .notice-item:hover {
            background: #f8f9fa;
        }

        .notice-item.unread {
            background: #f0f7ff;
        }

        .priority-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .priority-urgent {
            background: #ff6b6b;
        }

        .priority-important {
            background: #ffd93d;
        }

        .priority-normal {
            background: #95a5a6;
        }

        .notice-content {
            flex: 1;
        }

        .notice-title {
            font-size: 18px;
            color: #333;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .notice-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            color: #999;
        }

        .type-tag {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
        }

        .type-course {
            background: #e8f4fd;
            color: #667eea;
        }

        .type-system {
            background: #fff3cd;
            color: #856404;
        }

        .unread-badge {
            background: #ff6b6b;
            color: white;
            padding: 3px 8px;
            border-radius: 10px;
            font-size: 12px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state .icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        .btn-publish {
            padding: 10px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <c:if test="${sessionScope.user.role == 'teacher'}">
            <a href="${pageContext.request.contextPath}/notice/toAdd.action">发布通知</a>
        </c:if>
    </div>
</div>

<div class="main-content">
    <div class="page-header">
        <div>
            <h1>📢 通知公告</h1>
            <c:if test="${sessionScope.user.role == 'student'}">
                <div class="filter-tabs" style="margin-top: 15px;">
                    <a href="${pageContext.request.contextPath}/notice/list.action"
                       class="${empty filter ? 'active' : ''}">全部</a>
                    <a href="${pageContext.request.contextPath}/notice/list.action?filter=unread"
                       class="${filter == 'unread' ? 'active' : ''}">未读 <c:if test="${unreadCount > 0}"><span class="unread-badge">${unreadCount}</span></c:if></a>
                    <a href="${pageContext.request.contextPath}/notice/list.action?filter=read"
                       class="${filter == 'read' ? 'active' : ''}">已读</a>
                </div>
            </c:if>
        </div>
        <c:if test="${sessionScope.user.role == 'teacher'}">
            <a href="${pageContext.request.contextPath}/notice/toAdd.action" class="btn-publish">+ 发布通知</a>
        </c:if>
    </div>

    <div class="notice-list">
        <c:choose>
            <c:when test="${not empty noticeList}">
                <c:forEach var="notice" items="${noticeList}">
                    <div class="notice-item ${notice.isRead ? '' : 'unread'}"
                         onclick="location.href='${pageContext.request.contextPath}/notice/detail.action?id=${notice.id}'">
                        <div class="priority-icon
                                <c:choose>
                                    <c:when test='${notice.priority == "urgent"}'>priority-urgent</c:when>
                                    <c:when test='${notice.priority == "important"}'>priority-important</c:when>
                                    <c:otherwise>priority-normal</c:otherwise>
                                </c:choose>">
                        </div>
                        <div class="notice-content">
                            <div class="notice-title">
                                <c:if test="${!notice.isRead}">
                                    <span style="color: #ff6b6b; margin-right: 5px;">●</span>
                                </c:if>
                                    ${notice.title}
                            </div>
                            <div class="notice-meta">
                                    <span class="type-tag ${notice.type == 'system' ? 'type-system' : 'type-course'}">
                                            ${notice.type == 'system' ? '系统公告' : '课程通知'}
                                    </span>
                                <span>👤 ${notice.publisherName}</span>
                                <c:if test="${not empty notice.courseName}">
                                    <span>📚 ${notice.courseName}</span>
                                </c:if>
                                <span>📅 <fmt:formatDate value="${notice.publishTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
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
