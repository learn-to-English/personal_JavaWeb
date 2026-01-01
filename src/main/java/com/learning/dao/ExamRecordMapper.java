package com.learning.dao;
import com.learning.model.ExamRecord;
import org.apache.ibatis.annotations.Param;
import java.math.BigDecimal;

public interface ExamRecordMapper {
    ExamRecord findByExamAndStudent(@Param("examId") Integer examId, @Param("studentId") Integer studentId);
    int insert(ExamRecord record);
    int updateScore(@Param("id") Integer id, @Param("score") BigDecimal score, @Param("status") String status);
}