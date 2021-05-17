package com.xzm.student.service.impl;

import com.xzm.student.dao.AcademicDao;
import com.xzm.student.domain.Academic;
import com.xzm.student.service.AcademicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AcademicServiceImpl implements AcademicService {

    @Autowired
    private AcademicDao academicDao;

    @Override
    public List<Academic> queryAll() {
        return academicDao.queryAll();
    }
}
