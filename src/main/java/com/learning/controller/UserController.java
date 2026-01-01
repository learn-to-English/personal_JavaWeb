package com.learning.controller;

import com.learning.model.User;
import com.learning.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  // ← 添加这个导入
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
    @RequestMapping(value = "/toRegister.action", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String toRegister() {
        return "register";
    }

    /**
     * 进入登录页面
     */
    @RequestMapping(value = "/toLogin.action", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String toLogin() {
        return "login";
    }

    /**
     * 用户注册（改进版 - 支持角色选择）
     */
    @RequestMapping(value = "/register.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String register(String username, String password, String confirmPassword, String email, String phone, String role) {
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

            // 验证角色参数
            if (role == null || role.isEmpty()) {
                role = "student";  // 默认为学生
            }

            // 只允许注册学生和教师，不允许直接注册管理员
            if (!"student".equals(role) && !"teacher".equals(role)) {
                return "{\"success\": false, \"message\": \"无效的角色类型\"}";
            }

            // 创建用户对象
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone);
            user.setRole(role);  // 使用用户选择的角色

            // 注册用户
            boolean result = userService.register(user);

            if (result) {
                String roleText = "student".equals(role) ? "学生" : "教师";
                return "{\"success\": true, \"message\": \"注册成功！您的身份是：" + roleText + "\"}";
            } else {
                return "{\"success\": false, \"message\": \"注册失败，请重试\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"系统错误: " + e.getMessage() + "\"}";
        }
    }


    /**
     * 用户登录
     */
    @RequestMapping(value = "/login.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
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
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"系统错误: " + e.getMessage() + "\"}";
        }
    }

    /**
     * 用户登出
     */
    @RequestMapping(value = "/logout.action", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
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
    @RequestMapping(value = "/getCurrentUser.action", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
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
    @RequestMapping(value = "/checkUsername.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
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

    /**
     * 显示个人中心页面
     */
    @RequestMapping(value = "/profile.action", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String profile(HttpSession session, Model model) {
        System.out.println("========== 进入profile方法 ==========");

        // 检查登录
        User user = (User) session.getAttribute("user");
        System.out.println("Session中的用户: " + user);

        if (user == null) {
            System.out.println("用户未登录，跳转到登录页");
            return "redirect:/user/toLogin.action";
        }

        System.out.println("用户ID: " + user.getId());

        // 从数据库重新获取最新的用户信息
        User latestUser = userService.getUserById(user.getId());
        System.out.println("从数据库获取的用户: " + latestUser);

        // 更新session中的用户信息
        session.setAttribute("user", latestUser);

        model.addAttribute("user", latestUser);

        System.out.println("准备返回视图: user/profile");
        return "user/profile";
    }

    /**
     * 显示编辑个人信息页面
     */
    @RequestMapping(value = "/toEditProfile.action", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String toEditProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/toLogin.action";
        }

        model.addAttribute("user", user);
        return "user/editProfile";
    }

    /**
     * 更新个人信息
     */
    @RequestMapping(value = "/updateProfile.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String updateProfile(String email, String phone, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "{\"success\": false, \"message\": \"请先登录\"}";
            }

            // 更新用户信息
            user.setEmail(email);
            user.setPhone(phone);

            boolean success = userService.updateUser(user);

            if (success) {
                // 更新session中的用户信息
                session.setAttribute("user", user);
                return "{\"success\": true, \"message\": \"信息更新成功\"}";
            } else {
                return "{\"success\": false, \"message\": \"信息更新失败\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"系统错误: " + e.getMessage() + "\"}";
        }
    }

    /**
     * 修改密码
     */
    @RequestMapping(value = "/changePassword.action", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String changePassword(String oldPassword, String newPassword, String confirmPassword, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "{\"success\": false, \"message\": \"请先登录\"}";
            }

            // 验证旧密码
            if (!user.getPassword().equals(oldPassword)) {
                return "{\"success\": false, \"message\": \"原密码错误\"}";
            }

            // 验证新密码
            if (newPassword == null || newPassword.trim().isEmpty()) {
                return "{\"success\": false, \"message\": \"新密码不能为空\"}";
            }

            if (newPassword.length() < 6) {
                return "{\"success\": false, \"message\": \"新密码至少6位\"}";
            }

            if (!newPassword.equals(confirmPassword)) {
                return "{\"success\": false, \"message\": \"两次输入的密码不一致\"}";
            }

            // 更新密码
            user.setPassword(newPassword);
            boolean success = userService.updateUser(user);

            if (success) {
                // 更新session
                session.setAttribute("user", user);
                return "{\"success\": true, \"message\": \"密码修改成功\"}";
            } else {
                return "{\"success\": false, \"message\": \"密码修改失败\"}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"success\": false, \"message\": \"系统错误: " + e.getMessage() + "\"}";
        }
    }

}