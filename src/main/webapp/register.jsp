<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.daowen.util.*" %>
<%@ page import="com.daowen.entity.*" %>
<%@ page import="com.daowen.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<%
	BanjiService banjiSrv=BeansUtil.getBean("banjiService", BanjiService.class);
	List<Object> bjid_datasource = banjiSrv.getEntity("");
	request.setAttribute("bjid_datasource", bjid_datasource);

%>
 <head>
  <title>考生</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
     <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.validateex.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
	    <link href="${pageContext.request.contextPath}/webui/easydropdown/themes/easydropdown.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/easydropdown/jquery.easydropdown.js" type="text/javascript"></script>
	 <link href="${pageContext.request.contextPath}/webui/dapper/dapper.css" rel="stylesheet" type="text/css" />
	 <script src="${pageContext.request.contextPath}/webui/dapper/dapper.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
     <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript">
        function initControl(){
	 

                   //开始绑定
                    //结束绑定
			            editor = KindEditor.create('textarea[name="des"]', {
			            uploadJson : '../plusin/upload_json.jsp',
				        fileManagerJson : '../plusin/file_manager_json.jsp',
			            resizeType: 1,
				        allowFileManager: true
				       });
	                  $("#txtBirthday").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
	                  $("#bjid").change(function(){
	        	           $("[name=bjname]").val($("#bjid option:selected").text());
	                  });
	                   $("[name=bjname]").val($("#bjid option:selected").text());
        }
        $(function (){
			dapperUtil.uploadImage({
				targetId:"divPhoto",
				hiddenFiledName:"photo",
				server:"${pageContext.request.contextPath}"
			});
            initControl();
            $.metadata.setType("attr","validate");
            $("#studentForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>在线注册</h2>
		<div class="description">
		   <a href="${pageContext.request.contextPath}/admin/login.jsp">登录系统</a>
		</div>
	</div>
	<form name="studentform" method="post"
		action="${pageContext.request.contextPath}/admin/studentmanager.do"
		id="studentForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="actiontype" value="save" />
			<input type="hidden" name="photo"  />
			<input type="hidden" name="errorurl" value="/register.jsp" />
			<input type="hidden" name="forwardurl"
				value="/regresult.jsp" />
			<tr>
				<td colspan="4">${errormsg}</td>
			</tr>
			<tr>
				<td align="right">工号:</td>
				<td><input name="stno" placeholder="学号"
					validate="{required:true,messages:{required:'请输入工号'}}"
					value="${requestScope.student.stno}" class="input-txt" type="text"
					id="txtStno" />
				</td>
				<td colspan="2" rowspan="6">
					<div id="divPhoto"></div>

				</td>
			</tr>
			<tr>
				<td align="right">姓名:</td>
				<td><input name="name" placeholder="姓名"
					validate="{required:true,messages:{required:'请输入姓名'}}"
					value="${requestScope.student.name}" class="input-txt" type="text"
					id="txtName" /></td>
			</tr>



			<tr>
				<td align="right">联系电话:</td>
				<td><input name="mobile" placeholder="联系电话"
					validate="{required:true,messages:{required:'请输入联系电话'}}"
					value="${requestScope.student.mobile}" class="input-txt"
					type="text" id="txtMobile" /></td>
			</tr>
			<tr>
				<td align="right">班级:</td>
				<td><web:dropdownlist name="bjid" id="bjid" cssclass="dropdown"
						value="${requestScope.student.bjid}"
						datasource="${bjid_datasource}" textfieldname="name"
						valuefieldname="id">
					</web:dropdownlist> <input id="hidbjname" name="bjname" type="hidden"
					value="${requestScope.student.bjname}" />
				</td>
			</tr>

			<tr>
				

			<tr>
				
			
				<td align="right">面貌:</td>
				<td><select name="mianmao" id="ddlMianmao" class="dropdown">
						<option value="党员">党员</option>
						<option value="团员">团员</option>
						<option value="其他">其他</option>
				</select></td>
			

			<tr>
				<td align="right">说明:</td>
				<td colspan="3"><textarea name="des" id="txtDes"
						style="width:98%;height:200px;">${requestScope.student.des}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
						<button class="orange-button">
							<i class="icon-ok icon-white"></i>提交
						</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
