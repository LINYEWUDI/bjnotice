<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
    String  id=request.getParameter("id");
     HuibaoService huibaoSrv=BeansUtil.getBean("huibaoService",  HuibaoService.class);
    if( id!=null)
    {
      Huibao temobjhuibao=huibaoSrv.load(" where id="+ id);
      request.setAttribute("huibao",temobjhuibao);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>汇报信息查看</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
</head>
<body >
	<div class="search-title">
		<h2>查看汇报</h2>
		<div class="description"></div>
	</div>
	<table cellpadding="0" cellspacing="1" class="grid" width="100%">
		<tr>
			<td width="10%" align="right">标题:</td>
			<td>${requestScope.huibao.title}</td>
		</tr>
		<tr>
			<td align="right">汇报日期:</td>
			<td><fmt:formatDate value="${requestScope.huibao.hbdate}"
					pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<td align="right">文件地址:</td>
			<td>
				<li><a
					href="${pageContext.request.contextPath}/plusin/download.jsp?filename=  ${requestScope.huibao.fileurl}">
						下载</a></li>
			</td>
		</tr>
		<tr>
			<td width="10%" align="right">汇报人:</td>
			<td>${requestScope.huibao.hbrname}-${requestScope.huibao.hbren}</td>
		</tr>
	
		<tr>
			<td align="right">汇报内容:</td>
			<td colspan="3">${requestScope.huibao.dcontent}</td>
		</tr>
	</table>
</body>
</html>
