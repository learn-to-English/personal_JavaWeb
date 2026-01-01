package com.learning.dao;

import com.learning.model.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 用户数据访问接口
 */
public interface UserMapper {

    /**
     * 根据 ID 查询用户
     */
    User selectUserById(Integer id);

    /**
     * 根据用户名查询用户
     */
    User selectUserByUsername(String username);

    /**
     * 查询所有用户
     */
    List<User> selectAllUsers();

    /**
     * 插入用户
     */
    int insertUser(User user);

    /**
     * 更新用户
     */
    int updateUser(User user);

    /**
     * 删除用户
     */
    int deleteUser(Integer id);

    /**
     * 验证用户登录（用户名和密码）
     * 注意：多个参数必须使用 @Param 注解
     */
    User selectUserByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
}