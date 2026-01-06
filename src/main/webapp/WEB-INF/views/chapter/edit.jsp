<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑章节 - ${chapter.title}</title>
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
            --error: #FF8787;
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
            max-width: 800px;
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
            background: rgba(255, 255, 255, 0.9);
            transform: translateX(-5px);
        }

        /* 表单卡片 */
        .form-card {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .form-card h2 {
            font-size: 24px;
            color: var(--text-dark);
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-light);
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group label .required {
            color: var(--error);
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

        .form-group textarea {
            min-height: 200px;
            resize: vertical;
        }

        .form-group .hint {
            font-size: 13px;
            color: var(--text-light);
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 数字输入框 */
        .form-group input[type="number"] {
            width: 150px;
        }

        /* 按钮区域 */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid rgba(93, 173, 226, 0.2);
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
            background: rgba(255, 255, 255, 0.8);
            color: var(--text-dark);
            border: 2px solid rgba(93, 173, 226, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 1);
            border-color: var(--primary-light);
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
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
            body {
                padding: 20px 15px;
            }

            .header h1 {
                font-size: 26px;
            }

            .form-card {
                padding: 30px 25px;
            }

            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- 页面标题 -->
<div class="header">
    <h1>✏️ 编辑章节</h1>
    <p class="subtitle">修改章节「${chapter.title}」的信息</p>
    <a href="${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}" class="back-link">
        ← 返回章节列表
    </a>
</div>

<!-- 表单卡片 -->
<div class="form-card">
    <h2>📚 章节信息</h2>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 表单 -->
    <form id="chapterForm">
        <!-- 隐藏字段：章节ID -->
        <input type="hidden" name="id" value="${chapter.id}">

        <!-- 章节标题 -->
        <div class="form-group">
            <label>
                <span>📖</span>
                <span>章节标题 <span class="required">*</span></span>
            </label>
            <input type="text" name="title" id="title" value="${chapter.title}" required>
        </div>

        <!-- 章节内容 -->
        <div class="form-group">
            <label>
                <span>📝</span>
                <span>章节内容</span>
            </label>
            <textarea name="content" id="content">${chapter.content}</textarea>
            <p class="hint">
                <span>💡</span>
                <span>提示：可以使用段落和换行来组织内容</span>
            </p>
        </div>

        <!-- 视频链接 -->
        <div class="form-group">
            <label>
                <span>🎬</span>
                <span>视频链接（选填）</span>
            </label>
            <input type="url" name="videoUrl" id="videoUrl" value="${chapter.videoUrl}" placeholder="https://example.com/video.mp4">
            <p class="hint">
                <span>💡</span>
                <span>提示：如果有教学视频，可以在这里填入视频地址</span>
            </p>
        </div>

        <!-- 排序序号 -->
        <div class="form-group">
            <label>
                <span>🔢</span>
                <span>排序序号</span>
            </label>
            <input type="number" name="sortOrder" id="sortOrder" value="${chapter.sortOrder}" min="1">
            <p class="hint">
                <span>💡</span>
                <span>提示：序号越小，章节排序越靠前</span>
            </p>
        </div>

        <!-- 按钮 -->
        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}" class="btn btn-secondary">
                取消
            </a>
            <button type="submit" class="btn btn-primary">
                💾 保存修改
            </button>
        </div>
    </form>
</div>

<script>
    // 表单提交事件
    document.getElementById('chapterForm').onsubmit = function(e) {
        // 阻止默认提交行为
        e.preventDefault();

        // 获取表单数据
        var id = ${chapter.id};
        var title = document.getElementById('title').value.trim();
        var content = document.getElementById('content').value.trim();
        var videoUrl = document.getElementById('videoUrl').value.trim();
        var sortOrder = document.getElementById('sortOrder').value;

        // 验证标题是否为空
        if (!title) {
            showAlert('❌ 请输入章节标题', 'error');
            return;
        }

        // 构建请求数据
        var formData = 'id=' + id
            + '&title=' + encodeURIComponent(title)
            + '&content=' + encodeURIComponent(content)
            + '&videoUrl=' + encodeURIComponent(videoUrl)
            + '&sortOrder=' + sortOrder;

        // 发送请求
        fetch('${pageContext.request.contextPath}/chapter/update.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                // 判断请求是否成功
                if (data.success) {
                    showAlert('✅ ' + data.message, 'success');
                    // 成功后1.5秒跳转到章节列表
                    setTimeout(function() {
                        window.location.href = '${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}';
                    }, 1500);
                } else {
                    showAlert('❌ ' + data.message, 'error');
                }
            })
            .catch(function(error) {
                showAlert('❌ 请求失败，请重试', 'error');
            });
    };

    // 显示提示消息
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>