package com.xzm.exam.dao;



import com.xzm.exam.domain.NetChoose;
import com.xzm.student.domain.ExamHistory;

import java.util.List;
import java.util.Map;

public interface ExamHistoryDao {


    List<NetChoose> getAllExam();

    int addExamResult(ExamHistory eh);

    List<ExamHistory> getExamHistory(Map<String,Object> data);

    int getExamHistoryCount(String id);

    List<ExamHistory> getExamScore(String id);
}
