package com.xzm.student.service;

import com.xzm.exception.LoginException;
import com.xzm.student.domain.ExamHistory;
import com.xzm.student.domain.School;
import com.xzm.student.domain.Student;

import java.util.List;
import java.util.Map;

public interface SchoolService {

    List<School> queryAll();
}
