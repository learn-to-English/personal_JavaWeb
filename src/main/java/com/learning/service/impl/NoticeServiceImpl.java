package com.learning.service.impl;
import com.learning.dao.*;
import com.learning.model.*;
import com.learning.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Autowired private NoticeMapper noticeMapper;
    @Autowired private NoticeReadMapper noticeReadMapper;

    public List<Notice> getUserNotices(Integer userId, String filter) {
        return noticeMapper.findByUser(userId, filter);
    }
    public List<Notice> getUnreadNotices(Integer userId) {
        return noticeMapper.findUnreadByUser(userId);
    }
    public Notice getNoticeById(Integer id, Integer userId) {
        Notice notice = noticeMapper.findById(id);
        if (notice != null && userId != null) {
            NoticeRead read = noticeReadMapper.findByNoticeAndUser(id, userId);
            notice.setIsRead(read != null);
        }
        return notice;
    }
    public boolean publishNotice(Notice notice) {
        return notice != null && noticeMapper.insert(notice) > 0;
    }
    public boolean markAsRead(Integer noticeId, Integer userId) {
        if (noticeReadMapper.findByNoticeAndUser(noticeId, userId) != null) return true;
        NoticeRead nr = new NoticeRead();
        nr.setNoticeId(noticeId);
        nr.setUserId(userId);
        return noticeReadMapper.insert(nr) > 0;
    }
    public int getUnreadCount(Integer userId) {
        return userId == null ? 0 : noticeMapper.countUnread(userId);
    }
    public List<Notice> getPublisherNotices(Integer publisherId) {
        return noticeMapper.findByPublisher(publisherId);
    }
    public boolean updateNotice(Notice notice) {
        return notice != null && noticeMapper.update(notice) > 0;
    }
    public boolean deleteNotice(Integer id) {
        return id != null && noticeMapper.delete(id) > 0;
    }
}