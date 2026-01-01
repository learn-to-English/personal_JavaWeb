<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${notice.title} - 通知详情</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding-bottom: 40px;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 50px;
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .main-content {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .back-link {
            display: inline-block;
            color: #667eea;
            text-decoration: none;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .notice-card {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .notice-header {
            padding-bottom: 25px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 30px;
        }

        .priority-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 13px;
            margin-bottom: 15px;
        }

        .priority-urgent {
            background: #ffe5e5;
            color: #dc3545;
        }

        .priority-important {
            background: #fff3cd;
            color: #856404;
        }

        .priority-normal {
            background: #e8e8e8;
            color: #666;
        }

        .priority-badge::before {
            content: '●';
            margin-right: 5px;
        }

        .priority-urgent::before {
            color: #dc3545;
        }

        .priority-important::before {
            color: #ffc107;
        }

        .priority-normal::before {
            color: #999;
        }

        .notice-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
            line-height: 1.4;
        }

        .notice-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            font-size: 14px;
            color: #999;
        }

        .notice-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .type-tag {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
        }

        .type-course {
            background: #e8f4fd;
            color: #667eea;
        }

        .type-system {
            background: #fff3cd;
            color: #856404;
        }

        .notice-content {
            font-size: 16px;
            color: #555;
            line-height: 2;
            white-space: pre-wrap;
            min-height: 100px;
        }

        .notice-content:empty::before {
            content: "（暂无详细内容）";
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
</div>

<div class="main-content">
    <a href="${pageContext.request.contextPath}/notice/list.action" class="back-link">
        ← 返回通知列表
    </a>

    <div class="notice-card">
        <div class="notice-header">
            <!-- 优先级标识 -->
            <c:choose>
                <c:when test="${notice.priority == 'urgent'}">
                    <span class="priority-badge priority-urgent">紧急通知</span>
                </c:when>
                <c:when test="${notice.priority == 'important'}">
                    <span class="priority-badge priority-important">重要通知</span>
                </c:when>
                <c:otherwise>
                    <span class="priority-badge priority-normal">普通通知</span>
                </c:otherwise>
            </c:choose>

            <!-- 标题 -->
            <h1 class="notice-title">${notice.title}</h1>

            <!-- 元信息 -->
            <div class="notice-meta">
                    <span class="type-tag ${notice.type == 'system' ? 'type-system' : 'type-course'}">
                        ${notice.type == 'system' ? '📣 系统公告' : '📚 课程通知'}
                    </span>
                <span>👤 发布者：${notice.publisherName}</span>
                <c:if test="${not empty notice.courseName}">
                    <span>📖 课程：${notice.courseName}</span>
                </c:if>
                <span>📅 <fmt:formatDate value="${notice.publishTime}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
        </div>

        <!-- 通知内容 -->
        <div class="notice-content">${notice.content}</div>
    </div>
</div>
</body>
</html>
