<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的作业 - 在线学习平台</title>
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
        }

        /* 顶部导航 */
        .header {
            background: rgba(255, 255, 255, 0.95);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: var(--primary-dark);
        }

        .header .nav-links {
            display: flex;
            gap: 25px;
        }

        .header .nav-links a {
            color: var(--text-dark);
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: var(--primary-light);
            color: white;
        }

        /* 主内容 */
        .main-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 页面标题栏 */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 32px;
            color: var(--text-dark);
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        .btn-add {
            padding: 12px 30px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-add:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.4);
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
            color: var(--error);
            border-left: 4px solid var(--error);
        }

        /* 作业表格容器 */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        /* 作业表格 */
        .assignment-table {
            width: 100%;
        }

        .assignment-table th,
        .assignment-table td {
            padding: 20px;
            text-align: left;
        }

        .assignment-table th {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            color: var(--text-dark);
            font-weight: 600;
            font-size: 15px;
        }

        .assignment-table tr {
            border-bottom: 2px solid rgba(93, 173, 226, 0.1);
        }

        .assignment-table tbody tr {
            transition: all 0.3s;
        }

        .assignment-table tbody tr:hover {
            background: rgba(168, 216, 234, 0.1);
        }

        .assignment-table .title {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 16px;
        }

        /* 操作按钮 */
        .actions {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 8px 16px;
            border-radius: 15px;
            font-size: 13px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: all 0.3s;
            font-weight: 600;
        }

        .btn-view {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-edit {
            background: linear-gradient(135deg, #FFD93D 0%, #FFC107 100%);
            color: var(--text-dark);
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 217, 61, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #FF8787 0%, #FF6B6B 100%);
            color: white;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 135, 135, 0.3);
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .empty-state p {
            font-size: 18px;
            color: var(--text-light);
            margin-bottom: 20px;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
            }

            .page-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .assignment-table {
                font-size: 14px;
            }

            .assignment-table th,
            .assignment-table td {
                padding: 12px;
            }

            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航 -->
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <a href="${pageContext.request.contextPath}/course/myList.action">课程管理</a>
        <a href="${pageContext.request.contextPath}/assignment/myList.action">作业管理</a>
    </div>
</div>

<!-- 主内容 -->
<div class="main-content">
    <div class="page-header">
        <h1>📋 作业管理</h1>
        <a href="${pageContext.request.contextPath}/assignment/toAdd.action" class="btn-add">+ 创建新作业</a>
    </div>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 判断是否有作业列表 -->
    <c:if test="${not empty assignmentList}">
        <!-- 有作业：显示作业表格 -->
        <div class="table-container">
            <table class="assignment-table">
                <thead>
                <tr>
                    <th>作业标题</th>
                    <th>课程</th>
                    <th>截止时间</th>
                    <th>提交率</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <!-- 遍历每个作业 -->
                <c:forEach var="assignment" items="${assignmentList}">
                    <tr id="row-${assignment.id}">
                        <td class="title">${assignment.title}</td>
                        <td>${assignment.courseName}</td>
                        <td><fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <!-- 判断是否有学生 -->
                            <c:if test="${assignment.totalStudents > 0}">
                                ${assignment.submissionCount}/${assignment.totalStudents}
                                (${Math.round(assignment.submissionCount * 100.0 / assignment.totalStudents)}%)
                            </c:if>
                            <c:if test="${assignment.totalStudents == 0}">
                                0/0
                            </c:if>
                        </td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/submission/submissions.action?assignmentId=${assignment.id}" class="btn-sm btn-view">查看提交</a>
                                <a href="${pageContext.request.contextPath}/assignment/toEdit.action?id=${assignment.id}" class="btn-sm btn-edit">编辑</a>
                                <button class="btn-sm btn-delete" onclick="deleteAssignment(${assignment.id}, '${assignment.title}')">删除</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <c:if test="${empty assignmentList}">
        <!-- 没有作业：显示空状态 -->
        <div class="empty-state">
            <div class="icon">📭</div>
            <p>您还没有创建任何作业</p>
            <a href="${pageContext.request.contextPath}/assignment/toAdd.action" class="btn-add">创建第一个作业</a>
        </div>
    </c:if>
</div>

<script>
    // 显示提示消息
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }

    // 删除作业
    function deleteAssignment(id, title) {
        // 弹出确认框
        if (confirm('确定要删除作业「' + title + '」吗？此操作不可恢复！')) {
            // 发送删除请求
            fetch('${pageContext.request.contextPath}/assignment/delete.action?id=' + id, {
                method: 'POST'
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    // 判断请求是否成功
                    if (data.success) {
                        showAlert('✅ ' + data.message, 'success');
                        // 从页面中移除该行
                        document.getElementById('row-' + id).remove();
                    } else {
                        showAlert('❌ ' + data.message, 'error');
                    }
                })
                .catch(function(error) {
                    showAlert('❌ 删除失败，请重试', 'error');
                });
        }
    }
</script>
</body>
</html>