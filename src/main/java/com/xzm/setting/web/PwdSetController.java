package com.xzm.setting.web;


import com.xzm.student.domain.Student;
import com.xzm.student.service.StudentService;
import com.xzm.utils.MD5Util;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.rmi.server.ObjID;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/pwd")
public class PwdSetController {

    @RequestMapping("Reset.do")
    @ResponseBody
    public Map<String, Object> pwdReset(HttpServletRequest request,String oldPwd, String newPwd, String confirmPwd,String id){
        String stuPwd = ((Student)request.getSession().getAttribute("stu")).getLoginPwd();
        ApplicationContext ac = (ApplicationContext) request.getServletContext().getAttribute("as");
        StudentService studentService = (StudentService) ac.getBean("studentService");
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        boolean flag = true;
        System.out.println(oldPwd + "==" + newPwd +"==" + confirmPwd +"==" + stuPwd);
        oldPwd = MD5Util.getMD5(oldPwd);
        newPwd = MD5Util.getMD5(newPwd);
        System.out.println(oldPwd + "==" + newPwd +"==" + confirmPwd +"==" + stuPwd);
        if(stuPwd.equals(oldPwd)){
            data.put("id",id);
            data.put("newPwd",newPwd);
            int result = studentService.resetPwd(data);
            if(result < 1){
                flag = false;
                map.put("mag","密码修改失败，请重新尝试");
            }
        }else {
            flag = false;
            map.put("mag","原密码有误，请重新输入");

        }

        map.put("success",flag);
        return map;
    }

}
