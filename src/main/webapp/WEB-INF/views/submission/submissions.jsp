<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>作业提交列表 - 在线学习平台</title>
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
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
    }

    .page-header {
      background: white;
      padding: 25px;
      border-radius: 15px;
      margin-bottom: 30px;
    }

    .page-header h1 {
      font-size: 24px;
      color: #333;
      margin-bottom: 10px;
    }

    .page-header .info {
      font-size: 14px;
      color: #666;
    }

    .submission-table {
      width: 100%;
      background: white;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    }

    .submission-table th,
    .submission-table td {
      padding: 18px 20px;
      text-align: left;
    }

    .submission-table th {
      background: #f8f9fa;
      color: #333;
      font-weight: 600;
    }

    .submission-table tr {
      border-bottom: 1px solid #eee;
    }

    .submission-table tr:hover {
      background: #f8f9fa;
    }

    .status-badge {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 12px;
    }

    .status-submitted { background: #cfe2ff; color: #084298; }
    .status-graded { background: #d4edda; color: #155724; }

    .btn-grade {
      padding: 6px 15px;
      background: #667eea;
      color: white;
      text-decoration: none;
      border-radius: 15px;
      font-size: 13px;
    }

    .btn-back {
      display: inline-block;
      padding: 10px 20px;
      background: #e0e0e0;
      color: #333;
      text-decoration: none;
      border-radius: 20px;
      margin-bottom: 20px;
    }

    .empty-state {
      text-align: center;
      padding: 80px 20px;
      background: white;
      border-radius: 15px;
    }

    .empty-state .icon {
      font-size: 80px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="logo">📚 在线学习平台</div>
</div>

<div class="main-content">
  <a href="${pageContext.request.contextPath}/assignment/myList.action" class="btn-back">← 返回作业列表</a>

  <div class="page-header">
    <h1>📊 ${assignment.title} - 提交列表</h1>
    <div class="info">
      课程：${assignment.courseName} |
      截止时间：<fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/> |
      满分：${assignment.totalScore}分
    </div>
  </div>

  <c:choose>
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
        <c:forEach var="submission" items="${submissionList}">
          <tr>
            <td>${submission.studentName}</td>
            <td><fmt:formatDate value="${submission.submitTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>
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
              <c:choose>
                <c:when test="${submission.score != null}">
                  ${submission.score}分
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td>
              <a href="${pageContext.request.contextPath}/submission/toGrade.action?id=${submission.id}" class="btn-grade">
                  ${submission.status == 'graded' ? '查看详情' : '去批改'}
              </a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </c:when>
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
