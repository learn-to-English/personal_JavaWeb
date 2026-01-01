<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${course.title} - 章节列表</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-bottom: 50px;
        }

        /* 顶部导航 */
        .header {
            background: rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
            color: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
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
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }

        /* 课程头部信息 */
        .course-header {
            max-width: 1000px;
            margin: 40px auto 30px;
            padding: 0 20px;
            color: white;
        }

        .course-header h1 {
            font-size: 36px;
            margin-bottom: 15px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }

        .course-header .course-info {
            display: flex;
            gap: 30px;
            font-size: 16px;
            opacity: 0.9;
        }

        .back-link {
            display: inline-block;
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            background: rgba(255,255,255,0.2);
            border-radius: 25px;
            margin-top: 20px;
            transition: all 0.3s;
        }

        .back-link:hover {
            background: rgba(255,255,255,0.3);
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
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .toolbar h2 {
            color: #333;
            font-size: 22px;
        }

        .btn-add-chapter {
            padding: 12px 30px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(255,107,107,0.3);
        }

        .btn-add-chapter:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255,107,107,0.4);
        }

        /* 章节列表 */
        .chapter-list {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .chapter-item {
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }

        .chapter-item:last-child {
            border-bottom: none;
        }

        .chapter-item:hover {
            background: linear-gradient(90deg, #f8f9fa 0%, #ffffff 100%);
        }

        .chapter-item:hover::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            margin-right: 25px;
            flex-shrink: 0;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }

        .chapter-info {
            flex: 1;
        }

        .chapter-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .chapter-meta {
            font-size: 14px;
            color: #999;
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
        }

        .btn-edit {
            background: #17a2b8;
            color: white;
        }

        .btn-edit:hover {
            background: #138496;
            transform: scale(1.05);
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background: #c82333;
            transform: scale(1.05);
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 24px;
            color: #666;
            margin-bottom: 15px;
        }

        .empty-state p {
            font-size: 16px;
            color: #999;
            margin-bottom: 30px;
        }

        /* 提示消息 */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .alert-success { background: #d4edda; color: #155724; }
        .alert-error { background: #f8d7da; color: #721c24; }

        /* 视频图标 */
        .video-icon {
            display: inline-block;
            padding: 4px 12px;
            background: rgba(255,107,107,0.1);
            color: #ff6b6b;
            border-radius: 15px;
            font-size: 12px;
            margin-left: 10px;
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
            <c:if test="${isTeacher}">
                <a href="${pageContext.request.contextPath}/chapter/toAdd.action?courseId=${course.id}" class="btn-add-chapter">
                    + 添加章节
                </a>
            </c:if>
        </div>

        <!-- 提示消息 -->
        <div id="alertBox"></div>

        <!-- 章节列表 -->
        <c:choose>
            <c:when test="${not empty chapterList}">
                <div class="chapter-list">
                    <c:forEach var="chapter" items="${chapterList}" varStatus="status">
                        <div class="chapter-item" id="chapter-${chapter.id}">
                            <a href="${pageContext.request.contextPath}/chapter/detail.action?id=${chapter.id}" class="chapter-link">
                                <div class="chapter-number">${status.index + 1}</div>
                                <div class="chapter-info">
                                    <div class="chapter-title">
                                        ${chapter.title}
                                        <c:if test="${not empty chapter.videoUrl}">
                                            <span class="video-icon">🎬 视频</span>
                                        </c:if>
                                    </div>
                                    <div class="chapter-meta">
                                        <c:choose>
                                            <c:when test="${not empty chapter.content}">
                                                ${chapter.content.length() > 50 ? chapter.content.substring(0, 50) : chapter.content}...
                                            </c:when>
                                            <c:otherwise>
                                                暂无内容简介
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </a>
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
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <h3>暂无章节</h3>
                    <p>该课程还没有添加任何章节内容</p>
                    <c:if test="${isTeacher}">
                        <a href="${pageContext.request.contextPath}/chapter/toAdd.action?courseId=${course.id}" 
                           class="btn-add-chapter">
                            + 添加第一个章节
                        </a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
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
            if (confirm('确定要删除章节「' + title + '」吗？此操作不可恢复！')) {
                fetch('${pageContext.request.contextPath}/chapter/delete.action?id=' + id, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert(data.message, 'success');
                        // 移除该章节的DOM元素
                        document.getElementById('chapter-' + id).remove();
                    } else {
                        showAlert(data.message, 'error');
                    }
                })
                .catch(error => {
                    showAlert('删除失败，请重试', 'error');
                });
            }
        }
    </script>
</body>
</html>
