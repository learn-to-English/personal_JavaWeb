<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>注册 - 在线学习平台</title>
  <style>
    /* 全局重置 */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* CSS变量 */
    :root {
      --primary: #56C596;
      --primary-light: #A8E6CF;
      --primary-dark: #3DB8B0;
      --secondary: #FFD93D;
      --success: #51CF66;
      --error: #FF8787;
      --text-dark: #2C3E50;
      --text-light: #7F8C8D;
      --bg-card: #FFFFFF;
      --border: #E9ECEF;
      --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
      --radius-md: 15px;
      --radius-lg: 20px;
      --shadow-lg: 0 8px 24px rgba(86, 197, 150, 0.2);
    }

    /* 页面主体 */
    body {
      font-family: var(--font-main);
      background: linear-gradient(135deg, #A8E6CF 0%, #56C596 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
      position: relative;
    }

    /* 背景装饰 */
    body::before {
      content: '🌱';
      position: absolute;
      font-size: 100px;
      opacity: 0.1;
      top: 8%;
      right: 12%;
      animation: float 7s ease-in-out infinite;
    }

    body::after {
      content: '🌿';
      position: absolute;
      font-size: 90px;
      opacity: 0.1;
      bottom: 12%;
      left: 8%;
      animation: float 9s ease-in-out infinite;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0) rotate(0deg); }
      50% { transform: translateY(-15px) rotate(3deg); }
    }

    /* 注册容器 - 关键修改：添加最大高度和滚动 */
    .register-container {
      background: var(--bg-card);
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-lg);
      width: 100%;
      max-width: 480px;
      max-height: 90vh;  /* 最大高度90%视口 */
      overflow-y: auto;  /* 垂直滚动 */
      padding: 35px 38px;
      position: relative;
      z-index: 1;
      animation: slideUp 0.5s ease;
    }

    /* 滚动条美化 */
    .register-container::-webkit-scrollbar {
      width: 8px;
    }

    .register-container::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 10px;
    }

    .register-container::-webkit-scrollbar-thumb {
      background: var(--primary-light);
      border-radius: 10px;
    }

    .register-container::-webkit-scrollbar-thumb:hover {
      background: var(--primary);
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* 页面标题 */
    .register-header {
      text-align: center;
      margin-bottom: 25px;
      position: sticky;
      top: 0;
      background: var(--bg-card);
      padding: 10px 0;
      z-index: 10;
    }

    .register-header .logo {
      font-size: 48px;
      margin-bottom: 10px;
      display: inline-block;
    }

    .register-header h1 {
      color: var(--text-dark);
      font-size: 24px;
      margin-bottom: 5px;
      font-weight: 700;
    }

    .register-header p {
      color: var(--text-light);
      font-size: 13px;
    }

    /* 表单组 */
    .form-group {
      margin-bottom: 16px;
    }

    .form-group label {
      display: block;
      margin-bottom: 7px;
      color: var(--text-dark);
      font-weight: 600;
      font-size: 13px;
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .input-wrapper {
      position: relative;
    }

    .input-icon {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 16px;
      color: var(--text-light);
    }

    .form-group input {
      width: 100%;
      padding: 12px 14px 12px 42px;
      border: 2px solid var(--border);
      border-radius: var(--radius-md);
      font-size: 14px;
      font-family: var(--font-main);
      transition: all 0.3s ease;
      background: #F8F9FA;
    }

    .form-group input:focus {
      outline: none;
      border-color: var(--primary);
      background: var(--bg-card);
      box-shadow: 0 0 0 4px rgba(86, 197, 150, 0.15);
    }

    /* 角色选择 */
    .role-selection {
      display: flex;
      gap: 10px;
      margin-top: 8px;
    }

    .role-option {
      flex: 1;
      position: relative;
    }

    .role-option input[type="radio"] {
      display: none;
    }

    .role-option label {
      display: block;
      padding: 14px 10px;
      border: 2px solid var(--border);
      border-radius: var(--radius-md);
      text-align: center;
      cursor: pointer;
      transition: all 0.3s ease;
      background: #F8F9FA;
    }

    .role-option input[type="radio"]:checked + label {
      border-color: var(--primary);
      background: linear-gradient(135deg, rgba(168, 230, 207, 0.2) 0%, rgba(86, 197, 150, 0.1) 100%);
      box-shadow: 0 4px 12px rgba(86, 197, 150, 0.2);
    }

    .role-option label:hover {
      border-color: var(--primary);
      transform: translateY(-2px);
    }

    .role-icon {
      font-size: 28px;
      display: block;
      margin-bottom: 5px;
    }

    .role-name {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-dark);
      display: block;
    }

    .role-desc {
      font-size: 11px;
      color: var(--text-light);
      display: block;
      margin-top: 2px;
    }

    /* 用户名检查 */
    .username-check {
      font-size: 12px;
      margin-top: 6px;
      padding: 6px 10px;
      border-radius: 8px;
      display: none;
      animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
      from {
        opacity: 0;
        transform: translateY(-8px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .username-check.ok {
      background: #E7F5E9;
      color: var(--success);
      border-left: 3px solid var(--success);
    }

    .username-check.error {
      background: #FFE5E5;
      color: var(--error);
      border-left: 3px solid var(--error);
    }

    /* 提交按钮 */
    .register-btn {
      width: 100%;
      padding: 13px;
      background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
      color: white;
      border: none;
      border-radius: var(--radius-lg);
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      margin-top: 10px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 12px rgba(86, 197, 150, 0.3);
      position: relative;
      overflow: hidden;
    }

    .register-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(86, 197, 150, 0.4);
    }

    .register-btn:active {
      transform: translateY(0);
    }

    .register-btn::before {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 0;
      height: 0;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.3);
      transform: translate(-50%, -50%);
      transition: width 0.6s, height 0.6s;
    }

    .register-btn:hover::before {
      width: 300px;
      height: 300px;
    }

    /* 页脚链接 */
    .register-footer {
      text-align: center;
      margin-top: 20px;
      padding-top: 20px;
      border-top: 1px solid var(--border);
    }

    .register-footer p {
      color: var(--text-light);
      font-size: 13px;
    }

    .register-footer a {
      color: var(--primary);
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s ease;
      position: relative;
    }

    .register-footer a::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 0;
      height: 2px;
      background: var(--primary);
      transition: width 0.3s ease;
    }

    .register-footer a:hover::after {
      width: 100%;
    }

    .register-footer a:hover {
      color: var(--primary-dark);
    }

    /* 错误/成功提示 */
    .error-msg, .success-msg {
      font-size: 12px;
      margin-top: 6px;
      padding: 7px 10px;
      border-radius: 10px;
      display: none;
      animation: slideIn 0.3s ease;
    }

    .error-msg {
      background: #FFE5E5;
      color: var(--error);
      border-left: 3px solid var(--error);
    }

    .success-msg {
      background: #E7F5E9;
      color: var(--success);
      border-left: 3px solid var(--success);
    }

    /* 响应式设计 */
    @media (max-width: 480px) {
      body {
        padding: 10px;
      }

      .register-container {
        padding: 25px 20px;
        max-height: 95vh;
      }

      .register-header h1 {
        font-size: 22px;
      }

      .register-header .logo {
        font-size: 42px;
      }
    }

    /* 加载状态 */
    .loading {
      pointer-events: none;
      opacity: 0.6;
    }

    .loading::after {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 18px;
      height: 18px;
      margin: -9px 0 0 -9px;
      border: 3px solid white;
      border-radius: 50%;
      border-top-color: transparent;
      animation: spin 0.8s linear infinite;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
<div class="register-container">
  <!-- 标题 -->
  <div class="register-header">
    <div class="logo">✨</div>
    <h1>加入我们</h1>
    <p>开启学习之旅</p>
  </div>

  <!-- 表单 -->
  <form id="registerForm">
    <!-- 角色选择 -->
    <div class="form-group">
      <label>👥 选择身份</label>
      <div class="role-selection">
        <div class="role-option">
          <input type="radio" name="role" id="roleStudent" value="student" checked>
          <label for="roleStudent">
            <span class="role-icon">🎓</span>
            <span class="role-name">学生</span>
            <span class="role-desc">学习课程</span>
          </label>
        </div>
        <div class="role-option">
          <input type="radio" name="role" id="roleTeacher" value="teacher">
          <label for="roleTeacher">
            <span class="role-icon">👨‍🏫</span>
            <span class="role-name">教师</span>
            <span class="role-desc">发布课程</span>
          </label>
        </div>
      </div>
    </div>

    <!-- 用户名 -->
    <div class="form-group">
      <label for="username">
        <span>👤</span>
        <span>用户名</span>
      </label>
      <div class="input-wrapper">
        <span class="input-icon">👤</span>
        <input type="text" id="username" name="username" placeholder="3个字符以上" required>
      </div>
      <div class="username-check" id="usernameCheck"></div>
      <div class="error-msg" id="usernameError"></div>
    </div>

    <!-- 密码 -->
    <div class="form-group">
      <label for="password">
        <span>🔒</span>
        <span>密码</span>
      </label>
      <div class="input-wrapper">
        <span class="input-icon">🔒</span>
        <input type="password" id="password" name="password" placeholder="6位以上" required>
      </div>
      <div class="error-msg" id="passwordError"></div>
    </div>

    <!-- 确认密码 -->
    <div class="form-group">
      <label for="confirmPassword">
        <span>🔑</span>
        <span>确认密码</span>
      </label>
      <div class="input-wrapper">
        <span class="input-icon">🔑</span>
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="再次输入" required>
      </div>
      <div class="error-msg" id="confirmPasswordError"></div>
    </div>

    <!-- 邮箱 -->
    <div class="form-group">
      <label for="email">
        <span>📧</span>
        <span>邮箱（可选）</span>
      </label>
      <div class="input-wrapper">
        <span class="input-icon">📧</span>
        <input type="email" id="email" name="email" placeholder="选填">
      </div>
      <div class="error-msg" id="emailError"></div>
    </div>

    <!-- 手机 -->
    <div class="form-group">
      <label for="phone">
        <span>📱</span>
        <span>手机（可选）</span>
      </label>
      <div class="input-wrapper">
        <span class="input-icon">📱</span>
        <input type="tel" id="phone" name="phone" placeholder="选填">
      </div>
      <div class="error-msg" id="phoneError"></div>
    </div>

    <!-- 提交按钮 -->
    <button type="submit" class="register-btn" id="registerBtn">
      <span>立即注册</span>
    </button>

    <div class="error-msg" id="registerError"></div>
    <div class="success-msg" id="registerSuccess"></div>
  </form>

  <!-- 页脚 -->
  <div class="register-footer">
    <p>已有账号？<a href="<%= request.getContextPath() %>/user/toLogin.action">去登录</a></p>
  </div>
</div>

<script>
  // 实时检查用户名
  document.getElementById('username').addEventListener('blur', function() {
    const username = this.value.trim();
    const usernameCheck = document.getElementById('usernameCheck');
    const usernameError = document.getElementById('usernameError');

    usernameCheck.style.display = 'none';
    usernameError.style.display = 'none';

    if (username === '') return;

    if (username.length < 3) {
      showError(usernameError, '❌ 至少3个字符');
      return;
    }

    fetch('<%= request.getContextPath() %>/user/checkUsername.action', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'username=' + encodeURIComponent(username)
    })
            .then(response => response.json())
            .then(data => {
              if (data.exists) {
                usernameCheck.textContent = '❌ 已被占用';
                usernameCheck.className = 'username-check error';
              } else {
                usernameCheck.textContent = '✅ 可用';
                usernameCheck.className = 'username-check ok';
              }
              usernameCheck.style.display = 'block';
            })
            .catch(() => {
              showError(usernameError, '⚠️ 检查失败');
            });
  });

  // 表单提交
  document.getElementById('registerForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const role = document.querySelector('input[name="role"]:checked').value;
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const registerBtn = document.getElementById('registerBtn');

    hideAllErrors();

    let hasError = false;

    if (username === '' || username.length < 3) {
      showError(document.getElementById('usernameError'), '❌ 用户名至少3个字符');
      hasError = true;
    }

    if (password === '' || password.length < 6) {
      showError(document.getElementById('passwordError'), '❌ 密码至少6位');
      hasError = true;
    }

    if (password !== confirmPassword) {
      showError(document.getElementById('confirmPasswordError'), '❌ 两次密码不一致');
      hasError = true;
    }

    if (email !== '' && !isValidEmail(email)) {
      showError(document.getElementById('emailError'), '❌ 邮箱格式错误');
      hasError = true;
    }

    if (hasError) return;

    registerBtn.classList.add('loading');
    registerBtn.disabled = true;

    fetch('<%= request.getContextPath() %>/user/register.action', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'username=' + encodeURIComponent(username) +
              '&password=' + encodeURIComponent(password) +
              '&confirmPassword=' + encodeURIComponent(confirmPassword) +
              '&email=' + encodeURIComponent(email) +
              '&phone=' + encodeURIComponent(phone) +
              '&role=' + encodeURIComponent(role)
    })
            .then(response => response.json())
            .then(data => {
              registerBtn.classList.remove('loading');
              registerBtn.disabled = false;

              const registerError = document.getElementById('registerError');
              const registerSuccess = document.getElementById('registerSuccess');

              if (data.success) {
                showSuccess(registerSuccess, '✅ ' + data.message + '，即将跳转...');
                document.getElementById('registerForm').reset();

                setTimeout(() => {
                  window.location.href = '<%= request.getContextPath() %>/user/toLogin.action';
                }, 2000);
              } else {
                showError(registerError, '❌ ' + data.message);
              }
            })
            .catch(() => {
              registerBtn.classList.remove('loading');
              registerBtn.disabled = false;
              showError(document.getElementById('registerError'), '❌ 网络错误');
            });
  });

  function showError(element, message) {
    element.textContent = message;
    element.style.display = 'block';
  }

  function showSuccess(element, message) {
    element.textContent = message;
    element.style.display = 'block';
  }

  function hideAllErrors() {
    document.querySelectorAll('.error-msg, .success-msg').forEach(el => {
      el.style.display = 'none';
    });
  }

  function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }
</script>
</body>
</html>
