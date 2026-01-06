<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>考试成绩 - 在线学习平台</title>
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
            --success: #51CF66;
            --error: #FF8787;
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 - 天空蓝渐变 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* 页面头部 */
        .header {
            max-width: 900px;
            margin: 0 auto 30px;
            text-align: center;
            color: var(--text-dark);
        }

        .header h1 {
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        .header .subtitle {
            font-size: 16px;
            opacity: 0.8;
        }

        /* 主容器 */
        .main-container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* 成绩卡片 */
        .score-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 50px 40px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .score-label {
            font-size: 18px;
            color: var(--text-light);
            margin-bottom: 15px;
        }

        /* 分数显示 - 渐变文字 */
        .score-display {
            font-size: 80px;
            font-weight: bold;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 20px 0;
            line-height: 1;
        }

        .score-total {
            font-size: 18px;
            color: var(--text-light);
            margin-top: 15px;
        }

        /* 统计信息网格 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid rgba(93, 173, 226, 0.2);
        }

        .stat-item {
            padding: 20px;
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            border-radius: 12px;
            border: 1px solid rgba(93, 173, 226, 0.2);
        }

        .stat-label {
            font-size: 14px;
            color: var(--text-light);
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: var(--text-dark);
        }

        /* 答题详情区域 */
        .answers-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .section-title {
            font-size: 22px;
            color: var(--text-dark);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-light);
        }

        /* 答题项 */
        .answer-item {
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 12px;
            border-left: 4px solid #ccc;
            background: #F8F9FA;
            transition: all 0.3s;
        }

        .answer-item:hover {
            transform: translateX(5px);
        }

        /* 正确答案样式 */
        .answer-item.correct {
            background: linear-gradient(135deg, #E7F5E9 0%, #D4EDDA 100%);
            border-left-color: var(--success);
        }

        /* 错误答案样式 */
        .answer-item.wrong {
            background: linear-gradient(135deg, #FFE5E5 0%, #FFCCCB 100%);
            border-left-color: var(--error);
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .question-num {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .answer-status {
            font-size: 15px;
            font-weight: bold;
            padding: 5px 15px;
            border-radius: 15px;
        }

        .answer-status.correct {
            background: var(--success);
            color: white;
        }

        .answer-status.wrong {
            background: var(--error);
            color: white;
        }

        .answer-detail {
            font-size: 14px;
            color: #666;
            line-height: 1.8;
        }

        .answer-detail strong {
            color: var(--text-dark);
        }

        /* 操作按钮 */
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }

        .btn {
            padding: 15px 40px;
            border-radius: 25px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.8);
            color: var(--text-dark);
            border: 2px solid rgba(93, 173, 226, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 1);
            border-color: var(--primary-light);
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body {
                padding: 20px 15px;
            }

            .header h1 {
                font-size: 26px;
            }

            .score-card, .answers-section {
                padding: 30px 25px;
            }

            .score-display {
                font-size: 60px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- 页面头部 -->
<div class="header">
    <h1>考试成绩</h1>
    <p class="subtitle">查看您的考试结果和答题详情</p>
</div>

<!-- 主容器 -->
<div class="main-container">
    <!-- 成绩卡片 -->
    <div class="score-card">
        <div class="score-label">您的得分</div>
        <div class="score-display">${record.score}</div>
        <div class="score-total">满分 ${exam.totalScore} 分</div>

        <!-- 统计信息 -->
        <div class="stats-grid">
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

    <!-- 答题详情 -->
    <div class="answers-section">
        <h2 class="section-title">答题详情</h2>

        <c:forEach var="answer" items="${answers}" varStatus="status">
            <div class="answer-item ${answer.isCorrect == 1 ? 'correct' : 'wrong'}">
                <div class="answer-header">
                    <span class="question-num">第 ${status.index + 1} 题</span>
                    <span class="answer-status ${answer.isCorrect == 1 ? 'correct' : 'wrong'}">
                          <c:choose>
                              <c:when test="${answer.isCorrect == 1}">正确</c:when>
                              <c:otherwise>错误</c:otherwise>
                          </c:choose>
                      </span>
                </div>
                <div class="answer-detail">
                    <strong>您的答案:</strong> ${answer.studentAnswer}
                    <c:if test="${answer.isCorrect != 1}">
                        <br>
                        <strong>正确答案:</strong> ${questionMap[answer.questionId].correctAnswer}
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 操作按钮 -->
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/exam/list.action" class="btn btn-primary">
            返回考试列表
        </a>
        <a href="${pageContext.request.contextPath}/home.action" class="btn btn-secondary">
            返回首页
        </a>
    </div>
</div>
</body>
</html>