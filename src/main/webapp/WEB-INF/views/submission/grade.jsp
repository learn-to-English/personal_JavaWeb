<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>批改作业 - 在线学习平台</title>
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
      margin-bottom: 25px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    /* 已批改标签 */
    .readonly-badge {
      display: inline-block;
      padding: 6px 18px;
      background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
      color: #2E7D32;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 600;
      margin-bottom: 20px;
    }

    /* 信息区域 */
    .info-section {
      background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
      padding: 25px;
      border-radius: 15px;
      margin-bottom: 25px;
      border: 1px solid rgba(93, 173, 226, 0.2);
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

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 2px solid rgba(93, 173, 226, 0.2);
      border-radius: 12px;
      font-size: 15px;
      font-family: var(--font-main);
      transition: all 0.3s;
      background: rgba(255, 255, 255, 0.9);
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
      background: white;
    }

    .form-group input:read-only,
    .form-group textarea:read-only {
      background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
      cursor: not-allowed;
      color: var(--text-light);
    }

    .form-group textarea {
      min-height: 140px;
      resize: vertical;
    }

    /* 按钮组 */
    .form-actions {
      display: flex;
      gap: 15px;
      margin-top: 30px;
    }

    .btn {
      flex: 1;
      padding: 16px;
      border: none;
      border-radius: 12px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      text-align: center;
      transition: all 0.3s;
      display: inline-block;
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
      background: white;
      border-color: var(--primary-light);
    }

    /* 提示消息 */
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
      color: #FF8787;
      border-left: 4px solid #FF8787;
    }

    .alert-info {
      background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
      color: var(--primary-dark);
      border-left: 4px solid var(--primary-dark);
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

      .form-actions {
        flex-direction: column;
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
    <h2>✍️ 批改作业 - ${assignment.title}</h2>

    <%-- 判断：如果已经批改过，显示标签 --%>
    <c:if test="${submission.status == 'graded'}">
      <span class="readonly-badge">✅ 已批改</span>
    </c:if>

    <!-- 学生信息 -->
    <div class="info-section">
      <h3>👤 学生信息</h3>
      <div class="content">
        学生：${submission.studentName}<br>
        提交时间：<fmt:formatDate value="${submission.submitTime}" pattern="yyyy-MM-dd HH:mm"/>
      </div>
    </div>

    <!-- 学生答案 -->
    <div class="info-section">
      <h3>📝 学生答案</h3>
      <div class="content">${submission.content}</div>
    </div>

    <%-- 提示消息显示区域 --%>
    <div id="alertBox"></div>

    <%-- 判断：已批改还是未批改 --%>
    <c:choose>
      <%-- 情况1：已批改，只能查看 --%>
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
      <%-- 情况2：未批改，可以打分 --%>
      <c:otherwise>
        <div class="form-group">
          <label>得分（满分${assignment.totalScore}分）：</label>
          <input type="number" id="score" min="0" max="${assignment.totalScore}" placeholder="请输入分数">
        </div>

        <div class="form-group">
          <label>评语（可选）：</label>
          <textarea id="feedback" placeholder="请输入评语"></textarea>
        </div>

        <div class="form-actions">
          <a href="${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}" class="btn btn-secondary">取消</a>
          <button onclick="submitGrade()" class="btn btn-primary">提交批改</button>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
  // ========== 第1个函数：提交批改 ==========
  function submitGrade() {
    // 步骤1：获取分数输入框的值
    var score = document.getElementById('score').value;

    // 步骤2：获取评语输入框的值
    var feedback = document.getElementById('feedback').value;

    // 步骤3：去掉评语前后的空格
    feedback = feedback.trim();

    // 步骤4：判断是否输入了分数
    if (score == '') {
      showMessage('❌ 请输入分数', 'error');
      return;  // 停止执行
    }

    // 步骤5：判断分数是否在有效范围内
    var maxScore = ${assignment.totalScore};
    if (score < 0 || score > maxScore) {
      showMessage('❌ 分数必须在0-' + maxScore + '之间', 'error');
      return;  // 停止执行
    }

    // 步骤6：准备要发送的数据
    var data = 'submissionId=${submission.id}&score=' + score + '&feedback=' + encodeURIComponent(feedback);

    // 步骤7：发送请求到后端
    sendGradeRequest(data);
  }

  // ========== 第2个函数：发送批改请求到后端 ==========
  function sendGradeRequest(data) {
    fetch('${pageContext.request.contextPath}/submission/grade.action', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: data
    })
            .then(function(response) {
              // 步骤1：把后端返回的数据转成JSON对象
              return response.json();
            })
            .then(function(result) {
              // 步骤2：处理后端返回的结果
              handleGradeResult(result);
            })
            .catch(function(error) {
              // 如果请求失败，显示错误消息
              showMessage('❌ 请求失败，请重试', 'error');
            });
  }

  // ========== 第3个函数：处理批改结果 ==========
  function handleGradeResult(result) {
    // 判断1：如果批改成功
    if (result.success == true) {
      // 显示成功消息
      showMessage('✅ ' + result.message, 'success');

      // 等待1.5秒后跳转到提交列表页面
      setTimeout(function() {
        window.location.href = '${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}';
      }, 1500);
    } else {
      // 判断2：如果批改失败
      showMessage('❌ ' + result.message, 'error');
    }
  }

  // ========== 第4个函数：显示提示消息 ==========
  function showMessage(message, type) {
    // 找到提示消息的容器
    var alertBox = document.getElementById('alertBox');

    // 在容器里放入提示消息的HTML
    alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
  }
</script>
</body>
</html>