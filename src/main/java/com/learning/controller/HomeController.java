package com.learning.controller;

import com.learning.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;

/**
 * 首页控制器
 */
@Controller
public class HomeController {

    /**
     * 显示首页
     */
    @RequestMapping("/home.action")
    public String home(HttpSession session) {
        // 检查是否登录
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // 没登录，去登录页
            return "redirect:/user/toLogin.action";
        }
        
        // 已登录，显示首页
        return "home";
    }
}
