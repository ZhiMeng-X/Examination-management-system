package com.xzm.web.filter;

import com.xzm.student.domain.Student;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFilter implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("进入过滤器");
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;




        String path = request.getServletPath();
        System.out.println(path);
        if("/login.jsp".equals(path) || "/student/login.do".equals(path)|| "/student/academic.do".equals(path)|| "/student/school.do".equals(path)|| "/student/clazz.do".equals(path)|| "/student/register.do".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
        }else {
            Student student = (Student) request.getSession().getAttribute("stu");

            if(student != null){
                filterChain.doFilter(servletRequest,servletResponse);
            }else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }


    }

    @Override
    public void destroy() {

    }

}
