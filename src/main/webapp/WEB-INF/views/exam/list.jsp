<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>在线考试 - 在线学习平台</title>
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
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .main-content {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 25px;
        }

        .exam-grid {
            display: grid;
            gap: 20px;
        }

        .exam-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s;
        }

        .exam-card:hover {
            transform: translateY(-5px);
        }

        .exam-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }

        .exam-title {
            font-size: 22px;
            color: #333;
            margin-bottom: 8px;
        }

        .exam-status {
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 13px;
        }

        .status-open {
            background: #d4edda;
            color: #155724;
        }

        .exam-info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .info-item {
            font-size: 14px;
            color: #666;
        }

        .info-item .label {
            color: #999;
            margin-bottom: 5px;
        }

        .info-item .value {
            color: #333;
            font-weight: 500;
        }

        .exam-desc {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .btn-start {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            transition: transform 0.3s;
        }

        .btn-start:hover {
            transform: scale(1.05);
        }

        .btn-disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
        }

        .empty-state .icon {
            font-size: 60px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
</div>

<div class="main-content">
    <h1 class="page-title">📝 在线考试</h1>

    <div class="exam-grid">
        <c:choose>
            <c:when test="${not empty examList}">
                <c:forEach var="exam" items="${examList}">
                    <div class="exam-card">
                        <div class="exam-header">
                            <div>
                                <h2 class="exam-title">${exam.title}</h2>
                                <div style="color: #999; font-size: 14px;">
                                    📚 ${exam.courseName} · 👨‍🏫 ${exam.teacherName}
                                </div>
                            </div>
                            <span class="exam-status status-open">进行中</span>
                        </div>

                        <div class="exam-info">
                            <div class="info-item">
                                <div class="label">⏱️ 考试时长</div>
                                <div class="value">${exam.duration} 分钟</div>
                            </div>
                            <div class="info-item">
                                <div class="label">💯 总分</div>
                                <div class="value">${exam.totalScore} 分</div>
                            </div>
                            <div class="info-item">
                                <div class="label">📅 截止时间</div>
                                <div class="value"><fmt:formatDate value="${exam.endTime}" pattern="MM-dd HH:mm"/></div>
                            </div>
                        </div>

                        <c:if test="${not empty exam.description}">
                            <div class="exam-desc">${exam.description}</div>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/exam/start.action?examId=${exam.id}" class="btn-start">
                            开始考试
                        </a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>暂无可参加的考试</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
