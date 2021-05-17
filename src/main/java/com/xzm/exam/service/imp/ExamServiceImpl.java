package com.xzm.exam.service.imp;

import com.xzm.exam.dao.ExamDao;
import com.xzm.exam.dao.ExamHistoryDao;
import com.xzm.exam.dao.NetChooseCollectionDao;
import com.xzm.exam.domain.NetChoose;
import com.xzm.exam.domain.NetChooseCollection;
import com.xzm.exam.service.ExamService;
import com.xzm.student.domain.ExamHistory;
import com.xzm.student.domain.Student;
import com.xzm.utils.DateTimeUtil;
import com.xzm.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("examService")
public class ExamServiceImpl implements ExamService {

    @Autowired
    private ExamDao examDao;

    @Autowired
    private ExamHistoryDao examHistoryDao;

    @Autowired
    private NetChooseCollectionDao netChooseCollectionDao;

    @Override
    public List<NetChoose> getAllExam() {
        return examDao.getAllExam();
    }

    @Override
    public boolean addExamResult(ExamHistory eh) {

        int res = examHistoryDao.addExamResult(eh);
        boolean flag = false;

        if(res > 0){
            flag = true;
        }

        return flag;
    }

    @Override
    public List<NetChoose> getAllTest(Map<String,Object> map) {

        return examDao.getAllTest(map);
    }
    public int getAllTestCount(){
        return examDao.getAllTestCount();
    }

    @Override
    public boolean Collection(Map<String, Object> map, Student student) {
        boolean flag = true;
        int res = 1;
        int isC = (int) map.get("isCollection");
        NetChooseCollection nc = new NetChooseCollection();
        nc.setId(UUIDUtil.getUUID());
        nc.setCreateTime(DateTimeUtil.getSysTime());
        nc.setExam((String) map.get("id"));
        nc.setStudent(student.getId());
        res = examDao.updateCollection(map);
        if (isC == 0){
            res = netChooseCollectionDao.delCollection((String) map.get("id"));
        }else {
            res = netChooseCollectionDao.addCollection(nc);
        }


        if (res < 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public List<NetChoose> getCollectionTest(Map<String, Object> map) {
        return netChooseCollectionDao.getCollectionTest(map);
    }

    @Override
    public int getCollectionTestCount(Map<String, Object> map) {
        return netChooseCollectionDao.getCollectionCount(map);
    }

    @Override
    public boolean deleteCollectionTest(Map<String, Object> data) {

        return netChooseCollectionDao.deleteCollectionTest(data);
    }
}
