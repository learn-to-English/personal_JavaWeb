<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交作业 - 在线学习平台</title>
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
            max-width: 850px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 卡片容器 - 半透明白色背景 */
        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
            margin-bottom: 25px;
        }

        .card h2 {
            font-size: 26px;
            color: var(--text-dark);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* 作业信息区域 */
        .assignment-info {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            border: 1px solid rgba(93, 173, 226, 0.2);
        }

        .assignment-info .item {
            margin-bottom: 12px;
            font-size: 15px;
            color: var(--text-dark);
            line-height: 1.8;
        }

        .assignment-info .item strong {
            color: var(--primary-dark);
            margin-right: 10px;
        }

        .assignment-info .description-box {
            margin-top: 15px;
            padding: 15px;
            background: white;
            border-radius: 10px;
            color: var(--text-light);
            line-height: 1.7;
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

        .form-group textarea {
            width: 100%;
            padding: 18px;
            border: 2px solid rgba(93, 173, 226, 0.2);
            border-radius: 12px;
            font-size: 15px;
            font-family: var(--font-main);
            min-height: 280px;
            resize: vertical;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(93, 173, 226, 0.15);
            background: white;
        }

        .form-group textarea:read-only {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            cursor: not-allowed;
            color: var(--text-light);
        }

        /* 按钮组 */
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
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
            margin-bottom: 20px;
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
            color: #FF8787;
            border-left: 4px solid #FF8787;
        }

        .alert-warning {
            background: linear-gradient(135deg, #FFF9E5 0%, #FFE082 100%);
            color: #F57C00;
            border-left: 4px solid #F57C00;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 25px;
            }

            .main-content {
                padding: 0 15px;
            }

            .card {
                padding: 25px;
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
    <div class="card">
        <h2>📝 ${assignment.title}</h2>

        <!-- 作业信息展示 -->
        <div class="assignment-info">
            <div class="item"><strong>📚 课程：</strong>${assignment.courseName}</div>
            <div class="item"><strong>⏰ 截止时间：</strong><fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/></div>
            <div class="item"><strong>💯 满分：</strong>${assignment.totalScore}分</div>
            <div class="item"><strong>📋 作业要求：</strong></div>
            <div class="description-box">
                <%-- 判断：如果作业描述不为空就显示，否则显示"暂无详细说明" --%>
                <c:choose>
                    <c:when test="${not empty assignment.description}">
                        ${assignment.description}
                    </c:when>
                    <c:otherwise>
                        暂无详细说明
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- 这是提示消息显示的地方 --%>
        <div id="alertBox"></div>

        <%-- 判断：如果作业已经被批改了，就不能再提交 --%>
        <c:choose>
            <%-- 情况1：已批改，只能查看 --%>
            <c:when test="${submission != null && submission.status == 'graded'}">
                <div class="alert alert-warning">
                    ⚠️ 该作业已批改，无法重新提交
                </div>
                <div class="form-group">
                    <label>我的答案：</label>
                    <textarea readonly>${submission.content}</textarea>
                </div>
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/submission/list.action" class="btn btn-secondary">返回</a>
                    <a href="${pageContext.request.contextPath}/submission/viewGrade.action?id=${assignment.id}" class="btn btn-primary">查看成绩</a>
                </div>
            </c:when>
            <%-- 情况2：未批改，可以提交或修改 --%>
            <c:otherwise>
                <div class="form-group">
                    <label>作业答案：</label>
                    <textarea id="content" placeholder="请在此输入您的作业答案..."><c:if test="${submission != null}">${submission.content}</c:if></textarea>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/submission/list.action" class="btn btn-secondary">取消</a>
                    <button onclick="submitWork()" class="btn btn-primary">提交作业</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    // ========== 第1个函数：提交作业 ==========
    function submitWork() {
        // 步骤1：获取输入框的内容
        var content = document.getElementById('content').value;

        // 步骤2：去掉前后空格
        content = content.trim();

        // 步骤3：判断是否为空
        if (content == '') {
            showMessage('❌ 请输入作业答案', 'error');
            return;  // 停止执行
        }

        // 步骤4：判断是否太短
        if (content.length < 10) {
            showMessage('⚠️ 作业答案至少要10个字符', 'error');
            return;  // 停止执行
        }

        // 步骤5：准备要发送的数据（拼接成字符串）
        var data = 'assignmentId=${assignment.id}&content=' + encodeURIComponent(content);

        // 步骤6：发送请求到后端
        sendRequest(data);
    }

    // ========== 第2个函数：发送请求到后端 ==========
    function sendRequest(data) {
        // 使用 fetch 发送 POST 请求
        fetch('${pageContext.request.contextPath}/submission/submit.action', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
            .then(function(response) {
                // 步骤1：把后端返回的数据转成 JSON 对象
                return response.json();
            })
            .then(function(result) {
                // 步骤2：处理后端返回的结果
                handleResult(result);
            })
            .catch(function(error) {
                // 如果请求失败，显示错误消息
                showMessage('❌ 请求失败，请重试', 'error');
            });
    }

    // ========== 第3个函数：处理后端返回的结果 ==========
    function handleResult(result) {
        // 判断1：如果提交成功
        if (result.success == true) {
            // 显示成功消息
            showMessage('✅ ' + result.message, 'success');

            // 等待1.5秒后跳转到作业列表页面
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/submission/list.action';
            }, 1500);
        } else {
            // 判断2：如果提交失败
            showMessage('❌ ' + result.message, 'error');
        }
    }

    // ========== 第4个函数：显示提示消息 ==========
    function showMessage(message, type) {
        // 找到提示消息的容器
        var alertBox = document.getElementById('alertBox');

        // 在容器里放入提示消息的HTML
        alertBox.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>