<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>查看成绩 - 在线学习平台</title>
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
    }

    .main-content {
      max-width: 800px;
      margin: 40px auto;
      padding: 0 20px;
    }

    .card {
      background: white;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
      margin-bottom: 20px;
    }

    .card h2 {
      font-size: 24px;
      color: #333;
      margin-bottom: 20px;
    }

    .score-display {
      text-align: center;
      padding: 40px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 15px;
      margin-bottom: 30px;
    }

    .score-display .score {
      font-size: 60px;
      font-weight: bold;
      color: white;
      margin-bottom: 10px;
    }

    .score-display .label {
      font-size: 18px;
      color: rgba(255,255,255,0.9);
    }

    .info-section {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    .info-section h3 {
      font-size: 16px;
      color: #333;
      margin-bottom: 15px;
      font-weight: 600;
    }

    .info-section .content {
      font-size: 15px;
      color: #666;
      line-height: 1.8;
      white-space: pre-wrap;
    }

    .btn-back {
      display: block;
      padding: 15px;
      background: #667eea;
      color: white;
      text-align: center;
      text-decoration: none;
      border-radius: 10px;
      transition: opacity 0.3s;
    }

    .btn-back:hover {
      opacity: 0.9;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="logo">📚 在线学习平台</div>
</div>

<div class="main-content">
  <div class="card">
    <h2>🎯 ${assignment.title} - 成绩</h2>

    <div class="score-display">
      <div class="score">${submission.score}分</div>
      <div class="label">满分 ${assignment.totalScore}分</div>
    </div>

    <div class="info-section">
      <h3>📝 我的答案</h3>
      <div class="content">${submission.content}</div>
    </div>

    <c:if test="${not empty submission.feedback}">
      <div class="info-section">
        <h3>💬 教师评语</h3>
        <div class="content">${submission.feedback}</div>
      </div>
    </c:if>

    <div class="info-section">
      <h3>ℹ️ 作业信息</h3>
      <div class="content">
        课程：${assignment.courseName}<br>
        提交时间：<fmt:formatDate value="${submission.submitTime}" pattern="yyyy-MM-dd HH:mm"/><br>
        批改时间：<fmt:formatDate value="${submission.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>
      </div>
    </div>

    <a href="${pageContext.request.contextPath}/submission/list.action" class="btn-back">返回作业列表</a>
  </div>
</div>
</body>
</html>
