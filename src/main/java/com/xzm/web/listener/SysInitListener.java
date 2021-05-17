package com.xzm.web.listener;

import com.xzm.student.domain.Academic;
import com.xzm.student.domain.Clazz;
import com.xzm.student.domain.School;
import com.xzm.student.service.AcademicService;
import com.xzm.student.service.ClazzService;
import com.xzm.student.service.SchoolService;
import com.xzm.student.service.impl.AcademicServiceImpl;
import com.xzm.student.service.impl.ClazzServiceImpl;
import com.xzm.student.service.impl.SchoolServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

public class SysInitListener implements ServletContextListener {



    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("服务对象监听窗口");
        ServletContext application = sce.getServletContext();
        ApplicationContext as = new ClassPathXmlApplicationContext("conf/applicationContext.xml");
        application.setAttribute("as",as);
        SchoolService schoolService = (SchoolService) as.getBean("schoolServiceImpl");
        AcademicService academicService = (AcademicService) as.getBean("academicServiceImpl");
        ClazzService clazzService = (ClazzService) as.getBean("clazzServiceImpl");

        String names[] = as.getBeanDefinitionNames();

        for(String na:names){
            System.out.println("容器中对象名称："+na+"|"+as.getBean(na));
        }
        System.out.println("创建spring对象："+as);

        List<School> school = schoolService.queryAll();
        List<Academic> academic = academicService.queryAll();
        List<Clazz> clazz = clazzService.queryAll();

        application.setAttribute("school",school);
        application.setAttribute("clazz",clazz);
        application.setAttribute("academic",academic);


        System.out.println(school);
        System.out.println(clazz);
        System.out.println(academic);



    }
}
