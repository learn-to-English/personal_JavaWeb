<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${chapter.title} - 在线学习平台</title>
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

        .header .nav-links a {
            color: var(--text-dark);
            text-decoration: none;
            margin-left: 25px;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s;
        }

        .header .nav-links a:hover {
            background: var(--primary-light);
            color: white;
        }

        /* 章节头部 */
        .chapter-header {
            max-width: 1000px;
            margin: 40px auto 30px;
            padding: 0 20px;
            color: var(--text-dark);
        }

        .chapter-header h1 {
            font-size: 32px;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(255, 255, 255, 0.5);
        }

        .chapter-header .meta {
            display: flex;
            gap: 25px;
            font-size: 15px;
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

        /* 视频区域 */
        .video-section {
            margin-bottom: 30px;
            background: rgba(0, 0, 0, 0.9);
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            padding-top: 56.25%; /* 16:9 宽高比 */
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }

        .video-section video,
        .video-section iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }

        .video-placeholder {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #F8FBFF 0%, #EBF5FB 100%);
        }

        .video-placeholder .icon {
            font-size: 80px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .video-placeholder p {
            font-size: 16px;
            color: var(--text-light);
        }

        /* 内容卡片 */
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(93, 173, 226, 0.2);
            backdrop-filter: blur(10px);
        }

        .content-card h2 {
            font-size: 24px;
            color: var(--text-dark);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-light);
        }

        .content-card .text-content {
            font-size: 16px;
            line-height: 1.8;
            color: var(--text-dark);
            white-space: pre-wrap;
        }

        .empty-content {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-light);
        }

        .empty-content .icon {
            font-size: 60px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        /* 响应式 */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
            }

            .chapter-header h1 {
                font-size: 24px;
            }

            .content-card {
                padding: 25px;
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
    </div>
</div>

<!-- 章节头部 -->
<div class="chapter-header">
    <h1>📖 ${chapter.title}</h1>
    <div class="meta">
        <span>📚 课程：${course.title}</span>
        <span>👨‍🏫 讲师：${course.teacherName}</span>
    </div>
    <a href="${pageContext.request.contextPath}/chapter/list.action?courseId=${course.id}" class="back-link">
        ← 返回章节列表
    </a>
</div>

<!-- 主内容 -->
<div class="main-content">
    <!-- 视频区域 -->
    <!-- 判断是否有视频URL -->
    <c:if test="${not empty chapter.videoUrl}">
        <div class="video-section">
            <%
                // 获取视频URL
                String videoUrl = ((com.learning.model.Chapter)request.getAttribute("chapter")).getVideoUrl();

                // 判断视频URL是否为空
                if (videoUrl != null && !videoUrl.trim().isEmpty()) {
                    // 判断是B站视频
                    if (videoUrl.contains("bilibili.com")) {
                        // 提取B站视频BV号
                        String bvid = "";
                        if (videoUrl.contains("/BV")) {
                            int start = videoUrl.indexOf("/BV") + 1;
                            int end = videoUrl.length();

                            // 如果有问号，截取到问号前
                            if (videoUrl.indexOf("?") > 0) {
                                end = videoUrl.indexOf("?");
                            }

                            // 如果有斜杠，截取到斜杠前
                            if (videoUrl.indexOf("/", start) > 0) {
                                end = Math.min(end, videoUrl.indexOf("/", start));
                            }

                            bvid = videoUrl.substring(start, end);
                        }

                        // 如果提取到BV号，显示B站播放器
                        if (!bvid.isEmpty()) {
            %>
            <iframe src="//player.bilibili.com/player.html?bvid=<%= bvid %>&page=1"
                    scrolling="no"
                    border="0"
                    frameborder="no"
                    framespacing="0"
                    allowfullscreen="true"></iframe>
            <%
                }
            }
            // 判断是YouTube视频
            else if (videoUrl.contains("youtube.com") || videoUrl.contains("youtu.be")) {
                // 提取YouTube视频ID
                String videoId = "";

                if (videoUrl.contains("v=")) {
                    int start = videoUrl.indexOf("v=") + 2;
                    int end = videoUrl.length();

                    if (videoUrl.indexOf("&") > 0) {
                        end = videoUrl.indexOf("&");
                    }

                    videoId = videoUrl.substring(start, end);
                } else if (videoUrl.contains("youtu.be/")) {
                    int start = videoUrl.indexOf("youtu.be/") + 9;
                    videoId = videoUrl.substring(start);
                }

                // 如果提取到视频ID，显示YouTube播放器
                if (!videoId.isEmpty()) {
            %>
            <iframe src="https://www.youtube.com/embed/<%= videoId %>"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen></iframe>
            <%
                }
            }
            // 判断是标准视频文件
            else if (videoUrl.endsWith(".mp4") || videoUrl.endsWith(".webm") || videoUrl.endsWith(".ogg")) {
            %>
            <video controls>
                <source src="<%= videoUrl %>" type="video/mp4">
                您的浏览器不支持视频播放。
            </video>
            <%
            }
            // 其他情况，尝试用iframe嵌入
            else {
            %>
            <iframe src="<%= videoUrl %>"
                    frameborder="0"
                    allowfullscreen></iframe>
            <%
                    }
                }
            %>
        </div>
    </c:if>

    <c:if test="${empty chapter.videoUrl}">
        <!-- 没有视频：显示占位符 -->
        <div class="video-section">
            <div class="video-placeholder">
                <div class="icon">🎬</div>
                <p>该章节暂无视频内容</p>
            </div>
        </div>
    </c:if>

    <!-- 章节内容 -->
    <div class="content-card">
        <h2>📝 章节内容</h2>
        <!-- 判断是否有章节内容 -->
        <c:if test="${not empty chapter.content}">
            <div class="text-content">${chapter.content}</div>
        </c:if>

        <c:if test="${empty chapter.content}">
            <!-- 没有内容：显示空状态 -->
            <div class="empty-content">
                <div class="icon">📭</div>
                <p>该章节暂无文字内容</p>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>