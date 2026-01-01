package com.learning.dao;

import com.learning.model.DiscussionReply;
import java.util.List;

/**
 * 讨论回复数据访问接口
 */
public interface DiscussionReplyMapper {

    /**
     * 查询话题的所有回复（按时间正序）
     */
    List<DiscussionReply> findByDiscussionId(Integer discussionId);

    /**
     * 根据ID查询回复
     */
    DiscussionReply findById(Integer id);

    /**
     * 添加回复
     */
    int insert(DiscussionReply reply);

    /**
     * 删除回复
     */
    int delete(Integer id);
}