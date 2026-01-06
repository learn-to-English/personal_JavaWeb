<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">作业管理</c:when><c:otherwise>我的作业</c:otherwise></c:choose> - 在线学习平台</title>
    <style>
        /* 全局重置 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* CSS变量 - 天空蓝主题（和user文件夹一样） */
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(93, 173, 226, 0.3);
        }

        .header .logo {
            font-size: 26px;
            font-weight: bold;
            text-decoration: none;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .header .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
            padding: 10px 20px;
            border-radius: 25px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
        }

        /* 主内容区域 */
        .main-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 页面标题 */
        .page-header h1 {
            font-size: 32px;
            color: var(--text-dark);
            margin-bottom: 35px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        /* 作业卡片网格 */
        .assignment-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        /* 作业卡片 */
        .assignment-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .assignment-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 50px rgba(93, 173, 226, 0.35);
        }

        /* 课程标签 */
        .assignment-card .course-tag {
            display: inline-block;
            padding: 6px 16px;
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            color: var(--primary-dark);
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .assignment-card h3 {
            font-size: 20px;
            color: var(--text-dark);
            margin-bottom: 12px;
            font-weight: 700;
        }

        .assignment-card .desc {
            font-size: 14px;
            color: var(--text-light);
            line-height: 1.7;
            height: 48px;
            overflow: hidden;
            margin-bottom: 15px;
        }

        .assignment-card .meta {
            font-size: 13px;
            color: var(--text-light);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 状态标签 */
        .status-badge {
            display: inline-block;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .status-not-submitted {
            background: linear-gradient(135deg, #FFF9E5 0%, #FFE082 100%);
            color: #F57C00;
        }

        .status-submitted {
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
            color: var(--primary-dark);
        }

        .status-graded {
            background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%);
            color: #2E7D32;
        }

        .status-expired {
            background: linear-gradient(135deg, #FFEBEE 0%, #FFCDD2 100%);
            color: #C62828;
        }

        /* 按钮 */
        .assignment-card .btn {
            display: block;
            text-align: center;
            padding: 14px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
        }

        .assignment-card .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(93, 173, 226, 0.4);
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 100px 20px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(93, 173, 226, 0.25);
            backdrop-filter: blur(10px);
        }

        .empty-state .icon {
            font-size: 100px;
            margin-bottom: 25px;
            opacity: 0.8;
        }

        .empty-state p {
            font-size: 18px;
            color: var(--text-light);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 25px;
            }

            .main-content {
                padding: 0 15px;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .assignment-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="header">
    <a href="${pageContext.request.contextPath}/" class="logo">📚 在线学习平台</a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home.action">首页</a>
        <a href="${pageContext.request.contextPath}/course/list.action">课程</a>
        <%-- 根据用户角色显示不同的作业链接和文本 --%>
        <c:choose>
            <c:when test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">
                <a href="${pageContext.request.contextPath}/assignment/myList.action">作业管理</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/submission/list.action">作业</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <div class="page-header">
        <%-- 根据用户角色显示不同的标题 --%>
        <c:choose>
            <c:when test="${sessionScope.user.role == 'teacher' || sessionScope.user.role == 'admin'}">
                <h1>📋 作业管理</h1>
            </c:when>
            <c:otherwise>
                <h1>📝 我的作业</h1>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 判断：如果有作业数据 --%>
    <c:choose>
        <%-- 情况1：作业列表不为空，显示作业卡片 --%>
        <c:when test="${not empty assignmentList}">
            <div class="assignment-grid">
                    <%-- 循环遍历每个作业，var="assignment"表示当前作业对象 --%>
                <c:forEach var="assignment" items="${assignmentList}">
                    <div class="assignment-card">
                            <%-- 显示课程名称标签 --%>
                        <span class="course-tag">${assignment.courseName}</span>

                            <%-- 显示作业标题 --%>
                        <h3>${assignment.title}</h3>

                            <%-- 显示作业描述 --%>
                        <p class="desc">${assignment.description}</p>

                            <%-- 显示截止时间，fmt:formatDate用于格式化日期 --%>
                        <div class="meta">
                            📅 截止时间：<fmt:formatDate value="${assignment.deadline}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>

                            <%-- 判断作业状态：submitRate=2.0表示已批改，1.0表示已提交，其他表示未提交 --%>
                        <c:choose>
                            <%-- 状态1：已批改 --%>
                            <c:when test="${assignment.submitRate == 2.0}">
                                <span class="status-badge status-graded">✅ 已批改</span>
                                <a href="${pageContext.request.contextPath}/submission/viewGrade.action?id=${assignment.id}" class="btn">查看成绩</a>
                            </c:when>
                            <%-- 状态2：已提交但未批改 --%>
                            <c:when test="${assignment.submitRate == 1.0}">
                                <span class="status-badge status-submitted">📤 已提交</span>
                                <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn">查看详情</a>
                            </c:when>
                            <%-- 状态3：未提交 --%>
                            <c:otherwise>
                                <span class="status-badge status-not-submitted">⏰ 未提交</span>
                                <a href="${pageContext.request.contextPath}/submission/toSubmit.action?id=${assignment.id}" class="btn">去提交</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <%-- 情况2：作业列表为空，显示空状态 --%>
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