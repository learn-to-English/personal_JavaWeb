<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>发布新话题 - 在线学习平台</title>
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
      --error: #FF8787;
      --success: #51CF66;
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

    /* 页面标题 */
    .header {
      max-width: 800px;
      margin: 0 auto 30px;
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

    .back-link {
      display: inline-block;
      color: var(--text-dark);
      text-decoration: none;
      padding: 10px 25px;
      background: rgba(255, 255, 255, 0.6);
      border-radius: 25px;
      margin-top: 15px;
      transition: all 0.3s;
      backdrop-filter: blur(10px);
    }

    .back-link:hover {
      background: rgba(255, 255, 255, 0.8);
      transform: translateX(-5px);
    }

    /* 表单卡片 */
    .form-card {
      max-width: 800px;
      margin: 0 auto;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
      backdrop-filter: blur(10px);
    }

    .form-card h2 {
      font-size: 24px;
      color: var(--text-dark);
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 3px solid var(--primary-light);
    }

    /* 表单组 */
    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      margin-bottom: 10px;
      color: var(--text-dark);
      font-weight: 600;
      font-size: 15px;
    }

    .required {
      color: var(--error);
      margin-left: 3px;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 2px solid rgba(93, 173, 226, 0.2);
      border-radius: 12px;
      font-size: 15px;
      transition: all 0.3s;
      background: rgba(255, 255, 255, 0.9);
      font-family: var(--font-main);
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
      background: white;
    }

    .form-group textarea {
      min-height: 200px;
      resize: vertical;
    }

    /* 操作按钮 */
    .form-actions {
      display: flex;
      gap: 15px;
      margin-top: 40px;
      padding-top: 30px;
      border-top: 1px solid rgba(93, 173, 226, 0.2);
    }

    .btn {
      flex: 1;
      padding: 15px;
      border: none;
      border-radius: 12px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      text-align: center;
      transition: all 0.3s;
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

    /* 提示消息 */
    .alert {
      padding: 15px 20px;
      border-radius: 12px;
      margin-bottom: 25px;
      text-align: center;
      animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .alert-success {
      background: linear-gradient(135deg, #E7F5E9 0%, #D4EDDA 100%);
      color: var(--success);
      border-left: 4px solid var(--success);
    }

    .alert-error {
      background: linear-gradient(135deg, #FFE5E5 0%, #FFCCCB 100%);
      color: var(--error);
      border-left: 4px solid var(--error);
    }

    /* 响应式 */
    @media (max-width: 768px) {
      body {
        padding: 20px 15px;
      }

      .header h1 {
        font-size: 26px;
      }

      .form-card {
        padding: 30px 25px;
      }

      .form-actions {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
<!-- 页面标题 -->
<div class="header">
  <h1>发布新话题</h1>
  <p class="subtitle">${course.title}</p>
  <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}" class="back-link">
    返回讨论列表
  </a>
</div>

<!-- 表单卡片 -->
<div class="form-card">
  <h2>话题信息</h2>

  <!-- 提示消息 -->
  <div id="alertBox"></div>

  <!-- 表单 -->
  <form id="discussionForm">
    <input type="hidden" name="courseId" value="${course.id}">

    <!-- 话题标题 -->
    <div class="form-group">
      <label>话题标题<span class="required">*</span></label>
      <input type="text" name="title" id="title" placeholder="请输入话题标题">
    </div>

    <!-- 话题内容 -->
    <div class="form-group">
      <label>话题内容</label>
      <textarea name="content" id="content" placeholder="详细描述你的问题或想法..."></textarea>
    </div>

    <!-- 操作按钮 -->
    <div class="form-actions">
      <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}" class="btn btn-secondary">
        取消
      </a>
      <button type="submit" class="btn btn-primary">
        发布话题
      </button>
    </div>
  </form>
</div>

<script>
  // 功能1: 提交表单
  function submitDiscussionForm(e) {
    // 阻止默认提交
    e.preventDefault();

    // 获取输入值
    var title = document.getElementById('title').value.trim();
    var content = document.getElementById('content').value.trim();
    var courseId = ${course.id};

    // 验证标题
    if (!title) {
      showMessage('请输入话题标题', 'error');
      return;
    }

    // 构建表单数据
    var formData = 'courseId=' + courseId +
            '&title=' + encodeURIComponent(title) +
            '&content=' + encodeURIComponent(content);

    // 发送请求
    sendAddRequest(formData);
  }

  // 功能2: 发送添加请求
  function sendAddRequest(data) {
    fetch('${pageContext.request.contextPath}/discussion/add.action', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: data
    })
            .then(function(response) {
              return response.json();
            })
            .then(function(result) {
              handleAddResult(result);
            })
            .catch(function(error) {
              showMessage('请求失败，请重试', 'error');
            });
  }

  // 功能3: 处理添加结果
  function handleAddResult(result) {
    // 显示消息
    if (result.success) {
      showMessage(result.message, 'success');
      // 1.5秒后跳转
      setTimeout(function() {
        window.location.href = '${pageContext.request.contextPath}/discussion/list.action?courseId=${course.id}';
      }, 1500);
    } else {
      showMessage(result.message, 'error');
    }
  }

  // 功能4: 显示提示消息
  function showMessage(message, type) {
    var alertBox = document.getElementById('alertBox');
    alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
  }

  // 绑定表单提交事件
  document.getElementById('discussionForm').onsubmit = submitDiscussionForm;
</script>
</body>
</html>