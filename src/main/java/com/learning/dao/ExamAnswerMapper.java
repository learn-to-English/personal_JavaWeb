package com.learning.dao;
import com.learning.model.ExamAnswer;
import java.util.List;

public interface ExamAnswerMapper {
    int insert(ExamAnswer answer);
    List<ExamAnswer> findByRecordId(Integer recordId);
}