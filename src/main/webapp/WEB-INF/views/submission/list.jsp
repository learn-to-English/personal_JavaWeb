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

        .page-header h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
        }

        .assignment-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        .assignment-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .assignment-card:hover {
            transform: translateY(-5px);
        }

        .assignment-card .course-tag {
            display: inline-block;
            padding: 4px 12px;
            background: #e8f4fd;
            color: #667eea;
            border-radius: 15px;
            font-size: 12px;
            margin-bottom: 10px;
        }

        .assignment-card h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }

        .assignment-card .desc {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            height: 45px;
            overflow: hidden;
            margin-bottom: 15px;
        }

        .assignment-card .meta {
            font-size: 13px;
            color: #999;
            margin-bottom: 15px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 15px;
            font-size: 13px;
            margin-bottom: 15px;
        }

        .status-not-submitted { background: #fff3cd; color: #856404; }
        .status-submitted { background: #cfe2ff; color: #084298; }
        .status-graded { background: #d4edda; color: #155724; }
        .status-expired { background: #f8d7da; color: #721c24; }

        .assignment-card .btn {
            display: block;
            text-align: center;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: opacity 0.3s;
        }

        .assignment-card .btn:hover {
            opacity: 0.9;
        }

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
    </style>
</head>
<body>
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <a href="${pageContext.request.contextPath}/course/list.action">课程</a>
        <a href="${pageContext.request.contextPath}/submission/list.action">作业</a>
    </div>
</div>

<div class="main-content">
    <div class="page-header">
        <h1>📝 我的作业</h1>
    </div>

    <c:choose>
        <c:when test="${not empty assignmentList}">
            <div class="assignment-grid">
                <c:forEach var="assignment" items="${assignmentList}">
                    <div class="assignment-card">
                        <span class="course-tag">${assignment.courseName}</span>
                        <h3>${assignment.title}</h3>
                        <p class="desc">${assignment.description}</p>
                        <div class="meta">
                            📅 截止时间：<fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>

                        <c:choose>
                            <c:when test="${assignment.submitRate == 2.0}">
                                <span class="status-badge status-graded">✅ 已批改</span>
                                <a href="${pageContext.request.contextPath}/submission/viewGrade.action?id=${assignment.id}" class="btn">查看成绩</a>
                            </c:when>
                            <c:when test="${assignment.submitRate == 1.0}">
                                <span class="status-badge status-submitted">📤 已提交</span>
                                <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn">查看详情</a>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-not-submitted">⏰ 未提交</span>
                                <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn">去提交</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="icon">📭</div>
                <p>暂无作业</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
