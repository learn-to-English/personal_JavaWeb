package com.learning.service;

import com.learning.model.Discussion;
import com.learning.model.DiscussionReply;
import java.util.List;

/**
 * 讨论区业务接口
 */
public interface DiscussionService {

    /**
     * 获取课程的所有讨论话题
     */
    List<Discussion> getCourseDiscussions(Integer courseId);

    /**
     * 根据ID获取话题详情
     */
    Discussion getDiscussionById(Integer id);

    /**
     * 发布新话题
     */
    boolean addDiscussion(Discussion discussion);

    /**
     * 删除话题
     */
    boolean deleteDiscussion(Integer id);

    /**
     * 获取话题的所有回复
     */
    List<DiscussionReply> getDiscussionReplies(Integer discussionId);

    /**
     * 添加回复
     */
    boolean addReply(DiscussionReply reply);

    /**
     * 删除回复
     */
    boolean deleteReply(Integer replyId);
}