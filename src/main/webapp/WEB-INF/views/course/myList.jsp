<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的课程 - 在线学习平台</title>
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

        .header .nav-links a:hover,
        .header .nav-links a.active {
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

        /* 课程表格容器 */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.3);
            backdrop-filter: blur(10px);
        }

        /* 课程表格 */
        .course-table {
            width: 100%;
        }

        .course-table th,
        .course-table td {
            padding: 20px;
            text-align: left;
        }

        .course-table th {
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
            color: var(--text-dark);
            font-weight: 600;
            font-size: 15px;
        }

        .course-table tr {
            border-bottom: 1px solid rgba(93, 173, 226, 0.1);
        }

        .course-table tbody tr {
            transition: all 0.3s;
        }

        .course-table tbody tr:hover {
            background: rgba(168, 216, 234, 0.1);
        }

        .course-table .title {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 16px;
        }

        /* 状态标签 */
        .status-tag {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 15px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-draft {
            background: linear-gradient(135deg, #FFF3CD 0%, #FFE69C 100%);
            color: #856404;
        }

        .status-published {
            background: linear-gradient(135deg, #D4EDDA 0%, #C3E6CB 100%);
            color: #155724;
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

        .btn-edit {
            background: linear-gradient(135deg, #A8D8EA 0%, #5DADE2 100%);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .btn-publish {
            background: linear-gradient(135deg, #51CF66 0%, #37B24D 100%);
            color: white;
        }

        .btn-publish:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(81, 207, 102, 0.3);
        }

        .btn-unpublish {
            background: linear-gradient(135deg, #FFD93D 0%, #FFC107 100%);
            color: var(--text-dark);
        }

        .btn-unpublish:hover {
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

            .course-table {
                font-size: 14px;
            }

            .course-table th,
            .course-table td {
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
        <a href="${pageContext.request.contextPath}/course/list.action">全部课程</a>
        <a href="${pageContext.request.contextPath}/course/myList.action" class="active">课程管理</a>
    </div>
</div>

<!-- 主内容 -->
<div class="main-content">
    <div class="page-header">
        <h1>📚 我的课程</h1>
        <a href="${pageContext.request.contextPath}/course/toAdd.action" class="btn-add">+ 创建新课程</a>
    </div>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 判断是否有课程列表 -->
    <c:if test="${not empty courseList}">
        <!-- 有课程：显示课程表格 -->
        <div class="table-container">
            <table class="course-table">
                <thead>
                <tr>
                    <th>课程标题</th>
                    <th>分类</th>
                    <th>学生数</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <!-- 遍历每个课程 -->
                <c:forEach var="course" items="${courseList}">
                    <tr id="row-${course.id}">
                        <td class="title">${course.title}</td>
                        <td>
                            <!-- 判断是否有分类 -->
                            <c:if test="${not empty course.categoryName}">
                                ${course.categoryName}
                            </c:if>
                            <c:if test="${empty course.categoryName}">
                                -
                            </c:if>
                        </td>
                        <td>${course.studentCount}</td>
                        <td>
                            <!-- 判断课程状态 -->
                            <c:if test="${course.status == 'published'}">
                                <span class="status-tag status-published">✅ 已发布</span>
                            </c:if>
                            <c:if test="${course.status != 'published'}">
                                <span class="status-tag status-draft">📝 草稿</span>
                            </c:if>
                        </td>
                        <td>
                            <div class="actions">
                                <!-- 编辑按钮 -->
                                <a href="${pageContext.request.contextPath}/course/toEdit.action?id=${course.id}" class="btn-sm btn-edit">编辑</a>

                                <!-- 发布/下架按钮 -->
                                <c:if test="${course.status == 'published'}">
                                    <!-- 已发布：显示下架按钮 -->
                                    <button class="btn-sm btn-unpublish" onclick="unpublishCourse(${course.id})">下架</button>
                                </c:if>
                                <c:if test="${course.status != 'published'}">
                                    <!-- 未发布：显示发布按钮 -->
                                    <button class="btn-sm btn-publish" onclick="publishCourse(${course.id})">发布</button>
                                </c:if>

                                <!-- 删除按钮 -->
                                <button class="btn-sm btn-delete" onclick="deleteCourse(${course.id}, '${course.title}')">删除</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <c:if test="${empty courseList}">
        <!-- 没有课程：显示空状态 -->
        <div class="empty-state">
            <div class="icon">📭</div>
            <p>您还没有创建任何课程</p>
            <a href="${pageContext.request.contextPath}/course/toAdd.action" class="btn-add">创建第一门课程</a>
        </div>
    </c:if>
</div>

<script>
    // 显示提示消息
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }

    // 发布课程
    function publishCourse(id) {
        // 弹出确认框
        if (confirm('确定要发布这门课程吗？')) {
            // 发送发布请求
            fetch('${pageContext.request.contextPath}/course/publish.action?id=' + id, {
                method: 'POST'
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    // 判断请求是否成功
                    if (data.success) {
                        showAlert('✅ ' + data.message, 'success');
                        // 1秒后刷新页面
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        showAlert('❌ ' + data.message, 'error');
                    }
                })
                .catch(function(error) {
                    showAlert('❌ 请求失败，请重试', 'error');
                });
        }
    }

    // 下架课程
    function unpublishCourse(id) {
        // 弹出确认框
        if (confirm('确定要下架这门课程吗？')) {
            // 发送下架请求
            fetch('${pageContext.request.contextPath}/course/unpublish.action?id=' + id, {
                method: 'POST'
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    // 判断请求是否成功
                    if (data.success) {
                        showAlert('✅ ' + data.message, 'success');
                        // 1秒后刷新页面
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        showAlert('❌ ' + data.message, 'error');
                    }
                })
                .catch(function(error) {
                    showAlert('❌ 请求失败，请重试', 'error');
                });
        }
    }

    // 删除课程
    function deleteCourse(id, title) {
        // 弹出确认框
        if (confirm('确定要删除课程「' + title + '」吗？此操作不可恢复！')) {
            // 发送删除请求
            fetch('${pageContext.request.contextPath}/course/delete.action?id=' + id, {
                method: 'POST'
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    // 判断请求是否成功
                    if (data.success) {
                        showAlert('✅ ' + data.message, 'success');
                        // 从页面中移除这一行
                        document.getElementById('row-' + id).remove();
                    } else {
                        showAlert('❌ ' + data.message, 'error');
                    }
                })
                .catch(function(error) {
                    showAlert('❌ 请求失败，请重试', 'error');
                });
        }
    }
</script>
</body>
</html>