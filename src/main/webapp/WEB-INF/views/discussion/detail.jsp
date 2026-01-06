<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${discussion.title} - 讨论详情</title>
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
      padding-bottom: 40px;
    }

    /* 顶部导航 */
    .header {
      background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
      color: white;
      padding: 20px 50px;
      box-shadow: 0 3px 15px rgba(93, 173, 226, 0.4);
    }

    .header .logo {
      font-size: 24px;
      font-weight: bold;
      text-decoration: none;
      color: white;
    }

    /* 主内容 */
    .main-content {
      max-width: 900px;
      margin: 30px auto;
      padding: 0 20px;
    }

    /* 返回按钮 */
    .back-link {
      display: inline-block;
      color: var(--text-dark);
      text-decoration: none;
      padding: 10px 25px;
      background: rgba(255, 255, 255, 0.6);
      border-radius: 25px;
      margin-bottom: 20px;
      transition: all 0.3s;
      backdrop-filter: blur(10px);
    }

    .back-link:hover {
      background: rgba(255, 255, 255, 0.8);
      transform: translateX(-5px);
    }

    /* 话题卡片 */
    .discussion-card {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 40px;
      margin-bottom: 25px;
      box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
      backdrop-filter: blur(10px);
    }

    .discussion-card .title {
      font-size: 26px;
      color: var(--text-dark);
      margin-bottom: 20px;
      font-weight: 600;
    }

    .discussion-card .meta {
      display: flex;
      align-items: center;
      gap: 20px;
      padding-bottom: 25px;
      border-bottom: 2px solid rgba(93, 173, 226, 0.2);
      margin-bottom: 25px;
      font-size: 14px;
      color: var(--text-light);
    }

    .discussion-card .content {
      font-size: 16px;
      color: #666;
      line-height: 1.8;
      white-space: pre-wrap;
    }

    .role-badge {
      display: inline-block;
      padding: 3px 10px;
      border-radius: 10px;
      font-size: 12px;
      background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
      color: #2E7D32;
    }

    /* 回复区域 */
    .reply-section {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 40px;
      margin-bottom: 25px;
      box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
      backdrop-filter: blur(10px);
    }

    .reply-section h3 {
      font-size: 22px;
      color: var(--text-dark);
      margin-bottom: 25px;
      padding-bottom: 15px;
      border-bottom: 3px solid var(--primary-light);
    }

    /* 回复列表 */
    .reply-list {
      margin-bottom: 30px;
    }

    .reply-item {
      padding: 20px 0;
      border-bottom: 1px solid rgba(93, 173, 226, 0.1);
    }

    .reply-item:last-child {
      border-bottom: none;
    }

    .reply-item .reply-header {
      display: flex;
      align-items: center;
      gap: 15px;
      margin-bottom: 12px;
      font-size: 14px;
    }

    .reply-item .reply-header .author {
      font-weight: 600;
      color: var(--text-dark);
    }

    .reply-item .reply-header .time {
      color: var(--text-light);
    }

    .reply-item .reply-content {
      font-size: 15px;
      color: #666;
      line-height: 1.8;
      white-space: pre-wrap;
    }

    /* 回复表单 */
    .reply-form {
      padding-top: 25px;
      border-top: 2px solid rgba(93, 173, 226, 0.2);
    }

    .reply-form h4 {
      font-size: 18px;
      color: var(--text-dark);
      margin-bottom: 15px;
    }

    .reply-form textarea {
      width: 100%;
      padding: 15px;
      border: 2px solid rgba(93, 173, 226, 0.2);
      border-radius: 12px;
      font-size: 15px;
      min-height: 120px;
      resize: vertical;
      margin-bottom: 15px;
      font-family: var(--font-main);
      transition: all 0.3s;
    }

    .reply-form textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
    }

    .reply-form .btn-submit {
      padding: 12px 40px;
      background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
      color: white;
      border: none;
      border-radius: 25px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
      box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
    }

    .reply-form .btn-submit:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
    }

    /* 空状态 */
    .empty-replies {
      text-align: center;
      padding: 60px 20px;
      color: var(--text-light);
    }

    .empty-replies .icon {
      font-size: 50px;
      margin-bottom: 10px;
      opacity: 0.5;
    }

    /* 提示 */
    .alert {
      padding: 15px 20px;
      border-radius: 12px;
      margin-bottom: 20px;
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
      .header {
        padding: 15px 20px;
      }

      .main-content {
        padding: 0 15px;
      }

      .discussion-card, .reply-section {
        padding: 30px 25px;
      }

      .discussion-card .title {
        font-size: 22px;
      }

      .discussion-card .meta {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }
    }
  </style>
</head>
<body>
<!-- 顶部导航 -->
<div class="header">
  <a href="${pageContext.request.contextPath}/" class="logo">在线学习平台</a>
</div>

<!-- 主内容 -->
<div class="main-content">
  <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${discussion.courseId}" class="back-link">
    返回讨论列表
  </a>

  <!-- 话题卡片 -->
  <div class="discussion-card">
    <div class="title">${discussion.title}</div>
    <div class="meta">
              <span>
                  ${discussion.username}
                  <c:if test="${discussion.userRole == 'teacher'}">
                    <span class="role-badge">教师</span>
                  </c:if>
              </span>
      <span><fmt:formatDate value="${discussion.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
    </div>
    <div class="content">
      <c:choose>
        <c:when test="${not empty discussion.content}">
          ${discussion.content}
        </c:when>
        <c:otherwise>
          <span style="color: #999;">（暂无详细内容）</span>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- 回复区域 -->
  <div class="reply-section">
    <h3>${discussion.replyCount} 条回复</h3>

    <div id="alertBox"></div>

    <!-- 回复列表 -->
    <div class="reply-list">
      <c:choose>
        <c:when test="${not empty replyList}">
          <c:forEach var="reply" items="${replyList}">
            <div class="reply-item">
              <div class="reply-header">
                                  <span class="author">
                                      ${reply.username}
                                      <c:if test="${reply.userRole == 'teacher'}">
                                        <span class="role-badge">教师</span>
                                      </c:if>
                                  </span>
                <span class="time">
                                      <fmt:formatDate value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                  </span>
              </div>
              <div class="reply-content">${reply.content}</div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-replies">
            <div class="icon">o</div>
            <p>还没有回复，快来抢沙发吧！</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 回复表单 -->
    <div class="reply-form">
      <h4>发表回复</h4>
      <textarea id="replyContent" placeholder="写下你的回复..."></textarea>
      <button class="btn-submit" onclick="confirmSubmitReply()">发布回复</button>
    </div>
  </div>
</div>

<script>
  // 功能1: 确认提交回复
  function confirmSubmitReply() {
    // 获取回复内容
    var content = document.getElementById('replyContent').value.trim();

    // 验证内容
    if (!content) {
      showMessage('请输入回复内容', 'error');
      return;
    }

    // 提交回复
    submitReply(content);
  }

  // 功能2: 提交回复
  function submitReply(content) {
    // 构建请求数据
    var formData = 'discussionId=${discussion.id}&content=' + encodeURIComponent(content);

    // 发送请求
    sendReplyRequest(formData);
  }

  // 功能3: 发送回复请求
  function sendReplyRequest(data) {
    fetch('${pageContext.request.contextPath}/discussion/addReply.action', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: data
    })
            .then(function(response) {
              return response.json();
            })
            .then(function(result) {
              handleReplyResult(result);
            })
            .catch(function(error) {
              showMessage('请求失败，请重试', 'error');
            });
  }

  // 功能4: 处理回复结果
  function handleReplyResult(result) {
    // 显示消息
    if (result.success) {
      showMessage(result.message, 'success');
      // 1秒后刷新页面
      setTimeout(function() {
        location.reload();
      }, 1000);
    } else {
      showMessage(result.message, 'error');
    }
  }

  // 功能5: 显示提示消息
  function showMessage(message, type) {
    var alertBox = document.getElementById('alertBox');
    alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
  }
</script>
</body>
</html>