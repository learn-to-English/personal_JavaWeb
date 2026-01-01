<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${discussion.title} - 讨论详情</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: "Microsoft YaHei", Arial, sans-serif;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      min-height: 100vh;
      padding-bottom: 40px;
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
      max-width: 900px;
      margin: 30px auto;
      padding: 0 20px;
    }

    /* 返回按钮 */
    .back-link {
      display: inline-block;
      color: #667eea;
      text-decoration: none;
      margin-bottom: 20px;
      font-size: 14px;
    }

    /* 话题卡片 */
    .discussion-card {
      background: white;
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 25px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    }

    .discussion-card .title {
      font-size: 24px;
      color: #333;
      margin-bottom: 15px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .discussion-card .meta {
      display: flex;
      align-items: center;
      gap: 20px;
      padding-bottom: 20px;
      border-bottom: 2px solid #f0f0f0;
      margin-bottom: 20px;
      font-size: 14px;
      color: #999;
    }

    .discussion-card .content {
      font-size: 16px;
      color: #666;
      line-height: 1.8;
      white-space: pre-wrap;
    }

    .role-badge {
      display: inline-block;
      padding: 2px 8px;
      border-radius: 10px;
      font-size: 12px;
      background: #d4edda;
      color: #28a745;
    }

    /* 回复区域 */
    .reply-section {
      background: white;
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 25px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    }

    .reply-section h3 {
      font-size: 20px;
      color: #333;
      margin-bottom: 20px;
    }

    /* 回复列表 */
    .reply-list {
      margin-bottom: 30px;
    }

    .reply-item {
      padding: 20px 0;
      border-bottom: 1px solid #f0f0f0;
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
      color: #333;
    }

    .reply-item .reply-header .time {
      color: #999;
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
      border-top: 2px solid #f0f0f0;
    }

    .reply-form h4 {
      font-size: 16px;
      color: #333;
      margin-bottom: 15px;
    }

    .reply-form textarea {
      width: 100%;
      padding: 15px;
      border: 2px solid #e0e0e0;
      border-radius: 10px;
      font-size: 15px;
      min-height: 120px;
      resize: vertical;
      margin-bottom: 15px;
    }

    .reply-form textarea:focus {
      outline: none;
      border-color: #667eea;
    }

    .reply-form .btn-submit {
      padding: 12px 40px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 25px;
      font-size: 16px;
      cursor: pointer;
      transition: transform 0.3s;
    }

    .reply-form .btn-submit:hover {
      transform: scale(1.05);
    }

    /* 空状态 */
    .empty-replies {
      text-align: center;
      padding: 40px 20px;
      color: #999;
    }

    .empty-replies .icon {
      font-size: 50px;
      margin-bottom: 10px;
    }

    /* 提示 */
    .alert {
      padding: 15px 20px;
      border-radius: 10px;
      margin-bottom: 20px;
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
  <a href="${pageContext.request.contextPath}/discussion/list.action?courseId=${discussion.courseId}" class="back-link">
    ← 返回讨论列表
  </a>

  <!-- 话题卡片 -->
  <div class="discussion-card">
    <div class="title">
      <span>📌</span>
      <span>${discussion.title}</span>
    </div>
    <div class="meta">
                <span>
                    👤 ${discussion.username}
                    <c:if test="${discussion.userRole == 'teacher'}">
                      <span class="role-badge">教师</span>
                    </c:if>
                </span>
      <span>📅 <fmt:formatDate value="${discussion.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
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
    <h3>💬 ${discussion.replyCount} 条回复</h3>

    <div id="alertBox"></div>

    <!-- 回复列表 -->
    <div class="reply-list">
      <c:choose>
        <c:when test="${not empty replyList}">
          <c:forEach var="reply" items="${replyList}">
            <div class="reply-item">
              <div class="reply-header">
                                    <span class="author">
                                        👤 ${reply.username}
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
            <div class="icon">💭</div>
            <p>还没有回复，快来抢沙发吧！</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- 回复表单 -->
    <div class="reply-form">
      <h4>发表回复</h4>
      <textarea id="replyContent" placeholder="写下你的回复..."></textarea>
      <button class="btn-submit" onclick="submitReply()">发布回复</button>
    </div>
  </div>
</div>

<script>
  function submitReply() {
    var content = document.getElementById('replyContent').value.trim();

    if (!content) {
      showAlert('请输入回复内容', 'error');
      return;
    }

    var formData = 'discussionId=${discussion.id}&content=' + encodeURIComponent(content);

    fetch('${pageContext.request.contextPath}/discussion/addReply.action', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: formData
    })
            .then(response => response.json())
            .then(data => {
              showAlert(data.message, data.success ? 'success' : 'error');
              if (data.success) {
                setTimeout(function() {
                  location.reload();
                }, 1000);
              }
            })
            .catch(error => {
              showAlert('请求失败，请重试', 'error');
            });
  }

  function showAlert(message, type) {
    document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
  }
</script>
</body>
</html>
