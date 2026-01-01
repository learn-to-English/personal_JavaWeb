package com.learning.dao;
import com.learning.model.Exam;
import java.util.List;

public interface ExamMapper {
    List<Exam> findAllPublished();
    Exam findById(Integer id);
    int insert(Exam exam);
}