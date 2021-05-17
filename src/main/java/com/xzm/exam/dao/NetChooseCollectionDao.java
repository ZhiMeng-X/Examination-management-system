package com.xzm.exam.dao;



import com.xzm.exam.domain.NetChoose;
import com.xzm.exam.domain.NetChooseCollection;

import java.util.List;
import java.util.Map;

public interface NetChooseCollectionDao {


    int addCollection(NetChooseCollection nc);

    int delCollection(String examId);

    List<NetChoose> getCollectionTest(Map<String, Object> map);

    int getCollectionCount(Map<String, Object> map);

    boolean deleteCollectionTest(Map<String, Object> data);
}
