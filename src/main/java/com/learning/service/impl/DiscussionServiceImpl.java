package com.learning.service.impl;

import com.learning.dao.DiscussionMapper;
import com.learning.dao.DiscussionReplyMapper;
import com.learning.model.Discussion;
import com.learning.model.DiscussionReply;
import com.learning.service.DiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

/**
 * 讨论区业务实现类
 */
@Service
public class DiscussionServiceImpl implements DiscussionService {

    @Autowired
    private DiscussionMapper discussionMapper;

    @Autowired
    private DiscussionReplyMapper discussionReplyMapper;

    /**
     * 获取课程的所有讨论话题
     */
    @Override
    public List<Discussion> getCourseDiscussions(Integer courseId) {
        if (courseId == null || courseId <= 0) {
            return null;
        }
        return discussionMapper.findByCourseId(courseId);
    }

    /**
     * 根据ID获取话题详情
     */
    @Override
    public Discussion getDiscussionById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }
        return discussionMapper.findById(id);
    }

    /**
     * 发布新话题
     */
    @Override
    public boolean addDiscussion(Discussion discussion) {
        if (discussion == null) {
            return false;
        }

        // 验证必填字段
        if (discussion.getCourseId() == null || discussion.getUserId() == null) {
            return false;
        }

        if (discussion.getTitle() == null || discussion.getTitle().trim().isEmpty()) {
            return false;
        }

        int result = discussionMapper.insert(discussion);
        return result > 0;
    }

    /**
     * 删除话题（会级联删除所有回复）
     */
    @Override
    @Transactional
    public boolean deleteDiscussion(Integer id) {
        if (id == null || id <= 0) {
            return false;
        }

        int result = discussionMapper.delete(id);
        return result > 0;
    }

    /**
     * 获取话题的所有回复
     */
    @Override
    public List<DiscussionReply> getDiscussionReplies(Integer discussionId) {
        if (discussionId == null || discussionId <= 0) {
            return null;
        }
        return discussionReplyMapper.findByDiscussionId(discussionId);
    }

    /**
     * 添加回复
     */
    @Override
    @Transactional
    public boolean addReply(DiscussionReply reply) {
        if (reply == null) {
            return false;
        }

        // 验证必填字段
        if (reply.getDiscussionId() == null || reply.getUserId() == null) {
            return false;
        }

        if (reply.getContent() == null || reply.getContent().trim().isEmpty()) {
            return false;
        }

        // 添加回复
        int result = discussionReplyMapper.insert(reply);

        // 成功后，增加话题的回复数
        if (result > 0) {
            discussionMapper.addReplyCount(reply.getDiscussionId());
        }

        return result > 0;
    }

    /**
     * 删除回复
     */
    @Override
    @Transactional
    public boolean deleteReply(Integer replyId) {
        if (replyId == null || replyId <= 0) {
            return false;
        }

        // 先查询回复信息，获取所属话题ID
        DiscussionReply reply = discussionReplyMapper.findById(replyId);
        if (reply == null) {
            return false;
        }

        // 删除回复
        int result = discussionReplyMapper.delete(replyId);

        // 成功后，减少话题的回复数
        if (result > 0) {
            discussionMapper.reduceReplyCount(reply.getDiscussionId());
        }

        return result > 0;
    }
}