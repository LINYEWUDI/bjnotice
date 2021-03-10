<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
     Student student= (Student)request.getSession().getAttribute("student");
     StudentService studentSrv=BeansUtil.getBean("studentService", StudentService.class);
	 if(student!=null)
	 {
	     Student temstudent =studentSrv.load("where id="+((Student)student).getId());
	    request.setAttribute("student",temstudent);
	 }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>信息</title>
	<script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
  <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
  <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
    
</head>
<body >
	<div class="search-title">
		<h2>查看账户信息</h2>
		<div class="description"></div>
	</div>
	<table border="0" cellspacing="1" class="grid" cellpadding="0"
		width="100%">
		<tr>
			<td align="right" width="10%" class="title">工号:</td>
			<td>${requestScope.student.stno}</td>
			<td colspan="2" rowspan="6"><img src="${pageContext.request.contextPath}${requestScope.student.photo}" width="200"
				height="200" /></td>
		</tr>
		<tr>
			<td align="right" width="10%" class="title">姓名:</td>
			<td>${requestScope.student.name}</td>
		</tr>

		

		<tr>
			<td align="right" width="10%" class="title">联系电话:</td>
			<td>${requestScope.student.mobile}</td>
		</tr>
		<tr>
			
			<td align="right" class="title">面貌:</td>
			<td>${requestScope.student.mianmao}</td>
		</tr>

		<tr>
			<td align="right" class="title">说明:</td>
			<td colspan="3">${requestScope.student.des}</td>
		</tr>
	</table>
</body>
</html>
