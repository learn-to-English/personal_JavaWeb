<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 检查用户是否已经登录
    Object user = session.getAttribute("user");

    if (user == null) {
        // 没有登录，跳转到登录页面
        response.sendRedirect(request.getContextPath() + "/user/toLogin.action");
    } else {
        // 已经登录，跳转到首页
        response.sendRedirect(request.getContextPath() + "/home.action");
    }
%>
