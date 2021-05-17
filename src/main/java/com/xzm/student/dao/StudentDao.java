package com.xzm.student.dao;



import com.xzm.student.domain.Student;

import java.util.List;
import java.util.Map;

public interface StudentDao {


    Student login(Student student);

    int resetPwd(Map<String, Object> data);

    int regiest(Student student);
}
