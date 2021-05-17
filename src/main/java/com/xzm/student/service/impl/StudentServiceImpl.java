package com.xzm.student.service.impl;

import com.xzm.exam.dao.ExamHistoryDao;
import com.xzm.exception.LoginException;
import com.xzm.student.dao.StudentDao;
import com.xzm.student.domain.ExamHistory;
import com.xzm.student.domain.Student;
import com.xzm.student.service.StudentService;
import com.xzm.utils.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("studentService")
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private ExamHistoryDao examHistoryDao;


    @Override
    public Student login(Student student,String ip) throws LoginException {
        Student studentRes = studentDao.login(student);
        if (studentRes == null){
            throw new LoginException("账号密码错误");
        }

        String expireTime = studentRes.getExpireTime();
        String currentTime = DateTimeUtil.getSysTime();
        if(expireTime.compareTo(currentTime)<0){

            throw new LoginException("账号已失效");

        }

        //判断锁定状态
        String lockState = studentRes.getLockState();
        if("0".equals(lockState)){

            studentRes.setLockState("账户锁定");
            throw new LoginException("账号已锁定");

        }else {
            studentRes.setLockState("账户正常");
        }

        //判断ip地址
        String allowIps = studentRes.getAllowIps();

        if(!allowIps.contains(ip)){

            throw new LoginException("ip地址受限");

        }
        return studentRes;
    }

    @Override
    public int getExamHistoryCount(String id) {
        return examHistoryDao.getExamHistoryCount(id);
    }

    @Override
    public List<ExamHistory> getExamScore(String id) {
        return examHistoryDao.getExamScore(id);
    }

    @Override
    public int resetPwd(Map<String, Object> data) {
        return studentDao.resetPwd(data);
    }

    @Override
    public int regiest(Student student) {
        System.out.println(student);
        return studentDao.regiest(student);
    }

    @Override
    public List<ExamHistory> getExamHistory(Map<String,Object> data) {

        return examHistoryDao.getExamHistory(data);
    }
}
