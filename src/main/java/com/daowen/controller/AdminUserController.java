package com.daowen.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSONObject;
import com.daowen.util.AIUtil;
import com.daowen.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Student;
import com.daowen.entity.Users;
import com.daowen.service.StudentService;
import com.daowen.service.UsersService;
import com.daowen.ssm.simplecrud.SimpleController;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class AdminUserController extends SimpleController {

    @Autowired
    private UsersService usersService;

    @Autowired
    private StudentService studentSrv;

    @Override
    @RequestMapping("/admin/login.do")
    public void mapping(HttpServletRequest request, HttpServletResponse response) {
        super.mappingMethod(request, response);

    }

    @ResponseBody
    @PostMapping("/admin/facelogin")
    public JsonResult faceLogin() {
        String base64photo = request.getParameter("base64photo");
		String image1=base64photo.split(",")[1];
        //String image1 = "";
        Student student=matchStudent(image1);
		if(student!=null) {
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            return JsonResult.success(1, "登录结果", student);
        }
        return JsonResult.error(-1, "无效的脸蛋");
    }

    private Student matchStudent(String b64photo) {
        List<Student> listStudent = studentSrv.getEntity("");
        if (listStudent == null || listStudent.size() <= 0)
            return null;
        String hostHead = this.getHostHead();
        for (Student student : listStudent) {
            String url = hostHead + student.getPhoto();
            String myphoto = AIUtil.toBase64String(url);
            String res = AIUtil.faceMatch(myphoto, b64photo);
//            String jiaocha=AIUtil.faceMatch(myphoto,b64photo);
//            String b64=AIUtil.faceMatch(b64photo,b64photo);
            JSONObject joRes = JSONObject.parseObject(res);
            if (joRes != null && "0".equals(joRes.getString("error_code"))) {
                JSONObject matchRes = joRes.getJSONObject("result");
                System.out.println("比对结果" + matchRes);
                if (matchRes.getInteger("score") >= 70)
                    return student;
            }

        }
        return null;

    }

    public void login() {
        String usertype = request.getParameter("usertype");
        String validcode = (String) request.getSession().getAttribute(
                "validcode");
        String inputvalidcode = request.getParameter("validcode");
//        if (validcode != null && !validcode.equals(inputvalidcode)) {
//            System.out.println("系统验证错误");
//            request.setAttribute("errmsg",
//                    "<img src=\"images/error.gif\"/>系统验证码错误");
//
//            // 分发请求参数
//            dispatchParams(request, response);
//            forward("/admin/login.jsp");
//            return;
//        }
        System.out.println("验证码=" + validcode);
        if (usertype != null && usertype.equals("1")) {
            adminLogin();
        }

        if (usertype != null && usertype.equals("3")) {
            studentLogin();
        }
    }

    private void adminLogin() {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Users u = usersService.load(" where username='" + username
                + "' and password='" + password + "'");
        if (u == null) {
            dispatchParams(request, response);
            request.setAttribute("errmsg",
                    "<img src=\"images/error.gif\"/>用户与密码不匹配");
            System.out.println("系统用户登录失败");
            forward("/admin/login.jsp");
        }
        HttpSession session = request.getSession();
        u.setLogtimes(u.getLogtimes() + 1);
        usersService.update(u);
        session.setAttribute("users", u);
        redirect("/admin/index.jsp");

    }


    private void studentLogin() {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Student u = studentSrv.load(" where stno='" + username
                + "' and password='" + password + "'");

        if (u == null) {
            dispatchParams(request, response);
            request.setAttribute("errmsg",
                    "<img src=\"images/error.gif\"/>用户与密码不匹配");

            System.out.println("系统用户登录失败");
            forward("/admin/login.jsp");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("student", u);
        redirect("/student/index.jsp");

    }


    @PostMapping("/adminuser/exit")
    @ResponseBody
    public JsonResult exit() {
        String usertype = request.getParameter("usertype");
        if (usertype != null && usertype.equals("1")) {
            if (request.getSession().getAttribute("users") != null) {
                System.out.println("系统退出");
                request.getSession().removeAttribute("users");
            }
        }

        if (usertype != null && usertype.equals("3")) {
            if (request.getSession().getAttribute("student") != null) {
                System.out.println("系统退出");
                request.getSession().removeAttribute("student");
            }
        }
        return JsonResult.success(1, "退出成功");
    }


}
