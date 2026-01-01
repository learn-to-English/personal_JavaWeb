<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的学习 - 在线学习平台</title>
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

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 28px;
            color: #333;
        }

        .page-header p {
            color: #666;
            margin-top: 10px;
        }

        /* 课程卡片网格 */
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .course-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        .course-card .cover {
            height: 140px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
        }

        .course-card .info {
            padding: 20px;
        }

        .course-card .category-tag {
            display: inline-block;
            padding: 4px 12px;
            background: #e8f4fd;
            color: #667eea;
            border-radius: 15px;
            font-size: 12px;
            margin-bottom: 10px;
        }

        .course-card h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }

        .course-card .desc {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
            height: 42px;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .course-card .meta {
            font-size: 13px;
            color: #999;
            margin-bottom: 15px;
        }

        .course-card .actions {
            display: flex;
            gap: 10px;
        }

        .course-card .btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }

        .course-card .btn-learn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .course-card .btn-unenroll {
            background: #f8f9fa;
            color: #dc3545;
            border: 1px solid #dc3545;
        }

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

        .empty-state .btn-browse {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
        }

        /* 提示 */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
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
            <a href="${pageContext.request.contextPath}/course/list.action">全部课程</a>
            <a href="${pageContext.request.contextPath}/study/myList.action" class="active">我的学习</a>
        </div>
    </div>

    <!-- 主内容 -->
    <div class="main-content">
        <div class="page-header">
            <h1>📝 我的学习</h1>
            <p>已选 ${enrollmentList.size()} 门课程</p>
        </div>

        <!-- 提示消息 -->
        <div id="alertBox"></div>

        <c:choose>
            <c:when test="${not empty enrollmentList}">
                <div class="course-grid">
                    <c:forEach var="enrollment" items="${enrollmentList}">
                        <div class="course-card" id="card-${enrollment.courseId}">
                            <div class="cover">📖</div>
                            <div class="info">
                                <c:if test="${not empty enrollment.categoryName}">
                                    <span class="category-tag">${enrollment.categoryName}</span>
                                </c:if>
                                <h3>${enrollment.courseTitle}</h3>
                                <p class="desc">${enrollment.courseDescription}</p>
                                <div class="meta">
                                    👨‍🏫 ${enrollment.teacherName} · 
                                    选课时间：<fmt:formatDate value="${enrollment.enrollTime}" pattern="yyyy-MM-dd"/>
                                </div>
                                <div class="actions">
                                    <a href="${pageContext.request.contextPath}/course/detail.action?id=${enrollment.courseId}" class="btn btn-learn">进入学习</a>
                                    <button class="btn btn-unenroll" onclick="unenroll(${enrollment.courseId})">退课</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>您还没有选修任何课程</p>
                    <a href="${pageContext.request.contextPath}/course/list.action" class="btn-browse">去选课</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function showAlert(message, type) {
            document.getElementById('alertBox').innerHTML = 
                '<div class="alert alert-' + type + '">' + message + '</div>';
        }

        function unenroll(courseId) {
            if (confirm('确定要退出这门课程吗？')) {
                fetch('${pageContext.request.contextPath}/study/unenroll.action?courseId=' + courseId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert(data.message, 'success');
                        // 移除卡片
                        document.getElementById('card-' + courseId).remove();
                    } else {
                        showAlert(data.message, 'error');
                    }
                });
            }
        }
    </script>
</body>
</html>
