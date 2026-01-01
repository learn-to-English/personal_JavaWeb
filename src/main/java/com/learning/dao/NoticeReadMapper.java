package com.learning.dao;

import com.learning.model.NoticeRead;
import org.apache.ibatis.annotations.Param;

/**
 * 通知阅读记录数据访问接口
 */
public interface NoticeReadMapper {

    /**
     * 记录用户阅读通知
     */
    int insert(NoticeRead noticeRead);

    /**
     * 检查用户是否已读某通知
     */
    NoticeRead findByNoticeAndUser(@Param("noticeId") Integer noticeId, @Param("userId") Integer userId);

    /**
     * 统计某通知的阅读人数
     */
    int countByNotice(Integer noticeId);
}