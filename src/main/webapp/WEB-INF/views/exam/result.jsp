<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试成绩 - 在线学习平台</title>
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
            padding: 20px 50px;
            text-align: center;
        }

        .header h1 {
            font-size: 28px;
        }

        .main-content {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .score-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .score-display {
            font-size: 72px;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 20px 0;
        }

        .score-info {
            font-size: 18px;
            color: #666;
            margin-bottom: 10px;
        }

        .score-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 30px;
        }

        .stat-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .stat-label {
            color: #999;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        .answers-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .section-title {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .answer-item {
            padding: 20px;
            margin-bottom: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #ccc;
        }

        .answer-item.correct {
            background: #d4edda;
            border-left-color: #28a745;
        }

        .answer-item.wrong {
            background: #f8d7da;
            border-left-color: #dc3545;
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .answer-status {
            font-weight: bold;
        }

        .answer-status.correct {
            color: #28a745;
        }

        .answer-status.wrong {
            color: #dc3545;
        }

        .answer-detail {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }

        .actions {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 0 10px;
            border-radius: 25px;
            text-decoration: none;
            font-size: 16px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>📊 考试成绩</h1>
</div>

<div class="main-content">
    <div class="score-card">
        <div class="score-info">你的得分</div>
        <div class="score-display">${record.score}</div>
        <div class="score-info">满分 ${exam.totalScore} 分</div>

        <div class="score-stats">
            <div class="stat-item">
                <div class="stat-label">正确率</div>
                <div class="stat-value">
                    <c:set var="percentage" value="${(record.score / exam.totalScore) * 100}" />
                    <fmt:formatNumber value="${percentage}" pattern="#" />%
                </div>
            </div>
            <div class="stat-item">
                <div class="stat-label">考试用时</div>
                <div class="stat-value">
                    <c:set var="duration" value="${(record.submitTime.time - record.startTime.time) / 60000}" />
                    <fmt:formatNumber value="${duration}" pattern="#" /> 分钟
                </div>
            </div>
        </div>
    </div>

    <div class="answers-section">
        <h2 class="section-title">答题详情</h2>

        <c:forEach var="answer" items="${answers}" varStatus="status">
            <div class="answer-item ${answer.isCorrect == 1 ? 'correct' : 'wrong'}">
                <div class="answer-header">
                    <span>第 ${status.index + 1} 题</span>
                    <span class="answer-status ${answer.isCorrect == 1 ? 'correct' : 'wrong'}">
                            ${answer.isCorrect == 1 ? '✓ 正确' : '✗ 错误'}
                    </span>
                </div>
                <div class="answer-detail">
                    你的答案：${answer.studentAnswer}
                    <c:if test="${answer.isCorrect != 1}">
                        <br>正确答案：${answer.correctAnswer}
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/exam/list.action" class="btn btn-primary">返回考试列表</a>
        <a href="${pageContext.request.contextPath}/home.action" class="btn btn-secondary">返回首页</a>
    </div>
</div>
</body>
</html>
