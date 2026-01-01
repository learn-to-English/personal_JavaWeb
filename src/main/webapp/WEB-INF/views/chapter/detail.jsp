<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${chapter.title} - 在线学习平台</title>
    <style>
        /* ... 前面的样式保持不变 ... */
        
        /* 视频区域 */
        .video-section {
            margin-bottom: 30px;
            background: #000;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            padding-top: 56.25%; /* 16:9 宽高比 */
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
            padding: 100px 20px;
            text-align: center;
            color: #666;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .video-placeholder .icon {
            font-size: 60px;
            margin-bottom: 15px;
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <!-- ... 前面的HTML保持不变 ... -->

    <!-- 视频区域（支持多种视频源） -->
    <c:choose>
        <c:when test="${not empty chapter.videoUrl}">
            <div class="video-section">
                <%
                    String videoUrl = ((com.learning.model.Chapter)request.getAttribute("chapter")).getVideoUrl();
                    if (videoUrl != null && !videoUrl.trim().isEmpty()) {
                        // 判断视频类型
                        if (videoUrl.contains("bilibili.com")) {
                            // B站视频 - 转换成嵌入链接
                            String bvid = "";
                            if (videoUrl.contains("/BV")) {
                                int start = videoUrl.indexOf("/BV") + 1;
                                int end = videoUrl.indexOf("?") > 0 ? videoUrl.indexOf("?") : videoUrl.length();
                                if (videoUrl.indexOf("/", start) > 0) {
                                    end = Math.min(end, videoUrl.indexOf("/", start));
                                }
                                bvid = videoUrl.substring(start, end);
                            }
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
                        } else if (videoUrl.contains("youtube.com") || videoUrl.contains("youtu.be")) {
                            // YouTube视频
                            String videoId = "";
                            if (videoUrl.contains("v=")) {
                                int start = videoUrl.indexOf("v=") + 2;
                                int end = videoUrl.indexOf("&") > 0 ? videoUrl.indexOf("&") : videoUrl.length();
                                videoId = videoUrl.substring(start, end);
                            } else if (videoUrl.contains("youtu.be/")) {
                                int start = videoUrl.indexOf("youtu.be/") + 9;
                                videoId = videoUrl.substring(start);
                            }
                            if (!videoId.isEmpty()) {
                %>
                                <iframe src="https://www.youtube.com/embed/<%= videoId %>" 
                                        frameborder="0" 
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                        allowfullscreen></iframe>
                <%
                            }
                        } else if (videoUrl.endsWith(".mp4") || videoUrl.endsWith(".webm") || videoUrl.endsWith(".ogg")) {
                            // 标准视频文件
                %>
                            <video controls>
                                <source src="<%= videoUrl %>" type="video/mp4">
                                您的浏览器不支持视频播放。
                            </video>
                <%
                        } else {
                            // 尝试作为iframe嵌入
                %>
                            <iframe src="<%= videoUrl %>" 
                                    frameborder="0" 
                                    allowfullscreen></iframe>
                <%
                        }
                    }
                %>
            </div>
        </c:when>
        <c:otherwise>
            <div class="video-placeholder">
                <div class="icon">🎬</div>
                <p>该章节暂无视频内容</p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- ... 后面的HTML保持不变 ... -->
</body>
</html>
