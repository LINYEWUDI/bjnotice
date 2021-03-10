<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.context.annotation.Bean" %>
<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
     ReadrecordService readrecordSrv= BeansUtil.getBean("readrecordService",ReadrecordService.class);
     CoursewareService coursewareSrv=BeansUtil.getBean("coursewareService",  CoursewareService.class);
    if(id!=null){
      Courseware temobjcourseware=coursewareSrv.load(" where id="+ id);
      request.setAttribute("courseware",temobjcourseware);

      coursewareSrv.updateCheckTime(Integer.parseInt(id));

      String where= MessageFormat.format("where actorid={0,number,#} and targetid={1,number,#} ",tem_student.getId(),temobjcourseware.getId());

      Readrecord readrecord=readrecordSrv.load(where);
      if(readrecord==null) {
		  readrecord=new Readrecord();
		  readrecord.setActorid(tem_student.getId());
		  readrecord.setTargetid(temobjcourseware.getId());
		  readrecord.setCreatetime(new Date());
		  readrecordSrv.save(readrecord);
	  }else{
      	  readrecord.setCreatetime(new Date());
		  readrecordSrv.update(readrecord);
	  }
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>公告信息查看</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
</head>
<body >
<div class="search-title">
	<h2>
		查看公告
	</h2>
	<div class="description">
	</div>
</div>
<table cellpadding="0" cellspacing="1" class="grid" width="100%">
	<tr>
		<td width="10%" align="right">标题:</td>
		<td>
			${requestScope.courseware.title}
		</td>
	</tr>
	<tr>
		<td width="10%" align="right">发布人:</td>
		<td>
			${requestScope.courseware.pubren}-${requestScope.courseware.pubname}
		</td>
	</tr>

	<tr>
		<td align="right">文件:</td>
		<td>
			<li>
				<a href="${pageContext.request.contextPath}/plusin/download.jsp?filename=${requestScope.courseware.fileurl}">
					下载</a></li>
		</td>
	</tr>
	<tr>
		<td align="right">发布时间:</td>
		<td>
			<fmt:formatDate value="${requestScope.courseware.pubtime}" pattern="yyyy-MM-dd"/>
		</td>
	</tr>
	<tr>
		<td align="right">内容:</td>
		<td colspan="3">
			${requestScope.courseware.dcontent}
		</td>
	</tr>
</table>
</body>
</html>
