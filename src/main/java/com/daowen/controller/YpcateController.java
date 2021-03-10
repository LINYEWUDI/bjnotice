package com.daowen.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Ypcate;
import com.daowen.service.YpcateService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;
@Controller
public class YpcateController extends SimpleController {

	@Autowired
	private  YpcateService ypcateSrv=null;
	@Override
	@RequestMapping("/admin/ypcatemanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request,response);
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
		ypcateSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		String name = request.getParameter("name");
		String des = request.getParameter("des");
		SimpleDateFormat sdfypcate = new SimpleDateFormat("yyyy-MM-dd");
		Ypcate ypcate = new Ypcate();
		ypcate.setName(name == null ? "" : name);
		ypcateSrv.save(ypcate);
		
		if (forwardurl == null) {
			forwardurl = "/admin/ypcatemanager.do?actiontype=get";
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
		Ypcate ypcate = ypcateSrv.load( new Integer(id));
		if (ypcate == null)
			return;
		String name = request.getParameter("name");
		String des = request.getParameter("des");
		SimpleDateFormat sdfypcate = new SimpleDateFormat("yyyy-MM-dd");
		ypcate.setName(name);
		ypcateSrv.update(ypcate);

		if (forwardurl == null) {
			forwardurl = "/admin/ypcatemanager.do?actiontype=get";
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
		if (id!= null) {
			Ypcate ypcate = ypcateSrv.load("where id=" + id);
			if (ypcate != null) {
				request.setAttribute("ypcate", ypcate);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/ypcateadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String name = request.getParameter("name");
		if (name != null)
			filter += "  and name like '%" + name + "%'  ";
		//
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
		List<Ypcate> listypcate =ypcateSrv.getPageEntitys(filter,pageindex, pagesize);
		int recordscount = ypcateSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listypcate", listypcate);
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
			forwardurl = "/admin/ypcatemanager.jsp";
		}
		forward(forwardurl);
	}
	

}
