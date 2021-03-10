package com.daowen.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Student;
import com.daowen.service.BanjiService;
import com.daowen.service.StudentService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 考生控制
 *
 */
@Controller
public class StudentController extends SimpleController {
	@Autowired
	// 业务服务
	private StudentService studentSrv = null;
	@Autowired
	private BanjiService banjiSrv = null;

	@Override
	@RequestMapping("/admin/studentmanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request, response);
	}
	
	
	
	private void modifyPw() {
		String password1 = request.getParameter("password1");
		String repassword1 = request.getParameter("repassword1");
		String repassword2 = request.getParameter("repassword2");
		String forwardurl = request.getParameter("forwardurl");
		String errorpageurl = request.getParameter("errorpageurl");
		String id = request.getParameter("id");
		if (id == null || id == "")
			return;
		Student student = studentSrv.load(new Integer(id));
		if (student != null) {
			if (!student.getPassword().equals(password1)) {
				
					request.setAttribute("errormsg",
							"<label class='error'>原始密码不正确，不能修改</label>");
					forward(errorpageurl);
					return;
				
			} else {
				student.setPassword(repassword1);
				studentSrv.update(student);
				request.getSession().setAttribute("student", student);
				redirect(forwardurl);
			}
		}
	}

	/********************************************************
	 ****************** 信息注销监听支持*****************************
	 *********************************************************/
	public void delete() {
		String[] ids = request.getParameterValues("ids");
		if (ids == null)
			return;
		String spliter = ",";
		String SQL = " where id in(" + join(spliter, ids) + ")";
		System.out.println("sql=" + SQL);
		studentSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String stno = request.getParameter("stno");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String zhuanye = request.getParameter("zhuanye");
		String jiguan = request.getParameter("jiguan");
		String mobile = request.getParameter("mobile");
		String bjid = request.getParameter("bjid");
		String bjname=request.getParameter("bjname");
		String photo = request.getParameter("photo");
		String mianmao = request.getParameter("mianmao");
		String address = request.getParameter("address");
		String des = request.getParameter("des");
		String nation = request.getParameter("nation");
		String birthday = request.getParameter("birthday");
		SimpleDateFormat sdfstudent = new SimpleDateFormat("yyyy-MM-dd");
		Student student = new Student();
		student.setStno(stno == null ? "" : stno);
		student.setName(name == null ? "" : name);
		student.setSex(sex == null ? "" : sex);
		student.setZhuanye(zhuanye == null ? "" : zhuanye);
		student.setJiguan(jiguan == null ? "" : jiguan);
		student.setMobile(mobile == null ? "" : mobile);
		student.setPhoto(photo == null ? "" : photo);
		student.setMianmao(mianmao == null ? "" : mianmao);
		student.setAddress(address == null ? "" : address);
		student.setDes(des == null ? "" : des);
		student.setPassword("123456");
		student.setNation(nation == null ? "" : nation);
		if (birthday != null) {
			try {
				student.setBirthday(sdfstudent.parse(birthday));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			student.setBirthday(new Date());
		}
		student.setBjid(bjid==null?0:new Integer(bjid));
		student.setBjname(bjname==null?"":bjname);
		Boolean validateresult = studentSrv
				.isExist("where stno='" + stno + "'");
		if (validateresult) {
			try {
				request.setAttribute("errormsg",
						"<label class='error'>已经存在的学号</label>");
				request.setAttribute("student", student);
				request.setAttribute("actiontype", "save");
				request.getRequestDispatcher(errorurl).forward(request,
						response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return;
		}
		studentSrv.save(student);

		if (forwardurl == null) {
			forwardurl = "/admin/studentmanager.do?actiontype=get";
		}
		redirect(forwardurl);
	}

	/******************************************************
	 *********************** 更新内部支持*********************
	 *******************************************************/
	public void update() {
		String forwardurl = request.getParameter("forwardurl");
		String id = request.getParameter("id");
		if (id == null)
			return;
		Student student = studentSrv.load(new Integer(id));
		if (student == null)
			return;
		String stno = request.getParameter("stno");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String zhuanye = request.getParameter("zhuanye");
		String jiguan = request.getParameter("jiguan");
		String mobile = request.getParameter("mobile");
		String bjid = request.getParameter("bjid");
		String bjname=request.getParameter("bjname");
		String photo = request.getParameter("photo");
		String mianmao = request.getParameter("mianmao");
		String address = request.getParameter("address");
		String des = request.getParameter("des");

		String nation = request.getParameter("nation");
		String birthday = request.getParameter("birthday");
		SimpleDateFormat sdfstudent = new SimpleDateFormat("yyyy-MM-dd");
		if (stno != null)
			student.setStno(stno);
		if (name != null)
			student.setName(name);
		student.setSex(sex);
		student.setZhuanye(zhuanye);
		student.setJiguan(jiguan);
		student.setMobile(mobile);
		student.setPhoto(photo);
		student.setMianmao(mianmao);
		student.setAddress(address);
		student.setBjid(bjid==null?0:new Integer(bjid));
		student.setBjname(bjname==null?"":bjname);
		student.setDes(des);
		student.setNation(nation);
		if (birthday != null) {
			try {
				student.setBirthday(sdfstudent.parse(birthday));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		studentSrv.update(student);

		if (forwardurl == null) {
			forwardurl = "/admin/studentmanager.do?actiontype=get";
		}
		redirect(forwardurl);
	}

	/******************************************************
	 *********************** 加载内部支持*********************
	 *******************************************************/
	public void load() {
		//
		String id = request.getParameter("id");
		String actiontype = "save";
		dispatchParams(request, response);
		if (id != null) {
			Student student = studentSrv.load("where id=" + id);
			if (student != null) {
				request.setAttribute("student", student);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		List<Object> bjid_datasource = banjiSrv.getEntity("");
		request.setAttribute("bjid_datasource", bjid_datasource);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/studentadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String name = request.getParameter("name");
		String stno = request.getParameter("stno");
		if (stno != null)
			filter += "  and stno like '%" + stno + "%'  ";
		if (name != null)
			filter += "  and name  like '%" + name + "%'";
		//
		int pageindex = 1;
		int pagesize = 14;
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
		List<Student> liststudent = studentSrv.getPageEntitys(filter,
				pageindex, pagesize);
		int recordscount = studentSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("liststudent", liststudent);
		PagerMetal pm = new PagerMetal(recordscount);
		// 设置尺寸
		pm.setPagesize(pagesize);
		// 设置当前显示页
		pm.setCurpageindex(pageindex);
		// 设置分页信息
		request.setAttribute("pagermetal", pm);
		// 分发请求参数
		dispatchParams(request, response);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/studentmanager.jsp";
		}
		forward(forwardurl);
	}

	public void getJoinedStudent() {

		String projectno = request.getParameter("projectno");

		String sql = " select s.* from student s,promem pm where   pm.stno=s.stno   ";
		if (projectno != null)
			sql += " and pm.projectno='" + projectno + "'";

		List<Student> liststudent = studentSrv.query(sql);

		request.setAttribute("liststudent", liststudent);

		// 分发请求参数
		dispatchParams(request, response);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/studentmanager.jsp";
		}
		forward(forwardurl);
	}
}
