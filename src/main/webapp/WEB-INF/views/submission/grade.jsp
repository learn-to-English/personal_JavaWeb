<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>批改作业 - 在线学习平台</title>
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

    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: 500;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 2px solid #e0e0e0;
      border-radius: 10px;
      font-size: 15px;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #667eea;
    }

    .form-group textarea {
      min-height: 120px;
      resize: vertical;
    }

    .form-actions {
      display: flex;
      gap: 15px;
    }

    .btn {
      flex: 1;
      padding: 15px;
      border: none;
      border-radius: 10px;
      font-size: 16px;
      cursor: pointer;
      text-decoration: none;
      text-align: center;
      transition: transform 0.3s;
    }

    .btn:hover {
      transform: translateY(-2px);
    }

    .btn-primary {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
    }

    .btn-secondary {
      background: #e0e0e0;
      color: #333;
    }

    .alert {
      padding: 15px 20px;
      border-radius: 10px;
      margin-bottom: 20px;
      text-align: center;
    }

    .alert-success { background: #d4edda; color: #155724; }
    .alert-error { background: #f8d7da; color: #721c24; }
    .alert-info { background: #d1ecf1; color: #0c5460; }

    .readonly-badge {
      display: inline-block;
      padding: 5px 15px;
      background: #d4edda;
      color: #155724;
      border-radius: 15px;
      font-size: 14px;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="logo">📚 在线学习平台</div>
</div>

<div class="main-content">
  <div class="card">
    <h2>✍️ 批改作业 - ${assignment.title}</h2>

    <c:if test="${submission.status == 'graded'}">
      <span class="readonly-badge">✅ 已批改</span>
    </c:if>

    <div class="info-section">
      <h3>👤 学生信息</h3>
      <div class="content">
        学生：${submission.studentName}<br>
        提交时间：<fmt:formatDate value="${submission.submitTime}" pattern="yyyy-MM-dd HH:mm"/>
      </div>
    </div>

    <div class="info-section">
      <h3>📝 学生答案</h3>
      <div class="content">${submission.content}</div>
    </div>

    <div id="alertBox"></div>

    <c:choose>
      <c:when test="${submission.status == 'graded'}">
        <div class="form-group">
          <label>得分：</label>
          <input type="number" value="${submission.score}" readonly>
        </div>
        <div class="form-group">
          <label>评语：</label>
          <textarea readonly>${submission.feedback}</textarea>
        </div>
        <div class="info-section">
          <h3>ℹ️ 批改信息</h3>
          <div class="content">
            批改时间：<fmt:formatDate value="${submission.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>
          </div>
        </div>
        <a href="${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}" class="btn btn-secondary">返回</a>
      </c:when>
      <c:otherwise>
        <form id="gradeForm">
          <div class="form-group">
            <label>得分（满分${assignment.totalScore}分）：</label>
            <input type="number" name="score" id="score" min="0" max="${assignment.totalScore}" required>
          </div>

          <div class="form-group">
            <label>评语：</label>
            <textarea name="feedback" id="feedback" placeholder="请输入评语（可选）"></textarea>
          </div>

          <div class="form-actions">
            <a href="${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}" class="btn btn-secondary">取消</a>
            <button type="submit" class="btn btn-primary">提交批改</button>
          </div>
        </form>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
  var form = document.getElementById('gradeForm');
  if (form) {
    form.onsubmit = function(e) {
      e.preventDefault();

      var score = document.getElementById('score').value;
      var feedback = document.getElementById('feedback').value.trim();

      if (!score) {
        showAlert('请输入分数', 'error');
        return;
      }

      var maxScore = ${assignment.totalScore};
      if (score < 0 || score > maxScore) {
        showAlert('分数必须在0-' + maxScore + '之间', 'error');
        return;
      }

      var formData = 'submissionId=${submission.id}&score=' + score + '&feedback=' + encodeURIComponent(feedback);

      fetch('${pageContext.request.contextPath}/submission/grade.action', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData
      })
              .then(response => response.json())
              .then(data => {
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                  setTimeout(function() {
                    window.location.href = '${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}';
                  }, 1500);
                }
              })
              .catch(error => {
                showAlert('请求失败，请重试', 'error');
              });
    };
  }

  function showAlert(message, type) {
    document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
  }
</script>
</body>
</html>
