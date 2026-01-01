package com.learning.service;

import com.learning.model.Notice;
import java.util.List;

public interface NoticeService {
    List<Notice> getUserNotices(Integer userId, String filter);
    List<Notice> getUnreadNotices(Integer userId);
    Notice getNoticeById(Integer id, Integer userId);
    boolean publishNotice(Notice notice);
    boolean markAsRead(Integer noticeId, Integer userId);
    int getUnreadCount(Integer userId);
    List<Notice> getPublisherNotices(Integer publisherId);
    boolean updateNotice(Notice notice);
    boolean deleteNotice(Integer id);
}