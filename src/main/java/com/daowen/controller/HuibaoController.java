package com.daowen.controller;

import java.util.List;
import java.util.HashMap;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 汇报控制
 *
 */
@Controller
public class HuibaoController extends SimpleController {
	@Autowired
	private HuibaoService huibaoSrv = null;

	@Override
	@RequestMapping("/admin/huibaomanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request, response);
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
		huibaoSrv.delete(SQL);
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		// 获取标题
		String title = request.getParameter("title");
		// 获取汇报日期
		String hbdate = request.getParameter("hbdate");
		// 获取文件地址
		String fileurl = request.getParameter("fileurl");
		// 获取汇报内容
		String dcontent = request.getParameter("dcontent");
		// 获取汇报人
		String hbren = request.getParameter("hbren");
		// 获取姓名
		String hbrname = request.getParameter("hbrname");
		SimpleDateFormat sdfhuibao = new SimpleDateFormat("yyyy-MM-dd");
		Huibao huibao = new Huibao();
		// 设置标题
		huibao.setTitle(title == null ? "" : title);
		// 设置汇报日期
		if (hbdate != null) {
			try {
				huibao.setHbdate(sdfhuibao.parse(hbdate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			huibao.setHbdate(new Date());
		}
		// 设置文件地址
		huibao.setFileurl(fileurl == null ? "" : fileurl);
		// 设置汇报内容
		huibao.setDcontent(dcontent == null ? "" : dcontent);
		// 设置汇报人
		huibao.setHbren(hbren == null ? "" : hbren);
		// 设置姓名
		huibao.setHbrname(hbrname == null ? "" : hbrname);
		huibaoSrv.save(huibao);
		if (forwardurl == null) {
			forwardurl = "/admin/huibaomanager.do?actiontype=get";
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
		Huibao huibao = huibaoSrv.load(new Integer(id));
		if (huibao == null)
			return;
		// 获取标题
		String title = request.getParameter("title");
		// 获取汇报日期
		String hbdate = request.getParameter("hbdate");
		// 获取文件地址
		String fileurl = request.getParameter("fileurl");
		// 获取汇报内容
		String dcontent = request.getParameter("dcontent");
		// 获取汇报人
		String hbren = request.getParameter("hbren");
		// 获取姓名
		String hbrname = request.getParameter("hbrname");
		SimpleDateFormat sdfhuibao = new SimpleDateFormat("yyyy-MM-dd");
		// 设置标题
		huibao.setTitle(title);
		// 设置汇报日期
		if (hbdate != null) {
			try {
				huibao.setHbdate(sdfhuibao.parse(hbdate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		// 设置文件地址
		huibao.setFileurl(fileurl);
		// 设置汇报内容
		huibao.setDcontent(dcontent);
		// 设置汇报人
		huibao.setHbren(hbren);
		// 设置姓名
		huibao.setHbrname(hbrname);
		huibaoSrv.update(huibao);
		if (forwardurl == null) {
			forwardurl = "/admin/huibaomanager.do?actiontype=get";
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
			Huibao huibao = huibaoSrv.load("where id=" + id);
			if (huibao != null) {
				request.setAttribute("huibao", huibao);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/huibaoadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String title = request.getParameter("title");
		String hbren=request.getParameter("hbren");
		if (title != null)
			filter += "  and title like '%" + title + "%'  ";
		//
		if(hbren!=null)
			filter+=" and hbren='"+hbren+"'";
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
		List<Huibao> listhuibao = huibaoSrv.getPageEntitys(filter, pageindex, pagesize);
		int recordscount = huibaoSrv.getRecordCount(filter == null ? "" : filter);
		request.setAttribute("listhuibao", listhuibao);
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
			forwardurl = "/admin/huibaomanager.jsp";
		}
		forward(forwardurl);
	}

	public void query() {
		String sql = " select * from huibao    ";
		List<HashMap<String, Object>> listHuibao = huibaoSrv.queryToMap(sql);
		request.setAttribute("listHuibao", listHuibao);
		// 分发请求参数
		dispatchParams(request, response);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/huibaomanager.jsp";
		}
		forward(forwardurl);
	}
}
