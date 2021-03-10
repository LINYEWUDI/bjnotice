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

import com.daowen.entity.Notice;
import com.daowen.service.NoticeService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;

/**************************
 * 
 * 公告控制
 *
 */
@Controller
public class NoticeController extends SimpleController {
	@Autowired
	// 业务服务
	private NoticeService noticeSrv = null;

	@Override
	@RequestMapping("/admin/noticemanager.do")
	public void mapping(HttpServletRequest request, HttpServletResponse response) {
		mappingMethod(request, response);
	}

	/********************************************************
	 ****************** 信息注销监听支持*****************************
	 *********************************************************/
	public void delete() {
		String id = request.getParameter("id");
		noticeSrv.delete(" where id=" + id);
		get();
	}

	/*************************************************************
	 **************** 保存动作监听支持******************************
	 **************************************************************/
	public void save() {
		String forwardurl = request.getParameter("forwardurl");
		// 验证错误url
		String errorurl = request.getParameter("errorurl");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String createtime = request.getParameter("createtime");
		String pubren = request.getParameter("pubren");
		SimpleDateFormat sdfnotice = new SimpleDateFormat("yyyy-MM-dd");
		Notice notice = new Notice();
		notice.setTitle(title == null ? "" : title);
		notice.setContent(content == null ? "" : content);
		if (createtime != null) {
			try {
				notice.setCreatetime(sdfnotice.parse(createtime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			notice.setCreatetime(new Date());
		}
		notice.setPubren(pubren == null ? "" : pubren);
		noticeSrv.save(notice);
		if (forwardurl == null) {
			forwardurl = "/admin/noticemanager.do?actiontype=get";
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
		Notice notice = noticeSrv.load(new Integer(id));
		if (notice == null)
			return;
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String pubren = request.getParameter("pubren");
		SimpleDateFormat sdfnotice = new SimpleDateFormat("yyyy-MM-dd");
		notice.setTitle(title);
		notice.setContent(content);
		notice.setPubren(pubren);
		noticeSrv.update(notice);
		if (forwardurl == null) {
			forwardurl = "/admin/noticemanager.do?actiontype=get";
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
			Notice notice = noticeSrv.load("where id=" + id);
			if (notice != null) {
				request.setAttribute("notice", notice);
			}
			actiontype = "update";
			request.setAttribute("id", id);
		}
		request.setAttribute("actiontype", actiontype);
		String forwardurl = request.getParameter("forwardurl");
		System.out.println("forwardurl=" + forwardurl);
		if (forwardurl == null) {
			forwardurl = "/admin/noticeadd.jsp";
		}
		forward(forwardurl);
	}

	/******************************************************
	 *********************** 数据绑定内部支持*********************
	 *******************************************************/
	public void get() {
		String filter = "where 1=1 ";
		String title = request.getParameter("title");
		if (title != null)
			filter += "  and title like '%" + title + "%'  ";
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
		List<Notice> listnotice = noticeSrv.getPageEntitys(filter, pageindex,
				pagesize);
		int recordscount = noticeSrv.getRecordCount(filter == null ? ""
				: filter);
		request.setAttribute("listnotice", listnotice);
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
			forwardurl = "/admin/noticemanager.jsp";
		}
		forward(forwardurl);
	}
}
