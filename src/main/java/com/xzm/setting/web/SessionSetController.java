package com.xzm.setting.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/session")
public class SessionSetController {

    @RequestMapping("/removeSession.do")
    public ModelAndView removeSession(HttpServletRequest request){
        request.getSession().removeAttribute("stu");
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/login.jsp");
        return mv;
    }


}
