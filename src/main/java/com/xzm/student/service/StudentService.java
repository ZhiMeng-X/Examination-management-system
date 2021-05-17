package com.xzm.student.service;

import com.xzm.exception.LoginException;
import com.xzm.student.domain.ExamHistory;
import com.xzm.student.domain.Student;

import java.util.List;
import java.util.Map;



public interface StudentService {
    Student login(Student student,String ip) throws LoginException;

    List<ExamHistory> getExamHistory(Map<String,Object> data);

    int getExamHistoryCount(String id);

    List<ExamHistory> getExamScore(String id);

    int resetPwd(Map<String, Object> data);

    int regiest(Student student);
}
