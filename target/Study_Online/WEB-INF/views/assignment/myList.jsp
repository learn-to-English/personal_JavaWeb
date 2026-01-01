<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的作业 - 在线学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

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

        .header .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }

        .main-content {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

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

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }

        .assignment-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .assignment-table th,
        .assignment-table td {
            padding: 18px 20px;
            text-align: left;
        }

        .assignment-table th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
        }

        .assignment-table tr {
            border-bottom: 1px solid #eee;
        }

        .assignment-table tr:hover {
            background: #f8f9fa;
        }

        .assignment-table .title {
            font-weight: 500;
            color: #333;
        }

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

        .btn-view { background: #17a2b8; color: white; }
        .btn-edit { background: #ffc107; color: #333; }
        .btn-delete { background: #dc3545; color: white; }

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
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <a href="${pageContext.request.contextPath}/course/myList.action">课程管理</a>
        <a href="${pageContext.request.contextPath}/assignment/myList.action">作业管理</a>
    </div>
</div>

<div class="main-content">
    <div class="page-header">
        <h1>📝 我的作业</h1>
        <a href="${pageContext.request.contextPath}/assignment/toAdd.action" class="btn-add">+ 创建新作业</a>
    </div>

    <div id="alertBox"></div>

    <c:choose>
        <c:when test="${not empty assignmentList}">
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
                <c:forEach var="assignment" items="${assignmentList}">
                    <tr id="row-${assignment.id}">
                        <td class="title">${assignment.title}</td>
                        <td>${assignment.courseName}</td>
                        <td><fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${assignment.totalStudents > 0}">
                                    ${assignment.submissionCount}/${assignment.totalStudents}
                                    (${Math.round(assignment.submissionCount * 100.0 / assignment.totalStudents)}%)
                                </c:when>
                                <c:otherwise>0/0</c:otherwise>
                            </c:choose>
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
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="icon">📭</div>
                <p>您还没有创建任何作业</p>
                <a href="${pageContext.request.contextPath}/assignment/toAdd.action" class="btn-add">创建第一个作业</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }

    function deleteAssignment(id, title) {
        if (confirm('确定要删除作业「' + title + '」吗？此操作不可恢复！')) {
            fetch('${pageContext.request.contextPath}/assignment/delete.action?id=' + id, { method: 'POST' })
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
