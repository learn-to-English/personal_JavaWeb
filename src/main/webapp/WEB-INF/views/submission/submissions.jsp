<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>作业提交列表 - 在线学习平台</title>
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
      max-width: 1200px;
      margin: 40px auto;
      padding: 0 20px;
    }

    /* 返回按钮 */
    .btn-back {
      display: inline-block;
      padding: 12px 25px;
      background: rgba(255, 255, 255, 0.8);
      color: var(--text-dark);
      text-decoration: none;
      border-radius: 25px;
      margin-bottom: 25px;
      transition: all 0.3s;
      font-weight: 600;
      border: 2px solid rgba(93, 173, 226, 0.3);
    }

    .btn-back:hover {
      background: white;
      border-color: var(--primary-light);
      transform: translateX(-5px);
    }

    /* 页面头部卡片 */
    .page-header {
      background: rgba(255, 255, 255, 0.95);
      padding: 30px;
      border-radius: 20px;
      margin-bottom: 30px;
      box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
      backdrop-filter: blur(10px);
    }

    .page-header h1 {
      font-size: 26px;
      color: var(--text-dark);
      margin-bottom: 12px;
    }

    .page-header .info {
      font-size: 15px;
      color: var(--text-light);
      line-height: 1.8;
    }

    /* 表格容器 */
    .submission-table {
      width: 100%;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
      backdrop-filter: blur(10px);
    }

    .submission-table th,
    .submission-table td {
      padding: 20px;
      text-align: left;
    }

    /* 表头 */
    .submission-table th {
      background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
      color: var(--primary-dark);
      font-weight: 700;
      font-size: 15px;
    }

    /* 表格行 */
    .submission-table tr {
      border-bottom: 1px solid rgba(93, 173, 226, 0.1);
    }

    .submission-table tbody tr:hover {
      background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
    }

    .submission-table td {
      color: var(--text-dark);
      font-size: 14px;
    }

    /* 状态标签 */
    .status-badge {
      display: inline-block;
      padding: 6px 16px;
      border-radius: 20px;
      font-size: 13px;
      font-weight: 600;
    }

    .status-submitted {
      background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
      color: var(--primary-dark);
    }

    .status-graded {
      background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
      color: #2E7D32;
    }

    /* 批改按钮 */
    .btn-grade {
      padding: 8px 18px;
      background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
      color: white;
      text-decoration: none;
      border-radius: 20px;
      font-size: 13px;
      font-weight: 600;
      transition: all 0.3s;
      display: inline-block;
      box-shadow: 0 3px 10px rgba(93, 173, 226, 0.25);
    }

    .btn-grade:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(93, 173, 226, 0.35);
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

      .submission-table {
        font-size: 13px;
      }

      .submission-table th,
      .submission-table td {
        padding: 12px;
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
  <!-- 返回按钮 -->
  <a href="${pageContext.request.contextPath}/assignment/myList.action" class="btn-back">← 返回作业列表</a>

  <!-- 页面头部 -->
  <div class="page-header">
    <h1>📊 ${assignment.title} - 提交列表</h1>
    <div class="info">
      课程：${assignment.courseName} |
      截止时间：<fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/> |
      满分：${assignment.totalScore}分
    </div>
  </div>

  <%-- 判断：是否有学生提交了作业 --%>
  <c:choose>
    <%-- 情况1：有提交记录 --%>
    <c:when test="${not empty submissionList}">
      <table class="submission-table">
        <thead>
        <tr>
          <th>学生</th>
          <th>提交时间</th>
          <th>状态</th>
          <th>得分</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
          <%-- 循环显示每个学生的提交记录 --%>
        <c:forEach var="submission" items="${submissionList}">
          <tr>
            <td>${submission.studentName}</td>
            <td><fmt:formatDate value="${submission.submitTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>
                <%-- 判断：作业是否已批改 --%>
              <c:choose>
                <c:when test="${submission.status == 'graded'}">
                  <span class="status-badge status-graded">✅ 已批改</span>
                </c:when>
                <c:otherwise>
                  <span class="status-badge status-submitted">⏰ 待批改</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
                <%-- 判断：是否有分数 --%>
              <c:choose>
                <c:when test="${submission.score != null}">
                  ${submission.score}分
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td>
              <a href="${pageContext.request.contextPath}/submission/toGrade.action?id=${submission.id}" class="btn-grade">
                  <%-- 判断：按钮文字 --%>
                <c:choose>
                  <c:when test="${submission.status == 'graded'}">查看详情</c:when>
                  <c:otherwise>去批改</c:otherwise>
                </c:choose>
              </a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:when>
    <%-- 情况2：没有提交记录 --%>
    <c:otherwise>
      <div class="empty-state">
        <div class="icon">📭</div>
        <p>暂无学生提交</p>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>