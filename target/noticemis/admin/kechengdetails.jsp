<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
     KechengService kechengSrv=BeansUtil.getBean("kechengService",  KechengService.class);
    if( id!=null)
    {
      Kecheng temobjkecheng=kechengSrv.load(" where id="+ id);
      request.setAttribute("kecheng",temobjkecheng);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>科目信息信息查看</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
</head>
<body >
	<div class="search-title">
		<h2>查看科目信息</h2>
		<div class="description"></div>
	</div>
	<table cellpadding="0" cellspacing="1" class="grid" width="100%">
		<tr>
			<td width="10%" align="right">名称:</td>
			<td>${requestScope.kecheng.mingcheng}</td>
		</tr>
		<tr>
			<td width="10%" align="right">学分:</td>
			<td>${requestScope.kecheng.xuefen}</td>
		</tr>
		<tr>
			<td align="right">图片:</td>
			<td><img id="imgTupian" width="200px" height="200px"
				src="${pageContext.request.contextPath}${requestScope.kecheng.tupian}" />
			</td>
		</tr>
		<tr>
			<td align="right">说明:</td>
			<td colspan="3">${requestScope.kecheng.des}</td>
		</tr>
	</table>
</body>
</html>
