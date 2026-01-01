package com.learning.service.impl;

import com.learning.dao.UserMapper;
import com.learning.model.User;
import com.learning.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 用户业务层实现
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 用户登录
     */
    @Override
    public User login(String username, String password) {
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            return null;
        }
        return userMapper.selectUserByUsernameAndPassword(username, password);
    }

    /**
     * 用户注册
     */
    @Override
    public boolean register(User user) {
        if (user == null || user.getUsername() == null || user.getPassword() == null) {
            return false;
        }

        // 检查用户名是否已存在
        if (checkUsernameExists(user.getUsername())) {
            return false;
        }

        // 如果没有设置角色，默认为学生
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("student");
        }

        int result = userMapper.insertUser(user);
        return result > 0;
    }

    /**
     * 查询用户（根据 ID）
     */
    @Override
    public User getUserById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }
        return userMapper.selectUserById(id);
    }

    /**
     * 查询用户（根据用户名）
     */
    @Override
    public User getUserByUsername(String username) {
        if (username == null || username.isEmpty()) {
            return null;
        }
        return userMapper.selectUserByUsername(username);
    }

    /**
     * 查询所有用户
     */
    @Override
    public List<User> getAllUsers() {
        return userMapper.selectAllUsers();
    }

    /**
     * 更新用户信息
     */
    @Override
    public boolean updateUser(User user) {
        if (user == null || user.getId() == null) {
            return false;
        }
        int result = userMapper.updateUser(user);
        return result > 0;
    }

    /**
     * 删除用户
     */
    @Override
    public boolean deleteUser(Integer id) {
        if (id == null || id <= 0) {
            return false;
        }
        int result = userMapper.deleteUser(id);
        return result > 0;
    }

    /**
     * 检查用户名是否已存在
     */
    @Override
    public boolean checkUsernameExists(String username) {
        if (username == null || username.isEmpty()) {
            return false;
        }
        User user = userMapper.selectUserByUsername(username);
        return user != null;
    }
}