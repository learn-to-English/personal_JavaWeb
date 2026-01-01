package com.learning.dao;

import com.learning.model.Notice;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 通知公告数据访问接口
 */
public interface NoticeMapper {

    /**
     * 查询用户的所有通知（课程通知+系统公告）
     */
    List<Notice> findByUser(@Param("userId") Integer userId, @Param("filter") String filter);

    /**
     * 查询未读通知
     */
    List<Notice> findUnreadByUser(Integer userId);

    /**
     * 查询教师发布的通知
     */
    List<Notice> findByPublisher(Integer publisherId);

    /**
     * 根据ID查询通知
     */
    Notice findById(Integer id);

    /**
     * 添加通知
     */
    int insert(Notice notice);

    /**
     * 更新通知
     */
    int update(Notice notice);

    /**
     * 删除通知
     */
    int delete(Integer id);

    /**
     * 统计用户未读通知数量
     */
    int countUnread(Integer userId);
}