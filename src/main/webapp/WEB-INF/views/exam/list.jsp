<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>在线考试 - 在线学习平台</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 页面标题 */
        .page-title {
            font-size: 32px;
            color: var(--text-dark);
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        /* 考试列表网格 */
        .exam-grid {
            display: grid;
            gap: 25px;
        }

        /* 考试卡片 */
        .exam-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .exam-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 50px rgba(93, 173, 226, 0.35);
        }

        /* 考试头部 */
        .exam-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .exam-title {
            font-size: 24px;
            color: var(--text-dark);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .exam-meta {
            color: var(--text-light);
            font-size: 14px;
        }

        /* 状态标签 */
        .exam-status {
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-open {
            background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
            color: #2E7D32;
        }

        /* 考试信息网格 */
        .exam-info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 25px;
            padding: 20px;
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            border-radius: 15px;
            border: 1px solid rgba(93, 173, 226, 0.2);
        }

        .info-item {
            font-size: 14px;
        }

        .info-item .label {
            color: var(--text-light);
            margin-bottom: 8px;
            font-size: 13px;
        }

        .info-item .value {
            color: var(--text-dark);
            font-weight: 600;
            font-size: 16px;
        }

        /* 考试描述 */
        .exam-desc {
            font-size: 14px;
            color: var(--text-light);
            line-height: 1.8;
            margin-bottom: 25px;
        }

        /* 按钮组 */
        .exam-actions {
            display: flex;
            gap: 12px;
        }

        /* 开始考试按钮 */
        .btn-start {
            flex: 1;
            display: inline-block;
            padding: 14px 30px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            text-align: center;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-start:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        /* 返回首页按钮 */
        .btn-home {
            display: inline-block;
            padding: 14px 30px;
            background: rgba(255, 255, 255, 0.8);
            color: var(--text-dark);
            text-decoration: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            text-align: center;
            border: 2px solid rgba(93, 173, 226, 0.3);
        }

        .btn-home:hover {
            background: white;
            border-color: var(--primary-light);
        }

        /* 禁用按钮 */
        .btn-disabled {
            background: #ccc;
            cursor: not-allowed;
            box-shadow: none;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 100px 20px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
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

            .exam-info {
                grid-template-columns: 1fr;
            }

            .exam-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">在线学习平台</a>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <h1 class="page-title">在线考试</h1>

    <div class="exam-grid">
        <%-- 判断：是否有考试数据 --%>
        <c:choose>
            <%-- 情况1：有考试 --%>
            <c:when test="${not empty examList}">
                <%-- 循环显示每场考试 --%>
                <c:forEach var="exam" items="${examList}">
                    <div class="exam-card">
                        <div class="exam-header">
                            <div>
                                <h2 class="exam-title">${exam.title}</h2>
                                <div class="exam-meta">
                                    课程：${exam.courseName} | 教师：${exam.teacherName}
                                </div>
                            </div>
                            <span class="exam-status status-open">进行中</span>
                        </div>

                        <!-- 考试信息 -->
                        <div class="exam-info">
                            <div class="info-item">
                                <div class="label">考试时长</div>
                                <div class="value">${exam.duration} 分钟</div>
                            </div>
                            <div class="info-item">
                                <div class="label">总分</div>
                                <div class="value">${exam.totalScore} 分</div>
                            </div>
                            <div class="info-item">
                                <div class="label">截止时间</div>
                                <div class="value"><fmt:formatDate value="${exam.endTime}" pattern="MM-dd HH:mm"/></div>
                            </div>
                        </div>

                            <%-- 判断：如果有考试描述就显示 --%>
                        <c:if test="${not empty exam.description}">
                            <div class="exam-desc">${exam.description}</div>
                        </c:if>

                        <!-- 操作按钮 -->
                        <div class="exam-actions">
                                <%-- 判断：如果不是教师，显示开始考试按钮 --%>
                            <c:if test="${sessionScope.user.role != 'teacher'}">
                                <a href="${pageContext.request.contextPath}/exam/start.action?examId=${exam.id}" class="btn-start">
                                    开始考试
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <!-- 返回首页按钮 - 放在所有考试卡片后面 -->
                <div style="text-align: center; margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/home.action" class="btn-home">
                        返回首页
                    </a>
                </div>
            </c:when>
            <%-- 情况2：没有考试 --%>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">●</div>
                    <p>暂无可参加的考试</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>