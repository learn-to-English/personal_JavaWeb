<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 在线学习平台</title>
    <style>
        /* ====================
           全局重置
           ==================== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* ====================
           CSS变量 - 天空蓝配色
           ==================== */
        :root {
            /* 主色调 - 天空蓝 */
            --primary: #5DADE2;
            --primary-light: #A8D8EA;
            --primary-dark: #3498DB;

            /* 辅助色 */
            --secondary: #FFD93D;    /* 阳光黄 */
            --accent: #FF9CEE;       /* 粉色点缀 */

            /* 功能色 */
            --success: #51CF66;
            --warning: #FFB84D;

            /* 中性色 */
            --text-dark: #2C3E50;
            --text-light: #7F8C8D;
            --bg-page: #F5F7FA;
            --bg-card: #FFFFFF;
            --border: #E9ECEF;

            /* 字体 */
            --font-main: "Microsoft YaHei", "PingFang SC", sans-serif;

            /* 圆角和阴影 */
            --radius-sm: 10px;
            --radius-md: 15px;
            --radius-lg: 20px;
            --shadow-sm: 0 2px 8px rgba(93, 173, 226, 0.1);
            --shadow-md: 0 4px 16px rgba(93, 173, 226, 0.15);
            --shadow-lg: 0 8px 24px rgba(93, 173, 226, 0.2);
        }

        /* ====================
           页面主体
           ==================== */
        body {
            font-family: var(--font-main);
            background: var(--bg-page);
            min-height: 100vh;
        }

        /* ====================
           顶部导航栏 - 天空蓝渐变
           ==================== */
        .header {
            background: linear-gradient(135deg, #A8D8EA 0%, #79C2D0 100%);
            color: white;
            padding: 18px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 12px rgba(93, 173, 226, 0.3);
        }

        .header .logo {
            font-size: 24px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .header .user-info {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .header .username {
            font-size: 15px;
            font-weight: 500;
        }

        /* 角色标签 */
        .role-tag {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
        }

        /* 退出按钮 */
        .btn-logout {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-logout:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        /* ====================
           主要内容区
           ==================== */
        .main-content {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px 40px;
        }

        /* ====================
           大卡片 - 学习进度
           ==================== */
        .hero-card {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border-radius: var(--radius-lg);
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
        }

        /* 背景装饰 */
        .hero-card::before {
            content: '🎓';
            position: absolute;
            font-size: 180px;
            opacity: 0.1;
            right: -30px;
            top: -30px;
        }

        .hero-card .greeting {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
        }

        .hero-card .subtitle {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        /* 励志语录（仅学生可见） */
        .motivation-section {
            margin-bottom: 20px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            border-left: 4px solid var(--secondary);
            backdrop-filter: blur(10px);
        }

        .motivation-text {
            font-size: 16px;
            line-height: 1.8;
            opacity: 0.95;
            font-style: italic;
            font-weight: 500;
        }

        /* 大卡片按钮 */
        .hero-btn {
            display: inline-block;
            padding: 12px 32px;
            background: white;
            color: var(--primary-dark);
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        .hero-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        /* ====================
           功能卡片网格
           ==================== */
        .section-title {
            font-size: 20px;
            color: var(--text-dark);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        /* 功能卡片 */
        .function-card {
            background: var(--bg-card);
            border-radius: var(--radius-md);
            padding: 28px 24px;
            text-align: center;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            border: 2px solid transparent;
        }

        .function-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-light);
        }

        .function-card .icon {
            font-size: 48px;
            margin-bottom: 16px;
            display: block;
        }

        .function-card h3 {
            font-size: 17px;
            color: var(--text-dark);
            margin-bottom: 8px;
            font-weight: 600;
        }

        .function-card p {
            font-size: 13px;
            color: var(--text-light);
            line-height: 1.5;
        }

        /* 不同类型卡片的图标颜色 */
        .function-card.primary .icon {
            color: var(--primary);
        }

        .function-card.secondary .icon {
            color: var(--secondary);
        }

        .function-card.accent .icon {
            color: var(--accent);
        }

        .function-card.success .icon {
            color: var(--success);
        }

        /* ====================
           页脚
           ==================== */
        .footer {
            text-align: center;
            padding: 30px 20px;
            color: var(--text-light);
            font-size: 14px;
            border-top: 1px solid var(--border);
            margin-top: 40px;
        }

        /* ====================
           响应式设计
           ==================== */
        @media (max-width: 768px) {
            .header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .header .user-info {
                flex-wrap: wrap;
                justify-content: center;
            }

            .hero-card {
                padding: 30px 25px;
            }

            .hero-card .greeting {
                font-size: 24px;
            }

            .card-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                gap: 15px;
            }

            .function-card {
                padding: 24px 18px;
            }

            .function-card .icon {
                font-size: 40px;
            }
        }

        /* ====================
           加载动画
           ==================== */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero-card {
            animation: fadeIn 0.6s ease;
        }

        .function-card {
            animation: fadeIn 0.6s ease;
        }

        .function-card:nth-child(1) { animation-delay: 0.1s; }
        .function-card:nth-child(2) { animation-delay: 0.15s; }
        .function-card:nth-child(3) { animation-delay: 0.2s; }
        .function-card:nth-child(4) { animation-delay: 0.25s; }
        .function-card:nth-child(5) { animation-delay: 0.3s; }
        .function-card:nth-child(6) { animation-delay: 0.35s; }
    </style>
</head>
<body>
<%
    // 获取用户角色
    String role = ((com.learning.model.User)session.getAttribute("user")).getRole();
    String username = ((com.learning.model.User)session.getAttribute("user")).getUsername();
%>

<!-- ====================
     顶部导航栏
     ==================== -->
<div class="header">
    <div class="logo">
        <span>📚</span>
        <span>在线学习平台</span>
    </div>
    <div class="user-info">
        <span class="username">👋 你好，${sessionScope.user.username}</span>
        <span class="role-tag">
                <%= "teacher".equals(role) ? "🎓 教师" : "📖 学生" %>
            </span>
        <a href="${pageContext.request.contextPath}/user/logout.action" class="btn-logout">退出登录</a>
    </div>
</div>

<!-- ====================
     主要内容区
     ==================== -->
<div class="main-content">

    <!-- ====================
         大卡片 - 欢迎 & 学习进度
         ==================== -->
    <div class="hero-card">
        <% if ("student".equals(role)) { %>
        <!-- 学生：显示励志语句 -->
        <div class="greeting">🎓 欢迎回来，<%= username %>！</div>
        <div class="subtitle">继续你的学习之旅，每天进步一点点</div>

        <div class="motivation-section">
            <div class="motivation-text">
                💡 "学习是一场马拉松，不是短跑。坚持每天进步一点点，你会发现自己已经走了很远。加油！"
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/study/myList.action" class="hero-btn">
            继续学习 →
        </a>
        <% } else { %>
        <!-- 教师：显示欢迎信息 -->
        <div class="greeting">👨‍🏫 欢迎回来，<%= username %> 老师！</div>
        <div class="subtitle">今天也要认真教学哦，学生们都在等着你</div>

        <a href="${pageContext.request.contextPath}/course/myList.action" class="hero-btn">
            管理课程 →
        </a>
        <% } %>
    </div>

    <!-- ====================
         功能卡片网格
         ==================== -->
    <div class="section-title">🔧 快捷功能</div>

    <div class="card-grid">
        <% if ("student".equals(role)) { %>
        <!-- ========== 学生功能卡片 ========== -->

        <!-- 浏览课程 -->
        <a href="${pageContext.request.contextPath}/course/list.action" class="function-card primary">
            <span class="icon">📖</span>
            <h3>浏览课程</h3>
            <p>发现感兴趣的课程</p>
        </a>

        <!-- 我的学习 -->
        <a href="${pageContext.request.contextPath}/study/myList.action" class="function-card secondary">
            <span class="icon">📝</span>
            <h3>我的学习</h3>
            <p>查看已选课程</p>
        </a>

        <!-- 我的作业 -->
        <a href="${pageContext.request.contextPath}/submission/list.action" class="function-card accent">
            <span class="icon">✍️</span>
            <h3>我的作业</h3>
            <p>提交和查看作业</p>
        </a>

        <!-- 在线考试 -->
        <a href="${pageContext.request.contextPath}/exam/list.action" class="function-card success">
            <span class="icon">📋</span>
            <h3>在线考试</h3>
            <p>参加在线考试</p>
        </a>

        <!-- 通知公告 -->
        <a href="${pageContext.request.contextPath}/notice/list.action" class="function-card primary">
            <span class="icon">📢</span>
            <h3>通知公告</h3>
            <p>查看最新通知</p>
        </a>

        <!-- 个人中心 -->
        <a href="${pageContext.request.contextPath}/user/profile.action" class="function-card secondary">
            <span class="icon">👤</span>
            <h3>个人中心</h3>
            <p>管理个人信息</p>
        </a>

        <% } else { %>
        <!-- ========== 教师功能卡片 ========== -->

        <!-- 课程管理 -->
        <a href="${pageContext.request.contextPath}/course/myList.action" class="function-card primary">
            <span class="icon">🎯</span>
            <h3>课程管理</h3>
            <p>管理我的课程</p>
        </a>

        <!-- 作业管理 -->
        <a href="${pageContext.request.contextPath}/assignment/myList.action" class="function-card secondary">
            <span class="icon">📋</span>
            <h3>作业管理</h3>
            <p>布置和批改作业</p>
        </a>

        <!-- 考试管理 -->
        <a href="${pageContext.request.contextPath}/exam/toCreate.action" class="function-card accent">
            <span class="icon">📝</span>
            <h3>考试管理</h3>
            <p>创建和管理考试</p>
        </a>

        <!-- 浏览课程 -->
        <a href="${pageContext.request.contextPath}/course/list.action" class="function-card success">
            <span class="icon">📖</span>
            <h3>浏览课程</h3>
            <p>查看所有课程</p>
        </a>

        <!-- 通知公告 -->
        <a href="${pageContext.request.contextPath}/notice/list.action" class="function-card primary">
            <span class="icon">📢</span>
            <h3>通知公告</h3>
            <p>发布和查看通知</p>
        </a>

        <!-- 个人中心 -->
        <a href="${pageContext.request.contextPath}/user/profile.action" class="function-card secondary">
            <span class="icon">👤</span>
            <h3>个人中心</h3>
            <p>管理个人信息</p>
        </a>
        <% } %>
    </div>
</div>

<!-- ====================
     页脚
     ==================== -->
<div class="footer">
    <p>© 2026 在线学习平台 · 让学习变得更简单</p>
</div>

<script>
    /* ====================
       页面加载动画
       ==================== */
    window.addEventListener('load', function() {
        console.log('在线学习平台已加载');
    });
</script>
</body>
</html>
