package com.xzm.exam.web;


import com.xzm.exam.domain.NetChoose;
import com.xzm.exam.service.ExamService;
import com.xzm.student.domain.ExamHistory;
import com.xzm.student.domain.Student;
import com.xzm.student.service.StudentService;
import com.xzm.utils.DateTimeUtil;
import com.xzm.utils.UUIDUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/exam")
public class ExamController {


    @RequestMapping("/examList.do")
    @ResponseBody
    public Map<String, Object> examList(HttpServletRequest request){
        System.out.println("试题查询");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        ExamService es = (ExamService) ac.getBean("examService");
        boolean flag = true;
        List<NetChoose> nc = es.getAllExam();
        Map<String,Object> map = new HashMap<>();
        if (nc == null){
            flag = false;
        }
        request.getServletContext().setAttribute("nc",nc);
        map.put("nc",nc);
        map.put("success",flag);
        System.out.println(map);
        return map;
    }

    @RequestMapping("/result.do")
    @ResponseBody
    public Map<String, Object> result(HttpServletRequest request,String result){
        System.out.println("成绩上传");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        ExamHistory eh = new ExamHistory();
        eh.setId(UUIDUtil.getUUID());
        eh.setStudent(((Student) request.getSession().getAttribute("stu")).getId());
        eh.setCreateTime(DateTimeUtil.getSysTime());
        eh.setScore(result);
        System.out.println(eh);
        ExamService es = (ExamService) ac.getBean("examService");
        boolean flag = es.addExamResult(eh);

        Map<String,Object> map = new HashMap<>();

        map.put("success",flag);
        System.out.println(map);
        return map;
    }

    @RequestMapping("/testList.do")
    @ResponseBody
    public Map<String, Object> testList(HttpServletRequest request,Integer pageNo, Integer pageSize){
        System.out.println("测试模式");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        ExamService es = (ExamService) ac.getBean("examService");
        int skipCount = (pageNo-1)*(pageSize);
        boolean flag = true;
        Map<String,Object> map = new HashMap<>();
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        List<NetChoose> nc = es.getAllTest(map);
        int total = es.getAllTestCount();

        Map<String,Object> map1 = new HashMap<>();
        if (nc == null){
            flag = false;
        }
        request.getServletContext().setAttribute("nc",nc);
        map1.put("nc",nc);
        map1.put("success",flag);
        map1.put("total",total);
        System.out.println(map1);
        System.out.println(total);
        return map1;
    }


    @RequestMapping("/isCollection.do")
    @ResponseBody
    public Map<String, Object> isCollection(HttpServletRequest request,String id, Integer isCollection){
        System.out.println("收藏模式");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        ExamService es = (ExamService) ac.getBean("examService");
        Map<String,Object> map = new HashMap<>();
        Student student = (Student) request.getSession().getAttribute("stu");
        boolean flag = true;
        if(isCollection == 1){
            isCollection = 0;
        }else {
            isCollection = 1;
        }
        System.out.println(id + "==" + isCollection);
        map.put("id",id);
        map.put("isCollection",isCollection);
        flag = es.Collection(map,student);

        Map<String,Object> map1 = new HashMap<>();
        map1.put("success",flag);

        return map1;
    }

    @RequestMapping("/examHistory.do")
    @ResponseBody
    public Map<String, Object> examHistory(HttpServletRequest request,String id,Integer pageNo, Integer pageSize){

        System.out.println("考试历史");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        StudentService es = (StudentService) ac.getBean("studentService");
        int skipCount = (pageNo-1)*(pageSize);
        Map<String,Object> data = new HashMap<>();
        data.put("skipCount",skipCount);
        data.put("pageSize",pageSize);
        data.put("id",id);
        Map<String,Object> map = new HashMap<>();
        boolean flag = true;
        System.out.println(data);

        List<ExamHistory> list = es.getExamHistory(data);
        int total = es.getExamHistoryCount(id);
        if(list == null){
            flag = false;
        }

        map.put("success",flag);
        map.put("total",total);
        map.put("list",list);

        return map;
    }

    @RequestMapping("/examscore.do")
    @ResponseBody
    public Map<String, Object> examHistory(HttpServletRequest request,String id){

        System.out.println("考试分数分析");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        StudentService es = (StudentService) ac.getBean("studentService");

        Map<String,Object> map = new HashMap<>();
        boolean flag = true;
        List<ExamHistory> list = es.getExamScore(id);
        System.out.println(list);
        if(list == null){
            flag = false;
        }
        map.put("success",flag);
        map.put("score",list);

        return map;
    }

    @PostMapping("/testLove.do")
    @ResponseBody
    public Map<String,Object> testLove(HttpServletRequest request,String id,Integer pageNo, Integer pageSize){
        System.out.println("收藏模式");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        ExamService es = (ExamService) ac.getBean("examService");
        int skipCount = (pageNo-1)*(pageSize);
        boolean flag = true;
        Map<String,Object> map = new HashMap<>();
        map.put("studentId",id);
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);
        List<NetChoose> nc = es.getCollectionTest(map);
        int total = es.getCollectionTestCount(map);

        Map<String,Object> map1 = new HashMap<>();
        if (nc == null){
            flag = false;
        }

        map1.put("nc",nc);
        map1.put("success",flag);
        map1.put("total",total);
        System.out.println(map1);
        System.out.println(total);
        return map1;
    }


    @PostMapping("/deleteColl.do")
    @ResponseBody
    public Map<String,Object> deleteColl(HttpServletRequest request,String NetChoose_id,String student_id){
        System.out.println("删除收藏");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        ExamService es = (ExamService) ac.getBean("examService");
        Map<String,Object> data = new HashMap<>();
        data.put("NetChoose_id",NetChoose_id);
        data.put("student_id",student_id);
        boolean flag  = es.deleteCollectionTest(data);


        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        System.out.println(map);
        return map;
    }
}
