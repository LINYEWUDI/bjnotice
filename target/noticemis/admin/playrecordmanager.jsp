<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>播放记录信息</title>
    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
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
			url: "${pageContext.request.contextPath}/admin/playrecordmanager.do?actiontype=delete",
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
		<h2>播放记录管理</h2>
		<div class="description">
			
		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">
		<form id="searchForm"
			action="${pageContext.request.contextPath}/admin/playrecordmanager.do"
			method="post">
			<table cellspacing="0" width="100%">
				<tbody>
					<tr>
						<td>学号 <input name="accountname" value="${accountname}" class="input-txt"
							type="text"  /> <input type="hidden" name="actiontype"
							value="search" /> <input type="hidden" name="seedid"
							value="${seedid}" /> <input type="hidden" name="forwardurl"
							value="/admin/playrecordmanager.jsp" />
							<button class="orange-button">搜索</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 搜索控件结束 -->
	<div class="clear"></div>
	<div class="action-details">
		<span class="orange-href" id="btnCheckAll">选择</span> <span
			id="btnDelete" class="orange-href"> 删除 </span>
	</div>
	<table id="playrecord" width="100%" border="0" cellspacing="0"
		cellpadding="0" class="ui-record-table">
		<thead>
			<tr>
				<th>选择</th>
				<th><b>学号</b></th>
				<th><b>姓名</b></th>
				<th><b>视频名称</b></th>
				<th><b>播放时间</b></th>
			</tr>
		</thead>
		<tbody>
			<c:if
				test="${listplayrecord== null || fn:length(listplayrecord) == 0}">
				<tr>
					<td colspan="20">没有相关播放记录信息</td>
				</tr>
			</c:if>
			<%	
								    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
									if(request.getAttribute("listplayrecord")!=null)
								      {
									  List<Playrecord> listplayrecord=( List<Playrecord>)request.getAttribute("listplayrecord");
								     for(Playrecord  templayrecord  :  listplayrecord)
								      {
							%>
			<tr>
				<td>&nbsp<input id="chk<%=templayrecord.getId()%>"
					class="check" name="ids" type="checkbox"
					value='<%=templayrecord.getId()%>'></td>
				<td><%=templayrecord.getAccountname()%></td>
				<td><%=templayrecord.getName()%></td>
				<td><%=templayrecord.getMname()%></td>
				<td><%=sdf.format(templayrecord.getCreatetime())%></td>
				
			</tr>
			<%}}%>
		</tbody>
	</table>
	<div class="clear"></div>
	<daowen:pager id="pager1" attcheform="searchForm" />
</body>
</html>
