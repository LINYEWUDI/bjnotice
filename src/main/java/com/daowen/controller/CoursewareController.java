package com.daowen.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.HashMap;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daowen.util.JsonResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;
import org.springframework.web.bind.annotation.ResponseBody;

/**************************
 *
 * 公告控制
 *
 */
@Controller
public class CoursewareController extends SimpleController {
    @Autowired
    private CoursewareService coursewareSrv = null;

    @Autowired
    private StudentService studentSrv=null;

    @Override
    @RequestMapping("/admin/coursewaremanager.do")
    public void mapping(HttpServletRequest request, HttpServletResponse response) {
        mappingMethod(request, response);
    }

    @ResponseBody
    @PostMapping("/admin/courseware/readstat")
    public JsonResult readstat(){

        int studentCount=studentSrv.getStudentCount();
        String sql=" select cw.id , cw.title as name,count(*) as value from courseware cw,readrecord rc where rc.targetid=cw.id group by cw.id ,cw.title ";
        List<HashMap<String,Object>> listMap=coursewareSrv.queryToMap(sql);
        for (HashMap<String, Object> map : listMap) {
            int count= Integer.parseInt(map.get("value").toString());
            map.put("notread",studentCount-count);
        }
        return  JsonResult.success(1,"",listMap);
    }




    public void  exportstat(){

        HSSFWorkbook wkb = new HSSFWorkbook();
        // 建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wkb.createSheet("导出@{datasource.Description}");
        // 在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row1 = sheet.createRow(0);
        // 创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        HSSFCell cell = row1.createCell(0);
        // 设置单元格内容
        cell.setCellValue("系统公告信息");
        // 合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
        // 在sheet里创建第二行
        HSSFRow rowtitle = sheet.createRow(1);
        rowtitle.createCell(0).setCellValue("标题");
        rowtitle.createCell(1).setCellValue("阅读人数");
        int rowIndex=2;
        String sql=" select cw.title as name,count(*) as value from courseware cw,readrecord rc where rc.targetid=cw.id group by cw.id ,cw.title ";
        List<HashMap<String,Object>> listCourseware=coursewareSrv.queryToMap(sql);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");


        for(HashMap<String, Object> map : listCourseware){
            HSSFRow rowcontent=sheet.createRow(rowIndex);
            map.get("name");
            if(map.get("name")!=null)
               rowcontent.createCell(0).setCellValue(map.get("name").toString());
            if(map.get("value")!=null)
               rowcontent.createCell(1).setCellValue(map.get("value").toString());
            rowIndex++;
        }
        OutputStream output = null;
        try {
            output = response.getOutputStream();
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        response.reset();
        response.setHeader("Content-disposition",
                "attachment; filename=notice.xls");
        response.setContentType("application/msexcel");
        try {
            wkb.write(output);
            output.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    public void  export(){

        HSSFWorkbook wkb = new HSSFWorkbook();
        // 建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wkb.createSheet("导出@{datasource.Description}");
        // 在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row1 = sheet.createRow(0);
        // 创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        HSSFCell cell = row1.createCell(0);
        // 设置单元格内容
        cell.setCellValue("系统公告信息");
        // 合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
        // 在sheet里创建第二行
        HSSFRow rowtitle = sheet.createRow(1);
        rowtitle.createCell(0).setCellValue("标题");
        rowtitle.createCell(1).setCellValue("发布人");
        rowtitle.createCell(2).setCellValue("发布时间");
        rowtitle.createCell(3).setCellValue("文件");
        int rowIndex=2;
        List<Courseware> listCourseware=coursewareSrv.getEntity("");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        for(Courseware courseware : listCourseware){
            HSSFRow rowcontent=sheet.createRow(rowIndex);
            rowcontent.createCell(0).setCellValue(courseware.getTitle());
            rowcontent.createCell(1).setCellValue(courseware.getPubren());
            rowcontent.createCell(2).setCellValue(sdf.format(courseware.getPubtime()));
            rowcontent.createCell(3).setCellValue(courseware.getFileurl());
            rowIndex++;
        }
        OutputStream output = null;
        try {
            output = response.getOutputStream();
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        response.reset();
        response.setHeader("Content-disposition",
                "attachment; filename=notice.xls");
        response.setContentType("application/msexcel");
        try {
            wkb.write(output);
            output.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    public void  exportReaded(){

        String id=request.getParameter("id");
        if(id==null||id=="")
            return;
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("id",id);
        Courseware courseware=coursewareSrv.load("where id="+id);
        List<Student> listUnread=coursewareSrv.getReadedStudent(map);
        HSSFWorkbook wkb = new HSSFWorkbook();
        // 建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wkb.createSheet("已读人员");
        // 在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row1 = sheet.createRow(0);
        // 创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        HSSFCell cell = row1.createCell(0);
        // 设置单元格内容
        cell.setCellValue(courseware.getTitle());
        // 合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
        // 在sheet里创建第二行
        HSSFRow rowtitle = sheet.createRow(1);
        rowtitle.createCell(0).setCellValue("工号");
        rowtitle.createCell(1).setCellValue("姓名");
        rowtitle.createCell(2).setCellValue("班组");
        rowtitle.createCell(3).setCellValue("联系电话");
        int rowIndex=2;

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");


        for(Student student: listUnread){
            HSSFRow rowcontent=sheet.createRow(rowIndex);

            rowcontent.createCell(0).setCellValue(student.getStno());
            rowcontent.createCell(1).setCellValue(student.getName());
            rowcontent.createCell(2).setCellValue(student.getBjname());
            rowcontent.createCell(3).setCellValue(student.getMobile());

            rowIndex++;
        }
        OutputStream output = null;
        try {
            output = response.getOutputStream();
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        response.reset();
        response.setHeader("Content-disposition",
                "attachment; filename=readed.xls");
        response.setContentType("application/msexcel");
        try {
            wkb.write(output);
            output.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public void  exportUnread(){

        String id=request.getParameter("id");
        if(id==null||id=="")
            return;
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("id",id);
        Courseware courseware=coursewareSrv.load("where id="+id);
        List<Student> listUnread=coursewareSrv.getUnreadStudent(map);
        HSSFWorkbook wkb = new HSSFWorkbook();
        // 建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wkb.createSheet("未读人员");
        // 在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        HSSFRow row1 = sheet.createRow(0);
        // 创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        HSSFCell cell = row1.createCell(0);
        // 设置单元格内容
        cell.setCellValue(courseware.getTitle());
        // 合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
        // 在sheet里创建第二行
        HSSFRow rowtitle = sheet.createRow(1);
        rowtitle.createCell(0).setCellValue("工号");
        rowtitle.createCell(1).setCellValue("姓名");
        rowtitle.createCell(2).setCellValue("班组");
        rowtitle.createCell(3).setCellValue("联系电话");
        int rowIndex=2;

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");


        for(Student student: listUnread){
            HSSFRow rowcontent=sheet.createRow(rowIndex);

            rowcontent.createCell(0).setCellValue(student.getStno());
            rowcontent.createCell(1).setCellValue(student.getName());
            rowcontent.createCell(2).setCellValue(student.getBjname());
            rowcontent.createCell(3).setCellValue(student.getMobile());

            rowIndex++;
        }
        OutputStream output = null;
        try {
            output = response.getOutputStream();
        } catch (IOException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        response.reset();
        response.setHeader("Content-disposition",
                "attachment; filename=unread.xls");
        response.setContentType("application/msexcel");
        try {
            wkb.write(output);
            output.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    public void delete() {
        String[] ids = request.getParameterValues("ids");
        if (ids == null)
            return;
        String spliter = ",";
        String SQL = " where id in(" + join(spliter, ids)
                + ")";
        System.out.println("sql=" + SQL);
        coursewareSrv.delete(SQL);
    }

    /*************************************************************
     ****************保存动作监听支持******************************
     **************************************************************/
    public void save() {
        String forwardurl = request.getParameter("forwardurl");
        //验证错误url
        String errorurl = request.getParameter("errorurl");
        //获取标题
        String title = request.getParameter("title");
        //获取发布人
        String pubren = request.getParameter("pubren");
        //获取发布人姓名
        String pubname = request.getParameter("pubname");
        //获取文件
        String fileurl = request.getParameter("fileurl");
        //获取内容
        String dcontent = request.getParameter("dcontent");
        //获取发布时间
        String pubtime = request.getParameter("pubtime");
        SimpleDateFormat sdfcourseware = new SimpleDateFormat("yyyy-MM-dd");
        Courseware courseware = new Courseware();
        // 设置标题
        courseware.setTitle(title == null ? "" : title);
        // 设置发布人
        courseware.setPubren(pubren == null ? "" : pubren);
        // 设置发布人姓名
        courseware.setPubname(pubname == null ? "" : pubname);
        // 设置文件
        courseware.setFileurl(fileurl == null ? "" : fileurl);
        // 设置内容
        courseware.setDcontent(dcontent == null ? "" : dcontent);
        // 设置发布时间
        if (pubtime != null) {
            try {
                courseware.setPubtime(sdfcourseware.parse(pubtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            courseware.setPubtime(new Date());
        }
        coursewareSrv.save(courseware);
        if (forwardurl == null) {
            forwardurl = "/admin/coursewaremanager.do?actiontype=get";
        }
        redirect(forwardurl);
    }

    /******************************************************
     ***********************更新内部支持*********************
     *******************************************************/
    public void update() {
        String forwardurl = request.getParameter("forwardurl");
        String id = request.getParameter("id");
        if (id == null)
            return;
        Courseware courseware = coursewareSrv.load(new Integer(id));
        if (courseware == null)
            return;
        //获取标题
        String title = request.getParameter("title");
        //获取发布人
        String pubren = request.getParameter("pubren");
        //获取发布人姓名
        String pubname = request.getParameter("pubname");
        //获取文件
        String fileurl = request.getParameter("fileurl");
        //获取内容
        String dcontent = request.getParameter("dcontent");
        //获取发布时间
        String pubtime = request.getParameter("pubtime");
        SimpleDateFormat sdfcourseware = new SimpleDateFormat("yyyy-MM-dd");
// 设置标题
        courseware.setTitle(title);
        // 设置发布人
        courseware.setPubren(pubren);
        // 设置发布人姓名
        courseware.setPubname(pubname);
        // 设置文件
        courseware.setFileurl(fileurl);
        // 设置内容
        courseware.setDcontent(dcontent);
        // 设置发布时间
        if (pubtime != null) {
            try {
                courseware.setPubtime(sdfcourseware.parse(pubtime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        coursewareSrv.update(courseware);
        if (forwardurl == null) {
            forwardurl = "/admin/coursewaremanager.do?actiontype=get";
        }
        redirect(forwardurl);
    }

    /******************************************************
     ***********************加载内部支持*********************
     *******************************************************/
    public void load() {
        //
        String id = request.getParameter("id");
        String actiontype = "save";
        dispatchParams(request, response);
        if (id != null) {
            Courseware courseware = coursewareSrv.load("where id=" + id);
            if (courseware != null) {
                request.setAttribute("courseware", courseware);
            }
            actiontype = "update";
            request.setAttribute("id", id);
        }
        request.setAttribute("actiontype", actiontype);
        String forwardurl = request.getParameter("forwardurl");
        System.out.println("forwardurl=" + forwardurl);
        if (forwardurl == null) {
            forwardurl = "/admin/coursewareadd.jsp";
        }
        forward(forwardurl);
    }

    public void unread() {
        String filter = "where 1=1 ";
        String actorid=request.getParameter("actorid");
        String title = request.getParameter("title");
        HashMap<String,Object> map=new HashMap<>();

        if (title != null)
             map.put("title",title);
        if(actorid!=null)
            map.put("actorid",actorid);
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
        PageHelper.startPage(pageindex,pagesize);
        List<Courseware> listcourseware = coursewareSrv.getUnread(map);
        PageInfo<Courseware> pageInfo=new PageInfo<>();
        request.setAttribute("listcourseware", listcourseware);
        PagerMetal pm = new PagerMetal((int)pageInfo.getTotal());
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
            forwardurl = "/admin/coursewaremanager.jsp";
        }
        forward(forwardurl);
    }

    public void readed() {
        String filter = "where 1=1 ";
        String actorid=request.getParameter("actorid");
        String title = request.getParameter("title");
        HashMap<String,Object> map=new HashMap<>();

        if (title != null)
            map.put("title",title);
        if(actorid!=null)
            map.put("actorid",actorid);
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
        PageHelper.startPage(pageindex,pagesize);
        List<Courseware> listcourseware = coursewareSrv.getReaded(map);
        PageInfo<Courseware> pageInfo=new PageInfo<>();
        request.setAttribute("listcourseware", listcourseware);
        PagerMetal pm = new PagerMetal((int)pageInfo.getTotal());
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
            forwardurl = "/admin/coursewaremanager.jsp";
        }
        forward(forwardurl);
    }

    public void get() {
        String filter = "where 1=1 ";
        String title = request.getParameter("title");
        String pubren=request.getParameter("pubren");
        if (title != null)
            filter += "  and title like '%" + title + "%'  ";
        //
        if(pubren!=null)
            filter+=" and pubren ='"+pubren+"'";
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
        List<Courseware> listcourseware = coursewareSrv.getPageEntitys(filter, pageindex, pagesize);
        int recordscount = coursewareSrv.getRecordCount(filter == null ? "" : filter);
        request.setAttribute("listcourseware", listcourseware);
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
            forwardurl = "/admin/coursewaremanager.jsp";
        }
        forward(forwardurl);
    }


}
