<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交作业 - 在线学习平台</title>
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
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .main-content {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .card h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .assignment-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .assignment-info .item {
            margin-bottom: 10px;
            font-size: 15px;
            color: #666;
        }

        .assignment-info .item strong {
            color: #333;
            margin-right: 10px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            min-height: 250px;
            resize: vertical;
        }

        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-actions {
            display: flex;
            gap: 15px;
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

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }
        .alert-warning { background: #fff3cd; color: #856404; }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">📚 在线学习平台</div>
</div>

<div class="main-content">
    <div class="card">
        <h2>📝 ${assignment.title}</h2>

        <div class="assignment-info">
            <div class="item"><strong>课程：</strong>${assignment.courseName}</div>
            <div class="item"><strong>截止时间：</strong><fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/></div>
            <div class="item"><strong>满分：</strong>${assignment.totalScore}分</div>
            <div class="item"><strong>作业要求：</strong></div>
            <div style="margin-top:10px; padding:10px; background:white; border-radius:5px;">
                ${assignment.description != null && !assignment.description.isEmpty() ? assignment.description : '暂无详细说明'}
            </div>
        </div>

        <div id="alertBox"></div>

        <c:choose>
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
            <c:otherwise>
                <form id="submitForm">
                    <div class="form-group">
                        <label>作业答案：</label>
                        <textarea name="content" id="content" placeholder="请在此输入您的作业答案...">${submission != null ? submission.content : ''}</textarea>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/submission/list.action" class="btn btn-secondary">取消</a>
                        <button type="submit" class="btn btn-primary">提交作业</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    var form = document.getElementById('submitForm');
    if (form) {
        form.onsubmit = function(e) {
            e.preventDefault();

            var content = document.getElementById('content').value.trim();

            if (!content) {
                showAlert('请输入作业答案', 'error');
                return;
            }

            var formData = 'assignmentId=${assignment.id}&content=' + encodeURIComponent(content);

            fetch('${pageContext.request.contextPath}/submission/submit.action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    showAlert(data.message, data.success ? 'success' : 'error');
                    if (data.success) {
                        setTimeout(function() {
                            window.location.href = '${pageContext.request.contextPath}/submission/list.action';
                        }, 1500);
                    }
                })
                .catch(error => {
                    showAlert('请求失败，请重试', 'error');
                });
        };
    }

    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';
    }
</script>
</body>
</html>
