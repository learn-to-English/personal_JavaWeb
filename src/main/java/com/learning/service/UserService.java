package com.learning.service;

import com.learning.model.User;
import java.util.List;

/**
 * 用户业务层接口
 */
public interface UserService {

    /**
     * 用户登录
     */
    User login(String username, String password);

    /**
     * 用户注册
     */
    boolean register(User user);

    /**
     * 查询用户（根据 ID）
     */
    User getUserById(Integer id);

    /**
     * 查询用户（根据用户名）
     */
    User getUserByUsername(String username);

    /**
     * 查询所有用户
     */
    List<User> getAllUsers();

    /**
     * 更新用户信息
     */
    boolean updateUser(User user);

    /**
     * 删除用户
     */
    boolean deleteUser(Integer id);

    /**
     * 检查用户名是否已存在
     */
    boolean checkUsernameExists(String username);
}