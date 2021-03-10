<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>公告信息</title>
    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/combo/combo.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.theme.default.css" rel="stylesheet"
        type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/treetable/js/jquery.treetable.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(function() {
			    $("#btnDelete").click(function(){
			       var ids = $(".check[type=checkbox]:checked").serialize();
					 if($(".check:checked").length<1)
				        {
				           $.dialog.alert("请选择需要删除条目");
				           return;
				        }
					if(!confirm("你确定要删除吗")){
						return;
					}
					$.ajax({
			                    url: "${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=delete",
			                     method: 'post',
			                     data: ids,
			                     success: function (data) {
			                          window.location.reload();
			                     },
			                     error: function (XMLHttpRequest, textStatus, errorThrown) {
			                         alert(XMLHttpRequest.status + errorThrown);
			                     }
			                 });
			    });
			    $("#btnCheckAll").click(function(){
			           var ischeck=false;
			           $(".check").each(function(){
			               if($(this).is(":checked"))
			               {
			                  $(this).prop("checked","");
			                  ischeck=false;
			                }
			               else
			               {
			                  $(this).prop("checked","true");
			                  ischeck=true;
			                }
			           });
			           if($(this).text()=="选择记录")
			              $(this).text("取消选择");
			           else
			              $(this).text("选择记录");
			    })
			});
       </script>
	</head>
	 <body >
	 <div class="search-title">
		 <h2>公告管理</h2>
		 <div class="description">
			 <a href="${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=load">新建公告</a>
		 </div>
	 </div>
	 <!-- 搜索控件开始 -->
	 <div class="search-options">
		 <form id="searchForm" action="${pageContext.request.contextPath}/admin/coursewaremanager.do" method="post">
			 <table cellspacing="0" width="100%">
				 <tbody>
				 <tr>
					 <td>
						 标题
						 <input name="title" value="${title}" class="input-txt" type="text" id="title"/>
						 <input type="hidden" name="actiontype" value="search"/>

						 <input type="hidden" name="forwardurl" value="/admin/coursewaremanager.jsp"/>
						 <button class="orange-button">
							 搜索
						 </button>
					 </td>
				 </tr>
				 </tbody>
			 </table>
		 </form>
	 </div>
	 <!-- 搜索控件结束 -->
	 <div class="clear">
	 </div>
	 <div class="action-details">
		 <span class="orange-href" id="btnCheckAll">选择</span>
		 <a href="${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=export"  class="orange-href"> 导出EXCEL</a>
		 <span id="btnDelete" class="orange-href"> 删除
		</span>
	 </div>
	 <table id="courseware" width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
		 <thead>
		 <tr>
			 <th>
				 选择
			 </th>
			 <th><b>标题</b></th>
			 <th><b>发布人</b></th>
			 <th><b>文件</b></th>
			 <th><b>发布时间</b></th>
			 <th><b>最近一次查看时间</b></th>
			 <th>
				 操作
			 </th>
		 </tr>
		 </thead>
		 <tbody>
		 <c:if test="${listcourseware== null || fn:length(listcourseware) == 0}">
			 <tr>
				 <td colspan="20">
					 没有相关公告信息
				 </td>
			 </tr>
		 </c:if>
		 <%
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			 SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			 if (request.getAttribute("listcourseware") != null) {
				 List<Courseware> listcourseware = (List<Courseware>) request.getAttribute("listcourseware");
				 for (Courseware temcourseware : listcourseware) {
		 %>
		 <tr>
			 <td>
				 &nbsp<input id="chk<%=temcourseware.getId()%>" class="check" name="ids" type="checkbox"
							 value='<%=temcourseware.getId()%>'>
			 </td>
			 <td><%=temcourseware.getTitle()%>
			 </td>
			 <td><%=temcourseware.getPubname()%>-<%=temcourseware.getPubren()%>
			 </td>

			 <td><%=temcourseware.getFileurl()%>
			 </td>
			 <td><%=sdf.format(temcourseware.getPubtime())%>
			 </td>
			 <td><%
				 if (temcourseware.getLastCheckTime() != null){
					 final String format = sdfTime.format(temcourseware.getLastCheckTime());
					 out.println(format);
				 }
			 %>
			 </td>
			 <td>
				 <a class="orange-href"
					href="${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=load&id=<%=temcourseware.getId()%>&forwardurl=/admin/coursewareadd.jsp">修改</a>
				 <a class="orange-href"
					href="${pageContext.request.contextPath}/admin/coursewaredetails.jsp?id=<%=temcourseware.getId()%>">查看</a>
			 </td>
		 </tr>
		 <%
				 }
			 }
		 %>
		 </tbody>
	 </table>
	 <div class="clear"></div>
	 <daowen:pager id="pager1" attcheform="searchForm"/>
	</body>
</html>
