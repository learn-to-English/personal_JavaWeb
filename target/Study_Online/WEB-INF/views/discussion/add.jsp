<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>发布新话题 - 在线学习平台</title>
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
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .header .logo {
      font-size: 24px;
      font-weight: bold;
      text-decoration: none;
      color: white;
    }

    .main-content {
      max-width: 800px;
      margin: 40px auto;
      padding: 0 20px;
    }

    .form-card {
      background: white;
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    }

    .form-card h1 {
      font-size: 28px;
      color: #333;
      margin-bottom: 10px;
      text-align: center;
    }

    .form-card .subtitle {
      text-align: center;
      color: #666;
      margin-bottom: 30px;
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

    .form-group label .required {
      color: #dc3545;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 2px solid #e0e0e0;
      border-radius: 10px;
      font-size: 15px;
      transition: border-color 0.3s;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #667eea;
    }

    .form-group textarea {
      min-height: 200px;
      resize: vertical;
    }

    .form-actions {
      display: flex;
      gap: 15px;
      margin-top: 30px;
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
  </style>
</head>
<body>
<div class="header">
  <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
</div>

<div class="main-content">
  <div class="form-card">
    <h1>✨ 发布新话题</h1>
    <p class="subtitle">${course.title}</p>

    <div id="alertBox"></div>

    <form id="discussionForm">
      <input type="hidden" name="courseId" value="${course.id}">

      <div class="form-group">
        <label>话题标题 <span class="required">*</span></label>
        <input type="text" name="title" id="title" placeholder="请输入话题标题">
      </div>

      <div class="form-group">
        <label>话题内容</label>
        <textarea name="content" id="content" placeholder="详细描述你的问题或想法..."></textarea>
      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}" class="btn btn-secondary">取消</a>
        <button type="submit" class="btn btn-primary">发布话题</button>
      </div>
    </form>
  </div>
</div>

<script>
  document.getElementById('discussionForm').onsubmit = function(e) {
    e.preventDefault();

    var title = document.getElementById('title').value.trim();
    var content = document.getElementById('content').value.trim();
    var courseId = ${course.id};

    if (!title) {
      showAlert('请输入话题标题', 'error');
      return;
    }

    var formData = 'courseId=' + courseId +
            '&title=' + encodeURIComponent(title) +
            '&content=' + encodeURIComponent(content);

    fetch('${pageContext.request.contextPath}/discussion/add.action', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: formData
    })
            .then(response => response.json())
            .then(data => {
              showAlert(data.message, data.success ? 'success' : 'error');
              if (data.success) {
                setTimeout(function() {
                  window.location.href = '${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}';
                }, 1500);
              }
            })
            .catch(error => {
              showAlert('请求失败，请重试', 'error');
            });
  };

  function showAlert(message, type) {
    document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
  }
</script>
</body>
</html>
