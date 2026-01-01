<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录 - 在线学习网站</title>
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
        }

        .login-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            padding: 40px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .login-header p {
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

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .login-btn {
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

        .login-btn:hover {
            transform: translateY(-2px);
        }

        .login-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .login-footer p {
            color: #999;
            font-size: 14px;
        }

        .login-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .login-footer a:hover {
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
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h1>登录</h1>
        <p>欢迎回到在线学习平台</p>
    </div>

    <form id="loginForm">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" placeholder="请输入用户名" required>
            <div class="error-msg" id="usernameError"></div>
        </div>

        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" placeholder="请输入密码" required>
            <div class="error-msg" id="passwordError"></div>
        </div>

        <button type="submit" class="login-btn">登录</button>
        <div class="error-msg" id="loginError"></div>
        <div class="success-msg" id="loginSuccess"></div>
    </form>

    <div class="login-footer">
        <p>还没有账号？<a href="<%= request.getContextPath() %>/user/toRegister.action">立即注册</a></p>
    </div>
</div>

<script>
    // 表单提交处理
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        e.preventDefault();

        // 获取表单数据
        var username = document.getElementById('username').value;
        var password = document.getElementById('password').value;

        // 参数验证
        var usernameError = document.getElementById('usernameError');
        var passwordError = document.getElementById('passwordError');
        usernameError.style.display = 'none';
        passwordError.style.display = 'none';

        if (username === '') {
            usernameError.textContent = '用户名不能为空';
            usernameError.style.display = 'block';
            return;
        }

        if (password === '') {
            passwordError.textContent = '密码不能为空';
            passwordError.style.display = 'block';
            return;
        }

        // 发送 AJAX 请求
        fetch('<%= request.getContextPath() %>/user/login.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(password)
        })
            .then(response => response.json())
            .then(data => {
                var loginError = document.getElementById('loginError');
                var loginSuccess = document.getElementById('loginSuccess');

                if (data.success) {
                    loginSuccess.textContent = data.message;
                    loginSuccess.style.display = 'block';
                    loginError.style.display = 'none';

                    // 3 秒后重定向到首页
                    setTimeout(function() {
                        window.location.href = '<%= request.getContextPath() %>/';
                    }, 3000);
                } else {
                    loginError.textContent = data.message;
                    loginError.style.display = 'block';
                    loginSuccess.style.display = 'none';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                var loginError = document.getElementById('loginError');
                loginError.textContent = '登录请求失败，请检查网络';
                loginError.style.display = 'block';
            });
    });
</script>
</body>
</html>
