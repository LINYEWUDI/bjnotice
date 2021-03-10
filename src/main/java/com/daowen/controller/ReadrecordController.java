package com.daowen.controller;

import java.io.*;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

//##{{import}}
@Controller
public class ReadrecordController extends SimpleController {

    @Autowired
    private ReadrecordService readrecordSrv = null;

    @Override
    @RequestMapping("/admin/readrecordmanager.do")
    public void mapping(HttpServletRequest request, HttpServletResponse response) {
        mappingMethod(request, response);
    }
    //


    //新增阅读记录
    public void save() {

        String forwardurl = request.getParameter("forwardurl");
        //验证错误url
        String errorurl = request.getParameter("errorurl");


        String actorid = request.getParameter("actorid");


        String targetid = request.getParameter("targetid");


        String createtime = request.getParameter("createtime");

        SimpleDateFormat sdfreadrecord = new SimpleDateFormat("yyyy-MM-dd");
        Readrecord readrecord = new Readrecord();


        readrecord.setActorid(actorid == null ? 0 : new Integer(actorid));


        readrecord.setTargetid(targetid == null ? 0 : new Integer(targetid));


        if (createtime != null) {
            try {
                readrecord.setCreatetime(sdfreadrecord.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            readrecord.setCreatetime(new Date());
        }


        //end forEach

        Boolean validateresult = readrecordSrv.isExist("  where  actorid=" + actorid);
        if (validateresult) {
            dispatchParams(request, response);
            request.setAttribute("errormsg", "<label class='error'>已存在的信息</label>");
            request.setAttribute("readrecord", readrecord);
            request.setAttribute("actiontype", "save");
            forward(errorurl);
            return;
        }


        readrecordSrv.save(readrecord);
        if (forwardurl == null) {
            forwardurl = "/admin/readrecordmanager.do?actiontype=get";
        }
        redirect(forwardurl);
    }

    //新增阅读记录
    public void update() {
        String forwardurl = request.getParameter("forwardurl");
        //验证错误url
        String errorurl = request.getParameter("errorurl");
        String id = request.getParameter("id");
        if (id == null)
            return;
        Readrecord readrecord = readrecordSrv.load("where id=" + id);
        if (readrecord == null)
            return;


        String actorid = request.getParameter("actorid");


        String targetid = request.getParameter("targetid");


        String createtime = request.getParameter("createtime");

        SimpleDateFormat sdfreadrecord = new SimpleDateFormat("yyyy-MM-dd");


        readrecord.setActorid(actorid == null ? 0 : new Integer(actorid));


        readrecord.setTargetid(targetid == null ? 0 : new Integer(targetid));


        if (createtime != null) {
            try {
                readrecord.setCreatetime(sdfreadrecord.parse(createtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            readrecord.setCreatetime(new Date());
        }


        readrecordSrv.update(readrecord);
        if (forwardurl == null) {
            forwardurl = "/admin/readrecordmanager.do?actiontype=get";
        }
        redirect(forwardurl);
    }

    public void delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return;
        String spliter = ",";
        String where = " where id  in(" + join(spliter, ids) + ")";
        System.out.println("where=" + where);
        readrecordSrv.delete(where);
    }

    public void load() {
        String id = request.getParameter("id");
        String actiontype = "save";
        dispatchParams(request, response);
        if (id != null) {
            Readrecord readrecord = readrecordSrv.load("where id=" + id);
            if (readrecord != null) {
                request.setAttribute("readrecord", readrecord);
            }
            actiontype = "update";
            request.setAttribute("id", id);
        }
        request.setAttribute("actiontype", actiontype);


        String forwardurl = request.getParameter("forwardurl");
        System.out.println("forwardurl=" + forwardurl);
        if (forwardurl == null) {
            forwardurl = "/admin/readrecordadd.jsp";
        }
        forward(forwardurl);
    }

    //查询数据
    public void get() {
        String filter = "where 1=1 ";


        String actorid = request.getParameter("actorid");
        if (actorid != null)
            filter += " and actorid =" + actorid;


        int pageindex = 1;
        int pagesize = 10;
        // 获取当前分页
        String currentpageindex = request.getParameter("currentpageindex");
        // 当前页面尺寸
        String currentpagesize = request.getParameter("pagesize");
        // 设置当前页
        if (currentpageindex != null)
            pageindex = new Integer(currentpageindex);
        // 设置当前页尺寸
        if (currentpagesize != null)
            pagesize = new Integer(currentpagesize);

        List<Readrecord> listReadrecord = readrecordSrv.getPageEntitys(filter, pageindex, pagesize);
        int recordscount = readrecordSrv.getRecordCount(filter == null ? "" : filter);
        request.setAttribute("listReadrecord", listReadrecord);
        PagerMetal pm = new PagerMetal(recordscount);
        //设置尺寸
        pm.setPagesize(pagesize);
        //设置当前显示页
        pm.setCurpageindex(pageindex);
        // 设置分页信息
        request.setAttribute("pagermetal", pm);
        //分发请求参数
        dispatchParams(request, response);
        String forwardurl = request.getParameter("forwardurl");
        System.out.println("forwardurl=" + forwardurl);
        if (forwardurl == null) {
            forwardurl = "/admin/readrecordmanager.jsp";
        }
        forward(forwardurl);
    }

    //##{{methods}}


}
