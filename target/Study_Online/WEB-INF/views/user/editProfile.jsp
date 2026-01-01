<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑资料 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* 头部 */
        .header {
            max-width: 700px;
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

        /* 表单卡片 */
        .form-card {
            max-width: 700px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }

        .form-card h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #667eea;
        }

        /* 表单样式 */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: 600;
            font-size: 15px;
        }

        .form-group input {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102,126,234,0.1);
        }

        .form-group input:disabled {
            background: #f8f9fa;
            cursor: not-allowed;
        }

        .form-group .hint {
            font-size: 13px;
            color: #999;
            margin-top: 8px;
        }

        /* 按钮 */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid #f0f0f0;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
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
            background: #f8f9fa;
            color: #666;
        }

        .btn-secondary:hover {
            background: #e9ecef;
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* 图标 */
        .form-group label::before {
            margin-right: 8px;
        }

        .form-group:nth-child(2) label::before { content: '👤'; }
        .form-group:nth-child(3) label::before { content: '📧'; }
        .form-group:nth-child(4) label::before { content: '📱'; }
    </style>
</head>
<body>
<!-- 头部 -->
<div class="header">
    <h1>✏️ 编辑资料</h1>
    <p class="subtitle">更新您的个人信息</p>
    <a href="${pageContext.request.contextPath}/user/profile.action" class="back-link">
        ← 返回个人中心
    </a>
</div>

<!-- 表单卡片 -->
<div class="form-card">
    <h2>📝 个人信息</h2>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 表单 -->
    <form id="profileForm">
        <!-- 用户名（不可修改）-->
        <div class="form-group">
            <label>用户名</label>
            <input type="text" value="${user.username}" disabled>
            <p class="hint">💡 提示：用户名注册后不可修改</p>
        </div>

        <!-- 邮箱 -->
        <div class="form-group">
            <label>邮箱</label>
            <input type="email" name="email" id="email" value="${user.email}" placeholder="请输入邮箱地址">
        </div>

        <!-- 手机号 -->
        <div class="form-group">
            <label>手机号</label>
            <input type="tel" name="phone" id="phone" value="${user.phone}" placeholder="请输入手机号">
        </div>

        <!-- 按钮 -->
        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/user/profile.action" class="btn btn-secondary">
                取消
            </a>
            <button type="submit" class="btn btn-primary">
                💾 保存修改
            </button>
        </div>
    </form>
</div>

<script>
    // 表单提交
    document.getElementById('profileForm').addEventListener('submit', function(e) {
        e.preventDefault();

        console.log('开始提交表单...');

        var email = document.getElementById('email').value.trim();
        var phone = document.getElementById('phone').value.trim();

        console.log('邮箱:', email);
        console.log('手机:', phone);

        // 构建请求数据
        var formData = 'email=' + encodeURIComponent(email) +
            '&phone=' + encodeURIComponent(phone);

        console.log('请求数据:', formData);

        // 发送请求
        fetch('${pageContext.request.contextPath}/user/updateProfile.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        })
            .then(function(response) {
                console.log('收到响应，状态码:', response.status);
                return response.json();
            })
            .then(function(data) {
                console.log('响应数据:', data);
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                    // 成功后跳转回个人中心
                    setTimeout(function() {
                        window.location.href = '${pageContext.request.contextPath}/user/profile.action';
                    }, 1500);
                }
            })
            .catch(function(error) {
                console.error('请求错误:', error);
                showAlert('请求失败，请重试', 'error');
            });
    });

    // 显示提示消息
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>
