package com.xzm.exam.dao;



import com.xzm.exam.domain.NetChoose;
import com.xzm.student.domain.Student;

import java.util.List;
import java.util.Map;

public interface ExamDao {


    List<NetChoose> getAllExam();

    List<NetChoose> getAllTest(Map<String,Object> map);

    int getAllTestCount();

    int updateCollection(Map<String, Object> map);
}
