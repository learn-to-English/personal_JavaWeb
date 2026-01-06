<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 在线学习平台</title>
    <style>
        /* ====================
           全局样式重置
           ==================== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* ====================
           CSS变量 - 薄荷清新风配色
           ==================== */
        :root {
            /* 主色调 - 薄荷绿 */
            --primary: #56C596;
            --primary-light: #A8E6CF;
            --primary-dark: #3DB8B0;

            /* 辅助色 */
            --secondary: #FFD93D;    /* 阳光黄 */
            --accent: #FF9CEE;       /* 樱花粉 */

            /* 功能色 */
            --success: #51CF66;
            --error: #FF8787;

            /* 中性色 */
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --bg-card: #FFFFFF;
            --border: #E9ECEF;

            /* 字体 */
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;

            /* 圆角和阴影 */
            --radius-md: 15px;
            --radius-lg: 20px;
            --shadow-lg: 0 8px 24px rgba(86, 197, 150, 0.2);
        }

        /* ====================
           页面主体 - 薄荷绿渐变背景
           ==================== */
        body {
            font-family: var(--font-main);
            /* 薄荷绿渐变 */
            background: linear-gradient(135deg, #A8E6CF 0%, #56C596 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        /* ====================
           背景装饰元素 - 增加层次感
           ==================== */
        body::before {
            content: '🌿';
            position: absolute;
            font-size: 120px;
            opacity: 0.1;
            top: 10%;
            right: 10%;
            animation: float 6s ease-in-out infinite;
        }

        body::after {
            content: '🍃';
            position: absolute;
            font-size: 80px;
            opacity: 0.1;
            bottom: 15%;
            left: 10%;
            animation: float 8s ease-in-out infinite;
        }

        /* 漂浮动画 */
        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
        }

        /* ====================
           登录容器 - 白色卡片
           ==================== */
        .login-container {
            background: var(--bg-card);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 420px;
            padding: 45px 40px;
            position: relative;
            z-index: 1;
            /* 微妙的上升动画 */
            animation: slideUp 0.5s ease;
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

        /* ====================
           页面标题区域
           ==================== */
        .login-header {
            text-align: center;
            margin-bottom: 35px;
        }

        /* Logo图标 */
        .login-header .logo {
            font-size: 56px;
            margin-bottom: 15px;
            display: inline-block;
            animation: bounce 2s ease-in-out infinite;
        }

        /* 轻微弹跳动画 */
        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-8px);
            }
        }

        .login-header h1 {
            color: var(--text-dark);
            font-size: 28px;
            margin-bottom: 8px;
            font-weight: 700;
        }

        .login-header p {
            color: var(--text-light);
            font-size: 14px;
        }

        /* ====================
           表单组 - 统一样式
           ==================== */
        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
            /* 图标 + 文字 */
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* 输入框容器 */
        .input-wrapper {
            position: relative;
        }

        /* 输入框左侧图标 */
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: var(--text-light);
            z-index: 1;
        }

        /* 输入框样式 */
        .form-group input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid var(--border);
            border-radius: var(--radius-md);
            font-size: 15px;
            font-family: var(--font-main);
            transition: all 0.3s ease;
            background: #F8F9FA;
        }

        /* 输入框聚焦状态 */
        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            background: var(--bg-card);
            /* 薄荷绿发光效果 */
            box-shadow: 0 0 0 4px rgba(86, 197, 150, 0.15);
        }

        /* ====================
           提交按钮 - 薄荷绿渐变
           ==================== */
        .login-btn {
            width: 100%;
            padding: 15px;
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

        /* 按钮悬浮效果 */
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(86, 197, 150, 0.4);
        }

        /* 按钮点击效果 */
        .login-btn:active {
            transform: translateY(0);
        }

        /* 按钮涟漪效果 */
        .login-btn::before {
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

        .login-btn:hover::before {
            width: 300px;
            height: 300px;
        }

        /* ====================
           页脚链接区域
           ==================== */
        .login-footer {
            text-align: center;
            margin-top: 28px;
            padding-top: 28px;
            border-top: 1px solid var(--border);
        }

        .login-footer p {
            color: var(--text-light);
            font-size: 14px;
        }

        .login-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        /* 链接下划线动画 */
        .login-footer a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s ease;
        }

        .login-footer a:hover::after {
            width: 100%;
        }

        .login-footer a:hover {
            color: var(--primary-dark);
        }

        /* ====================
           错误/成功提示消息
           ==================== */
        .error-msg, .success-msg {
            font-size: 13px;
            margin-top: 10px;
            padding: 10px 14px;
            border-radius: 10px;
            display: none;
            animation: slideIn 0.3s ease;
        }

        /* 滑入动画 */
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

        /* 错误消息样式 */
        .error-msg {
            background: #FFE5E5;
            color: var(--error);
            border-left: 3px solid var(--error);
        }

        /* 成功消息样式 */
        .success-msg {
            background: #E7F5E9;
            color: var(--success);
            border-left: 3px solid var(--success);
        }

        /* ====================
           响应式设计 - 手机端适配
           ==================== */
        @media (max-width: 480px) {
            body {
                padding: 15px;
            }

            .login-container {
                padding: 35px 25px;
            }

            .login-header h1 {
                font-size: 24px;
            }

            .login-header .logo {
                font-size: 48px;
            }
        }

        /* ====================
           加载动画（可选）
           ==================== */
        .loading {
            pointer-events: none;
            opacity: 0.6;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
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
<!-- ====================
     登录表单容器
     功能：用户登录验证
     ==================== -->
<div class="login-container">
    <!--
        页面标题区域
        包含logo图标、标题和副标题
    -->
    <div class="login-header">
        <div class="logo">🎓</div>
        <h1>欢迎回来</h1>
        <p>登录你的学习账号，开启知识之旅</p>
    </div>

    <!--
        登录表单
        包含用户名和密码输入框
    -->
    <form id="loginForm">
        <!--
            用户名输入组
            必填项，用于用户身份识别
        -->
        <div class="form-group">
            <label for="username">
                <span>👤</span>
                <span>用户名</span>
            </label>
            <div class="input-wrapper">
                <span class="input-icon">👤</span>
                <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="请输入用户名"
                        required
                        autocomplete="username">
            </div>
            <!-- 用户名错误提示 -->
            <div class="error-msg" id="usernameError"></div>
        </div>

        <!--
            密码输入组
            必填项，用于用户身份验证
        -->
        <div class="form-group">
            <label for="password">
                <span>🔒</span>
                <span>密码</span>
            </label>
            <div class="input-wrapper">
                <span class="input-icon">🔒</span>
                <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="请输入密码"
                        required
                        autocomplete="current-password">
            </div>
            <!-- 密码错误提示 -->
            <div class="error-msg" id="passwordError"></div>
        </div>

        <!--
            提交按钮
            点击后触发登录验证
        -->
        <button type="submit" class="login-btn" id="loginBtn">
            <span>登 录</span>
        </button>

        <!--
            登录结果提示
            显示登录成功或失败的消息
        -->
        <div class="error-msg" id="loginError"></div>
        <div class="success-msg" id="loginSuccess"></div>
    </form>

    <!--
        页脚链接
        提供注册入口
    -->
    <div class="login-footer">
        <p>还没有账号？<a href="<%= request.getContextPath() %>/user/toRegister.action">立即注册</a></p>
    </div>
</div>

<script>
    /* ====================
       表单提交处理
       功能：验证表单并发送登录请求
       ==================== */
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        // 阻止表单默认提交行为
        e.preventDefault();

        // 获取表单输入值
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const loginBtn = document.getElementById('loginBtn');

        // 获取错误提示元素
        const usernameError = document.getElementById('usernameError');
        const passwordError = document.getElementById('passwordError');

        // 隐藏之前的错误提示
        hideAllErrors();

        /* ====================
           前端验证
           ==================== */
        // 验证用户名
        if (username === '') {
            showError(usernameError, '📝 用户名不能为空');
            return;
        }

        // 验证密码
        if (password === '') {
            showError(passwordError, '🔑 密码不能为空');
            return;
        }

        /* ====================
           发送登录请求
           ==================== */
        // 显示加载状态
        loginBtn.classList.add('loading');
        loginBtn.disabled = true;

        // 使用Fetch API发送POST请求
        fetch('<%= request.getContextPath() %>/user/login.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            // 将参数编码为URL格式
            body: 'username=' + encodeURIComponent(username) +
                '&password=' + encodeURIComponent(password)
        })
            .then(response => response.json()) // 解析JSON响应
            .then(data => {
                // 移除加载状态
                loginBtn.classList.remove('loading');
                loginBtn.disabled = false;

                // 处理登录结果
                handleLoginResponse(data);
            })
            .catch(error => {
                // 移除加载状态
                loginBtn.classList.remove('loading');
                loginBtn.disabled = false;

                // 处理网络错误
                console.error('登录请求失败:', error);
                showError(
                    document.getElementById('loginError'),
                    '❌ 网络错误，请检查连接后重试'
                );
            });
    });

    /* ====================
       处理登录响应
       参数：data - 服务器返回的JSON数据
            格式：{ success: boolean, message: string }
       ==================== */
    function handleLoginResponse(data) {
        const loginError = document.getElementById('loginError');
        const loginSuccess = document.getElementById('loginSuccess');

        if (data.success) {
            // 登录成功
            showSuccess(loginSuccess, '✅ ' + data.message + '，正在跳转...');

            // 2秒后跳转到首页
            setTimeout(function() {
                window.location.href = '<%= request.getContextPath() %>/';
            }, 2000);
        } else {
            // 登录失败
            showError(loginError, '❌ ' + data.message);
        }
    }

    /* ====================
       显示错误消息
       参数：element - 错误提示元素
            message - 错误信息
       ==================== */
    function showError(element, message) {
        element.textContent = message;
        element.style.display = 'block';
    }

    /* ====================
       显示成功消息
       参数：element - 成功提示元素
            message - 成功信息
       ==================== */
    function showSuccess(element, message) {
        element.textContent = message;
        element.style.display = 'block';
    }

    /* ====================
       隐藏所有错误提示
       用于清空之前的提示消息
       ==================== */
    function hideAllErrors() {
        // 使用querySelectorAll选择所有提示元素
        document.querySelectorAll('.error-msg, .success-msg').forEach(el => {
            el.style.display = 'none';
        });
    }

    /* ====================
       键盘快捷键（可选）
       按Enter键快速登录
       ==================== */
    document.getElementById('password').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            document.getElementById('loginForm').dispatchEvent(new Event('submit'));
        }
    });
</script>
</body>
</html>
