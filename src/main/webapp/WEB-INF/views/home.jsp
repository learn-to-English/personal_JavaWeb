<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页 - 在线学习平台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
        }

        /* 顶部导航栏 */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .header .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .header .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .header .user-info span {
            font-size: 14px;
        }

        .header .btn-logout {
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }

        .header .btn-logout:hover {
            background: rgba(255,255,255,0.3);
        }

        /* 欢迎区域 */
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 50px;
            text-align: center;
        }

        .welcome-section h1 {
            font-size: 36px;
            margin-bottom: 15px;
        }

        .welcome-section p {
            font-size: 18px;
            opacity: 0.9;
        }

        /* 主要内容区 */
        .main-content {
            max-width: 1200px;
            margin: -30px auto 0;
            padding: 0 20px 40px;
            position: relative;
        }

        /* 功能卡片区域 */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .card .icon {
            font-size: 50px;
            margin-bottom: 20px;
        }

        .card h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }

        /* 不同角色显示不同颜色 */
        .card.student { border-top: 4px solid #667eea; }
        .card.teacher { border-top: 4px solid #28a745; }
        .card.admin { border-top: 4px solid #dc3545; }

        /* 角色标签 */
        .role-tag {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            margin-top: 10px;
        }

        .role-tag.student { background: #e7f3ff; color: #667eea; }
        .role-tag.teacher { background: #d4edda; color: #28a745; }
        .role-tag.admin { background: #f8d7da; color: #dc3545; }

        /* 页脚 */
        .footer {
            text-align: center;
            padding: 30px;
            color: #999;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- 顶部导航 -->
    <div class="header">
        <div class="logo">📚 在线学习平台</div>
        <div class="user-info">
            <span>欢迎您，${sessionScope.user.username}</span>
            <span class="role-tag ${sessionScope.user.role}">
                <%
                    String role = ((com.learning.model.User)session.getAttribute("user")).getRole();
                    if ("admin".equals(role)) {
                        out.print("管理员");
                    } else if ("teacher".equals(role)) {
                        out.print("教师");
                    } else {
                        out.print("学生");
                    }
                %>
            </span>
            <a href="${pageContext.request.contextPath}/user/logout.action" class="btn-logout">退出登录</a>
        </div>
    </div>

    <!-- 欢迎区域 -->
    <div class="welcome-section">
        <h1>🎓 欢迎来到在线学习平台</h1>
        <p>开始您的学习之旅，探索知识的海洋</p>
    </div>

    <!-- 主要内容 -->
    <div class="main-content">
        <div class="card-grid">
            
            <!-- 所有用户都能看到：浏览课程 -->
            <a href="${pageContext.request.contextPath}/course/list.action" class="card student">
                <div class="icon">📖</div>
                <h3>浏览课程</h3>
                <p>查看所有可选课程，发现感兴趣的内容</p>
            </a>

            <!-- 所有用户都能看到：我的学习 -->
            <a href="${pageContext.request.contextPath}/study/myList.action" class="card student">
                <div class="icon">📝</div>
                <h3>我的学习</h3>
                <p>查看已选课程，继续学习进度</p>
            </a>

            <!-- 教师和管理员能看到：课程管理 -->
            <%
                if ("teacher".equals(role) || "admin".equals(role)) {
            %>
            <a href="${pageContext.request.contextPath}/course/myList.action" class="card teacher">
                <div class="icon">🎯</div>
                <h3>课程管理</h3>
                <p>管理我发布的课程，添加新课程</p>
            </a>
            <%
                }
            %>

            <!-- 管理员能看到：用户管理 -->
            <%
                if ("admin".equals(role)) {
            %>
            <a href="${pageContext.request.contextPath}/admin/userList.action" class="card admin">
                <div class="icon">👥</div>
                <h3>用户管理</h3>
                <p>管理系统用户，审核教师申请</p>
            </a>
            <%
                }
            %>

            <!-- 所有用户：个人中心 -->
            <a href="${pageContext.request.contextPath}/user/profile.action" class="card student">
                <div class="icon">👤</div>
                <h3>个人中心</h3>
                <p>查看和修改个人信息</p>
            </a>

        </div>
    </div>

    <!-- 页脚 -->
    <div class="footer">
        <p>© 2025 在线学习平台 - 课程设计作业</p>
    </div>
</body>
</html>
