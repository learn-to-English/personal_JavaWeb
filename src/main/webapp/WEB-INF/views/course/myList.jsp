<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的课程 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: #f5f5f5;
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
            padding: 8px 16px;
            border-radius: 20px;
        }

        .header .nav-links a:hover,
        .header .nav-links a.active {
            background: rgba(255,255,255,0.2);
        }

        /* 主内容 */
        .main-content {
            max-width: 1200px;
            margin: 30px auto;
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
            font-size: 28px;
            color: #333;
        }

        .btn-add {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            transition: transform 0.3s;
        }

        .btn-add:hover {
            transform: scale(1.05);
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }

        /* 课程表格 */
        .course-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .course-table th,
        .course-table td {
            padding: 18px 20px;
            text-align: left;
        }

        .course-table th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
        }

        .course-table tr {
            border-bottom: 1px solid #eee;
        }

        .course-table tr:hover {
            background: #f8f9fa;
        }

        .course-table .title {
            font-weight: 500;
            color: #333;
        }

        /* 状态标签 */
        .status-tag {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 13px;
        }

        .status-draft {
            background: #fff3cd;
            color: #856404;
        }

        .status-published {
            background: #d4edda;
            color: #155724;
        }

        /* 操作按钮 */
        .actions {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 6px 15px;
            border-radius: 15px;
            font-size: 13px;
            text-decoration: none;
            cursor: pointer;
            border: none;
        }

        .btn-edit { background: #17a2b8; color: white; }
        .btn-publish { background: #28a745; color: white; }
        .btn-unpublish { background: #ffc107; color: #333; }
        .btn-delete { background: #dc3545; color: white; }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 15px;
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .empty-state p {
            font-size: 18px;
            color: #666;
            margin-bottom: 20px;
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

        <c:choose>
            <c:when test="${not empty courseList}">
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
                        <c:forEach var="course" items="${courseList}">
                            <tr id="row-${course.id}">
                                <td class="title">${course.title}</td>
                                <td>${course.categoryName != null ? course.categoryName : '-'}</td>
                                <td>${course.studentCount}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${course.status == 'published'}">
                                            <span class="status-tag status-published">已发布</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-tag status-draft">草稿</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="${pageContext.request.contextPath}/course/toEdit.action?id=${course.id}" class="btn-sm btn-edit">编辑</a>
                                        <c:choose>
                                            <c:when test="${course.status == 'published'}">
                                                <button class="btn-sm btn-unpublish" onclick="unpublishCourse(${course.id})">下架</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn-sm btn-publish" onclick="publishCourse(${course.id})">发布</button>
                                            </c:otherwise>
                                        </c:choose>
                                        <button class="btn-sm btn-delete" onclick="deleteCourse(${course.id}, '${course.title}')">删除</button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>您还没有创建任何课程</p>
                    <a href="${pageContext.request.contextPath}/course/toAdd.action" class="btn-add">创建第一门课程</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // 显示提示
        function showAlert(message, type) {
            document.getElementById('alertBox').innerHTML = 
                '<div class="alert alert-' + type + '">' + message + '</div>';
        }

        // 发布课程
        function publishCourse(id) {
            if (confirm('确定要发布这门课程吗？')) {
                fetch('${pageContext.request.contextPath}/course/publish.action?id=' + id, { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    showAlert(data.message, data.success ? 'success' : 'error');
                    if (data.success) {
                        setTimeout(function() { location.reload(); }, 1000);
                    }
                });
            }
        }

        // 下架课程
        function unpublishCourse(id) {
            if (confirm('确定要下架这门课程吗？')) {
                fetch('${pageContext.request.contextPath}/course/unpublish.action?id=' + id, { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    showAlert(data.message, data.success ? 'success' : 'error');
                    if (data.success) {
                        setTimeout(function() { location.reload(); }, 1000);
                    }
                });
            }
        }

        // 删除课程
        function deleteCourse(id, title) {
            if (confirm('确定要删除课程「' + title + '」吗？此操作不可恢复！')) {
                fetch('${pageContext.request.contextPath}/course/delete.action?id=' + id, { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    showAlert(data.message, data.success ? 'success' : 'error');
                    if (data.success) {
                        document.getElementById('row-' + id).remove();
                    }
                });
            }
        }
    </script>
</body>
</html>
