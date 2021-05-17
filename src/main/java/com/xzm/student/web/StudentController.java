package com.xzm.student.web;


import com.xzm.student.domain.Academic;
import com.xzm.student.domain.Clazz;
import com.xzm.student.domain.School;
import com.xzm.student.domain.Student;
import com.xzm.student.service.StudentService;
import com.xzm.utils.DateTimeUtil;
import com.xzm.utils.MD5Util;
import com.xzm.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/student")
public class StudentController {



    @RequestMapping("/login.do")
    @ResponseBody
    public Map<String,Object> login(HttpServletRequest request, Student student){
        System.out.println("基于MVC进入学生登录信息校验");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        student.setLoginPwd(MD5Util.getMD5(student.getLoginPwd()));
        String ip = request.getRemoteAddr();
        System.out.println(student + "====" + ip);

        Map<String,Object> map = new HashMap<String,Object>();

        StudentService studentService = (StudentService) ac.getBean("studentService");

        try{
            Student studentRes = studentService.login(student,ip);
            System.out.println(studentRes);
            request.getSession().setAttribute("stu", studentRes);
            map.put("success", true);

        }catch (Exception e){
            e.printStackTrace();
            String msg = e.getMessage();

            map.put("success", false);
            map.put("msg", msg);
        }

        return map;
    }

    @RequestMapping("/school.do")
    @ResponseBody
    public List<School> getSchool(HttpServletRequest request){
        System.out.println("基于MVC进入获取学校");

        List<School> school = (List<School>) request.getServletContext().getAttribute("school");
        System.out.println(school);
        return school;
    }

    @RequestMapping("/academic.do")
    @ResponseBody
    public List<Academic> getacademic(HttpServletRequest request, String id){
        System.out.println("基于MVC进入获取二级学院");

        List<Academic> list = (List<Academic>) request.getServletContext().getAttribute("academic");
        List<Academic> academics = new ArrayList<>();
        for (Academic academic : list){
            System.out.println(academic.getSchool() + "--" + id);
            if (academic.getSchool().equals(id)){
                academics.add(academic);
            }
        }
        System.out.println(academics);
        return academics;
    }

    @RequestMapping("/clazz.do")
    @ResponseBody
    public List<Clazz> getclazz(HttpServletRequest request, String school_id,String academic_id){
        System.out.println("基于MVC进入获取班级");

        List<Clazz> list = (List<Clazz>) request.getServletContext().getAttribute("clazz");
        List<Clazz> clazzs = new ArrayList<>();
        for (Clazz clazz : list){

            if (clazz.getSchool().equals(school_id) && clazz.getAcademic().equals(academic_id)){
                clazzs.add(clazz);
            }
        }
        System.out.println(list);
        System.out.println(clazzs);
        return clazzs;
    }



    @PostMapping("/register.do")
    @ResponseBody
    public Map<String,Object> register(HttpServletRequest request, Student student){
        System.out.println("学生注册");
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        StudentService studentService = (StudentService) ac.getBean("studentService");
        student.setId(UUIDUtil.getUUID());
        student.setLockState("0");
        student.setCreateTime(DateTimeUtil.getSysTime());
        student.setAllowIps(request.getRemoteAddr());
        student.setLoginPwd(MD5Util.getMD5(student.getLoginPwd()));
        int result = studentService.regiest(student);
        Map<String,Object> map = new HashMap<>();
        boolean flag = true;

        if (result < 0){
            flag = false;
        }

        map.put("success",flag);
        return map;
    }



}
