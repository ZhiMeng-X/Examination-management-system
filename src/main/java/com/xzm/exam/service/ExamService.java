package com.xzm.exam.service;

import com.xzm.exam.domain.NetChoose;
import com.xzm.student.domain.ExamHistory;
import com.xzm.student.domain.Student;

import java.util.List;
import java.util.Map;

public interface ExamService {
    List<NetChoose> getAllExam();

    boolean addExamResult(ExamHistory eh);

    List<NetChoose> getAllTest(Map<String,Object> map);

    int getAllTestCount();

    boolean Collection(Map<String, Object> map, Student student);

    List<NetChoose> getCollectionTest(Map<String, Object> map);

    int getCollectionTestCount(Map<String, Object> map);

    boolean deleteCollectionTest(Map<String, Object> data);
}
