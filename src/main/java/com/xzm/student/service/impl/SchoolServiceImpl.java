package com.xzm.student.service.impl;

import com.xzm.student.dao.SchoolDao;
import com.xzm.student.domain.School;
import com.xzm.student.service.SchoolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SchoolServiceImpl implements SchoolService {

    @Autowired
    private SchoolDao schoolDao;

    @Override
    public List<School> queryAll() {
        return schoolDao.queryAll();
    }
}
