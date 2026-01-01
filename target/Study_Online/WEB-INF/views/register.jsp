<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>注册 - 在线学习网站</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Microsoft YaHei", Arial, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .register-container {
      background: white;
      border-radius: 8px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 480px;
      padding: 40px;
    }

    .register-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .register-header h1 {
      color: #333;
      font-size: 28px;
      margin-bottom: 10px;
    }

    .register-header p {
      color: #999;
      font-size: 14px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: 500;
    }

    .form-group input, .form-group select {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
      transition: border-color 0.3s;
    }

    .form-group input:focus, .form-group select:focus {
      outline: none;
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    /* 角色选择样式 */
    .role-selection {
      display: flex;
      gap: 15px;
      margin-top: 10px;
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
      padding: 15px;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      text-align: center;
      cursor: pointer;
      transition: all 0.3s;
    }

    .role-option input[type="radio"]:checked + label {
      border-color: #667eea;
      background: #f0f4ff;
      color: #667eea;
      font-weight: 600;
    }

    .role-option label:hover {
      border-color: #667eea;
    }

    .role-option .role-icon {
      font-size: 30px;
      display: block;
      margin-bottom: 8px;
    }

    .role-option .role-name {
      font-size: 16px;
      display: block;
    }

    .role-option .role-desc {
      font-size: 12px;
      color: #999;
      display: block;
      margin-top: 5px;
    }

    .register-btn {
      width: 100%;
      padding: 12px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      font-weight: 500;
      cursor: pointer;
      margin-top: 10px;
      transition: transform 0.2s;
    }

    .register-btn:hover {
      transform: translateY(-2px);
    }

    .register-footer {
      text-align: center;
      margin-top: 20px;
      padding-top: 20px;
      border-top: 1px solid #eee;
    }

    .register-footer p {
      color: #999;
      font-size: 14px;
    }

    .register-footer a {
      color: #667eea;
      text-decoration: none;
      font-weight: 500;
    }

    .register-footer a:hover {
      text-decoration: underline;
    }

    .error-msg {
      color: #e74c3c;
      font-size: 14px;
      margin-top: 5px;
      display: none;
    }

    .success-msg {
      color: #27ae60;
      font-size: 14px;
      margin-top: 5px;
      display: none;
    }

    .username-check {
      font-size: 12px;
      margin-top: 5px;
      display: none;
    }

    .username-check.ok {
      color: #27ae60;
    }

    .username-check.error {
      color: #e74c3c;
    }
  </style>
</head>
<body>
<div class="register-container">
  <div class="register-header">
    <h1>注册</h1>
    <p>创建新账号开始学习</p>
  </div>

  <form id="registerForm">
    <!-- 角色选择 -->
    <div class="form-group">
      <label>选择角色</label>
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

    <div class="form-group">
      <label for="username">用户名</label>
      <input type="text" id="username" name="username" placeholder="请输入用户名" required>
      <div class="username-check" id="usernameCheck"></div>
      <div class="error-msg" id="usernameError"></div>
    </div>

    <div class="form-group">
      <label for="password">密码</label>
      <input type="password" id="password" name="password" placeholder="请输入密码（至少6位）" required>
      <div class="error-msg" id="passwordError"></div>
    </div>

    <div class="form-group">
      <label for="confirmPassword">确认密码</label>
      <input type="password" id="confirmPassword" name="confirmPassword" placeholder="请再次输入密码" required>
      <div class="error-msg" id="confirmPasswordError"></div>
    </div>

    <div class="form-group">
      <label for="email">邮箱（可选）</label>
      <input type="email" id="email" name="email" placeholder="请输入邮箱">
      <div class="error-msg" id="emailError"></div>
    </div>

    <div class="form-group">
      <label for="phone">手机号（可选）</label>
      <input type="tel" id="phone" name="phone" placeholder="请输入手机号">
      <div class="error-msg" id="phoneError"></div>
    </div>

    <button type="submit" class="register-btn">注册</button>
    <div class="error-msg" id="registerError"></div>
    <div class="success-msg" id="registerSuccess"></div>
  </form>

  <div class="register-footer">
    <p>已有账号？<a href="<%= request.getContextPath() %>/user/toLogin.action">立即登录</a></p>
  </div>
</div>

<script>
  // 实时检查用户名
  document.getElementById('username').addEventListener('blur', function() {
    var username = this.value.trim();
    var usernameCheck = document.getElementById('usernameCheck');
    var usernameError = document.getElementById('usernameError');

    if (username === '') {
      usernameCheck.style.display = 'none';
      usernameError.style.display = 'none';
      return;
    }

    if (username.length < 3) {
      usernameError.textContent = '用户名至少3个字符';
      usernameError.style.display = 'block';
      usernameCheck.style.display = 'none';
      return;
    }

    // 发送 AJAX 检查用户名
    fetch('<%= request.getContextPath() %>/user/checkUsername.action', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: 'username=' + encodeURIComponent(username)
    })
    .then(response => response.json())
    .then(data => {
      usernameError.style.display = 'none';
      if (data.exists) {
        usernameCheck.textContent = '用户名已被占用';
        usernameCheck.className = 'username-check error';
        usernameCheck.style.display = 'block';
      } else {
        usernameCheck.textContent = '用户名可用';
        usernameCheck.className = 'username-check ok';
        usernameCheck.style.display = 'block';
      }
    });
  });

  // 表单提交处理
  document.getElementById('registerForm').addEventListener('submit', function(e) {
    e.preventDefault();

    // 获取选中的角色
    var role = document.querySelector('input[name="role"]:checked').value;
    var username = document.getElementById('username').value.trim();
    var password = document.getElementById('password').value;
    var confirmPassword = document.getElementById('confirmPassword').value;
    var email = document.getElementById('email').value.trim();
    var phone = document.getElementById('phone').value.trim();

    // 隐藏所有错误信息
    document.querySelectorAll('.error-msg').forEach(el => el.style.display = 'none');

    // 参数验证
    var hasError = false;

    if (username === '') {
      document.getElementById('usernameError').textContent = '用户名不能为空';
      document.getElementById('usernameError').style.display = 'block';
      hasError = true;
    }

    if (username.length < 3) {
      document.getElementById('usernameError').textContent = '用户名至少3个字符';
      document.getElementById('usernameError').style.display = 'block';
      hasError = true;
    }

    if (password === '') {
      document.getElementById('passwordError').textContent = '密码不能为空';
      document.getElementById('passwordError').style.display = 'block';
      hasError = true;
    }

    if (password.length < 6) {
      document.getElementById('passwordError').textContent = '密码至少6个字符';
      document.getElementById('passwordError').style.display = 'block';
      hasError = true;
    }

    if (password !== confirmPassword) {
      document.getElementById('confirmPasswordError').textContent = '两次输入的密码不一致';
      document.getElementById('confirmPasswordError').style.display = 'block';
      hasError = true;
    }

    if (email !== '' && !isValidEmail(email)) {
      document.getElementById('emailError').textContent = '邮箱格式不正确';
      document.getElementById('emailError').style.display = 'block';
      hasError = true;
    }

    if (hasError) {
      return;
    }

    // 发送 AJAX 请求注册
    fetch('<%= request.getContextPath() %>/user/register.action', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: 'username=' + encodeURIComponent(username) +
              '&password=' + encodeURIComponent(password) +
              '&confirmPassword=' + encodeURIComponent(confirmPassword) +
              '&email=' + encodeURIComponent(email) +
              '&phone=' + encodeURIComponent(phone) +
              '&role=' + encodeURIComponent(role)  // 添加角色参数
    })
    .then(response => response.json())
    .then(data => {
      var registerError = document.getElementById('registerError');
      var registerSuccess = document.getElementById('registerSuccess');

      if (data.success) {
        registerSuccess.textContent = data.message;
        registerSuccess.style.display = 'block';
        registerError.style.display = 'none';

        // 清空表单
        document.getElementById('registerForm').reset();

        // 3 秒后重定向到登录页
        setTimeout(function() {
          window.location.href = '<%= request.getContextPath() %>/user/toLogin.action';
        }, 3000);
      } else {
        registerError.textContent = data.message;
        registerError.style.display = 'block';
        registerSuccess.style.display = 'none';
      }
    })
    .catch(error => {
      console.error('Error:', error);
      var registerError = document.getElementById('registerError');
      registerError.textContent = '注册请求失败，请检查网络';
      registerError.style.display = 'block';
    });
  });

  // 简单的邮箱验证
  function isValidEmail(email) {
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
</script>
</body>
</html>
