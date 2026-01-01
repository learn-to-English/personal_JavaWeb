<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>创建课程 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        /* 顶部导航 */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .header .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
        }

        /* 主内容 */
        .main-content {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 表单卡片 */
        .form-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .form-card h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }

        .form-card .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }

        /* 表单样式 */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .form-group label .required {
            color: #dc3545;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

        .form-group .hint {
            font-size: 13px;
            color: #999;
            margin-top: 5px;
        }

        /* 按钮区域 */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: transform 0.3s;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <!-- 顶部导航 -->
    <div class="header">
        <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home.action">首页</a>
            <a href="${pageContext.request.contextPath}/course/myList.action">我的课程</a>
        </div>
    </div>

    <!-- 主内容 -->
    <div class="main-content">
        <div class="form-card">
            <h1>✨ 创建新课程</h1>
            <p class="subtitle">填写课程信息，开始分享你的知识</p>

            <!-- 提示消息 -->
            <div id="alertBox"></div>

            <!-- 表单 -->
            <form id="courseForm">
                <div class="form-group">
                    <label>课程标题 <span class="required">*</span></label>
                    <input type="text" name="title" id="title" placeholder="请输入课程标题">
                </div>

                <div class="form-group">
                    <label>课程分类</label>
                    <select name="categoryId" id="categoryId">
                        <option value="">请选择分类</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.id}">${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>课程简介</label>
                    <textarea name="description" id="description" placeholder="请输入课程简介，介绍课程内容和适合人群"></textarea>
                    <p class="hint">好的课程简介可以帮助学生更好地了解课程内容</p>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/course/myList.action" class="btn btn-secondary">取消</a>
                    <button type="submit" class="btn btn-primary">创建课程</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 表单提交
        document.getElementById('courseForm').onsubmit = function(e) {
            e.preventDefault();  // 阻止默认提交

            // 获取表单数据
            var title = document.getElementById('title').value.trim();
            var categoryId = document.getElementById('categoryId').value;
            var description = document.getElementById('description').value.trim();

            // 验证标题
            if (!title) {
                showAlert('请输入课程标题', 'error');
                return;
            }

            // 发送请求
            var formData = 'title=' + encodeURIComponent(title) 
                         + '&categoryId=' + categoryId 
                         + '&description=' + encodeURIComponent(description);

            fetch('${pageContext.request.contextPath}/course/add.action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                showAlert(data.message, data.success ? 'success' : 'error');
                if (data.success) {
                    // 成功后跳转到我的课程页面
                    setTimeout(function() {
                        window.location.href = '${pageContext.request.contextPath}/course/myList.action';
                    }, 1500);
                }
            })
            .catch(error => {
                showAlert('请求失败，请重试', 'error');
            });
        };

        // 显示提示
        function showAlert(message, type) {
            document.getElementById('alertBox').innerHTML = 
                '<div class="alert alert-' + type + '">' + message + '</div>';
        }
    </script>
</body>
</html>
