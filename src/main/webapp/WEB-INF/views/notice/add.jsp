
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布通知 - 在线学习平台</title>
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
            --danger: #FF6B6B;
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;
        }

        /* 页面主体 - 天空蓝渐变背景 */
        body {
            font-family: var(--font-main);
            background: linear-gradient(135deg, #E3F2FD 0%, #B3E5FC 50%, #81D4FA 100%);
            min-height: 100vh;
            padding: 0;
        }

        /* 顶部导航栏 */
        .header {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            padding: 20px 50px;
            box-shadow: 0 5px 20px rgba(93, 173, 226, 0.3);
        }

        .header .logo {
            font-size: 26px;
            font-weight: bold;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        /* 主内容区域 */
        .main-content {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 表单卡片 */
        .form-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 45px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
        }

        .form-card h1 {
            font-size: 30px;
            color: var(--text-dark);
            margin-bottom: 35px;
            text-align: center;
            font-weight: 700;
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
        }

        .form-group input,
        .form-group select,
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
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
            background: white;
        }

        .form-group textarea {
            min-height: 180px;
            resize: vertical;
        }

        /* 单选按钮组 */
        .radio-group {
            display: flex;
            gap: 25px;
        }

        .radio-group label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-weight: 500;
        }

        .radio-group input[type="radio"] {
            width: auto;
            cursor: pointer;
        }

        /* 按钮组 */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 35px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
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
            background: white;
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
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* 必填标识 */
        .required {
            color: var(--danger);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 25px;
            }

            .main-content {
                padding: 0 15px;
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
<!-- 顶部导航栏 -->
<div class="header">
    <div class="logo">📚 在线学习平台</div>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <div class="form-card">
        <h1>✨ 发布新通知</h1>

        <%-- 提示消息显示区域 --%>
        <div id="alertBox"></div>

        <!-- 表单 -->
        <form id="noticeForm">
            <!-- 通知类型 -->
            <div class="form-group">
                <label>通知类型 <span class="required">*</span></label>
                <div class="radio-group">
                    <label><input type="radio" name="type" value="course" checked onchange="toggleCourseSelect()"> 课程通知</label>
                    <label><input type="radio" name="type" value="system" onchange="toggleCourseSelect()"> 系统公告</label>
                </div>
            </div>

            <!-- 选择课程 -->
            <div class="form-group" id="courseGroup">
                <label>选择课程 <span class="required">*</span></label>
                <select name="courseId" id="courseId">
                    <option value="">请选择课程</option>
                    <%-- 循环显示教师的课程列表 --%>
                    <c:forEach var="course" items="${courseList}">
                        <option value="${course.id}">${course.title}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 优先级 -->
            <div class="form-group">
                <label>优先级</label>
                <div class="radio-group">
                    <label><input type="radio" name="priority" value="normal" checked> ● 普通</label>
                    <label><input type="radio" name="priority" value="important"> ★ 重要</label>
                    <label><input type="radio" name="priority" value="urgent"> ! 紧急</label>
                </div>
            </div>

            <!-- 通知标题 -->
            <div class="form-group">
                <label>通知标题 <span class="required">*</span></label>
                <input type="text" name="title" id="title" placeholder="请输入通知标题">
            </div>

            <!-- 通知内容 -->
            <div class="form-group">
                <label>通知内容</label>
                <textarea name="content" id="content" placeholder="请输入通知详细内容..."></textarea>
            </div>

            <!-- 按钮 -->
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/notice/list.action" class="btn btn-secondary">取消</a>
                <button type="button" onclick="publishNotice()" class="btn btn-primary">发布通知</button>
            </div>
        </form>
    </div>
</div>

<script>
    // ========== 第1个函数：切换课程选择框显示/隐藏 ==========
    function toggleCourseSelect() {
        // 步骤1：获取选中的通知类型
        var typeRadios = document.getElementsByName('type');
        var selectedType = '';

        // 步骤2：遍历单选按钮，找到选中的那个
        for (var i = 0; i < typeRadios.length; i++) {
            if (typeRadios[i].checked == true) {
                selectedType = typeRadios[i].value;
                break;
            }
        }

        // 步骤3：获取课程选择框的容器
        var courseGroup = document.getElementById('courseGroup');

        // 步骤4：判断类型，决定是否显示课程选择框
        if (selectedType == 'course') {
            courseGroup.style.display = 'block';  // 课程通知，显示
        } else {
            courseGroup.style.display = 'none';   // 系统公告，隐藏
            document.getElementById('courseId').value = '';  // 清空选择
        }
    }

    // ========== 第2个函数：发布通知 ==========
    function publishNotice() {
        // 步骤1：获取所有表单数据
        var type = getSelectedRadio('type');
        var courseId = document.getElementById('courseId').value;
        var priority = getSelectedRadio('priority');
        var title = document.getElementById('title').value;
        var content = document.getElementById('content').value;

        // 步骤2：去掉前后空格
        title = title.trim();
        content = content.trim();

        // 步骤3：验证标题是否为空
        if (title == '') {
            showMessage('❌ 请输入通知标题', 'error');
            return;  // 停止执行
        }

        // 步骤4：如果是课程通知，验证是否选择了课程
        if (type == 'course' && courseId == '') {
            showMessage('❌ 请选择课程', 'error');
            return;  // 停止执行
        }

        // 步骤5：准备要发送的数据
        var data = 'type=' + type +
            '&courseId=' + (courseId || '') +
            '&priority=' + priority +
            '&title=' + encodeURIComponent(title) +
            '&content=' + encodeURIComponent(content);

        // 步骤6：发送请求到后端
        sendPublishRequest(data);
    }

    // ========== 第3个函数：获取选中的单选按钮值 ==========
    function getSelectedRadio(name) {
        var radios = document.getElementsByName(name);
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked == true) {
                return radios[i].value;
            }
        }
        return '';
    }

    // ========== 第4个函数：发送发布请求到后端 ==========
    function sendPublishRequest(data) {
        fetch('${pageContext.request.contextPath}/notice/add.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
            .then(function(response) {
                // 步骤1：把后端返回的数据转成JSON对象
                return response.json();
            })
            .then(function(result) {
                // 步骤2：处理后端返回的结果
                handlePublishResult(result);
            })
            .catch(function(error) {
                // 如果请求失败，显示错误消息
                showMessage('❌ 请求失败，请重试', 'error');
            });
    }

    // ========== 第5个函数：处理发布结果 ==========
    function handlePublishResult(result) {
        // 判断1：如果发布成功
        if (result.success == true) {
            // 显示成功消息
            showMessage('✅ ' + result.message, 'success');

            // 等待1.5秒后跳转到通知列表页面
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/notice/list.action';
            }, 1500);
        } else {
            // 判断2：如果发布失败
            showMessage('❌ ' + result.message, 'error');
        }
    }

    // ========== 第6个函数：显示提示消息 ==========
    function showMessage(message, type) {
        // 找到提示消息的容器
        var alertBox = document.getElementById('alertBox');

        // 在容器里放入提示消息的HTML
        alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>