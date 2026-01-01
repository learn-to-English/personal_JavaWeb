<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .header {
            max-width: 900px;
            margin: 0 auto 30px;
            color: white;
        }

        .header h1 {
            font-size: 32px;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }

        .header .subtitle {
            font-size: 16px;
            opacity: 0.9;
        }

        .back-link {
            display: inline-block;
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            background: rgba(255,255,255,0.2);
            border-radius: 25px;
            margin-top: 15px;
            transition: all 0.3s;
        }

        .back-link:hover {
            background: rgba(255,255,255,0.3);
        }

        .main-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .user-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }

        .avatar-section {
            display: flex;
            align-items: center;
            gap: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 30px;
        }

        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            color: white;
            box-shadow: 0 10px 30px rgba(102,126,234,0.3);
        }

        .user-info {
            flex: 1;
        }

        .user-info h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }

        .role-badge {
            display: inline-block;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .role-student {
            background: #e7f3ff;
            color: #667eea;
        }

        .role-teacher {
            background: #d4edda;
            color: #28a745;
        }

        .role-admin {
            background: #f8d7da;
            color: #dc3545;
        }

        .info-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            transition: all 0.3s;
        }

        .info-item:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }

        .info-item .label {
            font-size: 13px;
            color: #999;
            margin-bottom: 8px;
        }

        .info-item .value {
            font-size: 18px;
            color: #333;
            font-weight: 600;
        }

        .info-item .icon {
            font-size: 24px;
            margin-bottom: 10px;
        }

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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102,126,234,0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(240,147,251,0.3);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(240,147,251,0.4);
        }
    </style>
</head>
<body>
<div class="header">
    <h1>👤 个人中心</h1>
    <p class="subtitle">管理您的个人信息和账户设置</p>
    <a href="${pageContext.request.contextPath}/home.action" class="back-link">← 返回首页</a>
</div>

<div class="main-container">
    <div class="user-card">
        <div class="avatar-section">
            <div class="avatar">👤</div>
            <div class="user-info">
                <h2>${user.username}</h2>
                <span class="role-badge role-${user.role}">
                        <c:choose>
                            <c:when test="${user.role == 'admin'}">管理员</c:when>
                            <c:when test="${user.role == 'teacher'}">教师</c:when>
                            <c:otherwise>学生</c:otherwise>
                        </c:choose>
                    </span>
            </div>
        </div>

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
                <div class="value">${user.id}</div>
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

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/user/toEditProfile.action" class="btn btn-primary">✏️ 编辑资料</a>
            <a href="#" class="btn btn-secondary" onclick="showChangePasswordModal(); return false;">🔑 修改密码</a>
        </div>
    </div>
</div>

<div id="passwordModal" style="display:none; position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,0.5); z-index:1000; align-items:center; justify-content:center;">
    <div style="background:white; border-radius:20px; padding:40px; max-width:500px; width:90%;">
        <h3 style="margin-bottom:25px; color:#333;">🔑 修改密码</h3>
        <div style="margin-bottom:20px;">
            <label style="display:block; margin-bottom:8px; color:#666; font-weight:600;">原密码</label>
            <input type="password" id="oldPassword" style="width:100%; padding:12px; border:2px solid #e0e0e0; border-radius:8px; font-size:15px;">
        </div>
        <div style="margin-bottom:20px;">
            <label style="display:block; margin-bottom:8px; color:#666; font-weight:600;">新密码</label>
            <input type="password" id="newPassword" style="width:100%; padding:12px; border:2px solid #e0e0e0; border-radius:8px; font-size:15px;">
        </div>
        <div style="margin-bottom:25px;">
            <label style="display:block; margin-bottom:8px; color:#666; font-weight:600;">确认新密码</label>
            <input type="password" id="confirmPassword" style="width:100%; padding:12px; border:2px solid #e0e0e0; border-radius:8px; font-size:15px;">
        </div>
        <div id="passwordAlert" style="margin-bottom:15px;"></div>
        <div style="display:flex; gap:15px;">
            <button onclick="hideChangePasswordModal()" style="flex:1; padding:12px; background:#f0f0f0; border:none; border-radius:8px; cursor:pointer; font-size:15px;">取消</button>
            <button onclick="submitChangePassword()" style="flex:1; padding:12px; background:linear-gradient(135deg, #667eea 0%, #764ba2 100%); color:white; border:none; border-radius:8px; cursor:pointer; font-size:15px; font-weight:600;">确认修改</button>
        </div>
    </div>
</div>

<script>
    function showChangePasswordModal() {
        document.getElementById('passwordModal').style.display = 'flex';
    }

    function hideChangePasswordModal() {
        document.getElementById('passwordModal').style.display = 'none';
        document.getElementById('oldPassword').value = '';
        document.getElementById('newPassword').value = '';
        document.getElementById('confirmPassword').value = '';
        document.getElementById('passwordAlert').innerHTML = '';
    }

    function submitChangePassword() {
        var oldPassword = document.getElementById('oldPassword').value;
        var newPassword = document.getElementById('newPassword').value;
        var confirmPassword = document.getElementById('confirmPassword').value;

        if (!oldPassword) { showPasswordAlert('请输入原密码', 'error'); return; }
        if (!newPassword) { showPasswordAlert('请输入新密码', 'error'); return; }
        if (newPassword.length < 6) { showPasswordAlert('新密码至少6位', 'error'); return; }
        if (newPassword !== confirmPassword) { showPasswordAlert('两次输入的密码不一致', 'error'); return; }

        var formData = 'oldPassword=' + encodeURIComponent(oldPassword) + '&newPassword=' + encodeURIComponent(newPassword) + '&confirmPassword=' + encodeURIComponent(confirmPassword);

        fetch('${pageContext.request.contextPath}/user/changePassword.action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                showPasswordAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) { setTimeout(function() { hideChangePasswordModal(); }, 1500); }
            })
            .catch(error => { showPasswordAlert('请求失败，请重试', 'error'); });
    }

    function showPasswordAlert(message, type) {
        var alertBox = document.getElementById('passwordAlert');
        var bgColor = type === 'success' ? '#d4edda' : '#f8d7da';
        var textColor = type === 'success' ? '#155724' : '#721c24';
        alertBox.innerHTML = '<div style="padding:12px 15px; background:' + bgColor + '; color:' + textColor + '; border-radius:8px; text-align:center;">' + message + '</div>';
    }
</script>
</body>
</html>
