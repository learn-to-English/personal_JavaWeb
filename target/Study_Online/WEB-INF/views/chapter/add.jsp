<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加章节 - ${course.title}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* 顶部导航 */
        .header {
            max-width: 800px;
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
            max-width: 800px;
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

        .form-group label .required {
            color: #ff6b6b;
            margin-left: 5px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102,126,234,0.1);
        }

        .form-group textarea {
            min-height: 200px;
            resize: vertical;
        }

        .form-group .hint {
            font-size: 13px;
            color: #999;
            margin-top: 8px;
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

        /* 表单图标 */
        .form-group label::before {
            content: '📝';
            margin-right: 8px;
        }

        .form-group:nth-child(3) label::before {
            content: '🎬';
        }

        .form-group:nth-child(4) label::before {
            content: '🔢';
        }
    </style>
</head>
<body>
    <!-- 头部 -->
    <div class="header">
        <h1>✨ 添加新章节</h1>
        <p class="subtitle">为课程「${course.title}」添加学习内容</p>
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
            <!-- 隐藏字段：课程ID -->
            <input type="hidden" name="courseId" value="${course.id}">

            <!-- 章节标题 -->
            <div class="form-group">
                <label>章节标题 <span class="required">*</span></label>
                <input type="text" name="title" id="title" placeholder="例如：第一章 Java基础入门" required>
            </div>

            <!-- 章节内容 -->
            <div class="form-group">
                <label>章节内容</label>
                <textarea name="content" id="content" placeholder="请输入章节的详细内容，可以包括知识点、学习目标等..."></textarea>
                <p class="hint">💡 提示：可以使用段落和换行来组织内容</p>
            </div>

            <!-- 视频链接 -->
            <div class="form-group">
                <label>视频链接（选填）</label>
                <input type="url" name="videoUrl" id="videoUrl" placeholder="https://example.com/video.mp4">
                <p class="hint">💡 提示：如果有教学视频，可以在这里填入视频地址</p>
            </div>

            <!-- 排序序号 -->
            <div class="form-group">
                <label>排序序号</label>
                <input type="number" name="sortOrder" id="sortOrder" min="1" value="1">
                <p class="hint">💡 提示：序号越小，章节排序越靠前。留空则自动排在最后</p>
            </div>

            <!-- 按钮 -->
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}" class="btn btn-secondary">
                    取消
                </a>
                <button type="submit" class="btn btn-primary">
                    ✅ 保存章节
                </button>
            </div>
        </form>
    </div>

    <script>
        // 表单提交
        document.getElementById('chapterForm').onsubmit = function(e) {
            e.preventDefault();

            // 获取表单数据
            var courseId = ${course.id};
            var title = document.getElementById('title').value.trim();
            var content = document.getElementById('content').value.trim();
            var videoUrl = document.getElementById('videoUrl').value.trim();
            var sortOrder = document.getElementById('sortOrder').value;

            // 验证
            if (!title) {
                showAlert('请输入章节标题', 'error');
                return;
            }

            // 构建请求数据
            var formData = 'courseId=' + courseId
                         + '&title=' + encodeURIComponent(title)
                         + '&content=' + encodeURIComponent(content)
                         + '&videoUrl=' + encodeURIComponent(videoUrl)
                         + '&sortOrder=' + sortOrder;

            // 发送请求
            fetch('${pageContext.request.contextPath}/chapter/add.action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                    // 成功后跳转到章节列表
                    setTimeout(function() {
                        window.location.href = '${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}';
                    }, 1500);
                }
            })
            .catch(error => {
                showAlert('请求失败，请重试', 'error');
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
