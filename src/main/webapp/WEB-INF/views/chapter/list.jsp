<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} - 章节列表</title>
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
            padding-bottom: 50px;
        }

        /* 顶部导航 */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(93, 173, 226, 0.2);
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

        /* 课程头部信息 */
        .course-header {
            max-width: 1000px;
            margin: 40px auto 30px;
            padding: 0 20px;
            color: var(--text-dark);
        }

        .course-header h1 {
            font-size: 36px;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        .course-header .course-info {
            display: flex;
            gap: 30px;
            font-size: 16px;
            opacity: 0.8;
        }

        .back-link {
            display: inline-block;
            color: var(--text-dark);
            text-decoration: none;
            padding: 10px 25px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 25px;
            margin-top: 20px;
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.9);
            transform: translateX(-5px);
        }

        /* 主内容区 */
        .main-content {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 工具栏 */
        .toolbar {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 25px 30px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .toolbar h2 {
            color: var(--text-dark);
            font-size: 22px;
        }

        .btn-add-chapter {
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

        .btn-add-chapter:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.4);
        }

        /* 章节列表 */
        .chapter-list {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .chapter-item {
            border-bottom: 2px solid rgba(93, 173, 226, 0.1);
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .chapter-item:last-child {
            border-bottom: none;
        }

        .chapter-item:hover {
            background: linear-gradient(90deg, rgba(168, 216, 234, 0.1) 0%, rgba(255, 255, 255, 0) 100%);
        }

        .chapter-item:hover::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
        }

        .chapter-link {
            display: flex;
            align-items: center;
            padding: 25px 30px;
            text-decoration: none;
            color: inherit;
        }

        .chapter-number {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            margin-right: 25px;
            flex-shrink: 0;
            box-shadow: 0 8px 20px rgba(93, 173, 226, 0.3);
        }

        .chapter-info {
            flex: 1;
        }

        .chapter-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .chapter-meta {
            font-size: 14px;
            color: var(--text-light);
        }

        .chapter-actions {
            display: flex;
            gap: 10px;
            margin-left: 20px;
        }

        .btn-sm {
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: all 0.3s;
            font-weight: 600;
        }

        .btn-edit {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary) 100%);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(93, 173, 226, 0.3);
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
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 24px;
            color: var(--text-dark);
            margin-bottom: 15px;
        }

        .empty-state p {
            font-size: 16px;
            color: var(--text-light);
            margin-bottom: 30px;
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

        /* 视频图标 */
        .video-icon {
            display: inline-block;
            padding: 5px 12px;
            background: linear-gradient(135deg, #FFE69C 0%, #FFD93D 100%);
            color: #856404;
            border-radius: 15px;
            font-size: 12px;
            margin-left: 10px;
            font-weight: 600;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
            }

            .course-header h1 {
                font-size: 28px;
            }

            .chapter-link {
                flex-direction: column;
                align-items: flex-start;
            }

            .chapter-actions {
                margin-left: 0;
                margin-top: 15px;
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
        <!-- 判断用户是否登录 -->
        <c:if test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/study/myList.action">我的学习</a>
        </c:if>
    </div>
</div>

<!-- 课程头部信息 -->
<div class="course-header">
    <h1>📖 ${course.title}</h1>
    <div class="course-info">
        <span>👨‍🏫 ${course.teacherName}</span>
        <span>📚 共 ${chapterList.size()} 个章节</span>
    </div>
    <a href="${pageContext.request.contextPath}/course/detail.action?id=${course.id}" class="back-link">
        ← 返回课程详情
    </a>
</div>

<!-- 主内容 -->
<div class="main-content">
    <!-- 工具栏 -->
    <div class="toolbar">
        <h2>🎯 课程章节</h2>
        <!-- 判断是否是教师 -->
        <c:if test="${isTeacher}">
            <a href="${pageContext.request.contextPath}/chapter/toAdd.action?courseId=${course.id}" class="btn-add-chapter">
                + 添加章节
            </a>
        </c:if>
    </div>

    <!-- 提示消息 -->
    <div id="alertBox"></div>

    <!-- 章节列表 -->
    <!-- 判断是否有章节 -->
    <c:if test="${not empty chapterList}">
        <!-- 有章节：显示章节列表 -->
        <div class="chapter-list">
            <!-- 遍历每个章节 -->
            <c:forEach var="chapter" items="${chapterList}" varStatus="status">
                <div class="chapter-item" id="chapter-${chapter.id}">
                    <a href="${pageContext.request.contextPath}/chapter/detail.action?id=${chapter.id}" class="chapter-link">
                        <!-- 章节序号 -->
                        <div class="chapter-number">${status.index + 1}</div>
                        <!-- 章节信息 -->
                        <div class="chapter-info">
                            <div class="chapter-title">
                                    ${chapter.title}
                                <!-- 判断是否有视频 -->
                                <c:if test="${not empty chapter.videoUrl}">
                                    <span class="video-icon">🎬 视频</span>
                                </c:if>
                            </div>
                            <div class="chapter-meta">
                                <!-- 判断是否有内容简介 -->
                                <c:if test="${not empty chapter.content}">
                                    <!-- 如果内容超过50字，只显示前50字 -->
                                    <c:if test="${chapter.content.length() > 50}">
                                        ${chapter.content.substring(0, 50)}...
                                    </c:if>
                                    <c:if test="${chapter.content.length() <= 50}">
                                        ${chapter.content}
                                    </c:if>
                                </c:if>
                                <c:if test="${empty chapter.content}">
                                    暂无内容简介
                                </c:if>
                            </div>
                        </div>
                    </a>
                    <!-- 判断是否是教师，显示操作按钮 -->
                    <c:if test="${isTeacher}">
                        <div class="chapter-actions">
                            <a href="${pageContext.request.contextPath}/chapter/toEdit.action?id=${chapter.id}"
                               class="btn-sm btn-edit">编辑</a>
                            <button class="btn-sm btn-delete" onclick="deleteChapter(${chapter.id}, '${chapter.title}')">删除</button>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty chapterList}">
        <!-- 没有章节：显示空状态 -->
        <div class="empty-state">
            <div class="icon">📭</div>
            <h3>暂无章节</h3>
            <p>该课程还没有添加任何章节内容</p>
            <!-- 判断是否是教师，显示添加按钮 -->
            <c:if test="${isTeacher}">
                <a href="${pageContext.request.contextPath}/chapter/toAdd.action?courseId=${course.id}"
                   class="btn-add-chapter">
                    + 添加第一个章节
                </a>
            </c:if>
        </div>
    </c:if>
</div>

<script>
    // 显示提示消息
    function showAlert(message, type) {
        document.getElementById('alertBox').innerHTML =
            '<div class="alert alert-' + type + '">' + message + '</div>';

        // 3秒后自动隐藏
        setTimeout(function() {
            document.getElementById('alertBox').innerHTML = '';
        }, 3000);
    }

    // 删除章节
    function deleteChapter(id, title) {
        // 弹出确认框
        if (confirm('确定要删除章节「' + title + '」吗？此操作不可恢复！')) {
            // 发送删除请求
            fetch('${pageContext.request.contextPath}/chapter/delete.action?id=' + id, {
                method: 'POST'
            })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    // 判断请求是否成功
                    if (data.success) {
                        showAlert('✅ ' + data.message, 'success');
                        // 从页面中移除该章节
                        document.getElementById('chapter-' + id).remove();
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