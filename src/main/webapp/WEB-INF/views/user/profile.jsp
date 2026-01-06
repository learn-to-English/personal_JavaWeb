<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - 在线学习平台</title>
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
            padding: 40px 20px;
        }

        /* 页面标题 */
        .header {
            max-width: 900px;
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

        /* 主容器 */
        .main-container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* 用户卡片 - 白色半透明 */
        .user-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        /* 头像区域 */
        .avatar-section {
            display: flex;
            align-items: center;
            gap: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid rgba(93, 173, 226, 0.2);
            margin-bottom: 30px;
        }

        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.4);
        }

        .user-info h2 {
            font-size: 28px;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        /* 角色标签 */
        .role-badge {
            display: inline-block;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .role-badge.role-student {
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            color: var(--primary-dark);
        }

        .role-badge.role-teacher {
            background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
            color: #2E7D32;
        }

        .role-badge.role-admin {
            background: linear-gradient(135deg, #FCE4EC 0%, #F8BBD0 100%);
            color: #C2185B;
        }

        /* 信息列表网格 - 2行2列固定布局 */
        .info-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            padding: 20px;
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            border-radius: 12px;
            border: 1px solid rgba(93, 173, 226, 0.2);
            transition: all 0.3s;
        }

        .info-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.2);
            border-color: var(--primary-light);
        }

        .info-item .icon {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .info-item .label {
            font-size: 13px;
            color: var(--text-light);
            margin-bottom: 8px;
        }

        .info-item .value {
            font-size: 17px;
            color: var(--text-dark);
            font-weight: 600;
        }

        /* 操作按钮 */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
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
            background: linear-gradient(135deg, #FFE082 0%, #FFD93D 100%);
            color: var(--text-dark);
            box-shadow: 0 5px 15px rgba(255, 217, 61, 0.3);
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 217, 61, 0.4);
        }

        /* 修改密码弹窗 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .modal-content h3 {
            margin-bottom: 25px;
            color: var(--text-dark);
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-dark);
            font-weight: 600;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #E9ECEF;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
        }

        .modal-buttons {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .modal-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .modal-btn.cancel {
            background: #F0F0F0;
            color: #666;
        }

        .modal-btn.cancel:hover {
            background: #E0E0E0;
        }

        .modal-btn.submit {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
        }

        .modal-btn.submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        /* 提示消息 */
        .alert {
            padding: 12px 15px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 15px;
        }

        .alert-success {
            background: #E7F5E9;
            color: var(--success);
        }

        .alert-error {
            background: #FFE5E5;
            color: #FF8787;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            body {
                padding: 20px 15px;
            }

            .header h1 {
                font-size: 26px;
            }

            .user-card {
                padding: 25px;
            }

            .avatar-section {
                flex-direction: column;
                text-align: center;
            }

            .info-list {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- 页面标题 -->
<div class="header">
    <h1>👤 个人中心</h1>
    <p class="subtitle">管理您的个人信息和账户设置</p>
    <a href="${pageContext.request.contextPath}/home.action" class="back-link">← 返回首页</a>
</div>

<!-- 主容器 -->
<div class="main-container">
    <div class="user-card">
        <!-- 头像区域 -->
        <div class="avatar-section">
            <div class="avatar">👤</div>
            <div class="user-info">
                <h2>${user.username}</h2>
                <span class="role-badge role-${user.role}">
                        <c:choose>
                            <c:when test="${user.role == 'admin'}">🔑 管理员</c:when>
                            <c:when test="${user.role == 'teacher'}">👨‍🏫 教师</c:when>
                            <c:otherwise>🎓 学生</c:otherwise>
                        </c:choose>
                    </span>
            </div>
        </div>

        <!-- 信息列表 -->
        <div class="info-list">
            <div class="info-item">
                <div class="icon">📧</div>
                <div class="label">邮箱</div>
                <div class="value">
                    <c:choose>
                        <c:when test="${not empty user.email}">${user.email}</c:when>
                        <c:otherwise>未设置</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-item">
                <div class="icon">📱</div>
                <div class="label">手机号</div>
                <div class="value">
                    <c:choose>
                        <c:when test="${not empty user.phone}">${user.phone}</c:when>
                        <c:otherwise>未设置</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-item">
                <div class="icon">🆔</div>
                <div class="label">用户ID</div>
                <div class="value">#${user.id}</div>
            </div>

            <div class="info-item">
                <div class="icon">📅</div>
                <div class="label">注册时间</div>
                <div class="value">
                    <c:choose>
                        <c:when test="${not empty user.createTime}">${user.createTime}</c:when>
                        <c:otherwise>未知</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- 操作按钮 -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/user/toEditProfile.action" class="btn btn-primary">
                ✏️ 编辑资料
            </a>
            <button onclick="showPasswordModal()" class="btn btn-secondary">
                🔑 修改密码
            </button>
        </div>
    </div>
</div>

<!-- 修改密码弹窗 -->
<div id="passwordModal" class="modal">
    <div class="modal-content">
        <h3>🔑 修改密码</h3>

        <div id="passwordAlert"></div>

        <div class="form-group">
            <label>原密码</label>
            <input type="password" id="oldPassword" placeholder="请输入原密码">
        </div>

        <div class="form-group">
            <label>新密码</label>
            <input type="password" id="newPassword" placeholder="至少6位">
        </div>

        <div class="form-group">
            <label>确认新密码</label>
            <input type="password" id="confirmPassword" placeholder="再次输入新密码">
        </div>

        <div class="modal-buttons">
            <button onclick="hidePasswordModal()" class="modal-btn cancel">取消</button>
            <button onclick="submitPassword()" class="modal-btn submit">确认修改</button>
        </div>
    </div>
</div>

<script>
    // 显示密码弹窗
    function showPasswordModal() {
        document.getElementById('passwordModal').style.display = 'flex';
    }

    // 隐藏密码弹窗
    function hidePasswordModal() {
        document.getElementById('passwordModal').style.display = 'none';
        document.getElementById('oldPassword').value = '';
        document.getElementById('newPassword').value = '';
        document.getElementById('confirmPassword').value = '';
        document.getElementById('passwordAlert').innerHTML = '';
    }

    // 提交密码修改
    function submitPassword() {
        const oldPassword = document.getElementById('oldPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        // 验证
        if (!oldPassword) {
            showAlert('❌ 请输入原密码', 'error');
            return;
        }

        if (!newPassword) {
            showAlert('❌ 请输入新密码', 'error');
            return;
        }

        if (newPassword.length < 6) {
            showAlert('❌ 新密码至少6位', 'error');
            return;
        }

        if (newPassword !== confirmPassword) {
            showAlert('❌ 两次密码不一致', 'error');
            return;
        }

        // 发送请求
        const formData = 'oldPassword=' + encodeURIComponent(oldPassword) +
            '&newPassword=' + encodeURIComponent(newPassword) +
            '&confirmPassword=' + encodeURIComponent(confirmPassword);

        fetch('${pageContext.request.contextPath}/user/changePassword.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                showAlert(data.success ? '✅ ' + data.message : '❌ ' + data.message,
                    data.success ? 'success' : 'error');

                if (data.success) {
                    setTimeout(() => hidePasswordModal(), 1500);
                }
            })
            .catch(() => {
                showAlert('❌ 请求失败', 'error');
            });
    }

    // 显示提示
    function showAlert(message, type) {
        document.getElementById('passwordAlert').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>
