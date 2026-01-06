<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${notice.title} - 通知详情</title>
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
            padding-bottom: 40px;
        }

        /* 顶部导航栏 */
        .header {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            padding: 20px 50px;
            box-shadow: 0 5px 20px rgba(93, 173, 226, 0.3);
        }

        .header .logo {
            font-size: 26px;
            font-weight: bold;
            text-decoration: none;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        /* 主内容区域 */
        .main-content {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 返回链接 */
        .back-link {
            display: inline-block;
            color: var(--text-dark);
            text-decoration: none;
            margin-bottom: 25px;
            font-size: 15px;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 25px;
            transition: all 0.3s;
            font-weight: 600;
        }

        .back-link:hover {
            background: white;
            transform: translateX(-5px);
        }

        /* 通知卡片 */
        .notice-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 45px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
        }

        /* 通知头部 */
        .notice-header {
            padding-bottom: 30px;
            border-bottom: 3px solid rgba(93, 173, 226, 0.2);
            margin-bottom: 35px;
        }

        /* 优先级徽章 */
        .priority-badge {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .priority-urgent {
            background: linear-gradient(135deg, #FFE5E5 0%, #FFCCCB 100%);
            color: var(--danger);
        }

        .priority-important {
            background: linear-gradient(135deg, #FFF9E5 0%, #FFE082 100%);
            color: #F57C00;
        }

        .priority-normal {
            background: linear-gradient(135deg, #F0F0F0 0%, #E0E0E0 100%);
            color: var(--text-light);
        }

        .priority-badge::before {
            content: '●';
            margin-right: 8px;
        }

        /* 通知标题 */
        .notice-title {
            font-size: 30px;
            color: var(--text-dark);
            margin-bottom: 25px;
            line-height: 1.5;
            font-weight: 700;
        }

        /* 元信息 */
        .notice-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            font-size: 15px;
            color: var(--text-light);
        }

        .notice-meta span {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* 类型标签 */
        .type-tag {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 15px;
            font-size: 14px;
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

        /* 通知内容 */
        .notice-content {
            font-size: 17px;
            color: var(--text-dark);
            line-height: 2;
            white-space: pre-wrap;
            min-height: 120px;
            padding: 20px;
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            border-radius: 15px;
            border-left: 4px solid var(--primary);
        }

        /* 如果内容为空显示提示 */
        .notice-content:empty::before {
            content: "（暂无详细内容）";
            color: var(--text-light);
            font-style: italic;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 25px;
            }

            .main-content {
                padding: 0 15px;
            }

            .notice-card {
                padding: 30px 25px;
            }

            .notice-title {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <!-- 返回链接 -->
    <a href="${pageContext.request.contextPath}/notice/list.action" class="back-link">
        ← 返回通知列表
    </a>

    <!-- 通知卡片 -->
    <div class="notice-card">
        <!-- 通知头部 -->
        <div class="notice-header">
            <%-- 优先级徽章 --%>
            <c:choose>
                <c:when test="${notice.priority == 'urgent'}">
                    <span class="priority-badge priority-urgent">! 紧急通知</span>
                </c:when>
                <c:when test="${notice.priority == 'important'}">
                    <span class="priority-badge priority-important">★ 重要通知</span>
                </c:when>
                <c:otherwise>
                    <span class="priority-badge priority-normal">● 普通通知</span>
                </c:otherwise>
            </c:choose>

            <!-- 通知标题 -->
            <h1 class="notice-title">${notice.title}</h1>

            <!-- 元信息 -->
            <div class="notice-meta">
                <%-- 类型标签 --%>
                <span class="type-tag ${notice.type == 'system' ? 'type-system' : 'type-course'}">
                    ${notice.type == 'system' ? '系统公告' : '课程通知'}
                </span>
                <span>👤 发布者：${notice.publisherName}</span>
                <%-- 判断：如果有课程名称就显示 --%>
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