package com.learning.dao;

import com.learning.model.Discussion;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 讨论话题数据访问接口
 */
public interface DiscussionMapper {

    /**
     * 查询课程的所有讨论话题（按时间倒序）
     */
    List<Discussion> findByCourseId(Integer courseId);

    /**
     * 根据ID查询话题详情
     */
    Discussion findById(Integer id);

    /**
     * 添加讨论话题
     */
    int insert(Discussion discussion);

    /**
     * 删除讨论话题
     */
    int delete(Integer id);

    /**
     * 增加回复数量
     */
    int addReplyCount(Integer id);

    /**
     * 减少回复数量
     */
    int reduceReplyCount(Integer id);
}