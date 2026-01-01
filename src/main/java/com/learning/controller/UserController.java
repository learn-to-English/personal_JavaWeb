package com.learning.controller;

import com.learning.model.User;
import com.learning.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;

/**
 * 用户控制层
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 进入注册页面
     */
    @RequestMapping(value = "/toRegister.action", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    public String toRegister() {
        return "register";
    }

    /**
     * 进入登录页面
     */
    @RequestMapping(value = "/toLogin.action", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    public String toLogin() {
        return "login";
    }

    /**
     * 用户注册
     */
    @RequestMapping(value = "/register.action", method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String register(String username, String password, String confirmPassword, String email, String phone) {
        try {
            // 参数验证
            if (username == null || username.isEmpty()) {
                return "{\"success\": false, \"message\": \"用户名不能为空\"}";
            }
            if (password == null || password.isEmpty()) {
                return "{\"success\": false, \"message\": \"密码不能为空\"}";
            }
            if (!password.equals(confirmPassword)) {
                return "{\"success\": false, \"message\": \"两次输入的密码不一致\"}";
            }

            // 检查用户名是否已存在
            if (userService.checkUsernameExists(username)) {
                return "{\"success\": false, \"message\": \"用户名已存在\"}";
            }

            // 创建用户对象
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone);
            user.setRole("student");

            // 注册用户
            boolean result = userService.register(user);

            if (result) {
                return "{\"success\": true, \"message\": \"注册成功，请登录\"}";
            } else {
                return "{\"success\": false, \"message\": \"注册失败，请重试\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();  // 打印详细错误到控制台
            return "{\"success\": false, \"message\": \"系统错误: " + e.getMessage() + "\"}";
        }
    }

    /**
     * 用户登录
     */
    @RequestMapping(value = "/login.action", method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String login(String username, String password, HttpSession session) {
        try {
            // 参数验证
            if (username == null || username.isEmpty()) {
                return "{\"success\": false, \"message\": \"用户名不能为空\"}";
            }
            if (password == null || password.isEmpty()) {
                return "{\"success\": false, \"message\": \"密码不能为空\"}";
            }

            System.out.println("=== 登录请求 ===");
            System.out.println("用户名: " + username);
            System.out.println("密码: " + password);

            // 调用业务层进行登录验证
            User user = userService.login(username, password);

            System.out.println("查询结果: " + user);

            if (user != null) {
                // 登录成功，将用户信息存储到 session
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());

                return "{\"success\": true, \"message\": \"登录成功\"}";
            } else {
                return "{\"success\": false, \"message\": \"用户名或密码错误\"}";
            }
        } catch (Exception e) {
            System.out.println("=== 登录异常 ===");
            e.printStackTrace();  // 打印详细错误到控制台
            return "{\"success\": false, \"message\": \"系统错误: " + e.getMessage() + "\"}";
        }
    }

    /**
     * 用户登出
     */
    @RequestMapping(value = "/logout.action", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    public String logout(HttpSession session) {
        // 清除 session 中的用户信息
        session.removeAttribute("user");
        session.removeAttribute("userId");
        session.removeAttribute("username");

        return "redirect:/";
    }

    /**
     * 获取当前登录用户信息
     */
    @RequestMapping(value = "/getCurrentUser.action", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String getCurrentUser(HttpSession session) {
        User user = (User) session.getAttribute("user");

        if (user != null) {
            return "{\"success\": true, \"data\": " + user.toString() + "}";
        } else {
            return "{\"success\": false, \"message\": \"用户未登录\"}";
        }
    }

    /**
     * 检查用户名是否已存在（AJAX 请求）
     */
    @RequestMapping(value = "/checkUsername.action", method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String checkUsername(String username) {
        try {
            if (username == null || username.isEmpty()) {
                return "{\"exists\": false}";
            }

            boolean exists = userService.checkUsernameExists(username);
            return "{\"exists\": " + exists + "}";
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"exists\": false, \"error\": \"" + e.getMessage() + "\"}";
        }
    }
}