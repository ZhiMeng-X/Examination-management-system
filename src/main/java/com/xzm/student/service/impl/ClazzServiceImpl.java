package com.xzm.student.service.impl;

import com.xzm.student.dao.ClazzDao;
import com.xzm.student.domain.Clazz;
import com.xzm.student.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ClazzServiceImpl implements ClazzService {

    @Autowired
    private ClazzDao clazzDao;

    @Override
    public List<Clazz> queryAll() {
        return clazzDao.queryAll();
    }
}
