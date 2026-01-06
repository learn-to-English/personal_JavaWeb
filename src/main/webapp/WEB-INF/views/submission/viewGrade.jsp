<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>查看成绩 - 在线学习平台</title>
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
      text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    /* 主内容区域 */
    .main-content {
      max-width: 850px;
      margin: 40px auto;
      padding: 0 20px;
    }

    /* 卡片容器 */
    .card {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
      backdrop-filter: blur(10px);
      margin-bottom: 25px;
    }

    .card h2 {
      font-size: 26px;
      color: var(--text-dark);
      margin-bottom: 30px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    /* 成绩展示区域 - 天空蓝渐变 */
    .score-display {
      text-align: center;
      padding: 50px;
      background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
      border-radius: 20px;
      margin-bottom: 35px;
      box-shadow: 0 10px 30px rgba(93, 173, 226, 0.35);
      animation: scaleIn 0.5s ease;
    }

    @keyframes scaleIn {
      from {
        opacity: 0;
        transform: scale(0.9);
      }
      to {
        opacity: 1;
        transform: scale(1);
      }
    }

    .score-display .score {
      font-size: 70px;
      font-weight: bold;
      color: white;
      margin-bottom: 15px;
      text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .score-display .label {
      font-size: 20px;
      color: rgba(255, 255, 255, 0.95);
    }

    /* 信息区域 */
    .info-section {
      background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
      padding: 25px;
      border-radius: 15px;
      margin-bottom: 25px;
      border: 1px solid rgba(93, 173, 226, 0.2);
      transition: all 0.3s;
    }

    .info-section:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(93, 173, 226, 0.15);
    }

    .info-section h3 {
      font-size: 17px;
      color: var(--primary-dark);
      margin-bottom: 18px;
      font-weight: 700;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .info-section .content {
      font-size: 15px;
      color: var(--text-dark);
      line-height: 1.9;
      white-space: pre-wrap;
    }

    /* 返回按钮 */
    .btn-back {
      display: block;
      padding: 16px;
      background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
      color: white;
      text-align: center;
      text-decoration: none;
      border-radius: 12px;
      font-weight: 600;
      transition: all 0.3s;
      box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
    }

    .btn-back:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
    }

    /* 响应式设计 */
    @media (max-width: 768px) {
      .header {
        padding: 15px 25px;
      }

      .main-content {
        padding: 0 15px;
      }

      .card {
        padding: 25px;
      }

      .score-display {
        padding: 35px 20px;
      }

      .score-display .score {
        font-size: 50px;
      }
    }
  </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="header">
  <div class="logo">📚 在线学习平台</div>
</div>

<!-- 主内容区域 -->
<div class="main-content">
  <div class="card">
    <h2>🎯 ${assignment.title} - 成绩</h2>

    <!-- 成绩展示区域 -->
    <div class="score-display">
      <div class="score">${submission.score}分</div>
      <div class="label">满分 ${assignment.totalScore}分</div>
    </div>

    <!-- 我的答案 -->
    <div class="info-section">
      <h3>📝 我的答案</h3>
      <div class="content">${submission.content}</div>
    </div>

    <%-- 判断：如果教师有评语，就显示出来 --%>
    <c:if test="${not empty submission.feedback}">
      <div class="info-section">
        <h3>💬 教师评语</h3>
        <div class="content">${submission.feedback}</div>
      </div>
    </c:if>

    <!-- 作业信息 -->
    <div class="info-section">
      <h3>ℹ️ 作业信息</h3>
      <div class="content">
        课程：${assignment.courseName}<br>
        提交时间：<fmt:formatDate value="${submission.submitTime}" pattern="yyyy-MM-dd HH:mm"/><br>
        批改时间：<fmt:formatDate value="${submission.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>
      </div>
    </div>

    <!-- 返回按钮 -->
    <a href="${pageContext.request.contextPath}/submission/list.action" class="btn-back">返回作业列表</a>
  </div>
</div>
</body>
</html>